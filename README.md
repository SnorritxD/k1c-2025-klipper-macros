# Creality K1C (2025) Klipper Macros & Hardware Config

Modular, clean, and professional Klipper configurations and macros designed specifically for the Creality K1C (2025 model with X2600 board).

## Repository Structure
├── README.md
├── install.sh
├── config/
│   ├── hardware.cfg
│   └── gcode-macro.cfg
└── scripts/
    └── git_backup.sh

## Features
* **Decoupled Architecture**: Separates hardware-specific definitions from logical G-code macros.
* **Advanced Print Start / End**: Automated heat soak countdown, nozzle cleaning, native adaptive bed mesh, and smart purge lines.
* **Filament Management**: Pre-configured load/unload macros optimized for the DXC extruder and Unicorn nozzle.
* **Automation**: Includes a deployment installer and a personal Git backup script.

## Important Note on Printer.cfg (Before Installing)
Before running the installer, make sure to comment out (using `#`) any conflicting native hardware definitions in your existing `printer.cfg` that are now managed by `hardware.cfg`:
* **Fans**: Comment out the original fan definitions (such as `[fan_generic model_fan]`, `[fan_generic side_fan]`, or `[fan_generic chassis_fan]`) if they are already present.
* **Filament Sensor**: Comment out the old filament sensor (e.g., `[filament_switch_sensor filament_sensor]`) to prevent duplicate definitions with the new DXC sensor[cite: 1].

## Installation (Via SSH)
Connect to your printer via SSH and run the following command to download and execute the installer directly:

```bash
wget --no-check-certificate -qO- [https://raw.githubusercontent.com/SnorritxD/k1c-2025-klipper-macros/refs/heads/main/install.sh](https://raw.githubusercontent.com/SnorritxD/k1c-2025-klipper-macros/refs/heads/main/install.sh) | sh
