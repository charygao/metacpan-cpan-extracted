// *************************************************************************
// Copyright (c) 2014-2017, SUSE LLC
//
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright
// notice, this list of conditions and the following disclaimer in the
// documentation and/or other materials provided with the distribution.
//
// 3. Neither the name of SUSE LLC nor the names of its contributors may be
// used to endorse or promote products derived from this software without
// specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
// *************************************************************************
//
// tests/datetime.js
//
"use strict";

define ([
    'QUnit',
    'datetime',
], function (
    QUnit,
    dt,
) {

    var date_valid = function (assert, d) {
            console.log("Entering date_valid() with argument", d);
            var r = dt.vetDate(d);
            assert.ok(r, "valid: " + d + " -> " + r);
        },
        date_invalid = function (assert, d) {
            console.log("Entering date_invalid() with argument", d);
            var r = dt.vetDate(d);
            assert.strictEqual(r, null, "invalid: " + d);
        },
        time_valid = function (assert, t) {
            console.log("Entering time_valid() with argument", t);
            var r = dt.canonicalizeTime(t);
            assert.ok(r, "valid: " + t + " -> " + r);
        },
        time_invalid = function (assert, t) {
            console.log("Entering time_invalid() with argument", t);
            var r = dt.canonicalizeTime(t);
            assert.strictEqual(r, null, "invalid: " + t);
        },
        timerange_valid = function (assert, tr) {
            console.log("Entering timerange_valid() with argument", tr);
            var r = dt.vetTimeRange(tr);
            assert.ok(r, "valid: " + tr + " -> " + r);
        },
        timerange_invalid = function (assert, tr) {
            console.log("Entering timerange_invalid() with argument", tr);
            var r = dt.vetTimeRange(tr);
            assert.strictEqual(r, null, "invalid: " + tr);
        };

    return function () {

        QUnit.test('intToMonth()', function (assert) {
            assert.strictEqual(dt.intToMonth(0), null);
            assert.strictEqual(dt.intToMonth(0, true), null);
            assert.strictEqual(dt.intToMonth(-1), null);
            assert.strictEqual(dt.intToMonth(-1, true), null);
            assert.strictEqual(dt.intToMonth(13), null);
            assert.strictEqual(dt.intToMonth(13, true), null);
            assert.strictEqual(dt.intToMonth('0'), null);
            assert.strictEqual(dt.intToMonth('0', true), null);
            assert.strictEqual(dt.intToMonth('-1'), null);
            assert.strictEqual(dt.intToMonth('-1', true), null);
            assert.strictEqual(dt.intToMonth('13'), null);
            assert.strictEqual(dt.intToMonth('13', true), null);
            assert.strictEqual(dt.intToMonth(''), null);
            assert.strictEqual(dt.intToMonth('', true), null);
            assert.strictEqual(dt.intToMonth(undefined), null);
            assert.strictEqual(dt.intToMonth(undefined, true), null);
            assert.strictEqual(dt.intToMonth(null), null);
            assert.strictEqual(dt.intToMonth(null, true), null);
            assert.strictEqual(dt.intToMonth(1), 'JAN');
            assert.strictEqual(dt.intToMonth(1, true), 'January');
            assert.strictEqual(dt.intToMonth(2), 'FEB');
            assert.strictEqual(dt.intToMonth(2, true), 'February');
            assert.strictEqual(dt.intToMonth(3), 'MAR');
            assert.strictEqual(dt.intToMonth(3, true), 'March');
            assert.strictEqual(dt.intToMonth(4), 'APR');
            assert.strictEqual(dt.intToMonth(4, true), 'April');
            assert.strictEqual(dt.intToMonth(5), 'MAY');
            assert.strictEqual(dt.intToMonth(5, true), 'May');
            assert.strictEqual(dt.intToMonth(6), 'JUN');
            assert.strictEqual(dt.intToMonth(6, true), 'June');
            assert.strictEqual(dt.intToMonth(7), 'JUL');
            assert.strictEqual(dt.intToMonth(7, true), 'July');
            assert.strictEqual(dt.intToMonth(8), 'AUG');
            assert.strictEqual(dt.intToMonth(8, true), 'August');
            assert.strictEqual(dt.intToMonth(9), 'SEP');
            assert.strictEqual(dt.intToMonth(9, true), 'September');
            assert.strictEqual(dt.intToMonth(10), 'OCT');
            assert.strictEqual(dt.intToMonth(10, true), 'October');
            assert.strictEqual(dt.intToMonth(11), 'NOV');
            assert.strictEqual(dt.intToMonth(11, true), 'November');
            assert.strictEqual(dt.intToMonth(12), 'DEC');
            assert.strictEqual(dt.intToMonth(12, true), 'December');
        });

        QUnit.test('strToMonth()', function (assert) {
            assert.strictEqual(dt.strToMonth(0), null);
            assert.strictEqual(dt.strToMonth(0, true), null);
            assert.strictEqual(dt.strToMonth(-1), null);
            assert.strictEqual(dt.strToMonth(-1, true), null);
            assert.strictEqual(dt.strToMonth(13), null);
            assert.strictEqual(dt.strToMonth(13, true), null);
            assert.strictEqual(dt.strToMonth(''), null);
            assert.strictEqual(dt.strToMonth('', true), null);
            assert.strictEqual(dt.strToMonth(undefined), null);
            assert.strictEqual(dt.strToMonth(undefined, true), null);
            assert.strictEqual(dt.strToMonth('se'), 'SEP');
            assert.strictEqual(dt.strToMonth('se', true), 'September');
            assert.strictEqual(dt.strToMonth('janFHDCDC'), 'JAN');
            assert.strictEqual(dt.strToMonth('janFHDCDC', true), 'January');
            assert.strictEqual(dt.strToMonth('jan'), 'JAN');
            assert.strictEqual(dt.strToMonth('jan', true), 'January');
            assert.strictEqual(dt.strToMonth('feb'), 'FEB');
            assert.strictEqual(dt.strToMonth('feb', true), 'February');
            assert.strictEqual(dt.strToMonth('mar'), 'MAR');
            assert.strictEqual(dt.strToMonth('mar', true), 'March');
            assert.strictEqual(dt.strToMonth('apr'), 'APR');
            assert.strictEqual(dt.strToMonth('apr', true), 'April');
            assert.strictEqual(dt.strToMonth('may'), 'MAY');
            assert.strictEqual(dt.strToMonth('may', true), 'May');
            assert.strictEqual(dt.strToMonth('jun'), 'JUN');
            assert.strictEqual(dt.strToMonth('jun', true), 'June');
            assert.strictEqual(dt.strToMonth('jul'), 'JUL');
            assert.strictEqual(dt.strToMonth('jul', true), 'July');
            assert.strictEqual(dt.strToMonth('aug'), 'AUG');
            assert.strictEqual(dt.strToMonth('aug', true), 'August');
            assert.strictEqual(dt.strToMonth('sep'), 'SEP');
            assert.strictEqual(dt.strToMonth('sep', true), 'September');
            assert.strictEqual(dt.strToMonth('oct'), 'OCT');
            assert.strictEqual(dt.strToMonth('oct', true), 'October');
            assert.strictEqual(dt.strToMonth('nov'), 'NOV');
            assert.strictEqual(dt.strToMonth('nov', true), 'November');
            assert.strictEqual(dt.strToMonth('dec'), 'DEC');
            assert.strictEqual(dt.strToMonth('dec', true), 'December');
        });

        QUnit.test('month vetter function', function (assert) {
            var cm = (new Date()).getMonth() + 1,
                cms = dt.intToMonth(cm, true);
            assert.strictEqual(dt.vetMonth(''), cms, "Empty string -> " + cms);
            assert.strictEqual(dt.vetMonth(undefined), cms, "undefined -> " + cms);
            assert.strictEqual(dt.vetMonth(null), cms, "null -> " + cms);
            assert.strictEqual(dt.vetMonth(0), null, "0 -> null");
            assert.strictEqual(dt.vetMonth('0'), null, "0 -> null");
            assert.strictEqual(dt.vetMonth(' 0'), null, "0 -> null");
            assert.strictEqual(dt.vetMonth(13), null, "13 -> null");
            assert.strictEqual(dt.vetMonth('13'), null, "13 -> null");
            assert.strictEqual(dt.vetMonth(' 13'), null, "13 -> null");
            assert.strictEqual(dt.vetMonth(12), 'December', "12 -> December");
            assert.strictEqual(dt.vetMonth('12'), 'December', "12 -> December");
            assert.strictEqual(dt.vetMonth(' 12'), 'December', "12 -> December");
            assert.strictEqual(dt.vetMonth('dec'), 'December', "dec -> December");
            assert.strictEqual(dt.vetMonth('decADFA'), 'December', "decADFA -> December");
            assert.strictEqual(dt.vetMonth(' decem'), 'December', "(space)decem -> December");
            assert.strictEqual(dt.vetMonth('December'), 'December', "December -> December");
            assert.strictEqual(dt.vetMonth('foobar'), null, "foobar -> null");
        });

        QUnit.test('date vetter function: zero components', function (assert) {
            date_valid(assert, ''); // empty string
            date_valid(assert, ' '); // space
            date_valid(assert, '   '); // several spaces
            date_valid(assert, '	'); // tab
            date_valid(assert, ' 	'); // space + tab
            date_valid(assert, '	  '); // tab + 2 spaces
        });

        QUnit.test('date vetter function: one component', function (assert) {
            date_valid(assert, '31');
            date_valid(assert, 31);
            date_valid(assert, ' 31');
            date_valid(assert, ' 	31');
            date_valid(assert, '31      ');
            date_invalid(assert, '32');
            date_invalid(assert, 32);
            date_valid(assert, "-1");
            date_valid(assert, -1);
            date_valid(assert, "-2");
            date_valid(assert, "+20 ");
            date_valid(assert, "0");
            date_valid(assert, 0);
            date_invalid(assert, "january");
            date_valid(assert, "january 1 ");
            date_valid(assert, "  1 january");
            date_invalid(assert, "foobar");
            date_invalid(assert, "  1 foobar");
            date_invalid(assert, "  foobar 1");
            date_invalid(assert, " *&áb");
            date_invalid(assert, " *&áb  3");
            date_valid(assert, " yesterday ");
            date_valid(assert, " today ");
            date_valid(assert, " TOMORROW ");
            date_valid(assert, " yesterday");
            date_valid(assert, " yestBAMBLATCH");
            date_valid(assert, " YEST****");
        });

        QUnit.test('date vetter function: two components', function (assert) {
            date_valid(assert, '2 31');
            date_valid(assert, '2-31');
            date_valid(assert, '  2 31');
            date_valid(assert, '  2-31');
            date_valid(assert, '2 31	');
            date_valid(assert, '2-31	');
            date_valid(assert, '  2 31	  	');
            date_valid(assert, '  2-31	  	');
            date_valid(assert, 'February 31');
            date_valid(assert, 'February-31');
            date_valid(assert, 'feb 31');
            date_valid(assert, 'feb-31');
            date_valid(assert, '31 feb');
            date_valid(assert, '31-feb');
            date_invalid(assert, '2 foo');
            date_invalid(assert, '2-foo');
            date_invalid(assert, '2 unor');
            date_invalid(assert, '2-unor');
            date_invalid(assert, '2. února');
            date_invalid(assert, 'february 5.5');
            date_valid(assert, 'dec 15');
            date_valid(assert, 'dec-15');
            date_valid(assert, '15    deception ');
            date_invalid(assert, 'dec 155');
            date_invalid(assert, '	-  ');
            date_invalid(assert, '	.  ');
            date_invalid(assert, ' 	/  ');
            date_invalid(assert, '3.1415927');
            date_valid(assert, '31-5');
            date_valid(assert, '5-31');
            date_valid(assert, '5-3');
            date_valid(assert, '5.3');
        });

        QUnit.test('date vetter function: three components', function (assert) {
            date_invalid(assert, 'February 31.');
            date_invalid(assert, 'February-31.');
            date_valid(assert, "2017 oct 15");
            date_valid(assert, "15 oct 2017");
            date_valid(assert, "2017 octopus 15");
            date_valid(assert, "15 octopus 2017");
            date_valid(assert, "2017 October 15");
            date_valid(assert, "15 October 2017");
            date_invalid(assert, "15 oct 20177");
            date_invalid(assert, "20177 oct 15");
            date_invalid(assert, "2017 octopus 0");
            date_invalid(assert, "0 octopus 1999");
            date_invalid(assert, "155 oct 2017");
            date_invalid(assert, 'Pi 3.1415927');
            date_valid(assert, '2017-SEP-30ll');
            date_valid(assert, '2017asdf*-SEP-30ll');
            date_valid(assert, '2017***-SEP-30ll');
        });

        QUnit.test('date vetter function: 4+ components', function (assert) {
            date_invalid(assert, "2017 oct 15 b");
            date_invalid(assert, "15 oct 2017 c");
            date_invalid(assert, '-	-  ');
            date_invalid(assert, '.	-  ');
            date_invalid(assert, ' .	/  ');
            date_invalid(assert, '15  -  deception ');
            date_invalid(assert, 'Pi is approximately 3.1415927');
        });

        QUnit.test('canonicalizeTime', function (assert) {
            time_valid(assert, "7:00");
            time_valid(assert, "7:0");
            time_valid(assert, "7:");
            time_valid(assert, "0:00");
            time_valid(assert, "0:0");
            time_valid(assert, ":0");
            time_valid(assert, ":");
            time_valid(assert, "7");
            time_invalid(assert, "foobar");
            time_invalid(assert, "foo:bar");
            time_invalid(assert, "foo:10");
            time_invalid(assert, "10:bar");
            time_invalid(assert, "10:K§Ň");
            time_invalid(assert, "-1:");
            time_invalid(assert, "5:-434");
            time_invalid(assert, "5:-43");
            time_invalid(assert, "5:60");
            time_invalid(assert, "24:60");
            time_invalid(assert, "245:600");
            time_invalid(assert, "25:50");
            time_valid(assert, "02:50");
            time_invalid(assert, "02:60");
            time_valid(assert, "02:03");
            time_valid(assert, "12:00");
            time_valid(assert, "2:1");
            time_valid(assert, "1:2");
            time_valid(assert, "1:9");
            time_valid(assert, "10:10");
            time_invalid(assert, "25:10");
            time_invalid(assert, "10::10");
            time_valid(assert, "10: 10");
            time_valid(assert, "10 :10");
        });

        QUnit.test('time range vetter function', function (assert) {
            timerange_valid(assert, "12:00-12:30");
            timerange_valid(assert, "12:00 -12:30");
            timerange_valid(assert, "12:00 - 12:30");
            timerange_invalid(assert, "12:00 -- 12:30");
            timerange_invalid(assert, "12:60-12:00");
            timerange_invalid(assert, "12:00-12:60");
            timerange_valid(assert, "12:0-12:6");
            timerange_valid(assert, "12:6-12:0");
            timerange_invalid(assert, "12::6-12:0");
            timerange_valid(assert, "8-12");
        });

        QUnit.test('time range vetter function - offset', function (assert) {
            timerange_valid(assert, "8+1");
            timerange_valid(assert, "16+10");
            timerange_valid(assert, "8:00+1");
            timerange_valid(assert, "8:00+1:45");
            timerange_valid(assert, "8:45+1:45");
            timerange_valid(assert, "8:45+1:55");
            timerange_valid(assert, "23:45+0:15");
            timerange_valid(assert, "23:45+0:16");
            timerange_valid(assert, "0+0");
            timerange_valid(assert, "+0:00");
            timerange_valid(assert, "+1:5");
            timerange_valid(assert, "+");
        });

        QUnit.test('is time range after time', function (assert) {
            assert.ok(dt.isTimeRangeAfterTime('08:00-12:00', '07:30'), "08:00 is after 07:30");
            assert.ok(dt.isTimeRangeAfterTime('08:00-12:00', "7:30"), "08:00 is after 7:30");
            assert.ok(dt.isTimeRangeAfterTime('8:00-12:00', "07:30"), "8:00 is after 07:30");
            assert.ok(dt.isTimeRangeAfterTime('8:00-9:0', "7:3"), "8:00 is after 7:3");
            assert.notOk(dt.isTimeRangeAfterTime('8:00-9:00', "8:00"), "8:00 is NOT after 8:00");
            assert.notOk(dt.isTimeRangeAfterTime('8:00-9:00', "8:01"), "8:00 is NOT after 8:01");
            assert.notOk(dt.isTimeRangeAfterTime('8:00-9:00', "9:00"), "8:00 is NOT after 9:00");
        });

        QUnit.test('is time within time range', function (assert) {
            assert.notOk(dt.isTimeWithinTimeRange('07:30', '08:00-12:00'), "07:30 is not within 08:00-12:00");
            assert.notOk(dt.isTimeWithinTimeRange('7:40', '08:00-12:00'), "7:40 is not within 08:00-12:00");
            assert.ok(dt.isTimeWithinTimeRange('8:00', '08:00-12:00'), "8:00 is within 08:00-12:00");
            assert.ok(dt.isTimeWithinTimeRange('8:15', '08:00-12:00'), "8:15 is within 08:00-12:00");
            assert.ok(dt.isTimeWithinTimeRange('8:55', '08:00-12:00'), "8:55 is within 08:00-12:00");
            assert.ok(dt.isTimeWithinTimeRange('9:00', '08:00-12:00'), "9:00 is within 08:00-12:00");
            assert.ok(dt.isTimeWithinTimeRange('10:46', '08:00-12:00'), "10:46 is within 08:00-12:00");
            assert.notOk(dt.isTimeWithinTimeRange('12:00', '08:00-12:00'), "12:00 is not within 08:00-12:00");
            assert.notOk(dt.isTimeWithinTimeRange('12:15', '08:00-12:00'), "12:15 is not within 08:00-12:00");
            assert.notOk(dt.isTimeWithinTimeRange('13:00', '08:00-12:00'), "13:00 is not within 08:00-12:00");
        });

    };

});

