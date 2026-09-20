#!/bin/sh
# ==============================================================================
#                 K1C 2025 MACRO & HARDWARE INSTALLATION SCRIPT
# ==============================================================================

CONFIG_DIR="/usr/data/printer_data/config"
PRINTER_CFG="$CONFIG_DIR/printer.cfg"
REPO_URL="https://raw.githubusercontent.com/SnorritxD/k1c-2025-klipper-macros/refs/heads/main"

echo "=== Starting Creality K1C (2025) Installation ==="

# 1. Download configuration files from your GitHub repository via wget
echo "[1/3] Downloading configuration files from GitHub..."
wget --no-check-certificate -qO "$CONFIG_DIR/hardware.cfg" "$REPO_URL/config/hardware.cfg"
wget --no-check-certificate -qO "$CONFIG_DIR/gcode-macro.cfg" "$REPO_URL/config/gcode-macro.cfg"
wget --no-check-certificate -qO "$CONFIG_DIR/git_backup.sh" "$REPO_URL/scripts/git_backup.sh"

# 2. Set execution permissions for the backup script
if [ -f "$CONFIG_DIR/git_backup.sh" ]; then
    chmod +x "$CONFIG_DIR/git_backup.sh"
fi

# 3. Add includes to printer.cfg if they are not already present
echo "[2/3] Checking printer.cfg includes..."

if ! grep -q "\[include hardware.cfg\]" "$PRINTER_CFG"; then
    sed -i '1i [include hardware.cfg]' "$PRINTER_CFG"
    echo "-> [include hardware.cfg] added to the top of printer.cfg"
fi

if ! grep -q "\[include gcode-macro.cfg\]" "$PRINTER_CFG"; then
    sed -i '1i [include gcode-macro.cfg]' "$PRINTER_CFG"
    echo "-> [include gcode-macro.cfg] added to the top of printer.cfg"
fi

echo "[3/3] Installation completed! Restart Klipper via Fluidd/Mainsail."
