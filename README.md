# Windows 11 Non-Touch Gaming Optimizer

**by Matt Hurley**

[GitHub Repository](https://github.com/theantipopau/windows11nontouchgamingoptimizer)

A comprehensive, menu-driven batch script to optimize Windows 11 for maximum gaming performance on non-touchscreen desktops and laptops. All changes are logged and reversible.

---

## 🎮 Features

### **Core Optimizations**
- **Debloat Windows 11** - Remove consumer apps, OEM bloatware, and promotional content
- **Disable Touch/Pen Features** - Remove unnecessary touch, pen, ink, and handwriting components
- **Gaming Performance Tweaks** - Ultimate Performance power plan, Game Mode, GPU scheduling, input optimizations
- **Service Optimization** - Reduce background CPU/RAM usage from telemetry, indexing, and unnecessary services
- **Network Optimizations** - Lower ping/latency with TCP/IP tweaks and disabled delivery optimization
- **Visual Effects** - Disable animations and transparency for better FPS
- **Startup Optimization** - Faster boot times and reduced startup delays

### **Advanced Features**
- **GPU & Storage Optimization** - 20+ GPU latency tweaks, SSD optimizations, TRIM support
- **Audio Latency Reduction** - High-priority audio processing for gaming and streaming
- **Mouse/Keyboard Input** - Disable pointer precision, increased polling queue sizes
- **Visual Effects Options** - Balanced (keeps smooth animations) or Minimal (max FPS)
- **Optional Xbox Service Disable** - For users who don't use Game Bar or Xbox features (requires confirmation)

### **Safety & Convenience**
- **System Restore Point** - Automatic restore point creation before changes
- **Comprehensive Logging** - All actions timestamped and logged for audit trail
- **Registry Backup** - Full backup of all modified registry keys before changes
- **Laptop Detection** - Warns laptop users about battery impact, offers opt-out
- **Hardware Detection** - Correctly identifies discrete GPUs on hybrid systems (iGPU + NVIDIA/AMD)
- **Verification Tool** - Check which optimizations are currently active
- **Changes Summary** - Clear summary of what was modified after each run
- **Undo Function** - Revert most changes back to Windows defaults
- **Optimization Report** - View system specs and applied optimizations
- **Full & Recommended Modes** - Run all tweaks at once or just the essentials

---

## 🚀 Quick Start

### **Requirements**
- Windows 11 (or Windows 10)
- Administrator privileges
- System Protection enabled (recommended for restore points)

### **Installation**
1. Download `win11_nontouch_gaming_optimiser.bat`
2. Right-click the file → **Run as administrator**
3. Follow the on-screen menu

### **Recommended First Run**
```
1. Select option [3] to create a system restore point
2. Select option [2] for "Recommended" optimization (5 minutes)
3. Restart your PC
```

---

## 📋 Menu Options

### **Quick Actions**
- **[1 / F]** - FULL OPTIMIZATION (all 15 steps, ~5-10 minutes)
- **[2]** - RECOMMENDED (core essentials, ~3-5 minutes)

### **Individual Optimizations**
- **[3]** - Create system restore point
- **[4]** - Debloat Windows 11 (remove consumer/OEM apps)
- **[5]** - Disable touchscreen, pen, and ink features
- **[6]** - Apply gaming performance tweaks
- **[7]** - Optimize services, telemetry, and indexing
- **[8]** - Network optimizations (submenu: apply/revert)
- **[9]** - Disable animations and visual effects
- **[A]** - Optimize startup programs and services
- **[B]** - Free disk space and clear temp files

### **Advanced Options**
- **[C]** - GPU and storage optimizations (prompts before applying; hardware-dependent)
- **[D]** - Audio latency reduction
- **[E]** - Disable Xbox services ⚠️ (breaks Game Bar, requires confirmation)

### **Utilities**
- **[H]** - Help / README (comprehensive guide)
- **[P]** - View optimization report (system info + recommendations)
- **[V]** - Verify optimizations status (check what's active)
- **[U]** - UNDO - Revert changes to defaults
- **[0]** - Exit

---

## ⚙️ What Gets Optimized

### **Gaming Performance**
- Ultimate Performance or High Performance power plan
- Hardware-accelerated GPU scheduling enabled
- Game Mode enabled, Game DVR disabled
- CPU/GPU priority set to "High" for games
- Multimedia system profile optimized (NetworkThrottlingIndex, SystemResponsiveness)
- Foreground app (game) prioritization via Win32PrioritySeparation (0x26)
- System timer resolution optimized for better frame pacing
- Mouse acceleration disabled, increased input queue sizes
- Low latency flags for games and audio

### **Network**
- TCP auto-tuning set to highly restricted
- TCP acknowledgment frequency optimized
- MaxUserPort increased to 65534
- TcpNoDelay and TcpAckFrequency enabled
- Delivery Optimization (P2P updates) disabled
- Network throttling removed

### **CPU & Memory**
- **Core parking disabled**: All CPU cores remain active (no parking delays)
- **Page file optimization**: Auto-configured based on RAM amount
  - 16GB+ RAM: System-managed page file
  - 8-15GB RAM: Fixed 4GB page file
  - Less than 8GB: System-managed (safe default)
- Memory compression enabled
- Paging executive disabled
- RAM-based prefetch tuning

### **GPU & Graphics**
- 20+ GPU power state and latency registry tweaks
- Display post-processing priority increased
- Hardware-accelerated GPU scheduling (HwSchMode)
- Tips provided for NVIDIA Low Latency Mode and AMD Anti-Lag

### **Storage**
- **Smart detection**: Auto-detects SSD vs HDD
- **SSD optimizations**: TRIM enabled, defrag disabled, last access updates disabled
- **HDD optimizations**: Prefetch/Superfetch enabled, scheduled defrag maintained
- 8.3 filename creation disabled
- Disk cleanup with DISM component cleanup
- Page combining disabled on SSDs with 8GB+ RAM

### **Services & Background Tasks**
- **Disabled services**: DiagTrack, SysMain (Superfetch), Windows Search (set to manual), telemetry services
- **Disabled scheduled tasks**: Compatibility Appraiser, CEIP, feedback collection, disk diagnostics
- Cortana, Bing search, tips, and suggestions disabled
- Advertising ID and cloud content disabled

### **Bloatware Removed**
Consumer apps: Bing News/Weather/Finance, Clipchamp, GetHelp, Office Hub, Solitaire, Sticky Notes, Skype, Teams, TikTok, Spotify, Facebook, Disney+, and more. Xbox/Game Bar components are preserved so the overlay continues to work.

### **Visual Effects**
- Transparency disabled
- Window animations disabled
- Taskbar animations disabled
- Aero Peek disabled
- Thumbnail previews optimized
- Visual effects set to "Best Performance"

---

## 🛡️ Safety Features

### **System Restore Point**
The script attempts to create a restore point before making changes. If System Protection is not enabled:
1. Open Control Panel → System → System Protection
2. Select C: drive → Configure
3. Enable "Turn on system protection"
4. Allocate 2-5GB space

If you see a message about a service being disabled, open **services.msc** and set both **Volume Shadow Copy** and **Microsoft Software Shadow Copy Provider** to **Manual** (start them if necessary), then rerun option [3].
The optimizer automatically attempts to start these services whenever it creates a restore point, but it cannot recover if they are removed or blocked by policy.

### **Comprehensive Logging**
All actions are logged with timestamps to:
```
logs\nontouch_gaming_optimizer_YYYYMMDD_HHMMSS.log
```

### **Undo Function**
The **[U]** option reverts most changes:
- Re-enables disabled services
- Restores telemetry/search defaults
- Re-enables animations
- Reverts network tweaks
- Re-enables touch/pen features
- Restores mouse acceleration
- Restores original mouse pointer settings from backup (if available)

**Note:** Some changes (like removed apps) cannot be automatically restored. Use System Restore for complete rollback.

---

## ⚠️ Important Notes

### **Xbox Services**
By default, Xbox services are **NOT disabled** to preserve:
- Xbox Game Bar (Win+G overlay)
- Xbox app and Game Pass
- Xbox Live cloud saves
- Xbox controller support

If you don't use these features, you can manually disable them via option **[E]** (requires typing "YES" to confirm).

### **Game Bar vs Game DVR**
- **Game DVR/recording** is disabled for better FPS
- **Game Bar overlay** remains functional unless you manually disable Xbox services

### **Antivirus/Security**
This script does **NOT** disable:
- Windows Defender
- Windows Security
- Firewall
- SmartScreen

### **System Requirements**
- Some tweaks (like Ultimate Performance power plan) may not be available on all systems
- Script detects OS version and warns if not Windows 10/11
- Built-in productivity tools such as **Camera** and **Quick Assist** are kept installed by default

### **Everyday Productivity Compatibility**
- **Microsoft Teams remains installed** so work/school meetings continue to function
- Windows Search indexing is left on-demand (not disabled) to keep Start, Outlook, and File Explorer search usable
- VPN/Remote Access services are preserved for work-from-home scenarios
- The script does **not** remove Office, browsers, or cloud sync tools such as OneDrive
- Mouse settings are backed up and restored so personal pointer preferences survive undo operations

---

## 🎯 Performance Expectations

### **Typical Improvements**
- **FPS gains**: 5-15% in CPU-bound games
- **Latency reduction**: 10-30ms lower input lag
- **RAM usage**: 500MB-1GB freed from background processes
- **Boot time**: 10-30% faster startup
- **Network ping**: 5-15ms reduction in online games

**Note:** Results vary based on hardware, game, and initial Windows configuration. Systems already optimized may see smaller gains.

---

## 🖥️ Hardware Compatibility

### **GPU Vendor Support**
This optimizer is **vendor-agnostic** and works with all modern GPUs:

| GPU Vendor | Compatibility | Notes |
|------------|---------------|-------|
| **NVIDIA** | ✅ Fully Compatible | GeForce GTX 10xx+. Hardware-accelerated GPU scheduling requires RTX 20xx+ |
| **AMD Radeon** | ✅ Fully Compatible | RX 5000+ recommended. GPU scheduling requires RX 5000+ series |
| **Intel Arc** | ✅ Fully Compatible | Arc A-series supported. GPU scheduling fully compatible |
| **Intel iGPU** | ✅ Compatible | Integrated graphics (11th gen+). Some GPU scheduling features may be limited |

**Registry tweaks applied are Windows-level optimizations** and do not interfere with vendor-specific drivers.

### **CPU Vendor Support**
All CPU-related optimizations are **cross-vendor compatible**:

| CPU Vendor | Compatibility | Notes |
|------------|---------------|-------|
| **Intel** | ✅ Fully Compatible | Core i3/i5/i7/i9, all generations |
| **AMD** | ✅ Fully Compatible | Ryzen 3/5/7/9, Threadripper, all generations |

**Power plans, scheduler settings, and multimedia profiles** work identically on Intel and AMD CPUs.

---

## 🔧 Manual Tweaks (Optional)

### **NVIDIA GPU**
1. NVIDIA Control Panel → Manage 3D Settings
2. Set "Low Latency Mode" to **Ultra**
3. Set "Power Management Mode" to **Prefer Maximum Performance**
4. Set "Texture Filtering - Quality" to **High Performance**

### **AMD GPU**
1. AMD Software → Gaming → Global Graphics
2. Enable **Anti-Lag** (or Anti-Lag+)
3. Enable **Radeon Boost** (if supported)
4. Set **Texture Filtering Quality** to Performance

### **Intel Arc GPU**
1. Intel Graphics Command Center → Gaming → Global Settings
2. Enable **XeSS** (if game supports it)
3. Set performance mode to **Maximum Performance**
4. Update to latest Intel Arc drivers for best compatibility

### **BIOS Settings**
- Enable **XMP/DOCP** for RAM (runs RAM at rated speed)
- Disable **C-States** for lower latency (increases power usage)
- Enable **Resizable BAR** (if supported by GPU/CPU)
- Update to latest BIOS version

### **In-Game Settings**
- Use **Fullscreen Exclusive** mode (not Borderless)
- Disable **V-Sync** (use G-Sync/FreeSync instead)
- Cap FPS slightly below monitor refresh rate
- Lower settings that impact CPU (shadows, draw distance, NPC count)

---

## 📊 Optimization Report

After running optimizations, use option **[P]** to view:
- System specifications (CPU, GPU, RAM)
- Applied optimizations summary
- Recommendations for manual tweaks
- Driver update reminders
- BIOS optimization suggestions

## ✅ Verify Optimizations

Use option **[V]** to check your current optimization status:
- Power plan verification (High/Ultimate Performance check)
- Game Mode status
- GPU hardware scheduling
- Telemetry service status
- Animation settings
- Network TCP optimizations
- Startup delay configuration

The verification tool shows **[PASS]** or **[WARN]** for each check and displays a percentage score. Use this after Windows updates to ensure tweaks are still active.

---

## 🐛 Troubleshooting

### **"Restore point creation failed"**
- Enable System Protection (see Safety Features section)
- Verify **Volume Shadow Copy** and **Microsoft Software Shadow Copy Provider** services are set to Manual and running
- You can continue without a restore point (not recommended)

### **Laptop battery warning / power concerns**
- The script detects laptop chassis types and warns before applying aggressive tweaks
- **Recommended for laptops:** Use option [2] RECOMMENDED, skip Advanced GPU [C]
- Power plans can be manually switched back via Windows Settings → System → Power
- Consider creating a separate "Gaming (Plugged In)" power plan

### **Script won't run**
- Right-click → "Run as administrator"
- Ensure PowerShell execution policy allows scripts

### **Changes not taking effect**
- Restart your PC after running optimizations
- Some tweaks require Explorer restart: `taskkill /f /im explorer.exe & start explorer.exe`

### **Game/app not working after optimization**
1. Use option **[U]** to undo changes
2. Restart your PC
3. If issues persist, use System Restore to restore point created in step 3

---

## 🔄 Update Guide (v2.4)

1) **Download the new script**: Grab `win11_nontouch_gaming_optimiser.bat` from GitHub and replace your existing copy.
2) **Run as administrator**: Launch the script; the menu shows version **v2.4**.
3) **Laptop users**: If detected as laptop, you'll see a battery warning with 10-second auto-cancel option.
4) **Pick your DVR preference**: When prompted, choose whether to disable Game DVR for a small FPS gain (default is **keep capture on**).
5) **Recommended run**: Use option **[1] FULL** (15 steps) or **[6] Gaming Tweaks** to apply the latest changes.
6) **Verify**: After restart, use **[V] Verify Optimizations** to check what's active.

