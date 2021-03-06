#!perl

use utf8;
use strict;
use warnings;

use lib 't/lib';

use MyTest tests => 265;

license_covered(
	'aal',
	name => 'Attribution Assurance License',
	text => <<EOF,
1. Redistributions of source code, in whole or part and with or without modification (the "Code"), must prominently display this GPG-signed text in verifiable form.
EOF
);

license_covered(
	'abstyles',
	name => 'Abstyles License',
	text => <<EOF,
Permission is granted to copy and distribute modified versions of this document under the conditions for verbatim copying, provided that the entire resulting derived work is distributed under the terms of a permission notice identical to this one.
EOF
);

license_covered(
	'adobe_2006',
	name => 'Adobe-2006 License',
	text => <<EOF,
Adobe Systems Incorporated grants to you a perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevocable copyright license, to reproduce, prepare derivative works of, publicly display, publicly perform, and distribute this source code and such derivative works in source or object code form without any attribution requirements.

The name "Adobe Systems Incorporated" must not be used to endorse or promote products derived from the source code without prior written permission.

You agree to indemnify, hold harmless and defend Adobe Systems Incorporated from and against any loss, damage, claims or lawsuits, including attorney's fees that arise or result from your use or distribution of the source code.

THIS SOURCE CODE IS PROVIDED "AS IS" AND "WITH ALL FAULTS", WITHOUT ANY TECHNICAL SUPPORT OR ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
ALSO, THERE IS NO WARRANTY OF NON-INFRINGEMENT, TITLE OR QUIET ENJOYMENT.
IN NO EVENT SHALL MACROMEDIA OR ITS SUPPLIERS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOURCE CODE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
EOF
);

license_covered(
	'adobe_glyph',
	name => 'Adobe Glyph List License',
	text => <<EOF,
Permission is hereby granted, free of charge, to any person obtaining a copy of this documentation file to use, copy, publish, distribute, sublicense, and/or sell copies of the documentation, and to permit others to do the same, provided that:
- No modification, editing or other alteration of this document is allowed; and
- The above copyright notice and this permission notice shall be included in all copies of the documentation.

Permission is hereby granted, free of charge, to any person obtaining a copy of this documentation file, to create their own derivative works from the content of this document to use, copy, publish, distribute, sublicense, and/or sell the derivative works, and to permit others to do the same, provided that the derived work is not represented as being a copy or version of this document.

Adobe shall not be liable to any party for any loss of revenue or profit or for indirect, incidental, special, consequential, or other similar damages, whether based on tort (including without limitation negligence or strict liability), contract or other legal or equitable grounds even if Adobe has been advised or had reason to know of the possibility of such damages.
The Adobe materials are provided on an "AS IS" basis.
Adobe specifically disclaims all express, statutory, or implied warranties relating to the Adobe materials, including but not limited to those concerning merchantability or fitness for a particular purpose or non-infringement of any third party rights regarding the Adobe materials.
EOF
);

license_covered(
	'adsl',
	name => 'Amazon Digital Services License',
	text => <<EOF,
Your use of this software code is at your own risk and you waive any claim against Amazon Digital Services, Inc. or its affiliates with respect to your use of this software code.
EOF
);

license_covered(
	'afl',
	name => 'Academic Free License',

# TODO: readd when children cover same region
#	license => <<EOF,
#This Academic Free License (the "License") applies to any original work of authorship (the "Original Work") whose owner (the "Licensor") has placed the following licensing notice adjacent to the copyright notice for the Original Work:
#EOF
	TODO => [qw(subject_license)]
);

license_covered(
	'afl_1_1',
	name    => 'Academic Free License version 1.1',
	grant   => 'Licensed under the Academic Free License version 1.1.',
	license => 'The Academic Free License applies to any original work',
	TODO    => [qw(grant_grant name_name)]
);

license_covered(
	'afl_1_2',
	name    => 'Academic Free License version 1.2',
	grant   => 'Licensed under the Academic Free License version 1.2',
	license => 'This Academic Free License applies to any original work',
	TODO    => [qw(grant_grant name_name)]
);

license_covered(
	'afl_2',
	name    => 'Academic Free License version 2.0',
	grant   => 'Licensed under the Academic Free License version 2.0',
	license => <<EOF,
9) Acceptance and Termination. If You distribute  copies of the Original Work or a Derivative Work, You must make a reasonable effort under the circumstances to obtain the express assent of recipients to the terms of this License.  Nothing else but this License (or another written agreement between Licensor and You) grants You permission to create Derivative Works based upon the Original Work or to exercise any of the rights granted in Section 1 herein, and any attempt to do so except under the terms of this License (or another written agreement between Licensor and You) is expressly prohibited by U.S. copyright law, the equivalent laws of other countries, and by international treaty.  Therefore, by exercising any of the rights granted to You in Section 1 herein, You indicate Your acceptance of this License and all of its terms and conditions.

10) Termination for Patent Action. This License shall terminate automatically and You may no longer exercise any of the rights granted to You by this License as of the date You commence an action, including a cross-claim or counterclaim, for patent infringement (i) against Licensor with respect to a patent applicable to software or (ii) against any entity with respect to a patent applicable to the Original Work (but excluding combinations of the Original Work with other software or hardware).
EOF
	TODO => [qw(grant_grant name_name)]
);

license_covered(
	'afl_2_1',
	name    => 'Academic Free License version 2.1',
	grant   => 'Licensed under the Academic Free License version 2.1',
	license => <<EOF,
9) Acceptance and Termination. If You distribute copies of the Original Work or a Derivative Work, You must make a reasonable effort under the circumstances to obtain the express assent of recipients to the terms of this License. Nothing else but this License (or another written agreement between Licensor and You) grants You permission to create Derivative Works based upon the Original Work or to exercise any of the rights granted in Section 1 herein, and any attempt to do so except under the terms of this License (or another written agreement between Licensor and You) is expressly prohibited by U.S. copyright law, the equivalent laws of other countries, and by international treaty. Therefore, by exercising any of the rights granted to You in Section 1 herein, You indicate Your acceptance of this License and all of its terms and conditions.

10) Termination for Patent Action. This License shall terminate automatically and You may no longer exercise any of the rights granted to You by this License as of the date You commence an action, including a cross-claim or counterclaim, against Licensor or any licensee alleging that the Original Work infringes a patent. This termination provision shall not apply for an action alleging patent infringement by combinations of the Original Work with other software or hardware.
EOF
	TODO => [qw(grant_grant name_name)]
);

license_covered(
	'afl_3',
	name    => 'Academic Free License version 3.0',
	grant   => 'Licensed under the Academic Free License version 3.0',
	license => <<EOF,
9) Acceptance and Termination. If, at any time, You expressly assented to this License, that assent indicates your clear and irrevocable acceptance of this License and all of its terms and conditions. If You distribute or communicate copies of the Original Work or a Derivative Work, You must make a reasonable effort under the circumstances to obtain the express assent of recipients to the terms of this License. This License conditions your rights to undertake the activities listed in Section 1, including your right to create Derivative Works based upon the Original Work, and doing so without honoring these terms and conditions is prohibited by copyright law and international treaty. Nothing in this License is intended to affect copyright exceptions and limitations (including “fair use” or “fair dealing”). This License shall terminate immediately and You may no longer exercise any of the rights granted to You by this License upon your failure to honor the conditions in Section 1(c).

10) Termination for Patent Action. This License shall terminate automatically and You may no longer exercise any of the rights granted to You by this License as of the date You commence an action, including a cross-claim or counterclaim, against Licensor or any licensee alleging that the Original Work infringes a patent. This termination provision shall not apply for an action alleging patent infringement by combinations of the Original Work with other software or hardware.
EOF
);

license_covered(
	'afmparse',
	name => 'Afmparse License',
	text => <<EOF,
2) If the file has been modified in any way, a notice of such modification is conspicuously indicated.
EOF
);

license_covered(
	'agpl',
	name  => 'GNU Affero General Public License',
	grant => <<EOF,
This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
EOF
	TODO => [qw(subject_license)]
);

license_covered(
	'agpl_1',
	name => 'Affero General Public License, Version 1',
	text => <<EOF,
* d) If the Program as you received it is intended to interact with users through a computer network and if, in the version you received, any user interacting with the Program was given the opportunity to request transmission to that user of the Program's complete source code, you must not remove that facility from your modified version of the Program or work based on the Program, and must offer an equivalent opportunity for all users interacting with your Program through a computer network to request immediate transmission by HTTP of the complete source code of your modified version or other derivative work.
EOF
	TODO => [qw(grant_grant)]
);

license_covered(
	'agpl_1_only',
	name => 'GNU Affero General Public License version 1 only',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'agpl_1_or_later',
	name => 'GNU Affero General Public License version 1 or later',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'agpl_2',
	name => 'Affero General Public License, Version 2',
	text => <<EOF,
This is version 2 of the Affero General Public License.
It gives each licensee permission to distribute the Program or a work based on the Program (as defined in version 1 of the Affero GPL) under the GNU Affero General Public License, version 3 or any later version.
EOF
	TODO => [qw(grant_grant)]
);

license_covered(
	'agpl_3',
	name  => 'GNU Affero General Public License, Version 3',
	grant => <<EOF,
Released under the terms of the GNU Affero General Public License version 3.
EOF
	text => <<EOF,
"This License" refers to version 3 of the GNU Affero General Public License.
EOF
	TODO => [qw()]
);

license_covered(
	'agpl_3_only',
	name => 'GNU Affero General Public License version 3 only',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'agpl_3_or_later',
	name => 'GNU Affero General Public License version 3 or later',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'aladdin',
	name  => 'Aladdin Free Public License',
	grant => <<EOF,
This program may also be distributed as part of Aladdin Ghostscript, under the terms of the Aladdin Free Public License (the "License").
EOF
	TODO => [qw(subject_license)]
);

license_covered(
	'aladdin_8',
	name  => 'Aladdin Free Public License',
	grant => <<EOF,
This program may also be distributed as part of Aladdin Ghostscript, under the terms of the Aladdin Free Public License (the "License").
EOF
	text => <<EOF,
Aladdin Enterprises hereby grants to anyone the permission to apply this License to their own work, as long as the entire License (including the above notices and this paragraph) is copied with no changes, additions, or deletions except for changing the first paragraph of Section 0 to include a suitable description of the work to which the license is being applied and of the person or entity that holds the copyright in the work, and, if the License is being applied to a work created in a country other than the United States, replacing the first paragraph of Section 6 with an appropriate reference to the laws of the appropriate country.

0. Subject Matter

This License applies to the computer program known as "Aladdin Ghostscript." The "Program", below, refers to such program.
EOF
	TODO => [qw(name_name grant_grant)]
);

