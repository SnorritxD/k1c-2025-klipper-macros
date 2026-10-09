# 🖨️ Creality K1C (2025) — Klipper Macros & Hardware Config

<p align="center">
  <strong>A modular Klipper configuration for the Creality K1C 2025</strong>
  <br>
  Hardware configuration, print macros, filament management and GitHub backup integration.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Printer-Creality%20K1C%202025-blue?style=for-the-badge" alt="Creality K1C 2025">
  <img src="https://img.shields.io/badge/Firmware-Klipper-orange?style=for-the-badge" alt="Klipper">
  <img src="https://img.shields.io/badge/Architecture-X2600-informational?style=for-the-badge" alt="X2600">
  <img src="https://img.shields.io/badge/Platform-Creality%20OS-lightgrey?style=for-the-badge" alt="Creality OS">
</p>

---

## 📖 Overview

This project provides a modular collection of Klipper configuration files and G-code macros designed for the **Creality K1C 2025**, including compatible systems based on the Ingenic X2600 board.

The goal is to keep hardware-specific configuration separate from logical print macros, making the setup easier to maintain, troubleshoot and extend.

Instead of keeping everything in one large configuration file, this project organizes the configuration into dedicated files that can be managed independently.

> [!IMPORTANT]
> This project targets the Creality K1C 2025. Compatibility with other K1C revisions, firmware versions and hardware configurations is not guaranteed. Always review the configuration files before installing them.

## ✨ Features

| Feature                          | Description                                                                                    |
| -------------------------------- | ---------------------------------------------------------------------------------------------- |
| 🧩 **Modular configuration**     | Separates hardware definitions from G-code macros.                                             |
| 🔥 **Print start and end**       | Provides print workflow macros defined in `gcode-macro.cfg`.                                   |
| 🧵 **Filament management**       | Includes filament-related macros intended for the supported extruder and nozzle configuration. |
| 🌀 **Hardware definitions**      | Organizes supported fan and filament-sensor configuration in `hardware.cfg`.                   |
| ☁️ **GitHub backup integration** | Includes a Git backup script for configuration management.                                     |
| ⚙️ **Deployment installer**      | Downloads the configuration files and adds the required includes to `printer.cfg`.             |
| 🛠️ **Maintainable structure**   | Keeps configuration components separate for easier debugging and updates.                      |

## 📁 Repository Structure

```text
k1c-2025-klipper-macros/
│
├── README.md
├── install.sh
│
├── config/
│   ├── hardware.cfg
│   └── gcode-macro.cfg
│
└── scripts/
    └── git_backup.sh
```

## 🖥️ Compatibility

**Target printer:** Creality K1C (2025 model)

**Target platform:** Creality OS / Klipper

**Target board:** Ingenic X2600-based systems, where the hardware configuration matches.

### Requirements

* SSH access to the printer.
* Root access or sufficient permissions to modify the Klipper configuration.
* A working Klipper installation.
* The configuration directory `/usr/data/printer_data/config`.
* Any additional extensions or shell-command support required by the individual macros.

Hardware pins, fan names, sensors and macro dependencies can differ between firmware versions. Verify them against your existing configuration before installation.

---

## 🚀 Installation

> [!WARNING]
> The installer downloads files directly into your printer's configuration directory. Files with the same names may be overwritten. Back up your working configuration before proceeding.

### Step 1 — Connect to your printer

Connect to your Creality K1C via SSH.

### Step 2 — Download the installer

The following commands download the installer without executing it immediately:

```sh
wget --no-check-certificate https://raw.githubusercontent.com/SnorritxD/k1c-2025-klipper-macros/refs/heads/main/install.sh -O /tmp/macros-install.sh

sed -i 's/\r$//' /tmp/macros-install.sh
```

### Step 3 — Review the installer

Inspect the downloaded script before running it:

```sh
cat /tmp/macros-install.sh
```

### Step 4 — Run the installer

Once you have reviewed the script and backed up your configuration:

```sh
sh /tmp/macros-install.sh
```

### Step 5 — Restart Klipper

When the installer finishes, restart Klipper through Fluidd or Mainsail.

Check that Klipper starts successfully and that no configuration errors are reported before starting a print.

---

## ⚙️ What Does the Installer Do?

The installer performs three main operations.

### 1. Downloads configuration files

The following files are downloaded to `/usr/data/printer_data/config/`:

* `hardware.cfg`
* `gcode-macro.cfg`
* `git_backup.sh`