What's new in v2.4 (high level):
- **Intelligent page file** - auto-configured based on your RAM (16GB+ users get managed, 8-15GB get fixed 4GB)
- **Storage detection** - SSD vs HDD detection with hardware-specific optimizations
- **Core parking disabled** - all CPU cores active for gaming (no more parking delays)
- **Smart superfetch** - disabled on fast SSDs, enabled on HDDs for better performance


### **Xbox Game Bar not working**
- If you ran option **[E]** to disable Xbox services, use option **[U]** to re-enable them
- Or manually run:
  ```cmd
  sc config XblAuthManager start=demand
  sc config XblGameSave start=demand
  sc config XboxGipSvc start=demand
  sc config XboxNetApiSvc start=demand
  ```

### **Network issues after optimization**
- Use option **[8]** → **[2]** to revert network tweaks
- Or run option **[U]** to undo all changes

---

## 📝 Changelog

### **Version 2.5** (Current)
- **Fixed:** GPU detection now correctly identifies discrete NVIDIA/AMD GPUs on hybrid systems (Intel iGPU + discrete)
- **Fixed:** GPU detection excludes virtual adapters (Vivi, Parsec, Remote Desktop, VMware, Hyper-V, etc.)
- **Fixed:** CPU name detection improved - no longer shows "Unknown" on multi-word processor names
- **Fixed:** Verify [V] command power plan check now works correctly
- **Fixed:** All hardware detection now uses PowerShell (WMIC removed in Windows 11 24H2+)
- **New:** Visual effects optimization menu - choose between Balanced, Minimal, or Skip
- **Improved:** Balanced mode keeps smooth Windows 11 animations while disabling non-essential effects
- **Improved:** Gaming machines no longer lose all visual polish by default
- **Compatibility:** Now works on Windows 11 24H2 and newer builds where WMIC is deprecated

