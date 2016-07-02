#!/usr/bin/env sh

DATADIR="/data/"

if [ ! -d ${DATADIR}/users ]; then
    mkdir -p "${DATADIR}/users"
fi

if [ ! -f "${DATADIR}/bitlbee.conf" ]; then
    cp /etc/bitlbee/bitlbee.conf.default "${DATADIR}/bitlbee.conf"
fi

if [ ! -f "${DATADIR}/motd.txt" ]; then
    cp /etc/bitlbee/motd.txt.default "${DATADIR}/motd.txt"
fi

# Make sure $DATADIR is owned by bitlbee user. This effects ownership of the
# mounted directory on the host machine too.
echo "Setting necessary permissions..."
chown -R bitlbee:bitlbee "$DATADIR"

if [ ! -f /var/run/bitlbee.pid ]; then
    mkdir -p /var/run/
    touch /var/run/bitlbee.pid
    chown bitlbee:bitlbee /var/run/bitlbee.pid
fi

echo "Starting Bitlbee..."
exec sudo -u bitlbee bitlbee -Fnv -c "${DATADIR}/bitlbee.conf" -d "${DATADIR}/users" $@
