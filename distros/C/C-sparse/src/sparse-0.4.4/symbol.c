/*
 * Symbol lookup and handling.
 *
 * Copyright (C) 2003 Transmeta Corp.
 *               2003-2004 Linus Torvalds
 *
 *  Licensed under the Open Software License version 1.1
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "lib.h"
#include "allocate.h"
#include "token.h"
#include "parse.h"
#include "symbol.h"
#include "scope.h"
#include "expression.h"

#include "target.h"

/*
 * Secondary symbol list for stuff that needs to be output because it
 * was used. 
 */
#ifndef DO_CTX
struct symbol_list *translation_unit_used_list = NULL;
struct stream *stream_sc;
struct stream *stream_sb;
#endif

/*
 * If the symbol is an inline symbol, add it to the list of symbols to parse
 */
void access_symbol(SCTX_ struct symbol *sym)
{
	if (sym->ctype.modifiers & MOD_INLINE) {
		if (!(sym->ctype.modifiers & MOD_ACCESSED)) {
			add_symbol(sctx_ &sctxp translation_unit_used_list, sym);
			sym->ctype.modifiers |= MOD_ACCESSED;
		}
	}
}

struct symbol *lookup_symbol(SCTX_ struct ident *ident, enum namespace ns)
{
	struct symbol *sym;

	for (sym = ident->symbols; sym; sym = sym->next_id) {
		if (sym->namespace & ns) {
			sym->used = 1;
			return sym;
		}
	}
	return NULL;
}

struct sym_context *alloc_context(SCTX)
{
	return __alloc_sym_context(sctx_ 0);
}

struct symbol *alloc_symbol(SCTX_ struct token *tok, int type)
{
	struct symbol *sym = __alloc_symbol(sctx_ 0);
#ifdef DO_CTX
	sym->ctx = sctx;
#endif
	sym->type = type;
	sym->pos = tok;
	sym->tok = tok;
	sym->endpos = NULL;
	return sym;
}

struct struct_union_info {
	unsigned long max_align;
	unsigned long bit_size;
	int align_size;
};

/*
 * Unions are fairly easy to lay out ;)
 */
static void lay_out_union(SCTX_ struct symbol *sym, struct struct_union_info *info)
{
	examine_symbol_type(sctx_ sym);

	// Unnamed bitfields do not affect alignment.
	if (sym->ident || !is_bitfield_type(sym)) {
		if (sym->ctype.alignment > info->max_align)
			info->max_align = sym->ctype.alignment;
	}

	if (sym->bit_size > info->bit_size)
		info->bit_size = sym->bit_size;

	sym->offset = 0;
}

static int bitfield_base_size(SCTX_ struct symbol *sym)
{
	if (sym->type == SYM_NODE)
		sym = sym->ctype.base_type;
	if (sym->type == SYM_BITFIELD)
		sym = sym->ctype.base_type;
	return sym->bit_size;
}

/*
 * Structures are a bit more interesting to lay out
 */
static void lay_out_struct(SCTX_ struct symbol *sym, struct struct_union_info *info)
{
	unsigned long bit_size, align_bit_mask;
	int base_size;

	examine_symbol_type(sctx_ sym);

	// Unnamed bitfields do not affect alignment.
	if (sym->ident || !is_bitfield_type(sym)) {
		if (sym->ctype.alignment > info->max_align)
			info->max_align = sym->ctype.alignment;
	}

	bit_size = info->bit_size;
	base_size = sym->bit_size; 

	/*
	 * Unsized arrays cause us to not align the resulting
	 * structure size
	 */
	if (base_size < 0) {
		info->align_size = 0;
		base_size = 0;
	}

	align_bit_mask = bytes_to_bits(sctx_ sym->ctype.alignment) - 1;

	/*
	 * Bitfields have some very special rules..
	 */
	if (is_bitfield_type (sym)) {
		unsigned long bit_offset = bit_size & align_bit_mask;
		int room = bitfield_base_size(sctx_ sym) - bit_offset;
		// Zero-width fields just fill up the unit.
		int width = base_size ? : (bit_offset ? room : 0);

		if (width > room) {
			bit_size = (bit_size + align_bit_mask) & ~align_bit_mask;
			bit_offset = 0;
		}
		sym->offset = bits_to_bytes(sctx_ bit_size - bit_offset);
		sym->bit_offset = bit_offset;
		sym->ctype.base_type->bit_offset = bit_offset;
		info->bit_size = bit_size + width;
		// warning (sym->pos, "bitfield: offset=%d:%d  size=:%d", sym->offset, sym->bit_offset, width);

		return;
	}

	/*
	 * Otherwise, just align it right and add it up..
	 */
	bit_size = (bit_size + align_bit_mask) & ~align_bit_mask;
	sym->offset = bits_to_bytes(sctx_ bit_size);

	info->bit_size = bit_size + base_size;
	// warning (sym->pos, "regular: offset=%d", sym->offset);
}

