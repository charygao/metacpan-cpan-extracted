/*
 * $Id: getcolor.h,v 1.4 2002/08/30 18:45:45 mikulik Exp $
 */

/* GNUPLOT - getcolor.h */

/* Routines + constants for mapping interval [0,1] into another [0,1] to be 
 * used to get RGB triplets from gray (palette of smooth colours).
 *
 * Note: The code in getcolor.h,.c cannot be inside color.h,.c since gplt_x11.c
 * compiles with getcolor.o, so it cannot load the other huge staff.
 *
 */

/*[
 *
 * Petr Mikulik, since December 1998
 * Copyright: open source as much as possible
 *
]*/


#ifndef GETCOLOR_H
#define GETCOLOR_H

#ifdef PM3D

#include "syscfg.h"

enum color_models_id {
    C_MODEL_RGB = 'r',
    C_MODEL_HSV = 'h',
    C_MODEL_CMY = 'c',
    C_MODEL_YIQ = 'y',
    C_MODEL_XYZ = 'x' 
};


/* main gray --> color mapping */
void color_components_from_gray __PROTO(( double gray, rgb_color *color ));
void color_from_gray __PROTO(( double gray, rgb_color *color ));
void rgb_from_gray __PROTO(( double gray, unsigned char *r, unsigned char *g, unsigned char *b ));

/* used by x11.trm to avoid 'set palet funct R(g),G(g),B(g)' problems */
int calculate_color_from_formulae __PROTO(( double, rgb_color * ));

/* used to (de-)serialize color/gradient information */
char *color_to_str __PROTO(( rgb_color col, char *buf ));
void str_to_color __PROTO(( char *buf, rgb_color *col ));
char *gradient_entry_to_str __PROTO(( gradient_struct *gs )); 
void str_to_gradient_entry __PROTO(( char *s, gradient_struct *gs ));

/* check if two palettes p1 and p2 differ */
int palettes_differ __PROTO(( t_sm_palette *p1, t_sm_palette *p2 ));

/* construct minimal gradient to approximate palette */
gradient_struct *approximate_palette __PROTO(( t_sm_palette *palette, int maxsamples, double allowed_deviation, int *gradient_num ));

double GetColorValueFromFormula __PROTO((int formula, double x));

extern const char *ps_math_color_formulae[];


#endif /* PM3D */

#endif /* GETCOLOR_H */

/* eof getcolor.h */
