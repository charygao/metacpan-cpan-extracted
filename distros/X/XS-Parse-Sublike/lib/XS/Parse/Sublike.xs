/*  You may distribute under the terms of either the GNU General Public License
 *  or the Artistic License (the same terms as Perl itself)
 *
 *  (C) Paul Evans, 2019-2020 -- leonerd@leonerd.org.uk
 */

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "XSParseSublike.h"

#define HAVE_PERL_VERSION(R, V, S) \
    (PERL_REVISION > (R) || (PERL_REVISION == (R) && (PERL_VERSION > (V) || (PERL_VERSION == (V) && (PERL_SUBVERSION >= (S))))))

#if HAVE_PERL_VERSION(5, 31, 3)
#  define HAVE_PARSE_SUBSIGNATURE
#elif HAVE_PERL_VERSION(5, 26, 0)
#  include "parse_subsignature.c.inc"
#  define HAVE_PARSE_SUBSIGNATURE
#endif

#if !HAVE_PERL_VERSION(5, 22, 0)
#  include "block_start.c.inc"
#  include "block_end.c.inc"
#endif

#ifndef wrap_keyword_plugin
#  include "wrap_keyword_plugin.c.inc"
#endif

#include "lexer-additions.c.inc"

/* Support two sets of hooks so we can handle xs_parse_sublike_any() with one
 * set which then finds a custom keyword which provides a second
 * Either or both may be NULL
 */
