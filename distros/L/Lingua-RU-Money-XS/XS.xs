#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"
#include <math.h>
#include <string.h>
#include "words.h"

#ifndef __bool_true_false_are_defined
#	define __bool_true_false_are_defined 1
#	define false 0
#	define true 1
#endif

#ifndef U64
typedef uint64_t U64;
#endif

#ifndef likely
#	define likely(x) __builtin_expect((x), 1)
#endif

#ifndef unlikely
#	define unlikely(x) __builtin_expect((x), 0)
#endif

/* Macro for choosing the ending corresponding to the specified value */
#define ending4value(value)                                          \
	((value) % 100 / 10 - 1) && (value) % 10 > 0 && (value) % 10 < 5 \
		? (value) % 10 > 1 ? COUPLE : SINGLE : SEVERAL

#define double2kopeck(value) \
	(U8) nearbyint(((value) - (U64) (value)) * 100) % 100

STATIC SV *
kopeck2words(pTHX_ U8 value, bool words) {
	U8 ending = ending4value(value);
	SV *value_pv = sv_2mortal(newSVpvs(""));
	if (words) {
		if (value % 100 < 20) {
			const char *word = strcmp(funits[value % 100], "") ? funits[value % 100] : zero;
			sv_catpvn(value_pv, word, strlen(word));
		} else {
			sv_catpvn(value_pv, tens[value % 100 / 10], strlen(tens[value % 100 / 10]));
			sv_catpvn(value_pv, funits[value % 10], strlen(funits[value % 10]));
		}
	} else {
		char value_str[4];
		sprintf(value_str, "%02d ", value);
		sv_catpvn(value_pv, value_str, strlen(value_str));
	}
	sv_catpvn(value_pv, kopeck[ending], strlen(kopeck[ending]));
	return value_pv;
}

STATIC SV *
ruble2words(pTHX_ U16 value, U8 decade, bool words) {
	U8 ending = ending4value(value);
	SV *value_pv = sv_2mortal(newSVpvs(""));
	if (!value) {
		if (!decade)
			sv_catpvn(value_pv, ruble[decade][ending], strlen(ruble[decade][ending]));
		return value_pv;
	}
	if (words) {
		sv_catpvn(value_pv, hundreds[value / 100], strlen(hundreds[value / 100]));
		char **units = (char **) (decade == THOUSAND ? funits : munits);
		if (value % 100 < 20) {
			sv_catpvn(value_pv, units[value % 100], strlen(units[value % 100]));
		} else {
			sv_catpvn(value_pv, tens[value % 100 / 10], strlen(tens[value % 100 / 10]));
			sv_catpvn(value_pv, units[value % 10], strlen(units[value % 10]));
		}
	} else {
		char value_str[5];
		sprintf(value_str, "%d ", value);
		sv_catpvn(value_pv, value_str, strlen(value_str));
	}
	sv_catpvn(value_pv, ruble[decade][ending], strlen(ruble[decade][ending]));
	return value_pv;
}

STATIC SV *
money2words(pTHX_ double amount, bool ruble_cvt, bool kopeck_cvt) {
	if (unlikely(amount < MONEY_MIN))
		croak("Negative amount can't be processed");
	if (unlikely(amount >= MONEY_MAX))
		croak("Given amount can't be processed due to the type overflow");
	if (unlikely(amount >= pow(1e3, TRILLION)))
		warn("Kopeck value is calculated inaccurate due to the lack for "
			"significant digits after the radix point");
	U8 kopeck_v = amount < pow(1e3, TRILLION) ? double2kopeck(amount) : 0;
	AV *stack = (AV *) sv_2mortal((SV *) newAV());
	av_push(stack, kopeck2words(aTHX_ kopeck_v, kopeck_cvt));
	U64 ruble_v = (U64) amount;
	U8 decade;
	for (decade = UNIT; ruble_v > 0; ruble_v /= 1000, decade++)
		av_push(stack, ruble2words(aTHX_ ruble_v % 1000, decade, ruble_cvt));
	/* Build the result string */
	SV *words = sv_2mortal(newSVpvs(""));
	while (av_len(stack) + 1)
		sv_catsv(words, av_pop(stack));
	SvUTF8_on(words);
	return words;
}

MODULE = Lingua::RU::Money::XS		PACKAGE = Lingua::RU::Money::XS

void
rur2words(SV *amount)
	PROTOTYPE: $
	PPCODE:
		ST(0) = money2words(aTHX_ SvNV(amount), true, false);
		XSRETURN(1);

void
all2words(SV *amount)
	PROTOTYPE: $
	PPCODE:
		ST(0) = money2words(aTHX_ SvNV(amount), true, true);
		XSRETURN(1);