static struct symbol * examine_struct_union_type(SCTX_ struct symbol *sym, int advance)
{
	struct struct_union_info info = {
		.max_align = 1,
		.bit_size = 0,
		.align_size = 1
	};
	unsigned long bit_size, bit_align;
	void (*fn)(SCTX_ struct symbol *, struct struct_union_info *);
	struct symbol *member;

	fn = advance ? lay_out_struct : lay_out_union;
	FOR_EACH_PTR(sym->symbol_list, member) {
		fn(sctx_ member, &info);
	} END_FOR_EACH_PTR(member);

	if (!sym->ctype.alignment)
		sym->ctype.alignment = info.max_align;
	bit_size = info.bit_size;
	if (info.align_size) {
		bit_align = bytes_to_bits(sctx_ sym->ctype.alignment)-1;
		bit_size = (bit_size + bit_align) & ~bit_align;
	}
	sym->bit_size = bit_size;
	return sym;
}

static struct symbol *examine_base_type(SCTX_ struct symbol *sym)
{
	struct symbol *base_type;

	/* Check the base type */
	base_type = examine_symbol_type(sctx_ sym->ctype.base_type);
	if (!base_type || base_type->type == SYM_PTR)
		return base_type;
	sym->ctype.as |= base_type->ctype.as;
	sym->ctype.modifiers |= base_type->ctype.modifiers & MOD_PTRINHERIT;
	concat_ptr_list(sctx_ (struct ptr_list *)base_type->ctype.contexts,
			(struct ptr_list **)&sym->ctype.contexts);
	if (base_type->type == SYM_NODE) {
		base_type = base_type->ctype.base_type;
		sym->ctype.base_type = base_type;
	}
	return base_type;
}

static struct symbol * examine_array_type(SCTX_ struct symbol *sym)
{
	struct symbol *base_type = examine_base_type(sctx_ sym);
	unsigned long bit_size = -1, alignment;
	struct expression *array_size = sym->array_size;

	if (!base_type)
		return sym;

	if (array_size) {	
		bit_size = base_type->bit_size * get_expression_value_silent(sctx_ array_size);
		if (array_size->type != EXPR_VALUE) {
			if (sctxp Wvla)
				warning(sctx_ array_size->pos->pos, "Variable length array is used.");
			bit_size = -1;
		}
	}
	alignment = base_type->ctype.alignment;
	if (!sym->ctype.alignment)
		sym->ctype.alignment = alignment;
	sym->bit_size = bit_size;
	return sym;
}

static struct symbol *examine_bitfield_type(SCTX_ struct symbol *sym)
{
	struct symbol *base_type = examine_base_type(sctx_ sym);
	unsigned long bit_size, alignment, modifiers;

	if (!base_type)
		return sym;
	bit_size = base_type->bit_size;
	if (sym->bit_size > bit_size)
		warning(sctx_ sym->pos->pos, "impossible field-width, %d, for this type",  sym->bit_size);

	alignment = base_type->ctype.alignment;
	if (!sym->ctype.alignment)
		sym->ctype.alignment = alignment;
	modifiers = base_type->ctype.modifiers;

	/* Bitfields are unsigned, unless the base type was explicitly signed */
	if (!(modifiers & MOD_EXPLICITLY_SIGNED))
		modifiers = (modifiers & ~MOD_SIGNED) | MOD_UNSIGNED;
	sym->ctype.modifiers |= modifiers & MOD_SIGNEDNESS;
	return sym;
}

/*
 * "typeof" will have to merge the types together
 */
