#!/usr/bin/env bash

set -euo pipefail

# Load .env from the same directory as this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/.env"

LAST_ID=""

while true; do
    json=$("$WACLI" messages list \
        --chat "$CHAT" \
        --limit 20 \
        --json)

    id=$(jq -r '
        .data.messages[]
        | select(.MediaType == "sticker")
        | .MsgID
    ' <<<"$json" | head -n1)

    if [[ -n "$id" && "$id" != "$LAST_ID" ]]; then
        LAST_ID="$id"

        path=$("$WACLI" media download \
            --chat "$CHAT" \
            --id "$id" . \
            | awk 'NR==1{print $1}')

        echo "Opening $path"

        xdg-open "$path" >/dev/null 2>&1 &
    fi

    sleep "$INTERVAL"
done


#WACLI="$HOME/Desktop/wacli/dist/wacli"
#CHAT="601XXXXXXX@s.whatsapp.net"
#INTERVAL=2