### **Version 2.4**
- **New:** Automatic RAM detection with intelligent page file optimization (16GB+ = managed, 8-15GB = fixed 4GB)
- **New:** Storage type detection (SSD vs HDD) with hardware-specific optimizations
- **New:** CPU core parking disabled for maximum gaming performance
- **New:** RAM-based superfetch tuning - disabled on SSDs with 8GB+ RAM, enabled on HDDs
- **Enhanced:** Full optimization now includes 15 steps (previously 12)
- **Enhanced:** Smart storage optimization - TRIM for SSDs, prefetch for HDDs
- **Performance:** Core parking elimination improves multi-core gaming performance
- **Performance:** Page file tuning reduces disk I/O based on available RAM

### **Version 2.3**
- **New:** Laptop detection with battery warning - auto-detects chassis type, warns users about power impact
- **New:** Comprehensive registry backup - all modified keys backed up before changes to logs folder
- **New:** Verification tool [V] - check which optimizations are currently active with pass/fail status
- **New:** Changes summary - displays clear list of applied changes after optimization runs
- **Enhanced:** Banner now shows chassis type (Desktop/Laptop) for quick identification
- **Enhanced:** Better error handling and user warnings for safer operations
- **Safety:** Laptop users get 10-second auto-cancel prompt before aggressive power tweaks