void merge_type(SCTX_ struct symbol *sym, struct symbol *base_type)
{
	sym->ctype.as |= base_type->ctype.as;
	sym->ctype.modifiers |= (base_type->ctype.modifiers & ~MOD_STORAGE);
	concat_ptr_list(sctx_ (struct ptr_list *)base_type->ctype.contexts,
	                (struct ptr_list **)&sym->ctype.contexts);
	sym->ctype.base_type = base_type->ctype.base_type;
	if (sym->ctype.base_type->type == SYM_NODE)
		merge_type(sctx_ sym, sym->ctype.base_type);
}

static int count_array_initializer(SCTX_ struct symbol *t, struct expression *expr)
{
	int nr = 0;
	int is_char = 0;

	/*
	 * Arrays of character types are special; they can be initialized by
	 * string literal _or_ by string literal in braces.  The latter means
	 * that with T x[] = {<string literal>} number of elements in x depends
	 * on T - if it's a character type, we get the length of string literal
	 * (including NUL), otherwise we have one element here.
	 */
	if (t->ctype.base_type == &sctxp int_type && t->ctype.modifiers & MOD_CHAR)
		is_char = 1;

	switch (expr->type) {
	case EXPR_INITIALIZER: {
		struct expression *entry;
		int count = 0;
		int str_len = 0;
		FOR_EACH_PTR(expr->expr_list, entry) {
			count++;
			switch (entry->type) {
			case EXPR_INDEX:
				if (entry->idx_to >= nr)
					nr = entry->idx_to+1;
				break;
			case EXPR_STRING:
				if (is_char)
					str_len = entry->string->length;
			default:
				nr++;
			}
		} END_FOR_EACH_PTR(entry);
		if (count == 1 && str_len)
			nr = str_len;
		break;
	}
	case EXPR_STRING:
		if (is_char)
			nr = expr->string->length;
	default:
		break;
	}
	return nr;
}

static struct symbol * examine_node_type(SCTX_ struct symbol *sym)
{
	struct symbol *base_type = examine_base_type(sctx_ sym);
	int bit_size;
	unsigned long alignment;

	/* SYM_NODE - figure out what the type of the node was.. */
	bit_size = 0;
	alignment = 0;
	if (!base_type)
		return sym;

	bit_size = base_type->bit_size;
	alignment = base_type->ctype.alignment;

	/* Pick up signedness information into the node */
	sym->ctype.modifiers |= (MOD_SIGNEDNESS & base_type->ctype.modifiers);

	if (!sym->ctype.alignment)
		sym->ctype.alignment = alignment;

	/* Unsized array? The size might come from the initializer.. */
	if (bit_size < 0 && base_type->type == SYM_ARRAY && sym->initializer) {
		struct symbol *node_type = base_type->ctype.base_type;
		int count = count_array_initializer(sctx_ node_type, sym->initializer);

		if (node_type && node_type->bit_size >= 0)
			bit_size = node_type->bit_size * count;
	}
	
	sym->bit_size = bit_size;
	return sym;
}

static struct symbol *examine_enum_type(SCTX_ struct symbol *sym)
{
	struct symbol *base_type = examine_base_type(sctx_ sym);

	sym->ctype.modifiers |= (base_type->ctype.modifiers & MOD_SIGNEDNESS);
	sym->bit_size = sctxp bits_in_enum;
	if (base_type->bit_size > sym->bit_size)
		sym->bit_size = base_type->bit_size;
	sym->ctype.alignment = sctxp enum_alignment;
	if (base_type->ctype.alignment > sym->ctype.alignment)
		sym->ctype.alignment = base_type->ctype.alignment;
	return sym;
}

static struct symbol *examine_pointer_type(SCTX_ struct symbol *sym)
{
	/*
	 * We need to set the pointer size first, and
	 * examine the thing we point to only afterwards.
	 * That's because this pointer type may end up
	 * being needed for the base type size evaluation.
	 */
	if (!sym->bit_size)
		sym->bit_size = sctxp bits_in_pointer;
	if (!sym->ctype.alignment)
		sym->ctype.alignment = sctxp pointer_alignment;
	return sym;
}

/*
 * Fill in type size and alignment information for
 * regular SYM_TYPE things.
 */
struct symbol *examine_symbol_type(SCTX_ struct symbol * sym)
{
	if (!sym)
		return sym;

	/* Already done? */
	if (sym->examined)
		return sym;
	sym->examined = 1;

