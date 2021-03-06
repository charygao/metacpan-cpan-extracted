/*
*+
*  Name:
*     palPlantu

*  Purpose:
*     Topocentric RA,Dec of a Solar-System object from universal elements

*  Language:
*     Starlink ANSI C

*  Type of Module:
*     Library routine

*  Invocation:
*     void palPlantu ( double date, double elong, double phi, const double u[13],
*                      double *ra, double *dec, double *r, int *jstat ) {

*  Description:
*     Topocentric apparent RA,Dec of a Solar-System object whose
*     heliocentric universal elements are known.

*  Arguments:
*     date = double (Given)
*        TT MJD of observation (JD-2400000.5)
*     elong = double (Given)
*        Observer's east longitude (radians)
*     phi = double (Given)
*        Observer's geodetic latitude (radians)
*     u = const double [13] (Given)
*        Universal orbital elements
*          -   (0)  combined mass (M+m)
*          -   (1)  total energy of the orbit (alpha)
*          -   (2)  reference (osculating) epoch (t0)
*          - (3-5)  position at reference epoch (r0)
*          - (6-8)  velocity at reference epoch (v0)
*          -   (9)  heliocentric distance at reference epoch
*          -  (10)  r0.v0
*          -  (11)  date (t)
*          -  (12)  universal eccentric anomaly (psi) of date, approx
*     ra = double * (Returned)
*        Topocentric apparent RA (radians)
*     dec = double * (Returned)
*        Topocentric apparent Dec (radians)
*     r = double * (Returned)
*        Distance from observer (AU)
*     jstat = int * (Returned)
*        status: 0 = OK
*             - -1 = radius vector zero
*             - -2 = failed to converge

*  Authors:
*     PTW: Pat Wallace (STFC)
*     TIMJ: Tim Jenness (JAC, Hawaii)
*     {enter_new_authors_here}

*  Notes:
*     - DATE is the instant for which the prediction is required.  It is
*       in the TT timescale (formerly Ephemeris Time, ET) and is a
*       Modified Julian Date (JD-2400000.5).
*     - The longitude and latitude allow correction for geocentric
*       parallax.  This is usually a small effect, but can become
*       important for near-Earth asteroids.  Geocentric positions can be
*       generated by appropriate use of routines palEpv (or palEvp) and
*       palUe2pv.
*     - The "universal" elements are those which define the orbit for the
*       purposes of the method of universal variables (see reference 2).
*       They consist of the combined mass of the two bodies, an epoch,
*       and the position and velocity vectors (arbitrary reference frame)
*       at that epoch.  The parameter set used here includes also various
*       quantities that can, in fact, be derived from the other
*       information.  This approach is taken to avoiding unnecessary
*       computation and loss of accuracy.  The supplementary quantities
*       are (i) alpha, which is proportional to the total energy of the
*       orbit, (ii) the heliocentric distance at epoch, (iii) the
*       outwards component of the velocity at the given epoch, (iv) an
*       estimate of psi, the "universal eccentric anomaly" at a given
*       date and (v) that date.
*     - The universal elements are with respect to the J2000 equator and
*       equinox.

*  See Also:
*     - Sterne, Theodore E., "An Introduction to Celestial Mechanics",
*       Interscience Publishers Inc., 1960.  Section 6.7, p199.
*     - Everhart, E. & Pitkin, E.T., Am.J.Phys. 51, 712, 1983.

*  History:
*     2012-03-12 (TIMJ):
*        Initial version direct conversion of SLA/F.
*        Adapted with permission from the Fortran SLALIB library.
*     {enter_further_changes_here}

*  Copyright:
*     Copyright (C) 2005 Patrick T. Wallace
*     Copyright (C) 2012 Science and Technology Facilities Council.
*     All Rights Reserved.

*  Licence:
*     This program is free software; you can redistribute it and/or
*     modify it under the terms of the GNU General Public License as
*     published by the Free Software Foundation; either version 3 of
*     the License, or (at your option) any later version.
*
*     This program is distributed in the hope that it will be
*     useful, but WITHOUT ANY WARRANTY; without even the implied
*     warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
*     PURPOSE. See the GNU General Public License for more details.
*
*     You should have received a copy of the GNU General Public License
*     along with this program; if not, write to the Free Software
*     Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
*     MA 02110-1301, USA.

*  Bugs:
*     {note_any_bugs_here}
*-
*/

#include <math.h>

#include "pal.h"
#include "palmac.h"

#include "pal1sofa.h"

void palPlantu ( double date, double elong, double phi, const double u[13],
                 double *ra, double *dec, double *r, int *jstat ) {

  int i;
  double dvb[3], dpb[3], vsg[6], vsp[6], v[6], rmat[3][3],
    vgp[6], stl, vgo[6], dx, dy, dz, d, tl;

  double ucp[13];

  /* To retain the stated const API and conform to the documentation
     we must copy the contents of the u array as palUe2pv updates
     the final two elements */
  for (i=0;i<13;i++) {
    ucp[i] = u[i];
  }

  /* Sun to geocentre (J2000, velocity in AU/s) */
  palEpv( date, vsg, &(vsg[3]), dpb, dvb );
  for (i=3; i < 6; i++) {
    vsg[i] /= PAL__SPD;
  }

  /* Sun to planet (J2000) */
  palUe2pv( date, ucp, vsp, jstat );

  /* Geocentre to planet (J2000) */
  for (i=0; i<6; i++) {
    v[i] = vsp[i] - vsg[i];
  }

  /* Precession and nutation to date */
  palPrenut( 2000.0, date, rmat );
  eraRxp(rmat, v, vgp);
  eraRxp( rmat, &(v[3]), &(vgp[3]) );

  /* Geocentre to observer (date) */
  stl = palGmst( date - palDt( palEpj(date) ) / PAL__SPD ) + elong;
  palPvobs( phi, 0.0, stl, vgo );

  /* Observer to planet (date) */
  for (i=0; i<6; i++) {
    v[i] = vgp[i] - vgo[i];
  }

  /* Geometric distance (AU) */
  dx = v[0];
  dy = v[1];
  dz = v[2];
  d = sqrt( dx*dx + dy*dy + dz*dz );

  /* Light time (sec) */
  tl = PAL__CR * d;

  /* Correct position for planetary aberration */
  for (i=0; i<3; i++) {
    v[i] -= tl * v[i+3];
  }

  /* To RA,Dec */
  eraC2s( v, ra, dec );
  *ra = eraAnp( *ra );
  *r = d;
}