### **Version 2.2**
- **New:** Game DVR choice prompt with default to keep capture on (Game Bar-friendly)
- **Enhanced:** Report and hardware detection now use PowerShell first, WMIC only as fallback
- **Enhanced:** Undo restores Game DVR policy flag alongside Game Bar settings
- **Docs:** Added quick v2.2 update guide; clarified Game Bar vs DVR behavior

### **Version 2.1**
- **New:** Hardware detection - automatically detects GPU vendor (NVIDIA/AMD/Intel Arc) and CPU vendor (Intel/AMD)
- **New:** Vendor-specific tips displayed after gaming tweaks (Low Latency Mode, Anti-Lag, XeSS)
- **New:** Enhanced ASCII banner with "GAMING OPT" title art
- **New:** Win32PrioritySeparation optimization (0x26) - prioritizes foreground apps (games) over background tasks
- **New:** System timer resolution optimization for better frame pacing and reduced input lag
- **New:** Hardware compatibility section in README - confirms cross-vendor support for all optimizations
- **Enhanced:** Visual presentation with box-drawing characters and improved section headers
- **Enhanced:** Intel Arc GPU support documented with manual tweaks
- **Fixed:** bcdedit timer settings now properly reverted in undo function

### **Version 2.0**
- Added GPU and storage optimizations (20+ latency tweaks)
- Added audio latency reduction
- Added mouse/keyboard input optimizations
- Added optional Xbox service disable (with confirmation)
- Added optimization report viewer
- Fixed: Xbox services now preserved by default for Game Bar users
- Enhanced: Full optimization now includes 12 steps
- Enhanced: Better visual presentation with color-coded sections
- Enhanced: Improved undo function with more reversions