	switch (sym->type) {
	case SYM_FN:
	case SYM_NODE:
		return examine_node_type(sctx_ sym);
	case SYM_ARRAY:
		return examine_array_type(sctx_ sym);
	case SYM_STRUCT:
		return examine_struct_union_type(sctx_ sym, 1);
	case SYM_UNION:
		return examine_struct_union_type(sctx_ sym, 0);
	case SYM_PTR:
		return examine_pointer_type(sctx_ sym);
	case SYM_ENUM:
		return examine_enum_type(sctx_ sym);
	case SYM_BITFIELD:
		return examine_bitfield_type(sctx_ sym);
	case SYM_BASETYPE:
		/* Size and alignment had better already be set up */
		return sym;
	case SYM_TYPEOF: {
		struct symbol *base = evaluate_expression(sctx_ sym->initializer);
		if (base) {
			if (is_bitfield_type(base))
				warning(sctx_ base->pos->pos, "typeof applied to bitfield type");
			if (base->type == SYM_NODE)
				base = base->ctype.base_type;
			sym->type = SYM_NODE;
			sym->ctype.modifiers = 0;
			sym->ctype.base_type = base;
			return examine_node_type(sctx_ sym);
		}
		break;
	}
	case SYM_PREPROCESSOR:
		sparse_error(sctx_ sym->pos->pos, "ctype on preprocessor command? (%s)", show_ident(sctx_ sym->ident));
		return NULL;
	case SYM_UNINITIALIZED:
		sparse_error(sctx_ sym->pos->pos, "ctype on uninitialized symbol %p", sym);
		return NULL;
	case SYM_RESTRICT:
		examine_base_type(sctx_ sym);
		return sym;
	case SYM_FOULED:
		examine_base_type(sctx_ sym);
		return sym;
	default:
		sparse_error(sctx_ sym->pos->pos, "Examining unknown symbol type %d", sym->type);
		break;
	}
	return sym;
}

const char* get_type_name(SCTX_ enum type type)
{
	const char *type_lookup[] = {
	[SYM_UNINITIALIZED] = "uninitialized",
	[SYM_PREPROCESSOR] = "preprocessor",
	[SYM_BASETYPE] = "basetype",
	[SYM_NODE] = "node",
	[SYM_PTR] = "pointer",
	[SYM_FN] = "function",
	[SYM_ARRAY] = "array",
	[SYM_STRUCT] = "struct",
	[SYM_UNION] = "union",
	[SYM_ENUM] = "enum",
	[SYM_TYPEDEF] = "typedef",
	[SYM_TYPEOF] = "typeof",
	[SYM_MEMBER] = "member",
	[SYM_BITFIELD] = "bitfield",
	[SYM_LABEL] = "label",
	[SYM_RESTRICT] = "restrict",
	[SYM_FOULED] = "fouled",
	[SYM_KEYWORD] = "keyword",
	[SYM_BAD] = "bad"};

	if (type <= SYM_BAD)
		return type_lookup[type];
	else
		return NULL;
}

struct symbol *examine_pointer_target(SCTX_ struct symbol *sym)
{
	return examine_base_type(sctx_ sym);
}

#ifndef DO_CTX
static struct symbol_list *restr, *fouled;
#endif

void create_fouled(SCTX_ struct symbol *type)
{
	if (type->bit_size < sctxp bits_in_int) {
		struct symbol *new = alloc_symbol(sctx_ type->tok, type->type);
		*new = *type;
		new->bit_size = sctxp bits_in_int;
		new->type = SYM_FOULED;
		new->ctype.base_type = type;
		add_symbol(sctx_ &sctxp restr, type);
		add_symbol(sctx_ &sctxp fouled, new);
	}
}

struct symbol *befoul(SCTX_ struct symbol *type)
{
	struct symbol *t1, *t2;
	while (type->type == SYM_NODE)
		type = type->ctype.base_type;
	PREPARE_PTR_LIST(sctxp restr, t1);
	PREPARE_PTR_LIST(sctxp fouled, t2);
	for (;;) {
		if (t1 == type)
			return t2;
		if (!t1)
			break;
		NEXT_PTR_LIST(t1);
		NEXT_PTR_LIST(t2);
	}
	FINISH_PTR_LIST(t2);
	FINISH_PTR_LIST(t1);
	return NULL;
}

