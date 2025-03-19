#!/bin/bash

# Skript pro monitorování využití disku a záznam do logu

# Definice cesty k logovacímu souboru
LOG_DIR="/var/log/disk_monitor"
LOG_FILE="$LOG_DIR/disk_usage_$(date +%Y-%m).log"

# Vytvoření adresáře pro logy, pokud neexistuje
if [ ! -d "$LOG_DIR" ]; then
    mkdir -p "$LOG_DIR"
    chmod 755 "$LOG_DIR"
fi

# Získání aktuálního data a času
CURRENT_DATE=$(date "+%Y-%m-%d %H:%M:%S")

# Získání využití disku
DISK_USAGE=$(df -h / | grep -v Filesystem)
ROOT_USAGE=$(echo "$DISK_USAGE" | awk '{print $5}')
ROOT_AVAIL=$(echo "$DISK_USAGE" | awk '{print $4}')

# Kontrola zaplnění disku a nastavení úrovně zprávy
if [[ "${ROOT_USAGE/\%/}" -gt 90 ]]; then
    LEVEL="KRITICKÉ"
elif [[ "${ROOT_USAGE/\%/}" -gt 80 ]]; then
    LEVEL="VAROVÁNÍ"
elif [[ "${ROOT_USAGE/\%/}" -gt 70 ]]; then
    LEVEL="UPOZORNĚNÍ"
else
    LEVEL="INFO"
fi

# Zápis do logu
echo "[$CURRENT_DATE] [$LEVEL] Využití root oddílu: $ROOT_USAGE, volné místo: $ROOT_AVAIL" >> "$LOG_FILE"

# Pokud je využití kritické, pošle se email administrátorovi (pokud je mail nakonfigurován)
if [[ "$LEVEL" == "KRITICKÉ" ]]; then
    echo "KRITICKÉ využití disku: $ROOT_USAGE na serveru $(hostname)" | \
    mail -s "[$LEVEL] Kritické využití disku na $(hostname)" root@localhost
fi

# Získání nejvetších 5 adresářů v /home
echo "[$CURRENT_DATE] Největší adresáře v /home:" >> "$LOG_FILE"
du -h /home --max-depth=2 | sort -hr | head -n 5 >> "$LOG_FILE"
echo "--------------------------------------" >> "$LOG_FILE"

exit 0