### **Version 1.0**
- Initial release with core optimizations
- Menu-driven interface
- System restore point creation
- Comprehensive logging
- Network optimization submenu
- Undo functionality

---

## 🤝 Contributing

Found a bug or have a suggestion? Please:
1. Check existing issues on GitHub
2. Create a new issue with detailed description
3. Include your Windows version and log file (if applicable)

Pull requests welcome for:
- Bug fixes
- New optimizations (with safety verification)
- Documentation improvements

---

## 📜 License

This project is released under the **MIT License**.

```
Copyright (c) 2025 Matt Hurley

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## ⚖️ Disclaimer

**USE AT YOUR OWN RISK.** This script modifies system settings and registry values. While all changes are designed to be safe and reversible:

- Always create a system restore point before running
- Review the log files to understand what changed
- Test in a non-production environment first
- The author is not responsible for any issues that may arise

**Not affiliated with Microsoft.** Windows, Xbox, and related trademarks are property of Microsoft Corporation.

---

## 🌟 Credits

Created by **Matt Hurley**

Inspired by the Windows optimization community and countless hours of gaming performance research.

Special thanks to:
- The /r/pcgaming and /r/windows11 communities
- Chris Titus Tech for Windows optimization concepts
- NVIDIA and AMD for GPU optimization documentation

---

## 📞 Support

- **Issues/Bugs**: [GitHub Issues](https://github.com/theantipopau/windows11nontouchgamingoptimizer/issues)
- **Discussions**: [GitHub Discussions](https://github.com/theantipopau/windows11nontouchgamingoptimizer/discussions)

---

**⭐ If this script helped improve your gaming experience, consider starring the repo!**

---

*Last updated: December 2025*
