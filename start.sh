#!/bin/bash

set -e

if [ "$PORT" = "" ] && [ "$PASS" = "" ]; then
  echo "! Need $PORT and $PASS set!"
  exit 1
fi

sed -i s/\$PORT/${PORT}/ .znc/configs/znc.conf
sed -i s/\$NICK/${NICK}/ .znc/configs/znc.conf
sed -i s^\$PASS^${PASS}^ .znc/configs/znc.conf

./znc --foreground --no-color --datadir $PWD/.znc
