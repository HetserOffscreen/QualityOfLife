# 🚽 PROTOCOL: ZEE TOILLETE (Stremio Cleaner)

> **"Flush your cache, not your settings."** > *Made by Hetser Offscreen*

## 📜 Description
A batch script designed to clean the **Stremio video cache** without removing your login details or installed add-ons. It automates the cleanup process with visual feedback and safety checks.

## ✨ Features
* **Dual-Scan Detection:** Automatically hunts for the cache in both `%AppData%` (Roaming) and `%LocalAppData%` to ensure it works on all system configurations.
* **Turd Sizing:** Calculates and displays the exact size of the cache (in MB) before deletion.
* **Safe Flush:** Asks for confirmation (`y/n`) before deleting any files.
* **Visual Feedback:** Custom ASCII animations ("Looking for Shit", "Flushing") for the cleaning process.
* **Audio Queue:** Plays a console beep upon successful cleaning.

## 🚀 Installation & Usage
1.  Download `cleanstremio.bat`.
2.  **Recommended:** Move the file to `C:\Windows` (requires Admin privileges). This allows you to run it from the "Run" dialog (Win+R) just by typing `cleanstremio` or as a command in Windows Terminal.

## ⚠️ Note
This script force-closes `stremio.exe` to ensure files are unlocked before deletion. Make sure you are done watching before running!