static int parse2(pTHX_
  const struct XSParseSublikeHooks *hooksA, void *hookdataA,
  const struct XSParseSublikeHooks *hooksB, void *hookdataB,
  OP **op_ptr)
{
  struct XSParseSublikeContext ctx = { 0 };

  U8 require_parts = 0, skip_parts = 0;
  if(hooksA) {
    require_parts |= hooksA->require_parts;
    skip_parts    |= hooksA->skip_parts;
  }
  if(hooksB) {
    require_parts |= hooksB->require_parts;
    skip_parts    |= hooksB->skip_parts;
  }

  if(!(skip_parts & XS_PARSE_SUBLIKE_PART_NAME)) {
    ctx.name = lex_scan_ident();
    lex_read_space(0);
  }
  if((require_parts & XS_PARSE_SUBLIKE_PART_NAME) && !ctx.name)
    croak("Expected name for sub-like construction");

  ENTER_with_name("parse_sublike");
  /* From here onwards any `return` must be prefixed by LEAVE_with_name() */

  if(hooksA && hooksA->pre_subparse)
    (*hooksA->pre_subparse)(aTHX_ &ctx, hookdataA);
  if(hooksB && hooksB->pre_subparse)
    (*hooksB->pre_subparse)(aTHX_ &ctx, hookdataB);

  I32 floor_ix = start_subparse(FALSE, ctx.name ? 0 : CVf_ANON);
  SAVEFREESV(PL_compcv);

  if(!(skip_parts & XS_PARSE_SUBLIKE_PART_ATTRS) && (lex_peek_unichar(0) == ':')) {
    lex_read_unichar(0);
    lex_read_space(0);

    ctx.attrs = newLISTOP(OP_LIST, 0, NULL, NULL);

    while(1) {
      SV *attr = newSV(0);
      SV *val  = newSV(0);
      if(!lex_scan_attrval_into(attr, val))
        break;
      lex_read_space(0);
      if(lex_peek_unichar(0) == ':') {
        lex_read_unichar(0);
        lex_read_space(0);
      }

      bool handled = false;

      if(hooksA && (hooksA->flags & XS_PARSE_SUBLIKE_FLAG_FILTERATTRS) && (hooksA->filter_attr))
        handled |= (*hooksA->filter_attr)(aTHX_ &ctx, attr, val, hookdataA);
      if(hooksB && (hooksB->flags & XS_PARSE_SUBLIKE_FLAG_FILTERATTRS) && (hooksB->filter_attr))
        handled |= (*hooksB->filter_attr)(aTHX_ &ctx, attr, val, hookdataB);

      if(handled) {
        SvREFCNT_dec(attr);
        SvREFCNT_dec(val);
        continue;
      }

      if(strEQ(SvPVX(attr), "lvalue")) {
        CvLVALUE_on(PL_compcv);
        continue;
      }

      if(SvPOK(val))
        sv_catpvf(attr, "(%" SVf ")", val);
      SvREFCNT_dec(val);

      ctx.attrs = op_append_elem(OP_LIST, ctx.attrs, newSVOP(OP_CONST, 0, attr));
    }
  }

  PL_hints |= HINT_LOCALIZE_HH;
  I32 save_ix = block_start(TRUE);

  if(hooksA && hooksA->post_blockstart)
    (*hooksA->post_blockstart)(aTHX_ &ctx, hookdataA);
  if(hooksB && hooksB->post_blockstart)
    (*hooksB->post_blockstart)(aTHX_ &ctx, hookdataB);

#ifdef HAVE_PARSE_SUBSIGNATURE
  OP *sigop = NULL;
  if(!(skip_parts & XS_PARSE_SUBLIKE_PART_SIGNATURE) && (lex_peek_unichar(0) == '(')) {
    lex_read_unichar(0);
    lex_read_space(0);

#if HAVE_PERL_VERSION(5, 31, 3)
    /* core's parse_subsignature doesn't seem able to handle empty sigs
     *   RT132284
     *   https://github.com/Perl/perl5/issues/17689
     */
    if(lex_peek_unichar(0) == ')') {
      /* Inject an empty OP_ARGCHECK much as core would do if it encountered
       * an empty signature */
      UNOP_AUX_item *aux = (UNOP_AUX_item *)PerlMemShared_malloc(sizeof(UNOP_AUX_item) * 3);
      aux[0].iv = 0;
      aux[1].iv = 0;
      aux[2].iv = 0;

      sigop = op_prepend_elem(OP_LINESEQ, newSTATEOP(0, NULL, NULL),
        newUNOP_AUX(OP_ARGCHECK, 0, NULL, aux));

      /* a nextstate at the end handles context correctly for an empty
       * sub body */
      sigop = op_append_elem(OP_LINESEQ, sigop, newSTATEOP(0, NULL, NULL));

#if HAVE_PERL_VERSION(5,31,5)
      /* wrap the list of arg ops in a NULL aux op.  This serves two
       * purposes. First, it makes the arg list a separate subtree
       * from the body of the sub, and secondly the null op may in
       * future be upgraded to an OP_SIGNATURE when implemented. For
       * now leave it as ex-argcheck
       */
      sigop = newUNOP_AUX(OP_ARGCHECK, 0, sigop, NULL);
      op_null(sigop);
#endif
    }
    else
#endif
    {
      sigop = parse_subsignature(0);

      if(PL_parser->error_count) {
        LEAVE_with_name("parse_sublike");
        return 0;
      }
    }

    if(lex_peek_unichar(0) != ')')
      croak("Expected ')'");
    lex_read_unichar(0);
    lex_read_space(0);
  }
#endif

  ctx.body = parse_block(0);
  SvREFCNT_inc(PL_compcv);

#ifdef HAVE_PARSE_SUBSIGNATURE
  if(sigop) {
    /* parse_block() returns an empy block as a stub op.
     * no need to keep that if we we have a signature.
     */
    if (ctx.body->op_type == OP_STUB) {
      op_free(ctx.body);
      ctx.body = NULL;
    }
    ctx.body = op_append_list(OP_LINESEQ, sigop, ctx.body);
  }
#endif

  if(PL_parser->error_count) {
    /* parse_block() still sometimes returns a valid body even if a parse
     * error happens.
     * We need to destroy this partial body before returning a valid(ish)
     * state to the keyword hook mechanism, so it will find the error count
     * correctly
     *   See https://rt.cpan.org/Ticket/Display.html?id=130417
     */
    op_free(ctx.body);
    *op_ptr = newOP(OP_NULL, 0);
    if(ctx.name) {
      SvREFCNT_dec(ctx.name);
      LEAVE_with_name("parse_sublike");
      return KEYWORD_PLUGIN_STMT;
    }
    else {
      LEAVE_with_name("parse_sublike");
      return KEYWORD_PLUGIN_EXPR;
    }
  }

  if(hooksB && hooksB->pre_blockend)
    (*hooksB->pre_blockend)(aTHX_ &ctx, hookdataB);
  if(hooksA && hooksA->pre_blockend)
    (*hooksA->pre_blockend)(aTHX_ &ctx, hookdataA);

  ctx.body = block_end(save_ix, ctx.body);

  ctx.cv = newATTRSUB(floor_ix,
    ctx.name ? newSVOP(OP_CONST, 0, SvREFCNT_inc(ctx.name)) : NULL,
    NULL,
    ctx.attrs,
    ctx.body);

  if(hooksA && hooksA->post_newcv)
    (*hooksA->post_newcv)(aTHX_ &ctx, hookdataA);
  if(hooksB && hooksB->post_newcv)
    (*hooksB->post_newcv)(aTHX_ &ctx, hookdataB);

  LEAVE_with_name("parse_sublike");

  if(ctx.name) {
    *op_ptr = newOP(OP_NULL, 0);

    SvREFCNT_dec(ctx.name);
    return KEYWORD_PLUGIN_STMT;
  }
  else {
    *op_ptr = newUNOP(OP_REFGEN, 0,
      newSVOP(OP_ANONCODE, 0, (SV *)ctx.cv));

    return KEYWORD_PLUGIN_EXPR;
  }
}

