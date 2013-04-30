#!/bin/bash

#assuming that you have the whole apertium tree in your source dir. and you are in tur-uzb directory

python3 ../../trunk/apertium-tools/trim-lexc.py apertium-tur-uzb.tur-uzb.dix ../apertium-tur/apertium-tur.tur.lexc ../apertium-uzb/apertium-uzb.uzb.lexc

cp /tmp/apertium-tur.tur.lexc.trimmed apertium-tur-uzb.tur.lexc
cp /tmp/apertium-uzb.uzb.lexc.trimmed apertium-tur-uzb.uzb.lexc

DIFF=$(diff ../apertium-tur/apertium-tur.tur.twol apertium-tur-uzb.tur.twol)
if [ "$DIFF" != "" ]; then
	cp ../apertium-tur/apertium-tur.tur.twol apertium-tur-uzb.tur.twol
fi;
cp ../apertium-tur/apertium-tur.tur.rlx apertium-tur-uzb.tur-uzb.rlx

DIFF=$(diff ../apertium-uzb/apertium-uzb.uzb.twol apertium-tur-uzb.uzb.twol)
if [ "$DIFF" != "" ]; then
	cp ../apertium-uzb/apertium-uzb.uzb.twol apertium-tur-uzb.uzb.twol
fi;
cp ../apertium-uzb/apertium-uzb.uzb.rlx apertium-tur-uzb.uzb-tur.rlx

exit 0