license_covered(
	'aladdin_9',
	name  => 'Aladdin Free Public License',
	grant => <<EOF,
This program may also be distributed as part of Aladdin Ghostscript, under the terms of the Aladdin Free Public License (the "License").
EOF
	text => <<EOF,
Aladdin Enterprises hereby grants to anyone the permission to apply this License to their own work, as long as the entire License (including the above notices and this paragraph) is copied with no changes, additions, or deletions except for changing the first paragraph of Section 0 to include a suitable description of the work to which the license is being applied and of the person or entity that holds the copyright in the work, and, if the License is being applied to a work created in a country other than the United States, replacing the first paragraph of Section 6 with an appropriate reference to the laws of the appropriate country.

This License is not an Open Source license: among other things, it places restrictions on distribution of the Program, specifically including sale of the Program.
While Aladdin Enterprises respects and supports the philosophy of the Open Source Definition, and shares the desire of the GNU project to keep licensed software freely redistributable in both source and object form, we feel that Open Source licenses unfairly prevent developers of useful software from being compensated proportionately when others profit financially from their work.
This License attempts to ensure that those who receive, redistribute, and contribute to the licensed Program according to the Open Source and Free Software philosophies have the right to do so, while retaining for the developer(s) of the Program the power to make those who use the Program to enhance the value of commercial products pay for the privilege of doing so.

0. Subject Matter

This License applies to the computer programs known as "AFPL Ghostscript", "AFPL Ghostscript PCL5e", "AFPL Ghostscript PCL5c", and "AFPL Ghostscript PXL".&nbsp; The "Program", below, refers to such program.
EOF
	TODO => [qw(name_name grant_grant)]
);

license_covered(
	'amdplpa',
	name => "AMD's plpa_map.c License",
	text => <<EOF,
Neither the names nor trademarks of Advanced Micro Devices, Inc. or any copyright holders or contributors may be used to endorse or promote products derived from this material without specific prior written permission.
EOF
);

license_covered(
	'aml',
	name => 'Apple MIT License',
	text => <<EOF,
In consideration of your agreement to abide by the following terms, and subject to these terms, Apple grants you a personal, non-exclusive license, under Apple's copyrights in this original Apple software (the "Apple Software"),
EOF
);

license_covered(
	'ampas',
	name => 'Academy of Motion Picture Arts and Sciences BSD',
	text => <<EOF,
* Redistributions of source code must retain the above copyright notice, this list of conditions and the Disclaimer of Warranty.

* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the Disclaimer of Warranty in the documentation and/or other materials provided with the distribution.

* Nothing in this license shall be deemed to grant any rights to trademarks,
EOF
);

license_covered(
	'antlr_pd',
	name => 'ANTLR Software Rights Notice',
	text => <<EOF,
We reserve no legal rights to the ANTLR--it is fully in the public domain.
EOF
);

license_covered(
	'apache',
	name  => 'Apache License',
	iri   => 'https://www.apache.org/licenses/LICENSE-2.0',
	grant => <<EOF,
Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and limitations under the License.
EOF
	TODO => [qw(subject_license not_grant_iri)]
);

license_covered(
	'apafml',
	name => 'Adobe Postscript AFM License',
	text => <<EOF,
This file and the 14 PostScript(R) AFM files it accompanies may be used, copied, and distributed for any purpose and without charge, with or without modification, provided that all copyright notices are retained; that the AFM files are not distributed without this file; that all modifications to this file or any of the AFM files are prominently noted in the modified file(s); and that this paragraph is not modified.
Adobe Systems has no responsibility or obligation to support the use of the AFM files.
EOF
);

license_covered(
	'apl',
	name => 'Adaptive Public License',
	TODO => [qw(subject_license)]
);

license_covered(
	'apl_1',
	name  => 'Adaptive Public License 1.0',
	grant => <<EOF,
Licensed under the Adaptive Public License version 1.0
EOF
	text => <<EOF,
THE LICENSED WORK IS PROVIDED UNDER THE TERMS OF THIS ADAPTIVE PUBLIC LICENSE ("LICENSE").
EOF
);

license_covered(
	'apsl',
	name => 'Apple Public Source License',
	TODO => [qw(subject_license)]
);

license_covered(
	'apsl_1',
	name  => 'Apple Public Source License 1.0',
	grant => <<EOF,
Licensed under the Apple Public Source License version 1.0
EOF
	text => <<EOF,
This License applies to any program or other work which Apple Computer, Inc. ("Apple") publicly announces as subject to this Apple Public Source License and which contains a notice placed by Apple identifying such program or work as "Original Code" and stating that it is subject to the terms of this Apple Public Source License version 1.0 (or subsequent version thereof), as it may be revised from time to time by Apple ("License").
EOF
);

license_covered(
	'apsl_1_1',
	name  => 'Apple Public Source License 1.1',
	grant => <<EOF,
Licensed under the Apple Public Source License version 1.1
EOF
	text => <<EOF,
This License applies to any program or other work which Apple Computer, Inc. ("Apple") publicly announces as subject to this Apple Public Source License and which contains a notice placed by Apple identifying such program or work as "Original Code" and stating that it is subject to the terms of this Apple Public Source License version 1.1 (or subsequent version thereof), as it may be revised from time to time by Apple ("License").
EOF
);

license_covered(
	'apsl_1_2',
	name  => 'Apple Public Source License 1.2',
	grant => <<EOF,
Licensed under the Apple Public Source License version 1.2
EOF
	text => <<EOF,
This License applies to any program or other work which Apple Computer, Inc. ("Apple") makes publicly available and which contains a notice placed by Apple identifying such program or work as "Original Code" and stating that it is subject to the terms of this Apple Public Source License version 1.2 (or subsequent version thereof) ("License").
EOF
);

license_covered(
	'apsl_2',
	name  => 'Apple Public Source License 2.0',
	grant => <<EOF,
Licensed under the Apple Public Source License version 2.0
EOF
	text => <<EOF,
This License applies to any program or other work which Apple Inc. ("Apple") makes publicly available and which contains a notice placed by Apple identifying such program or work as "Original Code" and stating that it is subject to the terms of this Apple Public Source License version 2.0 ("License").
EOF
);

license_covered(
	'artistic',
	name => 'Artistic License',
	TODO => [qw(subject_license)]
);

license_covered(
	'artistic_1',
	name => 'Artistic License 1.0',
	iri  => 'https://opensource.org/licenses/artistic-license-1.0',
	text => <<EOF,
7. C or perl subroutines supplied by you and linked into this Package shall not be considered part of this Package.

8. The name of the Copyright Holder may not be used to endorse or promote products derived from this software without specific prior written permission.
EOF
	TODO => [qw(iri_iri subject_license)]
);

license_covered(
	'artistic_1_cl8',
	name => 'Artistic-1.0-cl8',
	iri  => 'https://spdx.org/licenses/Artistic-1.0-cl8',
	text => <<EOF,
7. C or perl subroutines supplied by you and linked into this Package shall not be considered part of this Package.

8.Aggregation of this Package with a commercial distribution is always permitted provided that the use of this Package is embedded;
that is, when no overt attempt is made to make this Package's interfaces visible to the end user of the commercial distribution.
Such use shall not be construed as a distribution of this Package.

9. The name of the Copyright Holder may not be used to endorse or promote products derived from this software without specific prior written permission.
EOF
	TODO => [qw(name_name subject_license not_iri_name)]
);

license_covered(
	'artistic_1_clarified',
	name => 'Clarified Artistic License',
	iri =>
		'http://gianluca.dellavedova.org/2011/01/03/clarified-artistic-license/',
	text => <<EOF,
7. C subroutines (or comparably compiled subroutines in other languages) supplied by you and linked into this Package in order to emulate subroutines and variables of the language defined by this Package shall not be considered part of this Package, but are the equivalent of input as in Paragraph 6, provided these subroutines do not change the language in any way that would cause it to fail the regression tests for the language.

8. Aggregation of the Standard Version of the Package with a commercial distribution is always permitted provided that the use of this Package is embedded;
that is, when no overt attempt is made to make this Package's interfaces visible to the end user of the commercial distribution.
Such use shall not be construed as a distribution of this Package.

9. The name of the Copyright Holder may not be used to endorse or promote products derived from this software without specific prior written permission.
EOF
	TODO => [qw(name_name)]
);

license_covered(
	'artistic_1_perl',
	name => 'Artistic License 1.0 (Perl)',
	iri  => 'http://dev.perl.org/licenses/artistic.html',
	text => <<EOF,
7. C subroutines (or comparably compiled subroutines in other languages) supplied by you and linked into this Package in order to emulate subroutines and variables of the language defined by this Package shall not be considered part of this Package, but are the equivalent of input as in Paragraph 6, provided these subroutines do not change the language in any way that would cause it to fail the regression tests for the language.

8. Aggregation of this Package with a commercial distribution is always permitted provided that the use of this Package is embedded;
that is, when no overt attempt is made to make this Package's interfaces visible to the end user of the commercial distribution.
Such use shall not be construed as a distribution of this Package.

9. The name of the Copyright Holder may not be used to endorse or promote products derived from this software without specific prior written permission.
EOF
	TODO => [qw(name_name subject_license)]
);

license_covered(
	'artistic_2',
	name => 'Artistic License 2.0',
	iri  => 'http://www.perlfoundation.org/artistic_license_2_0',
	text => <<EOF,
Any use, modification, and distribution of the Standard or Modified Versions is governed by this Artistic License.
EOF
);

license_covered(
	'bahyph',
	name => 'Bahyph License',
	text => <<EOF,
These patterns were developed for internal GMV use and are made public in the hope that they will benefit others.
EOF
);

license_covered(
	'barr',
	name => 'Barr License',
	text => <<'EOF',
This is a package of commutative diagram macros built on top of Xy-pic by Michael Barr (email: barr@barrs.org).
EOF
);

license_covered(
	'bdwgc',
	name => 'bdwgc',
	iri  => 'http://www.hboehm.info/gc/license.txt',
	text => <<EOF,
Permission is hereby granted to use or copy this program for any purpose, provided the above notices are retained on all copies.
Permission to modify the code and to distribute modified code is granted, provided the above notices are retained, and a notice that the code was modified is included with the above copyright notice.
EOF
	TODO => [qw(name_name)]
);

