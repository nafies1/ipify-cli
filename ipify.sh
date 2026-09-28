#!/bin/sh
#
# Prints your public IP address, via ipify.org.
#
# Usage: ipify [-4 | -6] [--json]

FAMILY_FLAG=''
JSON=0

for arg in "$@"; do
    case "$arg" in
        -4)
            FAMILY_FLAG='-4'
            ;;
        -6)
            FAMILY_FLAG='-6'
            ;;
        --json)
            JSON=1
            ;;
        -h|--help)
            echo "Usage: ipify [-4 | -6] [--json]"
            exit 0
            ;;
        *)
            echo "ipify: unknown option '$arg'" >&2
            echo "Usage: ipify [-4 | -6] [--json]" >&2
            exit 1
            ;;
    esac
done

URL='https://api64.ipify.org'
if [ "$JSON" -eq 1 ]; then
    URL="$URL?format=json"
fi

OUTPUT=$(curl -sS --max-time 5 $FAMILY_FLAG "$URL")

if [ -z "$OUTPUT" ]; then
    if [ "$FAMILY_FLAG" = '-6' ]; then
        echo "ipify: could not fetch public IP over IPv6 (you may not have IPv6 connectivity)" >&2
    else
        echo "ipify: could not fetch public IP (no network or ipify.org is unreachable)" >&2
    fi
    exit 1
fi

echo "$OUTPUT"
