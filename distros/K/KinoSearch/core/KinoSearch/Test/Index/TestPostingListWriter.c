#define C_KINO_TESTPOSTINGLISTWRITER
#include "KinoSearch/Util/ToolSet.h"

#include "KinoSearch/Test.h"
#include "KinoSearch/Test/Index/TestPostingListWriter.h"

void
TestPListWriter_run_tests()
{
    TestBatch *batch = TestBatch_new(1);
    TestBatch_Plan(batch);
    PASS(batch, "Placeholder");
    DECREF(batch);
}

/* Copyright 2005-2011 Marvin Humphrey
 *
 * This program is free software; you can redistribute it and/or modify
 * under the same terms as Perl itself.
 */

