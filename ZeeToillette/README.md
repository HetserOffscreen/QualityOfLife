# 🚽 Zee Toillette Project

> **"Flush your cache, not your settings."** > *Part of the Quality of Life Project*

## 📜 Description
**Zee Toillette** (command: `flush`) is a heavy-duty maintenance tool for Stremio users.

Over time, Stremio's video cache can grow to gigabytes of "phantom data" that clogs up your drive. This script identifies that waste and flushes it down the drain—without deleting your login, library, or add-ons.

## ✨ Features
* **Dual-Scan Logic:** Hunts for cache in both `%AppData%` and `%LocalAppData%`.
* **Turd Sizing:** Calculates the exact size of the cache (in MB) so you know how big the flush will be.
* **Safe Protocol:** Explicitly asks `Flush this turd? (y/n)` before deletion.
* **Visual Feedback:** "Looking for Shit" and "Flushing" ASCII animations.
* **Audio Confirm:** Plays a system beep upon successful cleaning.

## 🚀 Installation & Usage
1.  Download `flush.bat`.
2.  **Recommended:** Move the file to `C:\Windows` (requires Admin privileges).
3.  **Run it:**
    * Press `Win + R` and type `flush`.
    * Or type `flush` in any Command Prompt/Terminal window.

## ⚠️ Note
This script force-closes `stremio.exe` to unlock the files before flushing. Ensure you are done watching before you flush!