license_covered(
	'bdwgc_matlab',
	text => <<EOF,
Permission is hereby granted to use or copy this program for any purpose, provided the above notices are retained on all copies.
User documentation of any code that uses this code must cite the Authors, the Copyright, and "Used by permission."
If this code is accessible from within Matlab, then typing "help colamd" or "colamd" (with no arguments) must cite the Authors.
Permission to modify the code and to distribute modified code is granted, provided the above notices are retained, and a notice that the code was modified is included with the above copyright notice.
You must also retain the Availability information below, of the original version.
EOF
	TODO => [qw(subject_iri)]
);

license_covered(
	'bittorrent',
	name => 'BitTorrent Open Source License',
	TODO => [qw(subject_license)]
);

license_covered(
	'bittorrent_1',
	name  => 'BitTorrent Open Source License v1.0',
	grant => <<EOF,
Licensed under the BitTorrent Open Source License version 1.0
EOF
	text => <<EOF,
BitTorrent Open Source License

Version 1.0

This BitTorrent Open Source License (the "License") applies to the BitTorrent client and related software products as well as any updates or maintenance releases of that software ("BitTorrent Products") that are distributed by BitTorrent, Inc. ("Licensor").
EOF
);

license_covered(
	'bittorrent_1_1',
	name  => 'BitTorrent Open Source License v1.1',
	grant => <<EOF,
Licensed under the BitTorrent Open Source License version 1.1
EOF
	text => <<EOF,
BitTorrent Open Source License

Version 1.1

This BitTorrent Open Source License (the "License") applies to the BitTorrent client and related software products as well as any updates or maintenance releases of that software ("BitTorrent Products") that are distributed by BitTorrent, Inc. ("Licensor").
EOF
);

license_covered(
	'borceux',
	name => 'Borceux license',
	text => <<EOF,
You may freely use, modify, and/or distribute each of the files in this package without limitation.
EOF
);

license_covered(
	'bsd_2_clause',
	name => 'BSD 2-Clause',
	text => <<EOF,
Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
EOF
	TODO => [qw(name_name)]
);

license_covered(
	'bsd_3_clause',
	name => 'BSD 3-Clause',
	text => <<EOF,
Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
EOF
	TODO => [qw(name_name)]
);

license_covered(
	'bsd_4_clause',
	name => 'BSD 4-Clause',
	text => <<EOF,
Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
3. All advertising materials mentioning features or use of this software must display the following acknowledgement:
This product includes software developed by the <organization>.
4. Neither the name of the <organization> nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY <COPYRIGHT HOLDER> ''AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
EOF
	TODO => [qw(name_name)]
);

license_covered(
	'bsl',
	name => 'Boost Software License',
	iri  => 'http://www.boost.org/LICENSE_1_0.txt',
	TODO => [qw(subject_license not_iri_name)]
);

license_covered(
	'bsl_1',
	name => 'Boost Software License 1.0',
	iri  => 'http://www.boost.org/LICENSE_1_0.txt',
	text => <<EOF,
Permission is hereby granted, free of charge,
to any person or organization obtaining a copy of the software and accompanying documentation covered by this license (the "Software")
to use, reproduce, display, distribute, execute, and transmit the Software,
and to prepare derivative works of the Software,
and to permit third-parties to whom the Software is furnished to do so,
all subject to the following:
EOF
	TODO => [qw(text_license not_iri_name)]
);

license_covered(
	'bzip2',
	name => 'bzip2 and libbzip2 License',
	text => <<EOF,
• Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

• The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.

• Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.

• The name of the author may not be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
EOF
);

license_covered(
	'bzip2_1_0_5',
	name => 'bzip2 and libbzip2 License v1.0.5',
	text => <<EOF,
This program, bzip2, the associated library libbzip2, and all documentation, are copyright © 1996-2007 Julian Seward. All rights reserved.
EOF
);

license_covered(
	'bzip2_1_0_6',
	name => 'bzip2 and libbzip2 License v1.0.6',
	text => <<EOF,
This program, "bzip2", the associated library "libbzip2", and all documentation, are copyright (C) 1996-2010 Julian R Seward. All rights reserved.
EOF
);

license_covered(
	'caldera',
	name => 'BSD Source Caldera License',
	text => <<EOF,
Caldera International, Inc. hereby grants a fee free license that includes the rights use, modify and distribute this named source code, including creating derived binary products created from the source code.
EOF
);

license_covered(
	'catosl',
	name => 'Computer Associates Trusted Open Source License',
	TODO => [qw(subject_license)]
);

license_covered(
	'catosl_1_1',
	name => 'Computer Associates Trusted Open Source License 1.1',
	text => <<EOF,
1.1 Contribution means (a) in the case of CA, the Original Program;
EOF
);

license_covered(
	'cc_by',
	name => 'Creative Commons Attribution 4.0 International Public License',
	TODO => [qw(subject_license)]
);

license_covered(
	'cc_by_1',
	name  => 'Creative Commons Attribution 1.0 Generic License',
	iri   => 'https://creativecommons.org/licenses/by/1.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution 1.0 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(not_grant_iri)]
);

license_covered(
	'cc_by_2',
	name  => 'Creative Commons Attribution 2.0 Generic License',
	iri   => 'https://creativecommons.org/licenses/by/2.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution 2.0 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/by/2.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(not_grant_iri)]
);

license_covered(
	'cc_by_2_5',
	name  => 'Creative Commons Attribution 2.5 Generic License',
	iri   => 'https://creativecommons.org/licenses/by/2.5/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution 2.5 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/by/2.5/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(not_grant_iri)]
);

license_covered(
	'cc_by_3',
	name  => 'Creative Commons Attribution 3.0 Unported License',
	iri   => 'https://creativecommons.org/licenses/by/3.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution 3.0 Unported License.
To view a copy of this license, visit http://creativecommons.org/licenses/by/3.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(name_name grant_grant not_grant_iri)]
);

license_covered(
	'cc_by_4',
	name  => 'Creative Commons Attribution 4.0 International License',
	iri   => 'https://creativecommons.org/licenses/by/4.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(name_name grant_grant not_grant_iri)]
);

license_covered(
	'cc_by_nc',
	name =>
		'Creative Commons Attribution-NonCommercial 4.0 International Public License',
	TODO => [qw(subject_license)]
);

license_covered(
	'cc_by_nc_1',
	name  => 'Creative Commons Attribution-NonCommercial 1.0 Generic License',
	iri   => 'https://creativecommons.org/licenses/by-nc/1.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NonCommercial 1.0 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc/1.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(not_grant_iri)]
);

license_covered(
	'cc_by_nc_2',
	name  => 'Creative Commons Attribution-NonCommercial 2.0 Generic License',
	iri   => 'https://creativecommons.org/licenses/by-nc/2.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NonCommercial 2.0 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc/2.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(not_grant_iri)]
);

license_covered(
	'cc_by_nc_2_5',
	name  => 'Creative Commons Attribution-NonCommercial 2.5 Generic License',
	iri   => 'https://creativecommons.org/licenses/by-nc/2.5/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NonCommercial 2.5 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc/2.5/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(not_grant_iri)]
);

license_covered(
	'cc_by_nc_3',
	name => 'Creative Commons Attribution-NonCommercial 3.0 Unported License',
	iri  => 'https://creativecommons.org/licenses/by-nc/3.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NonCommercial 3.0 Unported License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc/3.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(name_name grant_grant not_grant_iri)]
);

license_covered(
	'cc_by_nc_4',
	name =>
		'Creative Commons Attribution-NonCommercial 4.0 International License',
	iri   => 'https://creativecommons.org/licenses/by-nc/4.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(name_name grant_grant not_grant_iri)]
);

license_covered(
	'cc_by_nc_nd',
	name =>
		'Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International Public License',
	TODO => [qw(subject_license)]
);

license_covered(
	'cc_by_nc_nd_1',
	name =>
		'Creative Commons Attribution-NoDerivs-NonCommercial 1.0 Generic License',
	iri   => 'https://creativecommons.org/licenses/by-nd-nc/1.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NoDerivs-NonCommercial 1.0 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nd-nc/1.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(iri_iri)]
);

license_covered(
	'cc_by_nc_nd_2',
	name =>
		'Creative Commons Attribution-NonCommercial-NoDerivs 2.0 Generic License',
	iri   => 'https://creativecommons.org/licenses/by-nc-nd/2.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivs 2.0 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/2.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(not_grant_iri)]
);

license_covered(
	'cc_by_nc_nd_2_5',
	name =>
		'Creative Commons Attribution-NonCommercial-NoDerivs 2.5 Generic License',
	iri   => 'https://creativecommons.org/licenses/by-nc-nd/2.5/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivs 2.5 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/2.5/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(not_grant_iri)]
);

license_covered(
	'cc_by_nc_nd_3',
	name =>
		'Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License',
	iri   => 'https://creativecommons.org/licenses/by-nc-nd/3.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/3.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(name_name grant_grant not_grant_iri)]
);

license_covered(
	'cc_by_nc_nd_4',
	name =>
		'Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License',
	iri   => 'https://creativecommons.org/licenses/by-nc-nd/4.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(name_name grant_grant not_grant_iri)]
);

license_covered(
	'cc_by_nc_sa',
	name =>
		'Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Public License',
	TODO => [qw(subject_license)]
);

license_covered(
	'cc_by_nc_sa_1',
	name =>
		'Creative Commons Attribution-NonCommercial-ShareAlike 1.0 Generic License',
	iri   => 'https://creativecommons.org/licenses/by-nc-sa/1.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 1.0 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/1.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(not_grant_iri)]
);

license_covered(
	'cc_by_nc_sa_2',
	name =>
		'Creative Commons Attribution-NonCommercial-ShareAlike 2.0 Generic License',
	iri   => 'https://creativecommons.org/licenses/by-nc-sa/2.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 2.0 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/2.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(not_grant_iri)]
);

license_covered(
	'cc_by_nc_sa_2_5',
	name =>
		'Creative Commons Attribution-NonCommercial-ShareAlike 2.5 Generic License',
	iri   => 'https://creativecommons.org/licenses/by-nc-sa/2.5/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 2.5 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/2.5/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(not_grant_iri)]
);

license_covered(
	'cc_by_nc_sa_3',
	name =>
		'Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License',
	iri   => 'https://creativecommons.org/licenses/by-nc-sa/3.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(name_name grant_grant not_grant_iri)]
);

license_covered(
	'cc_by_nc_sa_4',
	name =>
		'Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License',
	iri   => 'https://creativecommons.org/licenses/by-nc-sa/4.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(name_name grant_grant not_grant_iri)]
);