void check_declaration(SCTX_ struct symbol *sym)
{
	int warned = 0;
	struct symbol *next = sym;

	while ((next = next->next_id) != NULL) {
		if (next->namespace != sym->namespace)
			continue;
		if (sym->scope == next->scope) {
			sym->same_symbol = next;
			return;
		}
		if (sym->ctype.modifiers & next->ctype.modifiers & MOD_EXTERN) {
			if ((sym->ctype.modifiers ^ next->ctype.modifiers) & MOD_INLINE)
				continue;
			sym->same_symbol = next;
			return;
		}

		if (!sctxp Wshadow || warned)
			continue;
		if (get_sym_type(next) == SYM_FN)
			continue;
		warned = 1;
		warning(sctx_ sym->pos->pos, "symbol '%s' shadows an earlier one", show_ident(sctx_ sym->ident));
		info(sctx_ next->pos->pos, "originally declared here");
	}
}

void bind_symbol(SCTX_ struct symbol *sym, struct ident *ident, enum namespace ns)
{
	struct scope *scope;
	if (sym->bound) {
		sparse_error(sctx_ sym->pos->pos, "internal error: symbol type already bound");
		return;
	}
	if (ident->reserved && (ns & (NS_TYPEDEF | NS_STRUCT | NS_LABEL | NS_SYMBOL))) {
		sparse_error(sctx_ sym->pos->pos, "Trying to use reserved word '%s' as identifier", show_ident(sctx_ ident));
		return;
	}
	sym->namespace = ns;
	sym->next_id = ident->symbols;
	ident->symbols = sym;
	if (sym->ident && sym->ident != ident)
		warning(sctx_ sym->pos->pos, "Symbol '%s' already bound", show_ident(sctx_ sym->ident));
	sym->ident = ident;
	sym->bound = 1;

	scope = sctxp block_scope;
	if (ns == NS_SYMBOL && toplevel(sctx_ scope)) {
		unsigned mod = MOD_ADDRESSABLE | MOD_TOPLEVEL;

		scope = sctxp global_scope;
		if (sym->ctype.modifiers & MOD_STATIC ||
		    is_extern_inline(sym)) {
			scope = sctxp file_scope;
			mod = MOD_TOPLEVEL;
		}
		sym->ctype.modifiers |= mod;
	}
	if (ns == NS_MACRO)
		scope = sctxp file_scope;
	if (ns == NS_LABEL)
		scope = sctxp function_scope;
	bind_scope(sctx_ sym, scope);
}

struct symbol *create_symbol(SCTX_ int stream, const char *name, int type, int namespace)
{
	struct token *token = built_in_token(sctx_ stream, name);
	struct symbol *sym = alloc_symbol(sctx_ token, type);

	bind_symbol(sctx_ sym, token->ident, namespace);
	return sym;
}

static int evaluate_to_integer(SCTX_ struct expression *expr)
{
	expr->ctype = &sctxp int_ctype;
	return 1;
}

static int evaluate_expect(SCTX_ struct expression *expr)
{
	/* Should we evaluate it to return the type of the first argument? */
	expr->ctype = &sctxp int_ctype;
	return 1;
}

static int arguments_choose(SCTX_ struct expression *expr)
{
	struct expression_list *arglist = expr->args;
	struct expression *arg;
	int i = 0;

	FOR_EACH_PTR (arglist, arg) {
		if (!evaluate_expression(sctx_ arg))
			return 0;
		i++;
	} END_FOR_EACH_PTR(arg);
	if (i < 3) {
		sparse_error(sctx_ expr->pos->pos,
			     "not enough arguments for __builtin_choose_expr");
		return 0;
	} if (i > 3) {
		sparse_error(sctx_ expr->pos->pos,
			     "too many arguments for __builtin_choose_expr");
		return 0;
	}
	return 1;
}

static int evaluate_choose(SCTX_ struct expression *expr)
{
	struct expression_list *list = expr->args;
	struct expression *arg, *args[3];
	int n = 0;

	/* there will be exactly 3; we'd already verified that */
	FOR_EACH_PTR(list, arg) {
		args[n++] = arg;
	} END_FOR_EACH_PTR(arg);

	*expr = get_expression_value(sctx_ args[0]) ? *args[1] : *args[2];

	return 1;
}

