#!/bin/bash

# Znajdź interfejs używany do ruchu w sieci
IFACE=$(ip route get 1.1.1.1 2>/dev/null | grep -oP 'dev \K\S+')

# Fallback: jeśli nie znaleziono, wyjdź z zerami
[ -z "$IFACE" ] && echo '{"download": 0, "upload": 0}' && exit 0

# Pobierz RX/TX w bajtach
read RX1 TX1 < <(awk -v iface=$IFACE '$1 ~ iface":" {print $2, $10}' /proc/net/dev)
sleep 1
read RX2 TX2 < <(awk -v iface=$IFACE '$1 ~ iface":" {print $2, $10}' /proc/net/dev)

# Policz różnicę (KB/s)
RXBPS=$(( (RX2 - RX1) / 1024 ))
TXBPS=$(( (TX2 - TX1) / 1024 ))

echo "{\"iface\": \"$IFACE\", \"download\": $RXBPS, \"upload\": $TXBPS}"