license_covered(
	'cc_by_nd',
	name =>
		'Creative Commons Attribution-NoDerivatives 4.0 International Public License',
	TODO => [qw(subject_license)]
);

license_covered(
	'cc_by_nd_1',
	name  => 'Creative Commons Attribution-NoDerivs 1.0 Generic License',
	iri   => 'https://creativecommons.org/licenses/by-nd/1.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NoDerivs 1.0 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nd/1.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(not_grant_iri)]
);

license_covered(
	'cc_by_nd_2',
	name  => 'Creative Commons Attribution-NoDerivs 2.0 Generic License',
	iri   => 'https://creativecommons.org/licenses/by-nd/2.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NoDerivs 2.0 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nd/2.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(not_grant_iri)]
);

license_covered(
	'cc_by_nd_2_5',
	name  => 'Creative Commons Attribution-NoDerivs 2.5 Generic License',
	iri   => 'https://creativecommons.org/licenses/by-nd/2.5/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NoDerivs 2.5 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nd/2.5/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(not_grant_iri)]
);

license_covered(
	'cc_by_nd_3',
	name  => 'Creative Commons Attribution-NoDerivs 3.0 Unported License',
	iri   => 'https://creativecommons.org/licenses/by-nd/3.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NoDerivs 3.0 Unported License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nd/3.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(name_name grant_grant not_grant_iri)]
);

license_covered(
	'cc_by_nd_4',
	name =>
		'Creative Commons Attribution-NoDerivatives 4.0 International License',
	iri   => 'https://creativecommons.org/licenses/by-nd/4.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-NoDerivatives 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nd/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(name_name grant_grant not_grant_iri)]
);

license_covered(
	'cc_by_sa',
	name =>
		'Creative Commons Attribution-ShareAlike 4.0 International Public License',
	TODO => [qw(subject_license)]
);

license_covered(
	'cc_by_sa_1',
	name  => 'Creative Commons Attribution-ShareAlike 1.0 Generic License',
	iri   => 'https://creativecommons.org/licenses/by-sa/1.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-ShareAlike 1.0 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/1.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(not_grant_iri)]
);

license_covered(
	'cc_by_sa_2',
	name  => 'Creative Commons Attribution-ShareAlike 2.0 Generic License',
	iri   => 'https://creativecommons.org/licenses/by-sa/2.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-ShareAlike 2.0 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/2.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(not_grant_iri)]
);

license_covered(
	'cc_by_sa_2_5',
	name  => 'Creative Commons Attribution-ShareAlike 2.5 Generic License',
	iri   => 'https://creativecommons.org/licenses/by-sa/2.5/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-ShareAlike 2.5 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/2.5/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(not_grant_iri)]
);

license_covered(
	'cc_by_sa_3',
	name  => 'Creative Commons Attribution-ShareAlike 3.0 Unported License',
	iri   => 'https://creativecommons.org/licenses/by-sa/3.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(name_name grant_grant not_grant_iri)]
);

license_covered(
	'cc_by_sa_4',
	name =>
		'Creative Commons Attribution-ShareAlike 4.0 International License',
	iri   => 'https://creativecommons.org/licenses/by-sa/4.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(name_name grant_grant not_grant_iri)]
);

license_covered(
	'cc_cc0',
	name => 'Creative Commons Zero 1.0 Universal',
	iri =>
		'https://en.wikipedia.org/wiki/Creative_Commons_license#Zero_/_public_domain',
	grant =>
		'To the extent possible under law, the person who associated CC0 with this work has waived all copyright and related or neighboring rights to this work',
	TODO => [qw(subject_license)]
);

license_covered(
	'cc_cc0_1',
	name => 'Creative Commons Zero 1.0 Universal',
	iri =>
		'https://en.wikipedia.org/wiki/Creative_Commons_license#Zero_/_public_domain',
	grant =>
		'To the extent possible under law, the person who associated CC0 with this work has waived all copyright and related or neighboring rights to this work',
	TODO => [qw(name_name subject_license)]
);

license_covered(
	'cc_nc',
	name => 'Creative Commons NonCommercial 1.0 Generic Public License',
	TODO => [qw(iri_iri subject_license)]
);

license_covered(
	'cc_nc_1',
	name  => 'Creative Commons NonCommercial 1.0 Generic License',
	iri   => 'https://creativecommons.org/licenses/nc/1.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons NonCommercial 1.0 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/nc/1.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(iri_iri)]
);

license_covered(
	'cc_nd',
	name => 'Creative Commons NoDerivs 1.0 Generic Public License',
	TODO => [qw(iri_iri subject_license)]
);

license_covered(
	'cc_nd_1',
	name  => 'Creative Commons NoDerivs 1.0 Generic License',
	iri   => 'https://creativecommons.org/licenses/nd/1.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons NoDerivs 1.0 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/nd/1.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(not_grant_iri)]
);

license_covered(
	'cc_sa',
	name => 'Creative Commons ShareAlike 1.0 Generic Public License',
	TODO => [qw(iri_iri subject_license)]
);

license_covered(
	'cc_sa_1',
	name  => 'Creative Commons ShareAlike 1.0 Generic License',
	iri   => 'https://creativecommons.org/licenses/sa/1.0/',
	grant => <<EOF,
This work is licensed under the Creative Commons ShareAlike 1.0 Generic License.
To view a copy of this license, visit http://creativecommons.org/licenses/sa/1.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
EOF
	TODO => [qw(not_grant_iri)]
);

license_covered(
	'cc_sp',
	name => 'Creative Commons Sampling Plus 1.0',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'cddl',
	name => 'Common Development and Distribution License',
	TODO => [qw(subject_license)]
);

license_covered(
	'cddl_1',
	name => 'Common Development and Distribution License 1.0',
	text => <<EOF,
4. Versions of the License.

4.1. New Versions.

Sun Microsystems, Inc. is the initial license steward and may publish revised and/or new versions
EOF
	TODO => [qw(subject_iri)]
);

license_covered(
	'cddl_1_1',
	name => 'Common Development and Distribution License 1.1',
	text => <<EOF,
4. Versions of the License.

4.1. New Versions.

Oracle is the initial license steward and may publish revised and/or new versions
EOF
	TODO => [qw(subject_iri)]
);

license_covered(
	'cecill',
	name => 'CeCILL Free Software License Agreement',
	text => <<EOF,
CONTRAT DE LICENCE DE LOGICIEL LIBRE CeCILL

Version 2.1 du 2013-06-21
EOF
);

license_covered(
	'cecill_1',
	name => 'CeCILL Free Software License Agreement v1.0',
	iri  => 'https://cecill.info/licences/Licence_CeCILL_V1-fr.html',
	text => <<EOF,
Version 1 du 21/06/2004
EOF
	TODO => [qw(name_name)]
);

license_covered(
	'cecill_1_1',
	name => 'CeCILL Free Software License Agreement v1.1',
	iri  => 'https://cecill.info/licences/Licence_CeCILL_V1.1-US.html',
	text => <<EOF,
Version 1.1 of 10/26/2004
EOF
	TODO => [qw(name_name)]
);

license_covered(
	'cecill_2',
	name => 'CeCILL Free Software License Agreement v2.0',
	iri  => 'https://cecill.info/licences/Licence_CeCILL_V2-fr.html',
	text => <<EOF,
Version 2.0 du 2006-09-05.
EOF
	TODO => [qw(name_name)]
);

license_covered(
	'cecill_2_1',
	name  => 'CeCILL Free Software License Agreement v2.1',
	iri   => 'https://cecill.info/licences/Licence_CeCILL_V2.1-fr.html',
	grant => <<EOF,
This software is governed by the CeCILL  license under French law and abiding by the rules of distribution of free software.
You can  use, modify and/ or redistribute the software under the terms of the CeCILL license as circulated by CEA, CNRS and INRIA at the following URL "http://www.cecill.info".
EOF
	text => <<EOF,
Version 2.1 du 2013-06-21
EOF
	TODO => [qw(name_name)]
);

license_covered(
	'cecill_b',
	name  => 'CeCILL-B Free Software License Agreement',
	iri   => 'https://cecill.info/licences/Licence_CeCILL-B_V1-en.html',
	grant => <<EOF,
This software is governed by the CeCILL-B license under French law and abiding by the rules of distribution of free software.
You can  use, modify and/ or redistribute the software under the terms of the CeCILL-B license as circulated by CEA, CNRS and INRIA at the following URL "http://www.cecill.info".
EOF
	text => <<EOF,
Ce contrat est une licence de logiciel libre dont l'objectif est de conférer aux utilisateurs une très large liberté de modification et de redistribution du logiciel régi par cette licence.
EOF
	TODO => [qw(not_iri_name)]
);

license_covered(
	'cecill_b_1',
	name  => 'CeCILL-B License 1.0',
	iri   => 'https://cecill.info/licences/Licence_CeCILL-B_V1-en.html',
	grant => <<EOF,
This software is governed by the CeCILL-B license under French law and abiding by the rules of distribution of free software.
You can  use, modify and/ or redistribute the software under the terms of the CeCILL-B license as circulated by CEA, CNRS and INRIA at the following URL "http://www.cecill.info".
EOF
	text => <<EOF,
Ce contrat est une licence de logiciel libre dont l'objectif est de conférer aux utilisateurs une très large liberté de modification et de redistribution du logiciel régi par cette licence.
EOF
	TODO => [qw(not_iri_name)]
);

license_covered(
	'cecill_c',
	name  => 'CeCILL-C Free Software License Agreement',
	iri   => 'https://cecill.info/licences/Licence_CeCILL-C_V1-fr.html',
	grant => <<EOF,
This software is governed by the CeCILL-C license under French law and abiding by the rules of distribution of free software.
You can  use, modify and/ or redistribute the software under the terms of the CeCILL-C license as circulated by CEA, CNRS and INRIA at the following URL "http://www.cecill.info".
EOF
	text => <<EOF,
6.4 MENTIONS DES DROITS

Le Licencié s'engage expressément:

1. à ne pas supprimer ou modifier de quelque manière que ce soit les mentions de propriété intellectuelle apposées sur le Logiciel;

2. à reproduire à l'identique lesdites mentions de propriété intellectuelle sur les copies du Logiciel modifié ou non;

3. à faire en sorte que l'utilisation du Logiciel, ses mentions de propriété intellectuelle et le fait qu'il est régi par le Contrat soient indiqués dans un texte facilement accessible notamment depuis l'interface de tout Logiciel Dérivé.

Le Licencié s'engage à ne pas porter atteinte, directement ou indirectement, aux droits de propriété intellectuelle du Titulaire et/ou des Contributeurs sur le Logiciel et à prendre, le cas échéant, à l'égard de son personnel toutes les mesures nécessaires pour assurer le respect des dits droits de propriété intellectuelle du Titulaire et/ou des Contributeurs.
EOF
	TODO => [qw(not_iri_name)]
);

