#!/bin/bash

# A script to run the "lite" ("one-word-per-each-paradigm-") testvoc.
#
# Assumes the pair is compiled.
# Extracts lexical units from compressed text files in languages/apertium-tur/
# tests/morphotactics/ and languages/apertium-uzb/tests/morphotactics
# and passes them through the translator (=INCONSISTENCY script).
# Produces 'testvoc-summary' files using the INCONSISTENCY_SUMMARY script.
#
# TODO: Generate stats about each file (e.g. N1.txt), not just about the category (e.g. nouns).
#
# Usage: [TMPDIR=/path/to/tmpdir] ./testvoc.sh

INCONSISTENCY=../standard/./inconsistency.sh
INCONSISTENCY_SUMMARY=../standard/./inconsistency-summary.sh

if [ -z $TMPDIR ]; then
	TMPDIR="/tmp"
fi

export TMPDIR

function extract_lexical_units {
    sort -u | cut -f2 -d':' | \
    sed 's/^/^/g' | sed 's/$/$ ^.<sent>$/g'
}

#-------------------------------------------------------------------------------
# Turkish->Uzbek testvoc
#-------------------------------------------------------------------------------

PARDEF_FILES=../../../apertium-tur/tests/morphotactics/*.txt.gz

echo "==Turkish->Uzbek==========================="

echo "" > $TMPDIR/tur-uzb.testvoc

for file in $PARDEF_FILES; do
    zcat $file | extract_lexical_units |
    $INCONSISTENCY tur-uzb >> $TMPDIR/tur-uzb.testvoc
done

$INCONSISTENCY_SUMMARY $TMPDIR/tur-uzb.testvoc tur-uzb

#-------------------------------------------------------------------------------
# Uzbek->Turkish testvoc
#-------------------------------------------------------------------------------

# TODO
