<div align="center">

# 🖨️ Creality K1C (2025)  
# Klipper Macros & Hardware Config

**Modular Klipper configuration for the Creality K1C 2025**

Hardware configuration · Print macros · Filament management · GitHub backup support

<img src="https://img.shields.io/badge/Printer-Creality%20K1C%202025-blue?style=for-the-badge">
<img src="https://img.shields.io/badge/Platform-Creality%20OS-orange?style=for-the-badge">
<img src="https://img.shields.io/badge/Board-Ingenic%20X2600-green?style=for-the-badge">
<img src="https://img.shields.io/badge/Klipper-Configuration-lightgrey?style=for-the-badge">

</div>

---

## 📖 Overview

This project provides a modular collection of Klipper configuration files and G-code macros designed for the **Creality K1C 2025**.

The configuration is designed for Creality OS based printers using the **Ingenic X2600 platform**, where the hardware configuration matches.

The goal is to keep hardware-specific configuration separate from logical print macros, making the setup easier to maintain, troubleshoot and extend.

Instead of keeping everything inside one large `printer.cfg`, this project separates configuration parts into dedicated files.

> ⚠️ **Compatibility**
>
> This project targets the Creality K1C 2025 model.
>
> Other K1C revisions, firmware versions or hardware configurations have not been verified.

---

# ✨ Features

| Feature | Description |
|---|---|
| 🧩 Modular configuration | Separates hardware definitions from G-code macros. |
| 🔥 Print workflow macros | Provides print start/end and utility macros through `gcode-macro.cfg`. |
| 🧵 Filament management | Includes filament-related macros for supported configurations. |
| 🌀 Hardware definitions | Stores hardware-specific settings inside `hardware.cfg`. |
| ☁️ GitHub backup support | Includes a Git backup script that can be configured separately. |
| ⚙️ Simple installer | Downloads files and adds required includes automatically. |
| 🛠️ Easy maintenance | Keeps configuration components separated for easier editing. |

---

# 📁 Repository Structure