license_covered(
	'cecill_c_1',
	name  => 'CeCILL-C License 1.0',
	iri   => 'https://cecill.info/licences/Licence_CeCILL-C_V1-fr.html',
	grant => <<EOF,
This software is governed by the CeCILL-C license under French law and abiding by the rules of distribution of free software.
You can  use, modify and/ or redistribute the software under the terms of the CeCILL-C license as circulated by CEA, CNRS and INRIA at the following URL "http://www.cecill.info".
EOF
	text => <<EOF,
6.4 MENTIONS DES DROITS

Le Licencié s'engage expressément:

1. à ne pas supprimer ou modifier de quelque manière que ce soit les mentions de propriété intellectuelle apposées sur le Logiciel;

2. à reproduire à l'identique lesdites mentions de propriété intellectuelle sur les copies du Logiciel modifié ou non;

3. à faire en sorte que l'utilisation du Logiciel, ses mentions de propriété intellectuelle et le fait qu'il est régi par le Contrat soient indiqués dans un texte facilement accessible notamment depuis l'interface de tout Logiciel Dérivé.

Le Licencié s'engage à ne pas porter atteinte, directement ou indirectement, aux droits de propriété intellectuelle du Titulaire et/ou des Contributeurs sur le Logiciel et à prendre, le cas échéant, à l'égard de son personnel toutes les mesures nécessaires pour assurer le respect des dits droits de propriété intellectuelle du Titulaire et/ou des Contributeurs.
EOF
	TODO => [qw(not_iri_name)]
);

license_covered(
	'cnri_jython',
	name => 'CNRI Jython License',
	text => <<EOF,
5. CNRI is making the Software available to Licensee on an "AS IS" basis.
EOF
);

license_covered(
	'cnri_python',
	name => '',
	text => <<EOF,
4. CNRI is making Python 1.6b1 available to Licensee on an "AS IS" basis.
EOF
);

license_covered(
	'cnri_python_gpl_compat',
	name => 'CNRI Python Open Source GPL Compatible License Agreement',
	text => <<EOF,
4. CNRI is making Python 1.6.1 available to Licensee on an "AS IS" basis.
EOF
);

license_covered(
	'cpal',
	name => 'Common Public Attribution License',
	TODO => [qw(subject_license)]
);

license_covered(
	'cpal_1',
	name => 'Common Public Attribution License 1.0',
	text => <<EOF,
Common Public Attribution License Version 1.0 (CPAL)

1. "Definitions"
EOF
);

license_covered(
	'cpl',
	name => 'Common Public License',
	TODO => [qw(not_iri_name subject_license)]
);

license_covered(
	'cpl_1',
	name => 'Common Public License 1.0',
	text => <<EOF,
Common Public License Version 1.0

THE ACCOMPANYING PROGRAM IS PROVIDED UNDER THE TERMS OF THIS COMMON PUBLIC LICENSE ("AGREEMENT"). ANY USE, REPRODUCTION OR DISTRIBUTION OF THE PROGRAM CONSTITUTES RECIPIENT'S ACCEPTANCE OF THIS AGREEMENT. 1.

DEFINITIONS

"Contribution" means:

a) in the case of the initial Contributor, the initial code and documentation distributed under this Agreement, and
EOF
	TODO => [qw(not_iri_name subject_iri)]
);

license_covered(
	'cpol',
	name => 'The Code Project Open License',
	TODO => [qw(subject_license)]
);

license_covered(
	'cpol_1_02',
	name => 'The Code Project Open License 1.02',
	text => <<EOF,
This License governs Your use of the Work.
EOF
	TODO => [qw(name_name)]
);

license_covered(
	'cryptix',
	name => 'Cryptix Public License',
	text => <<EOF,
1. Redistributions of source code must retain the copyright notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE CRYPTIX FOUNDATION LIMITED AND CONTRIBUTORS ``AS IS''
EOF
);

license_covered(
	'cube',
	name => 'Cube License',
	text => <<EOF,
1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software.
If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
3. This notice may not be removed or altered from any source distribution.
additional clause specific to Cube:
4. Source versions may not be "relicensed" under a different license without my explicitly written permission.
EOF
);

license_covered(
	'curl',
	name => 'curl License',
	text => <<EOF,
Permission to use, copy, modify, and distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
EOF
);

license_covered(
	'dsdp',
	name => 'DSDP License',
	text => <<EOF,
This program discloses material protectable under copyright laws of the United States.
EOF
);

license_covered(
	'ecl',
	name => 'Educational Community License',
	TODO => [qw(subject_license)]
);

license_covered(
	'ecl_1',
	name => 'Educational Community License, Version 1.0',
	text => <<EOF,
Licensed under the Educational Community License version 1.0
EOF
	TODO => [qw(not_iri_name subject_iri)]
);

license_covered(
	'ecl_2',
	name => 'Educational Community License, Version 2.0',
	text => <<EOF,
Licensed under the Educational Community License, Version 2.0 (the "License");
EOF
	TODO => [qw(not_iri_name subject_iri)]
);

license_covered(
	'epl',
	name => 'Eclipse Public License',
	text => <<EOF,
Eclipse Public License - v 1.0
EOF
	TODO => [qw(subject_license)]
);

license_covered(
	'epl_1',
	name => 'Eclipse Public License 1.0',
	text => <<EOF,
Eclipse Public License - v 1.0

THE ACCOMPANYING PROGRAM IS PROVIDED UNDER THE TERMS OF THIS ECLIPSE PUBLIC LICENSE ("AGREEMENT"). ANY USE, REPRODUCTION OR DISTRIBUTION OF THE PROGRAM CONSTITUTES RECIPIENT'S ACCEPTANCE OF THIS AGREEMENT.

1. DEFINITIONS

"Contribution" means:

a) in the case of the initial Contributor, the initial code and documentation distributed under this Agreement, and
EOF
	TODO => [qw(not_iri_name subject_iri)]
);

license_covered(
	'epl_2',
	name => 'Eclipse Public License 2.0',
	text => <<EOF,
Eclipse Public License - v 2.0

THE ACCOMPANYING PROGRAM IS PROVIDED UNDER THE TERMS OF THIS ECLIPSE PUBLIC LICENSE ("AGREEMENT"). ANY USE, REPRODUCTION OR DISTRIBUTION OF THE PROGRAM CONSTITUTES RECIPIENT'S ACCEPTANCE OF THIS AGREEMENT.

1. DEFINITIONS

"Contribution" means:

a) in the case of the initial Contributor, the initial content Distributed
EOF
	TODO => [qw(not_iri_name subject_iri)]
);

license_covered(
	'eupl',
	name => 'European Union Public License',
	TODO => [qw(subject_license)]
);

license_covered(
	'eupl_1',
	name => 'European Union Public License, Version 1.0',
	text => <<EOF,
The Original Work is provided under the terms of this Licence when the Licensor (as defined below) has placed the following notice immediately following the copyright notice for the Original Work:

Licensed under the EUPL V.1.0

or has expressed by any other mean his willingness to license under the EUPL.
EOF
);

license_covered(
	'eupl_1_1',
	name => 'European Union Public License, Version 1.1',
	text => <<EOF,
The Original Work is provided under the terms of this Licence when the Licensor (as defined below) has placed the following notice immediately following the copyright notice for the Original Work:

Licensed under the EUPL V.1.1

or has expressed by any other mean his willingness to license under the EUPL.
EOF
);

license_covered(
	'eupl_1_2',
	name => 'European Union Public License, Version 1.2',
	text => <<EOF,
The Work is provided under the terms of this Licence when the Licensor (as defined below) has placed the following notice immediately following the copyright notice for the Work:

Licensed under the EUPL

or has expressed by any other means his willingness to license under the EUPL.
EOF
);

license_covered(
	'eurosym',
	name => 'Eurosym License',
	text => <<EOF,
1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software.
If you use this software in a product, an acknowledgment in the product documentation would be appreciated.
2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
3. You must not use any of the names of the authors or copyright holders of the original software for advertising or publicity pertaining to distribution without specific, written prior permission.
4. If you change this software and redistribute parts or all of it in any form, you must make the source code of the altered version of this software available.
5. This notice may not be removed or altered from any source distribution.
EOF
);

license_covered(
	'fsfap',
	name => 'FSF All Permissive License',
	iri =>
		'https://www.gnu.org/prep/maintain/html_node/License-Notices-for-Other-Files.html',
	text => <<EOF,
Copying and distribution of this file, with or without modification, are permitted in any medium without royalty provided the copyright notice and this notice are preserved.
This file is offered as-is, without any warranty.
EOF
);

license_covered(
	'fsful',
	name => 'FSF Unlimited License',
	text => <<EOF,
This configure script is free software; the Free Software Foundation gives unlimited permission to copy, distribute and modify it.
EOF
);

license_covered(
	'fsfullr',
	name => 'FSF Unlimited License (with License Retention)',
	text => <<EOF,
This file is free software; the Free Software Foundation gives unlimited permission to copy and/or distribute it, with or without modifications, as long as this notice is preserved.
EOF
	TODO => [qw(name_name)]
);

license_covered(
	'ftl',
	name => 'FreeType Project License',
	text => <<EOF,
This license applies to all files found in such packages, and which do not fall under their own explicit license.
EOF
);

license_covered(
	'gfdl',
	name => 'GNU Free Documentation License',
	text => <<EOF,
GNU Free Documentation License
Version 1.1, March 2000
EOF
	TODO => [qw(subject_license)]
);

license_covered(
	'gfdl_1_1',
	name => 'GNU Free Documentation License, Version 1.1',
	text => <<EOF,
This License applies to any manual or other work that contains a notice placed by the copyright holder saying it can be distributed under the terms of this License.
EOF
	TODO => [qw(grant_grant)]
);

license_covered(
	'gfdl_1_1_only',
	name => 'GNU Free Documentation License, Version 1.1 only',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'gfdl_1_1_or_later',
	name => 'GNU Free Documentation License, Version 1.1 or later',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'gfdl_1_2',
	name => 'GNU Free Documentation License, Version 1.2',
	text => <<EOF,
GNU Free Documentation License
Version 1.2, November 2002
EOF
	TODO => [qw(grant_grant)]
);