static int IMPL_xs_parse_sublike(pTHX_ const struct XSParseSublikeHooks *hooks, void *hookdata, OP **op_ptr)
{
  return parse2(aTHX_ hooks, hookdata, NULL, NULL, op_ptr);
}

struct Registration;
struct Registration {
  struct Registration *next;
  const char *kw;
  STRLEN      kwlen;
  const struct XSParseSublikeHooks *hooks;
  void       *hookdata;
};

#define REGISTRATIONS_LOCK   OP_CHECK_MUTEX_LOCK
#define REGISTRATIONS_UNLOCK OP_CHECK_MUTEX_UNLOCK

static struct Registration *registrations;

static void IMPL_register_xs_parse_sublike(pTHX_ const char *kw, const struct XSParseSublikeHooks *hooks, void *hookdata)
{
  struct Registration *reg;
  Newx(reg, 1, struct Registration);

  reg->kw = savepv(kw);
  reg->kwlen = strlen(kw);
  reg->hooks = hooks;
  reg->hookdata = hookdata;

  REGISTRATIONS_LOCK;
  {
    reg->next = registrations;
    registrations = reg;
  }
  REGISTRATIONS_UNLOCK;
}

static const struct Registration *find_permitted(pTHX_ const char *kw, STRLEN kwlen)
{
  const struct Registration *reg;
  for(reg = registrations; reg; reg = reg->next) {
    if(reg->kwlen != kwlen || !strEQ(reg->kw, kw))
      continue;

    if(reg->hooks->permit &&
       !(*reg->hooks->permit)(aTHX_ reg->hookdata))
       continue;

    return reg;
  }

  return NULL;
}

static int IMPL_xs_parse_sublike_any(pTHX_ const struct XSParseSublikeHooks *hooksA, void *hookdataA, OP **op_ptr)
{
  SV *kwsv = lex_scan_ident();
  if(!kwsv || !SvCUR(kwsv))
    croak("Expected a keyword to introduce a sub or sub-like construction");

  const char *kw = SvPV_nolen(kwsv);
  STRLEN kwlen = SvCUR(kwsv);

  lex_read_space(0);

  const struct Registration *reg = NULL;
  /* We permit 'sub' as a NULL set of hooks; anything else should be a registered keyword */
  if(kwlen != 3 || !strEQ(kw, "sub")) {
    reg = find_permitted(aTHX_ kw, kwlen);
    if(!reg)
      croak("Expected a keyword to introduce a sub or sub-like construction, found \"%.*s\"",
        kwlen, kw);
  }

  SvREFCNT_dec(kwsv);

  return parse2(aTHX_ hooksA, hookdataA,
    reg ? reg->hooks : NULL, reg ? reg->hookdata : NULL,
    op_ptr);
}

static int (*next_keyword_plugin)(pTHX_ char *, STRLEN, OP **);

static int my_keyword_plugin(pTHX_ char *kw, STRLEN kwlen, OP **op_ptr)
{
  const struct Registration *reg = find_permitted(aTHX_ kw, kwlen);

  if(!reg)
    return (*next_keyword_plugin)(aTHX_ kw, kwlen, op_ptr);

  lex_read_space(0);

  return parse2(aTHX_ NULL, NULL, reg->hooks, reg->hookdata, op_ptr);
}

MODULE = XS::Parse::Sublike    PACKAGE = XS::Parse::Sublike

BOOT:
  sv_setiv(get_sv("XS::Parse::Sublike::ABIVERSION", GV_ADDMULTI), XSPARSESUBLIKE_ABI_VERSION);
  sv_setuv(get_sv("XS::Parse::Sublike::PARSE",      GV_ADDMULTI), PTR2UV(&IMPL_xs_parse_sublike));
  sv_setuv(get_sv("XS::Parse::Sublike::REGISTER",   GV_ADDMULTI), PTR2UV(&IMPL_register_xs_parse_sublike));
  sv_setuv(get_sv("XS::Parse::Sublike::PARSEANY",   GV_ADDMULTI), PTR2UV(&IMPL_xs_parse_sublike_any));

  wrap_keyword_plugin(&my_keyword_plugin, &next_keyword_plugin);
