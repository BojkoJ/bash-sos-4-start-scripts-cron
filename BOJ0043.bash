#!/bin/bash

# Skript pro přidání informace o času spuštění systému do všech domovských adresářů

# Získání informace o čase spuštění systému
BOOT_TIME=$(uptime -s)
DATE=$(date "+%Y-%m-%d %H:%M:%S")

# Projít všechny složky v /home
for USER_DIR in /home/*; do
    # Kontrola, zda se jedná o adresář
    if [ -d "$USER_DIR" ]; then
        # Vytvoření nebo přepsání souboru info s časem spuštění
        echo "Systém byl spuštěn: $BOOT_TIME" > "$USER_DIR/info"
        echo "Tento soubor byl vytvořen: $DATE" >> "$USER_DIR/info"
        echo "Skript BOJ0043.bash proběhl úspěšně." >> "$USER_DIR/info"
        
        # Nastavení správných oprávnění - soubor patří vlastníkovi adresáře
        USER_NAME=$(basename "$USER_DIR")
        chown "$USER_NAME:$USER_NAME" "$USER_DIR/info"
        chmod 644 "$USER_DIR/info"
        
        echo "Vytvořen info soubor v adresáři $USER_DIR"
    fi
done

exit 0