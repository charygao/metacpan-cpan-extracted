#!/bin/sh

BDIR=$(pwd)/libdwarf

echo $BDIR

(cd $BDIR && rm -f libdwarf/*.pdf)
(cd $BDIR && rm -f libdwarf/*.mm)
patch -p1 < misc/libelf.patch
