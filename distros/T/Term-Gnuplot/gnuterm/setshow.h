/*
 * $Id: setshow.h,v 1.31 2002/03/12 10:23:45 mikulik Exp $
 */

/* GNUPLOT - setshow.h */

/*[
 * Copyright 1986 - 1993, 1998   Thomas Williams, Colin Kelley
 *
 * Permission to use, copy, and distribute this software and its
 * documentation for any purpose with or without fee is hereby granted,
 * provided that the above copyright notice appear in all copies and
 * that both that copyright notice and this permission notice appear
 * in supporting documentation.
 *
 * Permission to modify the software is granted, but not the right to
 * distribute the complete modified source code.  Modifications are to
 * be distributed as patches to the released version.  Permission to
 * distribute binaries produced by compiling modified sources is granted,
 * provided you
 *   1. distribute the corresponding source modifications from the
 *    released version in the form of a patch file along with the binaries,
 *   2. add special version identification to distinguish your version
 *    in addition to the base release version number,
 *   3. provide your name and address as the primary contact for the
 *    support of your modified version, and
 *   4. retain our contact information in regard to use of the base
 *    software.
 * Permission to distribute the released version of the source code along
 * with corresponding source modifications in the form of a patch file is
 * granted with same provisions 2 through 4 for binary distributions.
 *
 * This software is provided "as is" without express or implied warranty
 * to the extent permitted by applicable law.
]*/


#ifndef GNUPLOT_SETSHOW_H
# define GNUPLOT_SETSHOW_H

#include "stdfn.h"

#include "gadgets.h"
#include "term_api.h"

#define PROGRAM "G N U P L O T"  /* FIXME: move to show.c! */

/* activate backwards compatible syntax */
#define BACKWARDS_COMPATIBLE


#define SAVE_NUM_OR_TIME(fp, x, axis)				\
do{								\
    if (axis_array[axis].is_timedata) {				\
	char s[80];						\
								\
	putc('"', fp);						\
	gstrftime(s,80,axis_array[axis].timefmt,(double)(x));	\
	fputs(conv_text(s), fp);				\
	putc('"', fp);						\
    } else {							\
	fprintf(fp,"%#g",x);					\
    }								\
} while(0)


/* The set and show commands, in setshow.c */
void set_command __PROTO((void));
void unset_command __PROTO((void));
void reset_command __PROTO((void));
void show_command __PROTO((void));
/* and some accessible support functions */
void show_version __PROTO((FILE *fp));
char *conv_text __PROTO((const char *s));
void delete_linestyle __PROTO((struct linestyle_def *, struct linestyle_def *));
void reset_key __PROTO((void));
#ifdef PM3D
void reset_palette __PROTO((void));
#endif

#endif /* GNUPLOT_SETSHOW_H */
