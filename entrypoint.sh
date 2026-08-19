#!/bin/sh
set -eu

configuration=${VAD_WIREGUARD_CONFIG:-/etc/wireguard/wg0.conf}

if [ ! -r "$configuration" ]; then
    echo "WireGuard configuration is not readable: $configuration" >&2
    exit 1
fi

wg-quick up "$configuration"

shutdown() {
    trap - EXIT INT TERM
    wg-quick down "$configuration" || true
    exit 0
}

trap shutdown EXIT INT TERM

while :; do
    sleep 86400 &
    wait "$!" || true
done
