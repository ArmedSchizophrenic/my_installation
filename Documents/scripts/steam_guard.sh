#!/usr/bin/env bash
# steam_guard.sh
# Monitoruje: Steam (title "Steam"), Friends List (title "Friends List") oraz steamwebhelper
# Przenosi je z dowolnego special workspace → DEFAULT_WS (domyślny workspace)
# DEFAULT_WS aktualizowany tylko na podstawie głównego okna / friends list

set -eo pipefail

# początkowy domyślny workspace (możesz zmienić)
DEFAULT_WS="2"

# czas pomiędzy iteracjami (sekundy)
SLEEP=2

# funkcja pomocnicza: pobiera listę adresów monitorowanych okien
get_target_addresses() {
    hyprctl clients -j 2>/dev/null | jq -r '
      .[] |
      select(
        # główne okno Steam lub Friends List
        (.initialClass=="steam" and (.initialTitle=="Steam" or .initialTitle=="Friends List"))
        or
        # lub steamwebhelper (klasa/initialClass zawiera steamwebhelper)
        (.class // "" | test("steamwebhelper"))
        or
        (.initialClass // "" | test("steamwebhelper"))
      )
      | {address: .address, kind: (if (.initialClass=="steam" and .initialTitle=="Steam") then "main"
                                    elif (.initialClass=="steam" and .initialTitle=="Friends List") then "friends"
                                    else "webhelper" end)}
      | "\(.address)::\(.kind)"' 2>/dev/null || true
}

# funkcja: pobiera workspace name dla adresu
get_workspace_for_address() {
    local addr="$1"
    hyprctl clients -j 2>/dev/null | jq -r --arg ADDR "$addr" '.[] | select(.address==$ADDR) | .workspace.name' 2>/dev/null || echo ""
}

# główna pętla
while true; do
    mapfile -t ADDR_LINES < <(get_target_addresses)

    if [[ ${#ADDR_LINES[@]} -eq 0 ]]; then
        # zamiast kończyć skrypt, wyświetl informację i czekaj
        echo "[$(date +'%T')] Brak monitorowanych okien Steam (main/friends/webhelper) → czekam..."
        sleep "$SLEEP"
        continue
    fi

    for line in "${ADDR_LINES[@]}"; do
        # linia ma format: "0x....::main" albo "::friends" albo "::webhelper"
        ADDR="${line%%::*}"
        KIND="${line##*::}"

        # pobierz workspace
        WS="$(get_workspace_for_address "$ADDR")"

        # jeśli nie udało się pobrać workspace, pomiń (okno mogło zniknąć między zapytaniami)
        if [[ -z "$WS" ]]; then
            continue
        fi

        # jeżeli okno wpadło na jakikolwiek special workspace → przenieś je cicho na DEFAULT_WS
        if [[ "$WS" == special:* ]]; then
            echo "[$(date +'%T')] $KIND ($ADDR) jest na $WS → przenoszę do $DEFAULT_WS"
            hyprctl dispatch movetoworkspacesilent "$DEFAULT_WS,address:$ADDR" >/dev/null 2>&1 || true
            sleep 0.05
            continue
        fi

        # jeśli to main lub friends i nie jest na special, ustaw ten workspace jako DEFAULT_WS
        if [[ "$KIND" == "main" || "$KIND" == "friends" ]]; then
            if [[ "$WS" != special:* ]]; then
                if [[ "$DEFAULT_WS" != "$WS" ]]; then
                    echo "[$(date +'%T')] $KIND ($ADDR) jest na $WS → ustawiam DEFAULT_WS=$WS"
                    DEFAULT_WS="$WS"
                fi
            fi
        fi
        # webhelper nie aktualizuje DEFAULT_WS, tylko przenosi w razie trafienia na special
    done

    sleep "$SLEEP"
done