static int expand_expect(SCTX_ struct expression *expr, int cost)
{
	struct expression *arg = first_ptr_list((struct ptr_list *) expr->args);

	if (arg)
		*expr = *arg;
	return 0;
}

/*
 * __builtin_warning() has type "int" and always returns 1,
 * so that you can use it in conditionals or whatever
 */
static int expand_warning(SCTX_ struct expression *expr, int cost)
{
	struct expression *arg;
	struct expression_list *arglist = expr->args;

	FOR_EACH_PTR (arglist, arg) {
		/*
		 * Constant strings get printed out as a warning. By the
		 * time we get here, the EXPR_STRING has been fully 
		 * evaluated, so by now it's an anonymous symbol with a
		 * string initializer.
		 *
		 * Just for the heck of it, allow any constant string
		 * symbol.
		 */
		if (arg->type == EXPR_SYMBOL) {
			struct symbol *sym = arg->symbol;
			if (sym->initializer && sym->initializer->type == EXPR_STRING) {
				struct string *string = sym->initializer->string;
				warning(sctx_ expr->pos->pos, "%*s", string->length-1, string->data);
			}
			continue;
		}

		/*
		 * Any other argument is a conditional. If it's
		 * non-constant, or it is false, we exit and do
		 * not print any warning.
		 */
		if (arg->type != EXPR_VALUE)
			goto out;
		if (!arg->value)
			goto out;
	} END_FOR_EACH_PTR(arg);
out:
	expr->type = EXPR_VALUE;
	expr->value = 1;
	expr->taint = 0;
	return 0;
}

static struct symbol_op constant_p_op = {
	.evaluate = evaluate_to_integer,
	.expand = expand_constant_p
};

static struct symbol_op safe_p_op = {
	.evaluate = evaluate_to_integer,
	.expand = expand_safe_p
};

static struct symbol_op warning_op = {
	.evaluate = evaluate_to_integer,
	.expand = expand_warning
};

static struct symbol_op expect_op = {
	.evaluate = evaluate_expect,
	.expand = expand_expect
};

static struct symbol_op choose_op = {
	.evaluate = evaluate_choose,
	.args = arguments_choose,
};

/*
 * Builtin functions
 */
static struct symbol builtin_fn_type = { .type = SYM_FN /* , .variadic =1 */ };
static struct sym_init {
	const char *name;
	struct symbol *base_type;
	unsigned int modifiers;
	struct symbol_op *op;
} eval_init_table[] = {
	{ "__builtin_constant_p", &builtin_fn_type, MOD_TOPLEVEL, &constant_p_op },
	{ "__builtin_safe_p", &builtin_fn_type, MOD_TOPLEVEL, &safe_p_op },
	{ "__builtin_warning", &builtin_fn_type, MOD_TOPLEVEL, &warning_op },
	{ "__builtin_expect", &builtin_fn_type, MOD_TOPLEVEL, &expect_op },
	{ "__builtin_choose_expr", &builtin_fn_type, MOD_TOPLEVEL, &choose_op },
	{ NULL,		NULL,		0 }
};


#ifndef DO_CTX
/*
 * Abstract types
 */
struct symbol	int_type,
		fp_type;

/*
 * C types (i.e. actual instances that the abstract types
 * can map onto)
 */
struct symbol	bool_ctype, void_ctype, type_ctype,
		char_ctype, schar_ctype, uchar_ctype,
		short_ctype, sshort_ctype, ushort_ctype,
		int_ctype, sint_ctype, uint_ctype,
		long_ctype, slong_ctype, ulong_ctype,
		llong_ctype, sllong_ctype, ullong_ctype,
		lllong_ctype, slllong_ctype, ulllong_ctype,
		float_ctype, double_ctype, ldouble_ctype,
		string_ctype, ptr_ctype, lazy_ptr_ctype,
		incomplete_ctype, label_ctype, bad_ctype,
		null_ctype;

struct symbol	zero_int;
#endif

#undef  __IDENT
#ifndef DO_CTX

#define __INIT_IDENT(str, res) { .len = sizeof(str)-1, .name = str, .reserved = res }
#define __IDENT(n,str,res) \
	struct ident n  = __INIT_IDENT(str,res)

#include "ident-list.h"

#else

void sparse_ctx_init_symbols(SCTX) {

#define __IDENT(n,str,res) \
  sctxp n.b.len = sizeof(str)-1; strcpy(sctxp n.b.name,str); sctxp n.b.reserved = res;

#include "ident-list.h"
}

