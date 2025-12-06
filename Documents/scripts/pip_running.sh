#!/bin/bash

RADIUS=200

while true; do
    WIN=$(hyprctl -j clients | jq -c '.[] | select(.floating==true) | select(.title=="Obraz w\u00A0obrazie")')

    if [ -n "$WIN" ]; then
        ADDR=$(echo "$WIN" | jq -r '.address')
        WX=$(echo "$WIN" | jq '.at[0]')
        WY=$(echo "$WIN" | jq '.at[1]')
        WW=$(echo "$WIN" | jq '.size[0]')
        WH=$(echo "$WIN" | jq '.size[1]')

        CX=$((WX + WW/2))
        CY=$((WY + WH/2))

        CUR=$(hyprctl -j cursorpos)
        MX=$(echo "$CUR" | jq '.x')
        MY=$(echo "$CUR" | jq '.y')

        DX=$((CX - MX))
        DY=$((CY - MY))
        DIST=$((DX*DX + DY*DY))

        if (( DIST < RADIUS*RADIUS )); then
            hyprctl dispatch focuswindow address "$ADDR"

            if (( DX > 0 )); then
                hyprctl dispatch movewindow r
            else
                hyprctl dispatch movewindow l
            fi

            if (( DY > 0 )); then
                hyprctl dispatch movewindow d
            else
                hyprctl dispatch movewindow u
            fi
        fi
    fi

    sleep 0.03
done

