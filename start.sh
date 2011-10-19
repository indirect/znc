#!/bin/bash

# Set it to use the C build pack.

# Run: ./configure && make && ./znc --makepass # copy password for below
# $ heroku config:add NICK=mynick PASS=sha256#05ef1effb902c58d97ad04a7f869c62f8d6d9ac4a3ac093f548e9eece7a8efec#mr)F/l.Z_y._Jjpyn7Gi#

# Deploy!
# $ heroku ps:scale znc=1

# Also need access to the TCP router (currently in private beta) to use this:
# $ heroku routes:create
# $ heroku routes:attach tcp://route.heroku.com:$PORT  znc.1

set -e

if [ "$PORT" = "" ] || [ "$PASS" = "" ] || [ "$NICK" = "" ]; then
  echo "! Need $PORT, $NICK, and $PASS set!"
  exit 1
fi

sed -i s/\$PORT/${PORT}/ .znc/configs/znc.conf
sed -i s/\$NICK/${NICK}/ .znc/configs/znc.conf
sed -i s^\$PASS^${PASS}^ .znc/configs/znc.conf

./znc --foreground --no-color --datadir $PWD/.znc