#endif

void init_symbols(SCTX)
{
	struct sym_init *ptr;
	int stream;
	
	sctxp stream_sc = init_stream(sctx_ "<cmdline>", -1, sctxp includepath);
	sctxp stream_sb = init_stream(sctx_ "<builtin>", -1, sctxp includepath);
	stream = sctxp stream_sb->id;

#undef  __IDENT
#ifndef DO_CTX
#define __IDENT(n,str,res) \
	hash_ident(sctx_ &n)
#else
#define __IDENT(n,str,res) \
	hash_ident(sctx_ (struct ident *)& sctxp n)
#endif
#include "ident-list.h"

	init_parser(sctx_ stream);

	builtin_fn_type.variadic = 1;
	for (ptr = eval_init_table; ptr->name; ptr++) {
		struct symbol *sym;
		sym = create_symbol(sctx_ stream, ptr->name, SYM_NODE, NS_SYMBOL);
		sym->ctype.base_type = ptr->base_type;
		sym->ctype.modifiers = ptr->modifiers;
		sym->op = ptr->op;
	}


}

#define MOD_ESIGNED (MOD_SIGNED | MOD_EXPLICITLY_SIGNED)
#define MOD_LL (MOD_LONG | MOD_LONGLONG)
#define MOD_LLL MOD_LONGLONGLONG