license_covered(
	'gfdl_1_2_only',
	name => 'GNU Free Documentation License, Version 1.2 only',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'gfdl_1_2_or_later',
	name => 'GNU Free Documentation License, Version 1.2 or later',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'gfdl_1_3',
	name => 'GNU Free Documentation License, Version 1.3',
	text => <<EOF,
GNU Free Documentation License
Version 1.3, 3 November 2008
EOF
	TODO => [qw(grant_grant)]
);

license_covered(
	'gfdl_1_3_only',
	name => 'GNU Free Documentation License, Version 1.3 only',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'gfdl_1_3_or_later',
	name => 'GNU Free Documentation License, Version 1.3 or later',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'gpl_1_only',
	name => 'GNU General Public License version 1 only',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'gpl_1_or_later',
	name => 'GNU General Public License version 1 or later',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'gpl_2_only',
	name => 'GNU General Public License version 2 only',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'gpl_2_or_later',
	name => 'GNU General Public License version 2 or later',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'gpl_3_only',
	name => 'GNU General Public License version 3 only',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'gpl_3_or_later',
	name => 'GNU General Public License version 3 or later',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'isc',
	name => 'ISC License',
	text => <<EOF,
Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies.
THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS.
EOF
);

license_covered(
	'icu',
	name => 'ICU License',
	text => <<EOF,
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, provided that the above copyright notice(s) and this permission notice appear in all copies of the Software and that both the above copyright notice(s) and this permission notice appear in supporting documentation.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR HOLDERS INCLUDED IN THIS NOTICE BE LIABLE FOR ANY CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
Except as contained in this notice, the name of a copyright holder shall not be used in advertising or otherwise to promote the sale, use or other dealings in this Software without prior written authorization of the copyright holder.
EOF
);

license_covered(
	'json',
	text => 'The Software shall be used for Good, not Evil.',
);

license_covered(
	'jython',
	name => 'Jython License',
	text =>
		'4. PSF is making Jython available to Licensee on an "AS IS" basis.',
);

license_covered(
	'kevlin_henney',
	text => <<EOF,
Permission to use, copy, modify, and distribute this software and its documentation for any purpose is hereby granted without fee, provided that this copyright and permissions notice appear in all copies and derivatives.
This software is supplied "as is" without express or implied warranty.
But that said, if there are any problems please get in touch.
EOF
	TODO => [qw(subject_iri)]
);

license_covered(
	'lgpl',
	name => 'GNU Library General Public License',
	TODO => [qw(subject_license)]
);

license_covered(
	'lgpl_2',
	name => 'GNU Library General Public License version 2',
	text => <<EOF,
This license, the Library General Public License, applies to some specially designated Free Software Foundation software
EOF
);

license_covered(
	'lgpl_2_only',
	name => 'GNU Library General Public License version 2 only',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'lgpl_2_or_later',
	name => 'GNU Library General Public License version 2 or newer',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'lgpl_2_1',
	name => 'GNU Lesser General Public License version 2.1',
	text => <<EOF,
This license, the Lesser General Public License, applies to some specially designated software packages
EOF
);

license_covered(
	'lgpl_2_1_only',
	name => 'GNU Lesser General Public License version 2.1 only',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'lgpl_2_1_or_later',
	name => 'GNU Lesser General Public License version 2.1 or newer',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'lgpl_3',
	name => 'GNU Lesser General Public License version 3',
	text => <<EOF,
As used herein, "this License" refers to version 3 of the GNU Lesser General Public License
EOF
);

license_covered(
	'lgpl_3_only',
	name => 'GNU Lesser General Public License version 3 only',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'lgpl_3_or_later',
	name => 'GNU Lesser General Public License version 3 or newer',
	TODO => [qw(subject_iri subject_license)]
);

license_covered(
	'lgpl_bdwgc',
	text => <<EOF,
Permission is hereby granted to use or copy this program under the terms of the GNU LGPL, provided that the Copyright, this License, and the Availability of the original version is retained on all copies.
User documentation of any code that uses this code or any modified version of this code must cite the Copyright, this License, the Availability note, and "Used by permission."
Permission to modify the code and to distribute modified code is granted, provided the Copyright, this License, and the Availability note are retained, and a notice that the code was modified is included.
EOF
	TODO => [qw(subject_iri)]
);

license_covered(
	'llgpl',
	name => 'Lisp Lesser General Public License',
	iri  => 'http://opensource.franz.com/preamble.html',
	text => <<EOF,
as governed by the terms of the Lisp Lesser General Public License
EOF
	TODO => [qw(subject_license)]
);

license_covered(
	'libpng',
	name => 'libpng License',
	text => <<EOF,
1. The origin of this source code must not be misrepresented.
2. Altered versions must be plainly marked as such and must not be misrepresented as being the original source.
3. This Copyright notice may not be removed or altered from any source or altered source distribution.
The Contributing Authors and Group 42, Inc. specifically permit, without fee, and encourage the use of this source code as a component to supporting the PNG file format in commercial products.
If you use this source code in a product, acknowledgment is not required but would be appreciated.
EOF
	TODO => [qw(name_name)],
);

license_covered(
	'lppl',
	name => 'LaTeX Project Public License',
	TODO => [qw(subject_license)]
);

license_covered(
	'lppl_1',
	name => 'LaTeX Project Public License 1.0',
	text => <<EOF,
LPPL Version 1.0 1999-03-01 Copyright 1999 LaTeX3 Project
EOF
);

license_covered(
	'lppl_1_1',
	name => 'LaTeX Project Public License 1.1',
	text => <<EOF,
LPPL Version 1.1 1999-07-10 Copyright 1999 LaTeX3 Project
EOF
);

license_covered(
	'lppl_1_2',
	name => 'LaTeX Project Public License 1.2',
	text => <<EOF,
LPPL Version 1.2 1999-09-03 Copyright 1999 LaTeX3 Project
EOF
);

license_covered(
	'lppl_1_3a',
	name => 'LaTeX Project Public License 1.3a',
	text => <<EOF,
LPPL Version 1.3a 2004-10-01 Copyright 1999 2002-04 LaTeX3 Project
EOF
	TODO => [qw(name_name)]
);

license_covered(
	'lppl_1_3c',
	name => 'LaTeX Project Public License 1.3c',
	text => <<EOF,
LPPL Version 1.3c 2008-05-04 Copyright 1999 2002-2008 LaTeX3 Project
EOF
	TODO => [qw(name_name)]
);

license_covered(
	'mit_advertising',
	text => <<EOF,
The above copyright notice and this permission notice shall be included in all copies of the Software, its documentation and marketing & publicity materials, and acknowledgment shall be given in the documentation, materials and software packages that this Software was used.
EOF
);

license_covered(
	'mit_cmu',
	name => 'CMU License',
	text => <<EOF,
Permission to use, copy, modify and distribute this software and its documentation for any purpose and without fee is hereby granted, provided that the above copyright notice appears in all copies and that both that copyright notice and this permission notice appear in supporting documentation, and that the name of CMU and The Regents of the University of California not be used in advertising or publicity pertaining to distribution of the software without specific written permission.
EOF
);

license_covered(
	'mit_cmu_warranty',
	text => <<EOF,
Permission to use, copy, modify, and distribute this software and its documentation for any purpose and without fee is hereby granted, provided that the above copyright notice appear in all copies and that both the copyright notice and this permission notice and warranty disclaimer appear in supporting documentation, and that the name of Lucent Technologies, Bell Labs or any Lucent entity not be used in advertising or publicity pertaining to distribution of the software without specific, written prior permission.
EOF
);

license_covered(
	'mit_enna',
	name => 'enna License',
	text => <<EOF,
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies of the Software and its Copyright notices.
In addition publicly documented acknowledgment must be given that this software has been used if no source code of this software is made available publicly.
This includes acknowledgments in either Copyright notices, Manuals, Publicity and Marketing documents or any documentation provided with any product containing this software.
This License does not apply to any software that links to the libraries provided by this software (statically or dynamically), but only to the software provided.
EOF
);

license_covered(
	'mit_feh',
	name => 'feh License',
	text => <<EOF,
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies of the Software and its documentation and acknowledgment shall be given in the documentation and software packages that this Software was used.
EOF
);

license_covered(
	'mit_new',
	name => 'MIT License',
	iri  => 'http://www.jclark.com/xml/copying.txt',
	text => <<EOF,
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
EOF
);

license_covered(
	'mit_new_materials',
	text => <<EOF,
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and/or associated documentation files (the "Materials"), to deal in the Materials without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Materials, and to permit persons to whom the Materials are furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Materials.
EOF
	TODO => [qw(subject_iri)]
);

license_covered(
	'mit_old',
	text => <<EOF,
Permission is hereby granted, without written agreement and without license or royalty fees, to use, copy, modify, and distribute this software and its documentation for any purpose, provided that the above copyright notice and the following two paragraphs appear in all copies of this software.
EOF
	TODO => [qw(subject_iri)]
);

license_covered(
	'mit_oldstyle',
	text => <<EOF,
Permission to use, copy, modify, distribute, and sell this software and its documentation for any purpose is hereby granted without fee, provided that the above copyright notice appear in all copies and that both that copyright notice and this permission notice appear in supporting documentation.
No representations are made about the suitability of this software for any purpose.
It is provided "as is" without express or implied warranty.
EOF
);

license_covered(
	'mit_oldstyle_disclaimer',
	text => <<EOF,
Permission to use, copy, modify, and distribute this software and its documentation for any purpose and without fee is hereby granted, provided that the above copyright notice appear in all copies and that both that copyright notice and this permission notice appear in supporting documentation.
THE AUTHOR PROVIDES THIS SOFTWARE ''AS IS'' AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
EOF
);

license_covered(
	'mit_oldstyle_permission',
	text => <<EOF,
License to use, copy, modify, and distribute this software and its documentation for any purpose and without fee is hereby granted, provided that the above copyright notice appear in all copies and that both that copyright notice and this permission notice appear in supporting documentation, and that the name of IBM or Lexmark not be used in advertising or publicity pertaining to distribution of the software without specific, written prior permission.
IBM AND LEXMARK PROVIDE THIS SOFTWARE "AS IS", WITHOUT ANY WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE, INCLUDING ANY DUTY TO SUPPORT OR MAINTAIN, BELONGS TO THE LICENSEE.
SHOULD ANY PORTION OF THE SOFTWARE PROVE DEFECTIVE, THE LICENSEE (NOT IBM OR LEXMARK) ASSUMES THE ENTIRE COST OF ALL SERVICING, REPAIR AND CORRECTION.
IN NO EVENT SHALL IBM OR LEXMARK BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
EOF
);