Existing files with these names may be overwritten.

### 2. Sets script permissions

The installer attempts to mark `git_backup.sh` as executable if the downloaded file exists.

### 3. Adds configuration includes

If the corresponding include text is not already found in `printer.cfg`, the installer adds:

```ini
[include hardware.cfg]
[include gcode-macro.cfg]
```

These directives allow Klipper to load the separate configuration files.

> [!NOTE]
> The installer does not automatically back up overwritten files, validate the downloaded configuration, or verify that all macro dependencies are installed. Review the resulting configuration before restarting Klipper.

## 🧩 Configuration Guide

### `hardware.cfg`

Contains hardware-specific configuration intended to be separated from the main `printer.cfg`.

Before enabling it, compare its sections with your existing configuration.

Pay particular attention to:

* Fan definitions such as `[fan_generic model_fan]`, `[fan_generic side_fan]` and `[fan_generic chassis_fan]`, if present.
* Filament sensor definitions such as `[filament_switch_sensor filament_sensor]`.
* Any other hardware sections that may already be defined in `printer.cfg` or another included file.

Duplicate section definitions can prevent Klipper from starting. Do not comment out existing settings blindly; compare the definitions first and preserve the settings your printer requires.

### `gcode-macro.cfg`

Contains the project's G-code macros for supported print and filament workflows.

Available functionality depends on the actual macro definitions and any required extensions. Review the file to confirm the commands, sensors, pins and macro references match your setup.

### `git_backup.sh`

Provides the Git backup script included in the repository.

The installer downloads it to:

```text
/usr/data/printer_data/config/git_backup.sh
```

The installer itself does not configure GitHub authentication, create a Git remote, schedule backups or execute the backup script. Those capabilities depend on the script's contents and any separate setup you perform.

Always verify that the backup reaches the intended repository before relying on it.

---

## 🔧 Troubleshooting

<details>
<summary><strong>❌ Klipper fails to start after installation</strong></summary>

1. Open the Klipper error details in Fluidd or Mainsail.
2. Check for duplicate configuration sections.
3. Verify that `hardware.cfg` and `gcode-macro.cfg` exist.
4. Check pin names, sensor references and macro dependencies.
5. Restore your previous configuration if necessary.

</details>

<details>
<summary><strong>📄 A configuration file is missing or empty</strong></summary>

Check the files in:

```text
/usr/data/printer_data/config/
```

The installer does not immediately stop if an individual download fails. Confirm that all downloaded files exist and contain the expected configuration before restarting Klipper.

</details>

<details>
<summary><strong>🌀 Hardware or filament sensor errors</strong></summary>

Compare the definitions in `hardware.cfg` with the configuration already installed on your printer. Firmware revisions and hardware variants may use different pins, sensors or section names.

</details>

<details>
<summary><strong>☁️ GitHub backup is not working</strong></summary>

Check the contents of `git_backup.sh`, the Git repository configuration, authentication and network connectivity. The installer only downloads the script and sets its executable permission; it does not configure the complete backup workflow.

</details>

---

## 🛡️ Safety Recommendations

* 📦 **Back up first:** Keep a copy of your known-working configuration.
* 🔍 **Review changes:** Inspect downloaded files before applying them.
* 🧩 **Avoid duplicate sections:** Ensure hardware definitions are not declared twice.
* 🧪 **Test before printing:** Confirm Klipper starts without errors.
* ☁️ **Verify backups:** Check that your configuration is actually reaching the intended GitHub repository.
* 🔄 **Check compatibility:** Review the configuration again after firmware updates.

## 🤝 Contributing

Suggestions, bug reports and compatibility findings are welcome.

When reporting an issue, include:

* Printer model and firmware version.
* The relevant configuration section.
* The exact Klipper error message.
* Any relevant changes made to the original configuration.

Contributions that improve compatibility, reliability and maintainability are appreciated.

## ⚠️ Disclaimer

This project is provided **as-is** for development, experimentation and community use.

Configuration changes can prevent Klipper from starting or cause hardware features to behave incorrectly. You are responsible for reviewing the files, backing up your configuration and testing changes safely.

Compatibility with other Creality printers, board revisions or firmware versions should be verified independently.

---

<p align="center">
 <strong>Made for the Creality K1C community</strong> 🧡
  <br>
  <sub>Modular configuration. Easier maintenance. Better control.</sub>
</p>
