#!/bin/sh

FULL_PATH="/usr/share/nginx/html/env.js"

sed -i 's#__AGGREGATOR_HOSTNAME__#'"$AGGREGATOR_HOSTNAME"'#g' $FULL_PATH
sed -i 's#__AGGREGATOR_PORT__#'"$AGGREGATOR_PORT"'#g' $FULL_PATH
sed -i 's#__API_HOSTNAME__#'"$API_HOSTNAME"'#g' $FULL_PATH
sed -i 's#__API_PORT__#'"$API_PORT"'#g' $FULL_PATH

exec "$@"