license_covered(
	'mpl',
	name => 'Mozilla Public License',
	iri  => 'https://www.mozilla.org/MPL',
	text => <<EOF,
The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); you may not use this file except in compliance with the License.
You may obtain a copy of the License at http://www.mozilla.org/MPL/
EOF
	TODO => [qw(subject_license)]
);

license_covered(
	'mpl_1',
	name => 'Mozilla Public License 1.0',
	text => <<EOF,
MOZILLA PUBLIC LICENSE

Version 1.0

1. Definitions.
EOF
	TODO => [qw(subject_iri)]
);

license_covered(
	'mpl_1_1',
	name => 'Mozilla Public License 1.1',
	text => <<EOF,
Mozilla Public License Version 1.1

1. Definitions.
EOF
	TODO => [qw(subject_iri)]
);

license_covered(
	'mpl_2',
	name => 'Mozilla Public License 2.0',
	text => <<EOF,
Mozilla Public License Version 2.0

1. Definitions
EOF
	TODO => [qw(subject_iri)]
);

license_covered(
	'ms_pl',
	name => 'Microsoft Public License',
	iri =>
		'https://en.wikipedia.org/wiki/Shared_source#Microsoft_Public_License_(Ms-PL)',
);

license_covered(
	'ms_rl',
	name => 'Microsoft Reciprocal License',
	iri =>
		'https://en.wikipedia.org/wiki/Shared_source#Microsoft_Reciprocal_License_(Ms-RL)',
);

license_covered(
	'ngpl',
	name => 'Nethack General Public License',
	text => <<EOF,
1. You may copy and distribute verbatim copies of NetHack source code as you receive it,
EOF
);

license_covered(
	'npl',
	name => 'Netscape Public License',
	TODO => [qw(subject_license)]
);

license_covered(
	'npl_1',
	name => 'Netscape Public License version 1.0',
	text => <<EOF,
NETSCAPE PUBLIC LICENSE

Version 1.0

1. Definitions.
EOF
);

license_covered(
	'npl_1_1',
	name => 'Netscape Public License version 1.1',
	text => <<EOF,
Netscape Public LIcense version 1.1

AMENDMENTS

The Netscape Public License Version 1.1 ("NPL") consists of the Mozilla Public License Version 1.1 with the following Amendments,
EOF
);

license_covered(
	'ntp',
	name => 'NTP License',
	text => <<EOF,
Permission to use, copy, modify, and distribute this software and its documentation for any purpose with or without fee is hereby granted, provided that the above copyright notice appears in all copies and that both the copyright notice and this permission notice appear in supporting documentation, and that the name <<var;name=TMname;original=(TrademarkedName);match=.+>> not be used in advertising or publicity pertaining to distribution of the software without specific, written prior permission.
<<var;name=TMname;original=(TrademarkedName);match=.+>> makes no representations about the suitability this software for any purpose.
It is provided "as is" without express or implied warranty.
EOF
);

license_covered(
	'ntp_disclaimer',
	text => <<EOF,
Permission to use, copy, modify, and distribute this software and its documentation for any purpose and without fee is hereby granted, provided that the above copyright notice appear in all copies and that both that copyright notice and this permission notice appear in supporting documentation, and that the name of M.I.T. not be used in advertising or publicity pertaining to distribution of the software without specific, written prior permission.
M.I.T. makes no representations about the suitability of this software for any purpose.
It is provided "as is" without express or implied warranty.

M.I.T. DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL M.I.T. BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
EOF
	TODO => [qw(subject_iri)]
);

license_covered(
	'oclc',
	name => 'OCLC Research Public License',
	TODO => [qw(subject_license)]
);

license_covered(
	'oclc_1',
	name => 'OCLC Research Public License 1.0',
	text => <<EOF,
If you distribute the Program or any derivative work of the Program in a form to which the recipient can make Modifications, you must ensure
EOF
	TODO => [qw(subject_iri)]
);

license_covered(
	'oclc_2',
	name => 'OCLC Research Public License 2.0',
	text => <<EOF,
The Program must be distributed without charge beyond the costs of physically transferring the files to the recipient.
EOF
);

license_covered(
	'ofl',
	name => 'SIL Open Font License',
	iri  => 'http://scripts.sil.org/OFL',
	TODO => [qw(subject_license not_iri_name)]
);

license_covered(
	'ofl_1',
	name => 'SIL Open Font License 1.0',
	text => <<EOF,
SIL OPEN FONT LICENSE

Version 1.0 - 22 November 2005

PREAMBLE

The goals of the Open Font License (OFL) are to stimulate worldwide development of cooperative font projects, to support the font creation efforts of academic and linguistic communities, and to provide an open framework in which fonts may be shared and improved in partnership with others.

The OFL allows the licensed fonts to be used, studied, modified and redistributed freely as long as they are not sold by themselves. The fonts, including any derivative works, can be bundled, embedded, redistributed and sold with any software provided that the font names of derivative works are changed. The fonts and derivatives, however, cannot be released under any other type of license.

DEFINITIONS

"Font Software" refers to any and all of the following:
EOF
	TODO => [qw(subject_iri)]
);

license_covered(
	'ofl_1_1',
	name => 'SIL Open Font License 1.1',
	text => <<EOF,
SIL OPEN FONT LICENSE

Version 1.1 - 26 February 2007

PREAMBLE

The goals of the Open Font License (OFL) are to stimulate worldwide development of collaborative font projects, to support the font creation efforts of academic and linguistic communities, and to provide a free and open framework in which fonts may be shared and improved in partnership with others.

The OFL allows the licensed fonts to be used, studied, modified and redistributed freely as long as they are not sold by themselves. The fonts, including any derivative works, can be bundled, embedded, redistributed and/or sold with any software provided that any reserved names are not used by derivative works. The fonts and derivatives, however, cannot be released under any other type of license. The requirement for fonts to remain under this license does not apply to any document created using the fonts or their derivatives.

DEFINITIONS

"Font Software" refers to the set of files released by the Copyright Holder(s) under this license and clearly marked as such. This may include source files, build scripts and documentation.
EOF
	TODO => [qw(subject_iri)]
);

license_covered(
	'ogtsl',
	name => 'Open Group Test Suite License',
	text => <<EOF,
rename any non-standard executables and testcases so the names do not conflict with standard executables and testcases,
EOF
);

license_covered(
	'openssl',
	name => 'OpenSSL License',
	text => <<'EOF',
6. Redistributions of any form whatsoever must retain the following acknowledgment: "This product includes software developed by the OpenSSL Project for use in the OpenSSL Toolkit (http://www.openssl.org/)"

THIS SOFTWARE IS PROVIDED BY THE OpenSSL PROJECT ``AS IS'' AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE OpenSSL PROJECT OR ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

This product includes cryptographic software written by Eric Young (eay@cryptsoft.com). This product includes software written by Tim Hudson (tjh@cryptsoft.com).

Original SSLeay License

Copyright (C) 1995-1998 Eric Young (eay@cryptsoft.com) All rights reserved.

This package is an SSL implementation written by Eric Young (eay@cryptsoft.com). The implementation was written so as to conform with Netscapes SSL.

This library is free for commercial and non-commercial use as long as the following conditions are aheared to.
EOF
);

license_covered(
	'osl',
	name => 'Open Software License',
	TODO => [qw(subject_license)]
);

license_covered(
	'osl_1',
	name  => 'Open Software License 1.0',
	grant => <<EOF,
Licensed under the Open Software License version 1.0
EOF
	text => <<EOF,
This Open Software License (the "License") applies to any original work of authorship (the "Original Work") whose owner (the "Licensor") has placed the following notice immediately following the copyright notice for the Original Work:

"Licensed under the Open Software License version 1.0"

License Terms
EOF
);

license_covered(
	'osl_1_1',
	name  => 'Open Software License 1.1',
	grant => <<EOF,
Licensed under the Open Software License version 1.1
EOF
	text => <<EOF,
This Open Software License (the "License") applies to any original work of authorship (the "Original Work") whose owner (the "Licensor") has placed the following notice immediately following the copyright notice for the Original Work:

Licensed under the Open Software License version 1.1

1) Grant of Copyright License.
EOF
);

license_covered(
	'osl_2',
	name  => 'Open Software License 2.0',
	trant => <<EOF,
Licensed under the Open Software License version 2.0
EOF
	text => <<EOF,
This Open Software License (the "License") applies to any original work of authorship (the "Original Work") whose owner (the "Licensor") has placed the following notice immediately following the copyright notice for the Original Work:

Licensed under the Open Software License version 2.0

1) Grant of Copyright License.
EOF
);

license_covered(
	'osl_2_1',
	name  => 'Open Software License 2.1',
	grant => <<EOF,
Licensed under the Open Software License version 2.1
EOF
	text => <<EOF,
This Open Software License (the "License") applies to any original work of authorship (the "Original Work") whose owner (the "Licensor") has placed the following notice immediately following the copyright notice for the Original Work:

Licensed under the Open Software License version 2.1

1) Grant of Copyright License.
EOF
);

license_covered(
	'osl_3',
	name  => 'Open Software License 3.0',
	grant => <<EOF,
Licensed under the Open Software License version 3.0
EOF
	text => <<EOF,
This Open Software License (the "License") applies to any original work of authorship (the "Original Work") whose owner (the "Licensor") has placed the following licensing notice adjacent to the copyright notice for the Original Work:

Licensed under the Open Software License version 3.0

1) Grant of Copyright License.
EOF
);

license_covered(
	'postgresql',
	name => 'PostgreSQL License',
	text => <<EOF,
Permission to use, copy, modify, and distribute this software and its documentation for any purpose, without fee, and without a written agreement is hereby granted, provided that the above copyright notice and this paragraph and the following two paragraphs appear in all copies.
EOF
);

license_covered(
	'public_domain',
	iri   => 'http://www.linfo.org/publicdomain.html',
	grant => <<EOF,
This file is put in the public domain
EOF
	TODO => [qw(subject_license)]
);

license_covered(
	'python',
	name => 'Python License',
	TODO => [qw(name_name subject_license)]
);