#ifndef DO_CTX
static const 
#else
void init_ctype(SCTX) {
#endif

struct ctype_declare ctype_declaration[] = {
	{ &sctxp bool_ctype,	    SYM_BASETYPE, MOD_UNSIGNED,		    &sctxp bits_in_bool,	     &sctxp max_int_alignment, &sctxp int_type },
	{ &sctxp void_ctype,	    SYM_BASETYPE, 0,			    NULL,	     NULL,		 NULL },
	{ &sctxp type_ctype,	    SYM_BASETYPE, MOD_TYPE,		    NULL,		     NULL,		 NULL },
	{ &sctxp incomplete_ctype,SYM_BASETYPE, 0,			    NULL,		     NULL,		 NULL },
	{ &sctxp bad_ctype,	    SYM_BASETYPE, 0,			    NULL,		     NULL,		 NULL },

	{ &sctxp char_ctype,	    SYM_BASETYPE, MOD_SIGNED | MOD_CHAR,    &sctxp bits_in_char,	     &sctxp max_int_alignment, &sctxp int_type },
	{ &sctxp schar_ctype,	    SYM_BASETYPE, MOD_ESIGNED | MOD_CHAR,   &sctxp bits_in_char,	     &sctxp max_int_alignment, &sctxp int_type },
	{ &sctxp uchar_ctype,	    SYM_BASETYPE, MOD_UNSIGNED | MOD_CHAR,  &sctxp bits_in_char,	     &sctxp max_int_alignment, &sctxp int_type },
	{ &sctxp short_ctype,	    SYM_BASETYPE, MOD_SIGNED | MOD_SHORT,   &sctxp bits_in_short,	     &sctxp max_int_alignment, &sctxp int_type },
	{ &sctxp sshort_ctype,    SYM_BASETYPE, MOD_ESIGNED | MOD_SHORT,  &sctxp bits_in_short,	     &sctxp max_int_alignment, &sctxp int_type },
	{ &sctxp ushort_ctype,    SYM_BASETYPE, MOD_UNSIGNED | MOD_SHORT, &sctxp bits_in_short,	     &sctxp max_int_alignment, &sctxp int_type },
	{ &sctxp int_ctype,	    SYM_BASETYPE, MOD_SIGNED,		    &sctxp bits_in_int,	     &sctxp max_int_alignment, &sctxp int_type },
	{ &sctxp sint_ctype,	    SYM_BASETYPE, MOD_ESIGNED,		    &sctxp bits_in_int,	     &sctxp max_int_alignment, &sctxp int_type },
	{ &sctxp uint_ctype,	    SYM_BASETYPE, MOD_UNSIGNED,		    &sctxp bits_in_int,	     &sctxp max_int_alignment, &sctxp int_type },
	{ &sctxp long_ctype,	    SYM_BASETYPE, MOD_SIGNED | MOD_LONG,    &sctxp bits_in_long,	     &sctxp max_int_alignment, &sctxp int_type },
	{ &sctxp slong_ctype,	    SYM_BASETYPE, MOD_ESIGNED | MOD_LONG,   &sctxp bits_in_long,	     &sctxp max_int_alignment, &sctxp int_type },
	{ &sctxp ulong_ctype,	    SYM_BASETYPE, MOD_UNSIGNED | MOD_LONG,  &sctxp bits_in_long,	     &sctxp max_int_alignment, &sctxp int_type },
	{ &sctxp llong_ctype,	    SYM_BASETYPE, MOD_SIGNED | MOD_LL,	    &sctxp bits_in_longlong,       &sctxp max_int_alignment, &sctxp int_type },
	{ &sctxp sllong_ctype,    SYM_BASETYPE, MOD_ESIGNED | MOD_LL,	    &sctxp bits_in_longlong,       &sctxp max_int_alignment, &sctxp int_type },
	{ &sctxp ullong_ctype,    SYM_BASETYPE, MOD_UNSIGNED | MOD_LL,    &sctxp bits_in_longlong,       &sctxp max_int_alignment, &sctxp int_type },
	{ &sctxp lllong_ctype,    SYM_BASETYPE, MOD_SIGNED | MOD_LLL,	    &sctxp bits_in_longlonglong,   &sctxp max_int_alignment, &sctxp int_type },
	{ &sctxp slllong_ctype,   SYM_BASETYPE, MOD_ESIGNED | MOD_LLL,    &sctxp bits_in_longlonglong,   &sctxp max_int_alignment, &sctxp int_type },
	{ &sctxp ulllong_ctype,   SYM_BASETYPE, MOD_UNSIGNED | MOD_LLL,   &sctxp bits_in_longlonglong,   &sctxp max_int_alignment, &sctxp int_type },

	{ &sctxp float_ctype,	    SYM_BASETYPE,  0,			    &sctxp bits_in_float,          &sctxp max_fp_alignment,  &sctxp fp_type },
	{ &sctxp double_ctype,    SYM_BASETYPE, MOD_LONG,		    &sctxp bits_in_double,         &sctxp max_fp_alignment,  &sctxp fp_type },
	{ &sctxp ldouble_ctype,   SYM_BASETYPE, MOD_LONG | MOD_LONGLONG,  &sctxp bits_in_longdouble,     &sctxp max_fp_alignment,  &sctxp fp_type },

	{ &sctxp string_ctype,    SYM_PTR,	  0,			    &sctxp bits_in_pointer,        &sctxp pointer_alignment, &sctxp char_ctype },
	{ &sctxp ptr_ctype,	    SYM_PTR,	  0,			    &sctxp bits_in_pointer,        &sctxp pointer_alignment, &sctxp void_ctype },
	{ &sctxp null_ctype,	    SYM_PTR,	  0,			    &sctxp bits_in_pointer,        &sctxp pointer_alignment, &sctxp void_ctype },
	{ &sctxp label_ctype,	    SYM_PTR,	  0,			    &sctxp bits_in_pointer,        &sctxp pointer_alignment, &sctxp void_ctype },
	{ &sctxp lazy_ptr_ctype,  SYM_PTR,	  0,			    &sctxp bits_in_pointer,        &sctxp pointer_alignment, &sctxp void_ctype },
	{ NULL, }
};
#undef MOD_LLL
#undef MOD_LL
#undef MOD_ESIGNED

#ifndef DO_CTX
void init_ctype(SCTX)
{
#else
 
#endif

	const struct ctype_declare *ctype;

	for (ctype = ctype_declaration ; ctype->ptr; ctype++) {
		struct symbol *sym = ctype->ptr;
		unsigned long bit_size = ctype->bit_size ? *ctype->bit_size : -1;
		unsigned long maxalign = ctype->maxalign ? *ctype->maxalign : 0;
		unsigned long alignment = bits_to_bytes(sctx_ bit_size + sctxp bits_in_char - 1);

		if (alignment > maxalign)
			alignment = maxalign;
		sym->type = ctype->type;
		sym->bit_size = bit_size;
#ifdef DO_CTX
		sym->ctx = sctx;
#endif
		sym->ctype.alignment = alignment;
		sym->ctype.base_type = ctype->base_type;
		sym->ctype.modifiers = ctype->modifiers;
	}
}
