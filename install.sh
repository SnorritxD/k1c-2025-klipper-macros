#!/bin/sh
# ==============================================================================
#                 K1C 2025 MACRO & HARDWARE INSTALLATIESCRIPT
# ==============================================================================

CONFIG_DIR="/usr/data/printer_data/config"
PRINTER_CFG="$CONFIG_DIR/printer.cfg"
REPO_URL="https://raw.githubusercontent.com/SnorritxD/k1c-2025-klipper-macros/refs/heads/main"

echo "=== Creality K1C (2025) Installatie Starten ==="

# 1. Bestanden downloaden uit jouw GitHub repository via wget
echo "[1/3] Configuratiebestanden downloaden uit GitHub..."
wget --no-check-certificate -qO "$CONFIG_DIR/hardware.cfg" "$REPO_URL/config/hardware.cfg"
wget --no-check-certificate -qO "$CONFIG_DIR/gcode-macro.cfg" "$REPO_URL/config/gcode-macro.cfg"
wget --no-check-certificate -qO "$CONFIG_DIR/git_backup.sh" "$REPO_URL/scripts/git_backup.sh"

# 2. Rechten goedzetten voor het backup script
if [ -f "$CONFIG_DIR/git_backup.sh" ]; then
    chmod +x "$CONFIG_DIR/git_backup.sh"
fi

# 3. Includes toevoegen aan printer.cfg als ze er nog niet in staan
echo "[2/3] Checking printer.cfg includes..."

if ! grep -q "\[include hardware.cfg\]" "$PRINTER_CFG"; then
    sed -i '1i [include hardware.cfg]' "$PRINTER_CFG"
    echo "-> [include hardware.cfg] toegevoegd bovenaan printer.cfg"
fi

if ! grep -q "\[include gcode-macro.cfg\]" "$PRINTER_CFG"; then
    sed -i '1i [include gcode-macro.cfg]' "$PRINTER_CFG"
    echo "-> [include gcode-macro.cfg] toegevoegd bovenaan printer.cfg"
fi

echo "[3/3] Installatie voltooid! Herstart Klipper via Fluidd/Mainsail."