license_covered(
	'python_2',
	name => 'Python Software Foundation License version 2',
	text =>
		'4. PSF is making Python available to Licensee on an "AS IS" basis.',
);

license_covered(
	'qpl',
	name => 'Q Public License',
	TODO => [qw(subject_license)]
);

license_covered(
	'qpl_1',
	name => 'Q Public License 1.0',
	text => <<EOF,
This license applies to any software containing a notice placed by the copyright holder saying that it may be distributed under the terms of the Q Public License version 1.0. Such software is herein referred to as the Software.
EOF
);

license_covered(
	'rpl',
	name => 'Reciprocal Public License',
	TODO => [qw(subject_license)]
);

license_covered(
	'rpl_1',
	name => 'Reciprocal Public License, Version 1.0',
	text => <<EOF,
1.0 General; Applicability & Definitions. This Reciprocal Public License Version 1.0 ("License") applies to any programs or other works
EOF
);

license_covered(
	'rpl_1_1',
	name => 'Reciprocal Public License, Version 1.1',
	text => <<EOF,
1.0 General; Applicability & Definitions. This Reciprocal Public License Version 1.1 ("License") applies to any programs or other works
EOF
);

license_covered(
	'rpl_1_3',
	name => 'Reciprocal Public License, Version 1.3',
	text => <<EOF,
1.0 General; Applicability & Definitions. This Reciprocal Public License Version 1.3 ("License") applies to any programs or other works
EOF
);

license_covered(
	'rpl_1_5',
	name => 'Reciprocal Public License, Version 1.5',
	text => <<EOF,
1.0 General; Applicability & Definitions. This Reciprocal Public License Version 1.5 ("License") applies to any programs or other works
EOF
);

license_covered(
	'rpsl',
	name => 'RealNetworks Public Source License',
	TODO => [qw(subject_license)]
);

license_covered(
	'rpsl_1',
	name => 'RealNetworks Public Source License 1.0',
	text => <<EOF,
1. General Definitions. This License applies to any program or other work which RealNetworks, Inc., or any other entity that elects to use this license,
EOF
);

license_covered(
	'ruby',
	name => 'Ruby License',
	text => <<EOF,
4. You may modify and include the part of the software into any other software (possibly commercial).
EOF
);

license_covered(
	'rscpl',
	name => 'Ricoh Source Code Public License',
	text => <<EOF,
5.2. Endorsements. The names "Ricoh," "Ricoh Silicon Valley," and "RSV" must not be used
EOF
);

license_covered(
	'sgi_b',
	name => 'SGI Free Software License B',
	iri  => 'https://www.sgi.com/projects/FreeB/',
	TODO => [qw(subject_license not_iri_name)]
);

license_covered(
	'sgi_b_1',
	name => 'SGI Free Software License B v1.0',
	text => <<EOF,
SGI FREE SOFTWARE LICENSE B

(Version 1.0 1/25/2000)

1. Definitions.
EOF
	TODO => [qw(subject_iri)]
);

license_covered(
	'sgi_b_1_1',
	name => 'SGI Free Software License B v1.1',
	text => <<EOF,
SGI FREE SOFTWARE LICENSE B

(Version 1.1 02/22/2000)

1. Definitions.
EOF
	TODO => [qw(subject_iri)]
);

license_covered(
	'sgi_b_2',
	name => 'SGI Free Software License B v2.0',
	text => <<EOF,
SGI FREE SOFTWARE LICENSE B

(Version 2.0, Sept. 18, 2008) Copyright (C) [dates of first publication] Silicon Graphics, Inc. All Rights Reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
EOF
	TODO => [qw(subject_iri)]
);

license_covered(
	'spl',
	name => 'Sun Public License',
	TODO => [qw(subject_license)]
);

license_covered(
	'spl_1',
	name  => 'Sun Public License 1.0',
	grant => <<EOF,
The contents of this file are subject to the Sun Public License Version 1.0 (the License);
EOF
	text => <<EOF,
Exhibit A -Sun Public License Notice.

The contents of this file are subject to the Sun Public License Version 1.0
EOF
	TODO => [qw(grant_grant)]
);

license_covered(
	'sugarcrm',
	name => 'SugarCRM Public License',
	TODO => [qw(subject_license)]
);

license_covered(
	'sugarcrm_1_1_3',
	name => 'SugarCRM Public License v1.1.3',
	text => <<EOF,
Version 1.1.3

The SugarCRM Public License Version ("SPL") consists of the Mozilla Public License Version 1.1,
EOF
);

license_covered(
	'unicode_strict',
	text => <<EOF,
This file is provided as-is by Unicode, Inc. (The Unicode Consortium).
No claims are made as to fitness for any particular purpose.
No warranties of any kind are expressed or implied.
The recipient agrees to determine applicability of information provided.  If this file has been provided on optical media by Unicode, Inc., the sole remedy for any claim will be exchange of defective media within 90 days of receipt.
Unicode, Inc. hereby grants the right to freely use the information supplied in this file in the creation of products supporting the Unicode Standard, and to make copies of this file in any form for internal or external distribution as long as this notice remains attached.
EOF
	TODO => [qw(subject_iri)]
);

license_covered(
	'unicode_tou',
	name => 'Unicode Terms of Use',
	text => <<EOF,
3. Any person is hereby authorized, without fee, to view, use, reproduce, and distribute all documents and files solely for informational purposes in the creation of products supporting the Unicode Standard, subject to the Terms and Conditions herein.
EOF
);

license_covered(
	'unlicense',
	name => 'the Unlicense',
	text => <<EOF,
This is free and unencumbered software released into the public domain.
EOF
);

license_covered(
	'watcom',
	name => 'Sybase Open Watcom Public License',
	TODO => [qw(subject_license)]
);

license_covered(
	'watcom_1',
	name => 'Sybase Open Watcom Public License 1.0',
	text => <<EOF,
USE OF THE SYBASE OPEN WATCOM SOFTWARE DESCRIBED BELOW ("SOFTWARE") IS SUBJECT TO THE TERMS AND CONDITIONS SET FORTH IN THE SYBASE OPEN WATCOM PUBLIC LICENSE SET FORTH BELOW ("LICENSE").
EOF
);

license_covered(
	'wtfpl',
	name  => 'Do What The F*ck You Want To Public License',
	iri   => 'http://www.wtfpl.net/',
	grant => 'This input method table is licensed under the WTFPL.',
);

license_covered(
	'wtfpl_1',
	name => 'Do What The Fuck You Want To Public License, Version 1',
	iri  => 'http://cvs.windowmaker.org/co.php/wm/COPYING.WTFPL',
	text => <<EOF,
Ok, the purpose of this license is simple and you just

DO WHAT THE FUCK YOU WANT TO.
EOF
	TODO => [qw(name_name not_iri_name)]
);

license_covered(
	'wtfpl_2',
	name  => 'Do What The Fuck You Want To Public License, Version 2',
	iri   => 'http://www.wtfpl.net/',
	grant => <<EOF,
This work is free.
You can redistribute it and/or modify it under the terms of the Do What The Fuck You Want To Public License, Version 2, as published by Sam Hocevar.
See the COPYING file for more details.
EOF
	text => <<EOF,
DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

0. You just DO WHAT THE FUCK YOU WANT TO.
EOF
	TODO => [qw(name_name not_iri_name)]
);

license_covered(
	'wtfnmfpl',
	name =>
		"Do What The Fuck You Want To But It's Not My Fault Public License",
	TODO => [qw(name_name subject_license)]
);

license_covered(
	'wtfnmfpl_1',
	name =>
		"Do What The Fuck You Want To But It's Not My Fault Public License v1",
	iri =>
		'http://www.adversary.org/wp/2013/10/14/do-what-the-fuck-you-want-but-its-not-my-fault/',
	text => <<EOF,
0. You just DO WHAT THE FUCK YOU WANT TO.

1. Do not hold the author(s), creator(s), developer(s) or distributor(s) liable for anything that happens or goes wrong with your use of the work.
EOF
);

license_covered(
	'zlib',
	name => 'zlib License',
	iri  => 'http://zlib.net/zlib_license.html',
	text => <<EOF,
This software is provided 'as-is', without any express or implied warranty.
In no event will the authors be held liable for any damages arising from the use of this software.
Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software.
If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
3. This notice may not be removed or altered from any source distribution.
EOF
	TODO => [qw(not_iri_name)]
);

license_covered(
	'zlib_acknowledgement',
	name => 'zlib/libpng License with Acknowledgement',
	text => <<EOF,
This software is provided 'as-is', without any express or implied warranty.
In no event will the authors be held liable for any damages arising from the use of this software.
Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software.
If you use this software in a product, an acknowledgment (see the following) in the product documentation is required.
Portions Copyright (c) 2002-2007 Charlie Poole or Copyright (c) 2002-2004 James W. Newkirk, Michael C. Two, Alexei A. Vorontsov or Copyright (c) 2000-2002 Philip A. Craig
2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
3. This notice may not be removed or altered from any source distribution.
EOF
);

license_covered(
	'zpl',
	name => 'ZPL License',
	TODO => [qw(subject_license)]
);

license_covered(
	'zpl_1',
	name => 'Zope Public License 1.0',
	iri  => 'http://www.zope.org/Resources/ZPL',
	TODO => [qw(subject_license)]
);

license_covered(
	'zpl_1_1',
	name => 'Zope Public License 1.1',
	iri  => 'https://spdx.org/licenses/ZPL-1.1',
	TODO => [qw(not_iri_name subject_license)]
);

license_covered(
	'zpl_2',
	name => 'Zope Public License 2.0',
	iri  => 'http://old.zope.org/Resources/License/ZPL-1.1',
	TODO => [qw(subject_license)]
);

license_covered(
	'zpl_2_1',
	name => 'Zope Public License 2.1',
	iri  => 'http://old.zope.org/Resources/ZPL/',
	TODO => [qw(subject_license)]
);

license_covered(
	'bsd',
	name => 'BSD 4-Clause',
	iri  => 'https://en.wikipedia.org/wiki/BSD_licenses',
	text => <<EOF,
Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
3. All advertising materials mentioning features or use of this software must display the following acknowledgement:
This product includes software developed by the <organization>.
4. Neither the name of the <organization> nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY <COPYRIGHT HOLDER> ''AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
EOF
	TODO => [qw(not_iri_name)]
);

license_covered(
	'mit',
	name  => 'MIT License',
	iri   => 'https://en.wikipedia.org/wiki/MIT_License',
	grant => 'Released under the MIT license',
	TODO  => [qw(name_name subject_license)]
);

done_testing;
