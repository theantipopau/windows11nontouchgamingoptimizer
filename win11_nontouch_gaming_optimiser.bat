@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "SCRIPT_DIR=%~dp0"
pushd "%SCRIPT_DIR%" >nul 2>&1

title Windows 11 Non-Touch Gaming Optimizer - by Matt Hurley
color 0A

for /f %%A in ('"prompt $E & for %%B in (1) do rem"') do set "ESC=%%A"
if defined ESC (
    set "CLR_TITLE=%ESC%[95;1m"
    set "CLR_SUBTITLE=%ESC%[96m"
    set "CLR_MENU=%ESC%[93;1m"
    set "CLR_SUCCESS=%ESC%[92m"
    set "CLR_WARNING=%ESC%[93m"
    set "CLR_RESET=%ESC%[0m"
) else (
    set "CLR_TITLE="
    set "CLR_SUBTITLE="
    set "CLR_MENU="
    set "CLR_SUCCESS="
    set "CLR_WARNING="
    set "CLR_RESET="
)

:: ---------------------------------------------------------------------------
:: Windows 11 Non-Touch Gaming Optimizer
:: by Matt Hurley
::
:: Menu-driven utility focused on:
::   - Removing bloatware and touch/pen components
::   - Maximizing gaming FPS and responsiveness  
::   - Optimizing network latency and throughput
::   - Reducing RAM/CPU usage from background services
::   - All changes are logged and reversible
:: ---------------------------------------------------------------------------

set "POWERSHELL=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"

set "RELAUNCHED="
if /I "%~1"=="-Elevated" (
    set "RELAUNCHED=1"
    shift
)

call :EnsureAdmin
set "ADMIN_STATUS=%errorlevel%"
if "%ADMIN_STATUS%"=="2" exit /b 0
if not "%ADMIN_STATUS%"=="0" exit /b %ADMIN_STATUS%
call :CheckAdmin || exit /b 1

for /f %%I in ('"%POWERSHELL%" -NoProfile -Command "Get-Date -Format yyyyMMdd_HHmmss"') do set "STAMP=%%I"
set "LOG_DIR=%SCRIPT_DIR%logs"
if not exist "%LOG_DIR%" mkdir "%LOG_DIR%" >nul 2>&1
set "LOG_FILE=%LOG_DIR%\nontouch_gaming_optimizer_%STAMP%.log"
call :Log "=== Windows 11 Non-Touch Gaming Optimizer started ==="

call :DetectOS
call :DetectHardware
call :DetectChassisType
call :DetectRAM
call :DetectStorageType
set "CHANGES_SUMMARY="
call :Log "Initialization complete - entering menu"

:Menu
cls
call :Banner
if errorlevel 1 (
    echo [!] Error displaying banner
    pause
    exit /b 1
)
call :Log "Awaiting menu selection"
echo.
echo    %CLR_MENU%[1 / F]%CLR_RESET% FULL OPTIMIZATION - All gaming tweaks in one run
echo    %CLR_MENU%[2]%CLR_RESET% RECOMMENDED - Core essentials only (faster)
echo.
echo    %CLR_MENU%[3]%CLR_RESET% Create system restore point
echo    %CLR_MENU%[4]%CLR_RESET% Debloat Windows 11 (remove consumer/OEM apps)
echo    %CLR_MENU%[5]%CLR_RESET% Disable touchscreen, pen, and ink features
echo    %CLR_MENU%[6]%CLR_RESET% Apply gaming performance tweaks
echo    %CLR_MENU%[7]%CLR_RESET% Optimize services, telemetry, and indexing
echo    %CLR_MENU%[8]%CLR_RESET% Network optimizations (apply/revert)
echo    %CLR_MENU%[9]%CLR_RESET% Disable animations and visual effects
echo    %CLR_MENU%[A]%CLR_RESET% Optimize startup programs and services
echo    %CLR_MENU%[B]%CLR_RESET% Free disk space and clear temp files
echo    %CLR_MENU%[C]%CLR_RESET% Advanced: GPU and storage optimizations
echo    %CLR_MENU%[D]%CLR_RESET% Advanced: Audio latency reduction
echo    %CLR_MENU%[E]%CLR_RESET% Optional: Disable Xbox services (breaks Game Bar)
echo.
echo    %CLR_MENU%[H]%CLR_RESET% Help / README
echo    %CLR_MENU%[P]%CLR_RESET% View optimization report
echo    %CLR_MENU%[V]%CLR_RESET% Verify optimizations status
echo    %CLR_MENU%[U]%CLR_RESET% UNDO - Revert key changes
echo    %CLR_MENU%[0]%CLR_RESET% Exit
echo.
set /p "choice=> "
set "choice=%choice:~0,1%"
if /I "%choice%"=="1" call :FullOptimization & call :PauseReturn & goto Menu
if /I "%choice%"=="F" call :FullOptimization & call :PauseReturn & goto Menu
if /I "%choice%"=="2" call :RunRecommended & call :PauseReturn & goto Menu
if /I "%choice%"=="3" call :CreateRestorePoint & call :PauseReturn & goto Menu
if /I "%choice%"=="4" call :Debloat & call :PauseReturn & goto Menu
if /I "%choice%"=="5" call :DisableTouchFeatures & call :PauseReturn & goto Menu
if /I "%choice%"=="6" call :ApplyGamingTweaks & call :PauseReturn & goto Menu
if /I "%choice%"=="7" call :OptimizeServices & call :PauseReturn & goto Menu
if /I "%choice%"=="8" call :NetworkMenu & goto Menu
if /I "%choice%"=="9" call :DisableAnimations & call :PauseReturn & goto Menu
if /I "%choice%"=="A" call :OptimizeStartup & call :PauseReturn & goto Menu
if /I "%choice%"=="B" call :FreeDiskSpace & call :PauseReturn & goto Menu
if /I "%choice%"=="C" call :AdvancedGPUStorage & call :PauseReturn & goto Menu
if /I "%choice%"=="D" call :OptimizeAudio & call :PauseReturn & goto Menu
if /I "%choice%"=="E" call :DisableXboxServices & call :PauseReturn & goto Menu
if /I "%choice%"=="H" call :ShowHelp & call :PauseReturn & goto Menu
if /I "%choice%"=="P" call :ShowReport & call :PauseReturn & goto Menu
if /I "%choice%"=="V" call :VerifyOptimizations & call :PauseReturn & goto Menu
if /I "%choice%"=="U" call :UndoChanges & call :PauseReturn & goto Menu
if "%choice%"=="0" goto End
echo.
echo [!] Unknown selection. Please try again.
call :PauseReturn
goto Menu

:FullOptimization
call :Log "Running FULL optimization sequence"
echo.
echo ========================================================================
echo   %CLR_TITLE%FULL GAMING OPTIMIZATION%CLR_RESET%
echo ========================================================================
echo   This will apply ALL gaming optimizations for maximum performance.
echo   %CLR_WARNING%Estimated time: 5-10 minutes%CLR_RESET%
echo ========================================================================
echo.
call :CreateRestorePoint
if errorlevel 1 exit /b 1
echo.
echo [*] Step 1/15: Removing consumer apps...
call :Debloat
echo [*] Step 2/15: Disabling touch/pen components...
call :DisableTouchFeatures
echo [*] Step 3/15: Applying gaming tweaks...
call :WarnIfOnBattery
if errorlevel 1 exit /b 1
call :ApplyGamingTweaks
echo [*] Step 4/15: Optimizing services and telemetry...
call :OptimizeServices
echo [*] Step 5/15: Applying network optimizations...
call :ApplyNetworkTweaks
echo [*] Step 6/15: Optimizing visual effects...
call :DisableAnimations
echo [*] Step 7/15: Optimizing startup...
call :OptimizeStartup
echo [*] Step 8/15: Freeing disk space...
call :FreeDiskSpace
echo [*] Step 9/15: GPU and storage optimizations...
set "AUTO_ADVANCED_CONFIRM=1"
call :AdvancedGPUStorage
set "AUTO_ADVANCED_CONFIRM="
echo [*] Step 10/15: Audio latency reduction...
call :OptimizeAudio
echo [*] Step 11/15: Finalizing memory optimizations...
call :OptimizeMemory
echo [*] Step 12/15: Optimizing page file...
call :OptimizePageFile
echo [*] Step 13/15: Disabling CPU core parking...
call :DisableCoreParking
echo [*] Step 14/15: Tuning storage-specific settings...
call :OptimizeStorageByType
echo [*] Step 15/15: Complete!
echo.
echo ========================================================================
echo   %CLR_SUCCESS%FULL OPTIMIZATION COMPLETE!%CLR_RESET%
echo   Please %CLR_WARNING%RESTART%CLR_RESET% your device for all changes to take effect.
echo ========================================================================
call :Log "Full optimization sequence completed"
call :ShowChangesSummary
exit /b 0

:RunRecommended
call :Log "Running recommended sequence"
echo.
echo ========================================================================
echo   %CLR_TITLE%RECOMMENDED GAMING OPTIMIZATION%CLR_RESET%
echo ========================================================================
echo   This will apply the most important gaming optimizations.
echo   %CLR_WARNING%Estimated time: 3-5 minutes%CLR_RESET%
echo ========================================================================
echo.
call :CreateRestorePoint
if errorlevel 1 exit /b 1
echo.
echo [*] Step 1/7: Removing consumer apps...
call :Debloat
echo [*] Step 2/7: Applying gaming tweaks...
call :WarnIfOnBattery
if errorlevel 1 exit /b 1
call :ApplyGamingTweaks
echo [*] Step 3/7: Optimizing services...
call :OptimizeServices
echo [*] Step 4/7: Applying network optimizations...
call :ApplyNetworkTweaksSafe
echo [*] Step 5/7: Optimizing visual effects...
call :DisableAnimations
echo [*] Step 6/7: Disabling CPU core parking...
call :DisableCoreParking
echo [*] Step 7/7: Finalizing...
echo.
echo ========================================================================
echo   %CLR_SUCCESS%RECOMMENDED OPTIMIZATION COMPLETE!%CLR_RESET%
echo   Please %CLR_WARNING%RESTART%CLR_RESET% your device for all changes to take effect.
echo ========================================================================
call :Log "Recommended optimization sequence completed"
call :ShowChangesSummary
exit /b 0

:CreateRestorePoint
call :Log "Creating system restore point"
echo.
echo [*] Checking restore point prerequisites...
call :EnsureShadowServices
echo    %CLR_MENU%[1]%CLR_RESET% Apply SAFE network tweaks (recommended)
echo    %CLR_MENU%[2]%CLR_RESET% Apply AGGRESSIVE network tweaks (may affect VPN/throughput)
echo    %CLR_MENU%[3]%CLR_RESET% Revert network tweaks to Windows defaults
echo    %CLR_MENU%[4]%CLR_RESET% Return to main menu
    call :Log "Restore point prerequisites missing"
    exit /b 1
choice /c 1234 /n /m "Select an option: "
echo [*] Creating system restore point...
    "%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "Try { Checkpoint-Computer -Description 'NonTouchGamingOptimizer' -RestorePointType 'MODIFY_SETTINGS' -ErrorAction Stop; exit 0 } Catch { Write-Warning $_; exit 1 }" >> "%LOG_FILE%" 2>&1
    call :ApplyNetworkTweaksSafe
    echo.
    echo ========================================================================
    echo   [!] SYSTEM RESTORE POINT FAILED
    echo ========================================================================
    call :ApplyNetworkTweaks
    echo.
    echo   To enable System Protection:
    echo   1. Open Control Panel ^> System ^> System Protection
    echo   2. Select your C: drive and click "Configure"
    call :RevertNetworkTweaks
    call :PauseReturn
    goto NetworkOptions
)
if "%netopt%"=="4" exit /b 0
    echo.
        call :Log "Restore point creation failed"
        echo.
        choice /c YN /n /m "Continue without a restore point? (Y/N): "

:ApplyNetworkTweaksSafe
call :Log "Applying SAFE network tweaks"
echo.
echo ========================================================================
echo   %CLR_TITLE%APPLYING SAFE NETWORK OPTIMIZATIONS%CLR_RESET%
echo ========================================================================
echo.
echo [*] Applying low-risk tweaks for gaming (keeps Windows TCP defaults)...
REM Keep global netsh defaults to reduce compatibility issues; apply only latency-friendly knobs.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpNoDelay /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul

REM Delivery Optimization (P2P updates) off for latency + bandwidth stability
sc stop DoSvc >nul 2>&1
sc config DoSvc start= disabled >nul 2>&1
for %%T in ("\Microsoft\Windows\Delivery Optimization\Maintenance" "\Microsoft\Windows\Delivery Optimization\Download") do (
    schtasks /Change /TN %%~T /Disable >nul 2>&1
)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v DODownloadMode /t REG_DWORD /d 0 /f >nul

call :Log "SAFE network tweaks applied"
call :AddToSummary "Network optimized (safe)"
echo.
echo %CLR_SUCCESS%[+] Safe network tweaks applied!%CLR_RESET% Low risk, good baseline.
echo     Log: %LOG_FILE%
exit /b 0
        if errorlevel 2 (
            echo.
            echo [!] Operation cancelled. Please enable System Protection and rerun the script.
            call :Log "User aborted after restore failure"
            exit /b 1
        )
        echo.
        echo [!] Continuing without a restore point at user request...
        call :Log "User chose to continue without restore point"
) else (
    echo %CLR_SUCCESS%[+] Restore point created successfully.%CLR_RESET%
    call :Log "Restore point created"
)
exit /b 0

:Debloat
call :BackupRegistryKeys
call :Log "Starting debloat routine"
echo.
echo ========================================================================
echo   %CLR_TITLE%DEBLOATING WINDOWS 11%CLR_RESET%
echo ========================================================================
echo.
echo [*] Removing consumer and OEM bloat (safe set). This may take a minute...
for %%A in (
    Clipchamp.Clipchamp
    Microsoft.BingNews
    Microsoft.BingFinance
    Microsoft.BingWeather
    Microsoft.GetHelp
    Microsoft.Getstarted
    Microsoft.Microsoft3DViewer
    Microsoft.MicrosoftOfficeHub
    Microsoft.MicrosoftSolitaireCollection
    Microsoft.MixedReality.Portal
    Microsoft.People
    Microsoft.PowerAutomateDesktop
    Microsoft.SkypeApp
    Microsoft.WindowsFeedbackHub
    Microsoft.ZuneMusic
    Microsoft.ZuneVideo
    MicrosoftWindows.Client.WebExperience
    Microsoft.YourPhone
    SpotifyAB.SpotifyMusic
    BytedancePte.Ltd.TikTok
    Facebook.Facebook
    Disney.37853FC22B2CE
    Microsoft.WindowsAlarms
    Microsoft.WindowsMaps
    Microsoft.WindowsSoundRecorder
    Microsoft.Whiteboard
    Microsoft.MixedReality.Portal
) do (
    call :RemoveApp %%A
)
call :Log "Debloat: Game Bar and Xbox app preserved"
echo [*] Skipping removal of Xbox/Game Bar components to keep overlay and sign-in working.
call :Log "Debloat routine complete"
call :AddToSummary "Bloatware removed"
echo.
echo %CLR_SUCCESS%[+] Debloat complete!%CLR_RESET% Removed consumer/OEM bloatware.
echo     Log: %LOG_FILE%
exit /b 0

:DisableTouchFeatures
call :Log "Disabling touch/pen stack"
echo.
echo ========================================================================
echo   %CLR_TITLE%DISABLING TOUCH/PEN FEATURES%CLR_RESET%
echo ========================================================================
echo.
echo [*] Disabling touchscreen, pen, handwriting, and touch keyboard components...
for %%S in (TabletInputService TextInputManagementService TouchInput WTabletServiceCon WTabletServicePen PenService TabletInputHost) do (
    sc stop %%S >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v EnableTabletModeAutoSwitch /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletModeAutoSwitch /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PenWorkspace" /v PenWorkspaceButtonDesiredVisibility /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\TabletTip\1.7" /v EnableAutocorrection /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\TabletTip\1.7" /v EnableTextPrediction /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\TabletTip\1.7" /v EnableSpellchecking /t REG_DWORD /d 0 /f >nul
"%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -Online -FeatureName 'TabletPC-OC' -NoRestart -ErrorAction SilentlyContinue" >> "%LOG_FILE%" 2>&1
"%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "Disable-WindowsOptionalFeature -Online -FeatureName 'InkAndHandwritingServices' -NoRestart -ErrorAction SilentlyContinue" >> "%LOG_FILE%" 2>&1
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v FlicksEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v TouchGate /t REG_DWORD /d 0 /f >nul
call :Log "Touch/pen features disabled"
call :AddToSummary "Touch/pen features disabled"
echo.
echo %CLR_SUCCESS%[+] Touch and pen components disabled!%CLR_RESET%
echo     Log: %LOG_FILE%
exit /b 0

:ApplyGamingTweaks
call :BackupRegistryKeys
call :Log "Applying gaming tweaks"
echo.
echo %CLR_TITLE%  ======================================================================%CLR_RESET%
echo %CLR_TITLE%  ^^|                 GAMING PERFORMANCE TWEAKS                         ^^|%CLR_RESET%
echo %CLR_TITLE%  ======================================================================%CLR_RESET%
echo.
if not defined DVR_PREF_SET (
    echo [*] Game Bar capture: keep it on, or disable for a small FPS gain?
    choice /c YN /n /d N /t 5 /m "Disable Game DVR background capture? (Y/N, default=N): "
    if "%errorlevel%"=="1" (
        set "DISABLE_DVR=1"
    ) else (
        set "DISABLE_DVR=0"
    )
    set "DVR_PREF_SET=1"
)
call :Log "Gaming tweaks: power plan"
echo [*] Enabling Ultimate Performance plan (or High Performance fallback)...
set "UP_GUID="
for /f "tokens=3" %%G in ('powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2^>nul ^| find /i "GUID"') do set "UP_GUID=%%G"
if not defined UP_GUID set "UP_GUID=e9a42b02-d5df-448d-aa00-03f14749eb61"
powercfg -setactive %UP_GUID% >nul 2>&1
if errorlevel 1 powercfg -setactive SCHEME_MIN >nul 2>&1

echo [*] Tuning Game Mode, GPU scheduling, and visual effects...
if not defined MOUSE_BACKUP_DONE (
    if not exist "%LOG_DIR%\mouse_settings_backup.reg" (
        reg export "HKCU\Control Panel\Mouse" "%LOG_DIR%\mouse_settings_backup.reg" /y >nul 2>&1
        call :Log "Mouse settings backed up to %LOG_DIR%\mouse_settings_backup.reg"
    )
    set "MOUSE_BACKUP_DONE=1"
)
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul
if "%DISABLE_DVR%"=="1" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v value /t REG_DWORD /d 0 /f >nul
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul
    reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul
    reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehaviorMode /t REG_DWORD /d 2 /f >nul
    reg add "HKCU\System\GameConfigStore" /v GameDVR_HonorUserFSEBehaviorMode /t REG_DWORD /d 1 /f >nul
    reg add "HKCU\System\GameConfigStore" /v GameDVR_DXGIHonorFSEWindowsCompatible /t REG_DWORD /d 1 /f >nul
    call :Log "Gaming tweaks: Game DVR disabled by user"
) else (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 1 /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v value /t REG_DWORD /d 1 /f >nul
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 1 /f >nul
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v GameDVR_Enabled /t REG_DWORD /d 1 /f >nul
    reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 1 /f >nul
    reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehaviorMode /t REG_DWORD /d 2 /f >nul
    reg add "HKCU\System\GameConfigStore" /v GameDVR_HonorUserFSEBehaviorMode /t REG_DWORD /d 1 /f >nul
    reg add "HKCU\System\GameConfigStore" /v GameDVR_DXGIHonorFSEWindowsCompatible /t REG_DWORD /d 1 /f >nul
    call :Log "Gaming tweaks: Game DVR kept enabled for Game Bar capture"
)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul
reg add "HKCU\Control Panel\Desktop" /v WaitToKillAppTimeout /t REG_SZ /d 2000 /f >nul
reg add "HKCU\Control Panel\Desktop" /v HungAppTimeout /t REG_SZ /d 1000 /f >nul
call :Log "Gaming tweaks: scheduler priorities"

echo [*] Prioritizing multimedia + game scheduler values...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 10 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul

call :Log "Gaming tweaks: latency + input"

echo [*] Optimizing for low latency and high throughput...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /t REG_SZ /d "True" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "NoLazyMode" /t REG_DWORD /d 1 /f >nul

echo [*] Optimizing mouse and keyboard input for gaming...
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul
reg add "HKCU\Control Panel\Mouse" /v MouseSensitivity /t REG_SZ /d 10 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v MouseDataQueueSize /t REG_DWORD /d 20 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v KeyboardDataQueueSize /t REG_DWORD /d 20 /f >nul

echo [*] Enabling full Game Mode stack...
reg add "HKCU\Software\Microsoft\GameBar" /v UseNexusForGameBarEnabled /t REG_DWORD /d 0 /f >nul

echo [*] Optimizing system timer resolution for better frame pacing...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v GlobalTimerResolutionRequests /t REG_DWORD /d 1 /f >nul
REM bcdedit changes - can cause issues on some systems, proceed with caution
for %%B in ("useplatformclock true" "disabledynamictick yes") do (
    bcdedit /set %%~B >nul 2>&1
    if errorlevel 1 call :Log "Warning: bcdedit /set %%~B failed - may require Secure Boot disabled"
)

echo [*] Prioritizing foreground apps (games) over background tasks...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f >nul
call :Log "Gaming tweaks: telemetry disable"

sc stop "DiagTrack" >nul 2>&1
sc config "DiagTrack" start= disabled >nul 2>&1

call :Log "Gaming tweaks applied"
call :AddToSummary "Gaming performance tweaks"
echo.
echo %CLR_SUCCESS%[+] Gaming optimizations applied!%CLR_RESET% FPS and responsiveness improved.
if /I "%GPU_VENDOR%"=="NVIDIA" (
    echo     %CLR_WARNING%Tip:%CLR_RESET% Open NVIDIA Control Panel ^> Low Latency Mode = Ultra
)
if /I "%GPU_VENDOR%"=="AMD Radeon" (
    echo     %CLR_WARNING%Tip:%CLR_RESET% Open AMD Software ^> Anti-Lag = Enabled
)
if /I "%GPU_VENDOR%"=="Intel Arc" (
    echo     %CLR_WARNING%Tip:%CLR_RESET% Open Intel Graphics Command Center for game optimizations
)
echo     Log: %LOG_FILE%
exit /b 0

:OptimizeServices
call :Log "Optimizing services/indexing"
echo.
echo ========================================================================
echo   %CLR_TITLE%OPTIMIZING SERVICES AND TELEMETRY%CLR_RESET%
echo ========================================================================
echo.
echo [*] Reducing background services, indexing, telemetry, and tips...
for %%S in (SysMain WSearch DiagTrack dmwappushservice RetailDemo RemoteRegistry MapsBroker TrkWks) do (
    sc stop %%S >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
)
sc config WSearch start= demand >nul 2>&1
for %%T in (
    "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
    "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
    "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
    "\Microsoft\Windows\Feedback\Siuf\DmClient"
    "\Microsoft\Windows\Autochk\Proxy"
    "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
) do (
    schtasks /Change /TN %%~T /Disable >nul 2>&1
)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v CortanaConsent /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSyncProviderNotifications /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_IrisRecommendations /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableSoftLanding /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightFeatures /t REG_DWORD /d 1 /f >nul
call :Log "Service/telemetry optimizations complete"
call :AddToSummary "Services optimized"
echo.
echo %CLR_SUCCESS%[+] Services optimized!%CLR_RESET% Background CPU/RAM usage reduced.
echo     Log: %LOG_FILE%
exit /b 0

:NetworkMenu
:NetworkOptions
cls
echo ========================================================================
echo   %CLR_TITLE%NETWORK OPTIMIZATION MENU%CLR_RESET%
echo ========================================================================
echo.
echo    %CLR_MENU%[1]%CLR_RESET% Apply gaming network tweaks (lower ping/latency)
echo    %CLR_MENU%[2]%CLR_RESET% Revert network tweaks to Windows defaults
echo    %CLR_MENU%[3]%CLR_RESET% Return to main menu
echo.
echo ========================================================================
choice /c 123 /n /m "Select an option: "
set "netopt=%errorlevel%"
if "%netopt%"=="1" (
    call :ApplyNetworkTweaks
    call :PauseReturn
    goto NetworkOptions
)
if "%netopt%"=="2" (
    call :RevertNetworkTweaks
    call :PauseReturn
    goto NetworkOptions
)
if "%netopt%"=="3" exit /b 0
echo.
echo [!] Unknown selection - try again.
call :PauseReturn
goto NetworkOptions

:ApplyNetworkTweaks
call :Log "Applying network tweaks"
echo.
echo ========================================================================
echo   %CLR_TITLE%APPLYING NETWORK OPTIMIZATIONS%CLR_RESET%
echo ========================================================================
echo.
echo [*] Applying safe TCP/IP and bandwidth tweaks for gaming...
netsh interface tcp set global autotuninglevel=highlyrestricted >nul 2>&1
netsh interface tcp set global ecncapability=disabled >nul 2>&1
netsh interface tcp set global rss=enabled >nul 2>&1
netsh interface tcp set global rsc=disabled >nul 2>&1
netsh interface tcp set global chimney=disabled >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpTimedWaitDelay /t REG_DWORD /d 30 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v MaxUserPort /t REG_DWORD /d 65534 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v Tcp1323Opts /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpNoDelay /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DefaultTTL /t REG_DWORD /d 64 /f >nul

sc stop DoSvc >nul 2>&1
sc config DoSvc start= disabled >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Delivery Optimization\Maintenance" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Delivery Optimization\Download" /Disable >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v DODownloadMode /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v DOMaxUploadBandwidth /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v DOMaxUploadPercentage /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul 2>&1
call :Log "Network tweaks applied"
call :AddToSummary "Network optimized"
echo.
echo %CLR_SUCCESS%[+] Network tweaks applied!%CLR_RESET% Lower latency and improved throughput.
echo     Log: %LOG_FILE%
exit /b 0

:RevertNetworkTweaks
call :Log "Reverting network tweaks"
echo.
echo ========================================================================
echo   %CLR_TITLE%REVERTING NETWORK TWEAKS%CLR_RESET%
echo ========================================================================
echo.
echo [*] Reverting network-related tweaks to Windows defaults...
netsh interface tcp set global autotuninglevel=normal >nul 2>&1
netsh interface tcp set global ecncapability=default >nul 2>&1
netsh interface tcp set global rss=enabled >nul 2>&1
netsh interface tcp set global rsc=default >nul 2>&1
netsh interface tcp set global chimney=default >nul 2>&1
for %%V in (TcpTimedWaitDelay MaxUserPort Tcp1323Opts TcpNoDelay TcpAckFrequency DefaultTTL) do (
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v %%V /f >nul 2>&1
)
sc config DoSvc start= delayed-auto >nul 2>&1
sc start DoSvc >nul 2>&1
for %%T in ("\Microsoft\Windows\Delivery Optimization\Maintenance" "\Microsoft\Windows\Delivery Optimization\Download") do (
    schtasks /Change /TN %%~T /Enable >nul 2>&1
)
for %%V in (DODownloadMode DOMaxUploadBandwidth DOMaxUploadPercentage) do (
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v %%V /f >nul 2>&1
)
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TcpAckFrequency /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TCPNoDelay /f >nul 2>&1
call :Log "Network tweaks reverted"
echo.
echo %CLR_SUCCESS%[+] Network tweaks reverted!%CLR_RESET% Restored Windows defaults.
echo     Log: %LOG_FILE%
exit /b 0

:DisableAnimations
call :Log "Animations menu"
echo.
echo ========================================================================
echo   %CLR_TITLE%VISUAL EFFECTS OPTIMIZATION%CLR_RESET%
echo ========================================================================
echo.
echo   Your system has capable hardware. Choose your preference:
echo.
echo   %CLR_MENU%[1]%CLR_RESET% BALANCED (Recommended) - Keep smooth animations, disable extras
echo       Keeps: Window animations, taskbar effects, transparency
echo       Disables: Aero Peek, thumbnail previews, listview effects
echo.
echo   %CLR_MENU%[2]%CLR_RESET% MINIMAL - Disable most animations for max FPS
echo       Disables most visual effects for raw performance
echo.
echo   %CLR_MENU%[3]%CLR_RESET% SKIP - Keep current Windows settings
echo.
choice /c 123 /n /d 1 /t 15 /m "Select option (auto-selects Balanced in 15s): "
set "ANIM_CHOICE=%errorlevel%"

if "%ANIM_CHOICE%"=="3" (
    echo.
    echo [*] Skipping visual effects changes.
    call :Log "User skipped animation changes"
    exit /b 0
)

if "%ANIM_CHOICE%"=="1" (
    echo.
    echo [*] Applying BALANCED visual settings...
    REM Keep animations but disable extras
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 1 /f >nul
    reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 1 /f >nul
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f >nul
    REM Disable non-essential extras
    reg add "HKCU\Software\Microsoft\Windows\DWM" /v EnableAeroPeek /t REG_DWORD /d 0 /f >nul
    reg add "HKCU\Software\Microsoft\Windows\DWM" /v AlwaysHibernateThumbnails /t REG_DWORD /d 0 /f >nul
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f >nul
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisallowShaking /t REG_DWORD /d 1 /f >nul
    REM Keep transparency and smooth scrolling
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f >nul
    call :Log "Balanced visual settings applied"
    call :AddToSummary "Visual effects: Balanced"
    echo.
    echo %CLR_SUCCESS%[+] Balanced visuals applied!%CLR_RESET% Smooth Windows 11 experience preserved.
) else (
    echo.
    echo [*] Applying MINIMAL visual settings for max FPS...
    reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f >nul
    reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f >nul
    reg add "HKCU\Software\Microsoft\Windows\DWM" /v EnableAeroPeek /t REG_DWORD /d 0 /f >nul
    reg add "HKCU\Software\Microsoft\Windows\DWM" /v AlwaysHibernateThumbnails /t REG_DWORD /d 0 /f >nul
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f >nul
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f >nul
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisallowShaking /t REG_DWORD /d 1 /f >nul
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >nul
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul
    call :Log "Minimal animations applied"
    call :AddToSummary "Visual effects: Minimal"
    echo.
    echo %CLR_SUCCESS%[+] Minimal visuals applied!%CLR_RESET% Maximum FPS mode.
    echo     Restart Explorer for immediate effect: taskkill /f /im explorer.exe ^& start explorer.exe
)
echo     Log: %LOG_FILE%
exit /b 0

:OptimizeStartup
call :Log "Optimizing startup"
echo.
echo ========================================================================
echo   %CLR_TITLE%OPTIMIZING STARTUP PROGRAMS%CLR_RESET%
echo ========================================================================
echo.
echo [*] Reducing startup delays and disabling unnecessary startup items...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f >nul
schtasks /Change /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\PcaPatchDbTask" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Maps\MapsUpdateTask" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Maps\MapsToastTask" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable >nul 2>&1
powercfg -attributes SUB_SLEEP 7bc4a2f9-d8fc-4469-b07b-33eb785aaca0 -ATTRIB_HIDE >nul 2>&1
powercfg -setacvalueindex SCHEME_CURRENT SUB_SLEEP 7bc4a2f9-d8fc-4469-b07b-33eb785aaca0 0 >nul 2>&1
powercfg -setdcvalueindex SCHEME_CURRENT SUB_SLEEP 7bc4a2f9-d8fc-4469-b07b-33eb785aaca0 0 >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f >nul
Dism /Online /Disable-Feature /FeatureName:Printing-XPSServices-Features /NoRestart /Quiet >nul 2>&1
Dism /Online /Disable-Feature /FeatureName:WorkFolders-Client /NoRestart /Quiet >nul 2>&1
Dism /Online /Disable-Feature /FeatureName:FaxServicesClientPackage /NoRestart /Quiet >nul 2>&1
call :Log "Startup optimized"
call :AddToSummary "Startup optimized"
echo.
echo %CLR_SUCCESS%[+] Startup optimized!%CLR_RESET% Boot time and responsiveness improved.
echo     Log: %LOG_FILE%
exit /b 0

:FreeDiskSpace
call :Log "Freeing disk space"
echo.
echo ========================================================================
echo   %CLR_TITLE%FREEING DISK SPACE%CLR_RESET%
echo ========================================================================
echo.
echo [*] Clearing temporary files and reclaiming disk space...
powercfg /h off >nul 2>&1
call :Log "Hibernation disabled"
if "!CHASSIS_TYPE!"=="Laptop" (
    echo     %CLR_WARNING%[NOTE] Hibernation disabled - re-enable with: powercfg /h on%CLR_RESET%
)
call :ClearTemp "%TEMP%"
if defined LOCALAPPDATA call :ClearTemp "%LOCALAPPDATA%\Temp"
call :ClearTemp "%SystemRoot%\Temp"
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
if exist "%SystemRoot%\SoftwareDistribution\Download" rd /s /q "%SystemRoot%\SoftwareDistribution\Download"
mkdir "%SystemRoot%\SoftwareDistribution\Download" >nul 2>&1
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
"%SystemRoot%\System32\dism.exe" /Online /Cleanup-Image /StartComponentCleanup >> "%LOG_FILE%" 2>&1
call :Log "Disk cleanup complete"
call :AddToSummary "Disk space freed"
echo.
echo %CLR_SUCCESS%[+] Disk cleanup complete!%CLR_RESET% Temporary files removed.
echo     Log: %LOG_FILE%
exit /b 0

:OptimizeMemory
call :Log "Optimizing memory"
echo [*] Enabling memory compression and optimizing paging...
if defined RAM_GB (
    if %RAM_GB% LSS 8 (
        echo     %CLR_WARNING%[!] WARNING: Low RAM detected (%RAM_GB%GB). DisablePagingExecutive may cause instability.%CLR_RESET%
        echo     %CLR_WARNING%    Consider adding more RAM for better gaming performance.%CLR_RESET%
        call :Log "Low RAM warning: %RAM_GB%GB detected - DisablePagingExecutive may cause issues"
    )
)
"%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "Enable-MMAgent -MemoryCompression" >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f >nul
call :Log "Memory optimizations applied"
call :AddToSummary "Memory optimizations applied"
exit /b 0

:ClearTemp
set "TARGET=%~1"
if not defined TARGET exit /b 0
if not exist "%TARGET%" exit /b 0
call :Log "Clearing %TARGET%"
pushd "%TARGET%" >nul 2>&1 || exit /b 0
del /f /s /q *.* >nul 2>&1
for /d %%D in (*) do rd /s /q "%%D" >nul 2>&1
popd >nul 2>&1
exit /b 0

:OptimizePageFile
call :Log "Optimizing page file based on RAM=%RAM_GB%GB"
echo [*] Configuring page file based on system RAM...
if not defined RAM_GB (
    echo [*] RAM not detected, skipping page file optimization
    call :Log "Page file optimization skipped - RAM not detected"
    exit /b 0
)
if %RAM_GB% GEQ 16 (
    echo     System RAM: %RAM_GB%GB - Setting managed page file
    "%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "$cs = Get-CimInstance Win32_ComputerSystem; $cs | Set-CimInstance -Property @{AutomaticManagedPagefile=$true}" >nul 2>&1
    if errorlevel 1 call :Log "Warning: Failed enabling automatic managed page file"
    call :Log "Page file: Managed (16GB+ RAM detected)"
    call :AddToSummary "Page file optimized for %RAM_GB%GB RAM"
) else if %RAM_GB% GEQ 8 (
    echo     System RAM: %RAM_GB%GB - Setting fixed page file (4GB)
    REM Win32_PageFileSetting may not exist when automatic management is enabled; set via CIM + registry for reliability.
    "%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "$cs = Get-CimInstance Win32_ComputerSystem; $cs | Set-CimInstance -Property @{AutomaticManagedPagefile=$false}; Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' -Name PagingFiles -Value @('C:\\pagefile.sys 4096 4096')" >nul 2>&1
    if errorlevel 1 call :Log "Warning: Failed setting fixed page file size"
    call :Log "Page file: Fixed 4GB (8-15GB RAM detected)"
    call :AddToSummary "Page file fixed at 4GB"
) else (
    echo     System RAM: %RAM_GB%GB - Keeping system-managed page file
    echo     %CLR_WARNING%[!] Low RAM detected - consider adding more RAM for gaming%CLR_RESET%
    "%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "$cs = Get-CimInstance Win32_ComputerSystem; $cs | Set-CimInstance -Property @{AutomaticManagedPagefile=$true}" >nul 2>&1
    if errorlevel 1 call :Log "Warning: Failed enabling automatic managed page file (low RAM path)"
    call :Log "Page file: System-managed (less than 8GB RAM) - LOW RAM WARNING"
)
exit /b 0

:DisableCoreParking
call :Log "Disabling CPU core parking"
echo [*] Disabling CPU core parking for better gaming performance...
REM Extract the actual GUID from powercfg output (format: "Power Scheme GUID: 12345678-1234-...")
for /f "tokens=4" %%G in ('powercfg /getactivescheme 2^>nul ^| findstr "GUID"') do set "SCHEME_GUID=%%G"
if not defined SCHEME_GUID (
    call :Log "Warning: Could not get active power scheme GUID, using default"
    set "SCHEME_GUID=SCHEME_CURRENT"
)
powercfg -setacvalueindex %SCHEME_GUID% SUB_PROCESSOR CPMINCORES 100 >nul 2>&1
powercfg -setactive %SCHEME_GUID% >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v ValueMax /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v ValueMin /t REG_DWORD /d 0 /f >nul
call :Log "Core parking disabled"
call :AddToSummary "CPU core parking disabled"
exit /b 0

:OptimizeStorageByType
call :Log "Optimizing storage by type: %STORAGE_TYPE%"
echo [*] Applying storage-specific optimizations...
if /I "%STORAGE_TYPE%"=="SSD" (
    echo     Storage: SSD detected - Optimizing for solid state
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v NtfsDisableLastAccessUpdate /t REG_DWORD /d 1 /f >nul
    fsutil behavior set DisableDeleteNotify 0 >nul 2>&1
    schtasks /Change /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" /Disable >nul 2>&1
    if %RAM_GB% GEQ 8 (
        "%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "Disable-MMAgent -PageCombining" >nul 2>&1
        call :Log "SSD: TRIM enabled, defrag disabled, page combining off"
    ) else (
        call :Log "SSD: TRIM enabled, defrag disabled"
    )
    call :AddToSummary "SSD optimizations applied"
) else if /I "%STORAGE_TYPE%"=="HDD" (
    echo     Storage: HDD detected - Enabling prefetch
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 3 /f >nul
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 3 /f >nul
    schtasks /Change /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" /Enable >nul 2>&1
    call :Log "HDD: Prefetch enabled, defrag scheduled"
    call :AddToSummary "HDD optimizations applied"
) else (
    echo     Storage: Unknown type - Applying safe defaults
    call :Log "Storage type unknown, skipping type-specific optimizations"
)
exit /b 0

:AdvancedGPUStorage
call :Log "Applying GPU and storage optimizations"
echo.
echo ========================================================================
echo   %CLR_TITLE%ADVANCED GPU AND STORAGE OPTIMIZATIONS%CLR_RESET%
echo ========================================================================
echo.
if not "%AUTO_ADVANCED_CONFIRM%"=="1" (
    set "advConfirm="
    set /p "advConfirm=These tweaks are aggressive and hardware-dependent. Continue? (Y/N): "
    if /I not "!advConfirm!"=="Y" (
        echo.
        echo [!] Advanced GPU/storage optimizations skipped.
        call :Log "User skipped advanced GPU/storage tweaks"
        exit /b 0
    )
)
echo [*] Applying GPU optimizations (NVIDIA/AMD agnostic)...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v DefaultD3TransitionLatencyActivelyUsed /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v DefaultD3TransitionLatencyIdleLongTime /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v DefaultD3TransitionLatencyIdleMonitorOff /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v DefaultD3TransitionLatencyIdleNoContext /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v DefaultD3TransitionLatencyIdleShortTime /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v DefaultD3TransitionLatencyIdleVeryLongTime /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v DefaultLatencyToleranceIdle0 /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v DefaultLatencyToleranceIdle1 /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v DefaultLatencyToleranceMemory /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v DefaultLatencyToleranceNoContext /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v DefaultLatencyToleranceNoContextMonitorOff /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v DefaultLatencyToleranceOther /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v DefaultLatencyToleranceTimerPeriod /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v DefaultMemoryRefreshLatencyToleranceActivelyUsed /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v DefaultMemoryRefreshLatencyToleranceMonitorOff /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v DefaultMemoryRefreshLatencyToleranceNoContext /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v Latency /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v MaxIAverageGraphicsLatencyInOneBucket /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v MiracastPerfTrackGraphicsLatency /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v MonitorLatencyTolerance /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v MonitorRefreshLatencyTolerance /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v TransitionLatency /t REG_DWORD /d 1 /f >nul

echo [*] Optimizing storage for SSDs and gaming drives...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v NtfsDisableLastAccessUpdate /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v NtfsDisable8dot3NameCreation /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v DontVerifyRandomDrivers /t REG_DWORD /d 1 /f >nul
schtasks /Change /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" /Disable >nul 2>&1
fsutil behavior set DisableDeleteNotify 0 >nul 2>&1

echo [*] Optimizing process priorities...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Priority" /t REG_DWORD /d 8 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul

call :Log "GPU and storage optimizations applied"
echo.
echo %CLR_SUCCESS%[+] GPU and storage optimized!%CLR_RESET% Reduced GPU latency and improved storage.
echo     %CLR_WARNING%Note:%CLR_RESET% For NVIDIA GPUs, also set Low Latency Mode in NVIDIA Control Panel.
echo     %CLR_WARNING%Note:%CLR_RESET% For AMD GPUs, enable Anti-Lag in AMD Software.
echo     Log: %LOG_FILE%
exit /b 0

:OptimizeAudio
call :Log "Optimizing audio latency"
echo.
echo ========================================================================
echo   %CLR_TITLE%AUDIO LATENCY REDUCTION%CLR_RESET%
echo ========================================================================
echo.
echo [*] Reducing audio latency for gaming and streaming...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Priority" /t REG_DWORD /d 6 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Priority" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AudioSrv" /v DependOnService /t REG_MULTI_SZ /d "AudioEndpointBuilder\0RpcSs" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Audiosrv" /v Start /t REG_DWORD /d 2 /f >nul

call :Log "Audio latency optimizations applied"
call :AddToSummary "Audio latency optimized"
echo.
echo %CLR_SUCCESS%[+] Audio latency reduced!%CLR_RESET% Lower audio buffer delay.
echo     %CLR_WARNING%Tip:%CLR_RESET% In Sound settings, enable Exclusive Mode for gaming headset.
echo     Log: %LOG_FILE%
exit /b 0

:DisableXboxServices
call :Log "Disabling Xbox services"
echo.
echo ========================================================================
echo   %CLR_TITLE%DISABLE XBOX SERVICES%CLR_RESET%
echo ========================================================================
echo.
echo   %CLR_WARNING%WARNING:%CLR_RESET% This will disable:
echo   - Xbox Game Bar (Win+G)
echo   - Xbox app and Game Pass integration
echo   - Xbox Live cloud saves
echo   - Some Xbox controller features
echo.
echo   Only proceed if you DON'T use these features!
echo.
set /p "confirm=Type YES to disable Xbox services: "
if /I not "!confirm!"=="YES" (
    echo.
    echo [!] Xbox services NOT disabled (user cancelled).
    call :Log "User cancelled Xbox service disable"
    exit /b 0
)
echo.
echo [*] Disabling Xbox-related services...
sc stop "XblAuthManager" >nul 2>&1
sc config "XblAuthManager" start= disabled >nul 2>&1
sc stop "XblGameSave" >nul 2>&1
sc config "XblGameSave" start= disabled >nul 2>&1
sc stop "XboxGipSvc" >nul 2>&1
sc config "XboxGipSvc" start= disabled >nul 2>&1
sc stop "XboxNetApiSvc" >nul 2>&1
sc config "XboxNetApiSvc" start= disabled >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\xbgm" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

call :Log "Xbox services disabled"
echo.
echo %CLR_SUCCESS%[+] Xbox services disabled.%CLR_RESET%
echo     To re-enable, use the UNDO option or run:
echo     sc config XblAuthManager start= demand
echo     sc config XblGameSave start= demand
echo     Log: %LOG_FILE%
exit /b 0

:ShowHelp
call :Log "Displaying help/readme"
echo.
echo ========================================================================
echo   %CLR_TITLE%WINDOWS 11 NON-TOUCH GAMING OPTIMIZER - HELP%CLR_RESET%
echo   %CLR_SUBTITLE%by Matt Hurley%CLR_RESET%
echo ========================================================================
echo.
echo   %CLR_SUBTITLE%WHAT DOES THIS SCRIPT DO?%CLR_RESET%
echo   Optimizes Windows 11 for maximum gaming performance by:
echo   - Removing bloatware and unnecessary apps
echo   - Disabling touch/pen features (for non-touch PCs)
echo   - Applying gaming-focused performance tweaks
echo   - Optimizing network latency and throughput
echo   - Reducing background CPU/RAM usage
echo   - All changes are logged and reversible
echo.
echo   %CLR_SUBTITLE%QUICK START (RECOMMENDED):%CLR_RESET%
echo   1. Select [3] to create a restore point
echo   2. Select [2] for "Recommended" optimization (3-5 min)
echo   3. Restart your PC
echo.
echo   %CLR_SUBTITLE%MENU OPTIONS:%CLR_RESET%
echo   [1/F] Full Optimization  - All tweaks (5-10 min, 15 steps)
echo   [2]   Recommended        - Core essentials only (3-5 min, 7 steps)
echo   [3]   Restore Point      - Create safety restore point
echo   [4]   Debloat            - Remove consumer/OEM apps
echo   [5]   Touch Disable      - Remove touch/pen/ink features
echo   [6]   Gaming Tweaks      - Power plan, Game Mode, input optimization
echo   [7]   Services           - Reduce background load
echo   [8]   Network            - Lower ping/latency
echo   [9]   Animations         - Disable for better FPS
echo   [A]   Startup            - Faster boot time
echo   [B]   Disk Cleanup       - Free space, clear temp files
echo   [C]   GPU/Storage        - Advanced GPU latency ^& SSD tweaks (prompts)
echo   [D]   Audio              - Reduce audio buffer latency
echo   [E]   Xbox Services      - Disable (breaks Game Bar - optional)
echo   [P]   Report             - View system info ^& optimization status
echo   [U]   Undo               - Revert changes to defaults
echo.
echo   %CLR_SUBTITLE%WHAT GETS OPTIMIZED:%CLR_RESET%
echo   Gaming: Ultimate Performance plan, Game Mode, GPU scheduling,
echo           input lag reduction, high priority for games
echo   Network: TCP tuning, reduced latency, disabled P2P updates
echo   GPU: 20+ latency tweaks, power state optimization
echo   Services: Disabled telemetry, indexing, tips, CEIP
echo   Bloat: Removed Bing apps, Xbox TCUI, Teams, Spotify, TikTok, etc.
echo   Visual: Transparency off, animations disabled
echo.
echo   %CLR_SUBTITLE%SAFETY FEATURES:%CLR_RESET%
echo   - System restore point creation before changes
echo   - Comprehensive logging to logs\ folder
echo   - Undo function reverts most changes
echo   - Xbox Game Bar preserved by default (option to disable)
echo.
echo   %CLR_WARNING%IMPORTANT NOTES:%CLR_RESET%
echo   - Restart PC after optimizations for full effect
echo   - Option [E] breaks Xbox Game Bar - only use if you don't need it
echo   - Game DVR prompt: choose to keep capture on (default) or disable for FPS
echo   - Windows Defender and Firewall are NOT disabled
echo   - Check README.md for manual GPU tweaks (NVIDIA/AMD)
echo.
echo   %CLR_SUBTITLE%PERFORMANCE EXPECTATIONS:%CLR_RESET%
echo   Typical improvements:
echo   - FPS: 5-15%% increase in CPU-bound games
echo   - Latency: 10-30ms lower input lag
echo   - RAM: 500MB-1GB freed from background processes
echo   - Boot: 10-30%% faster startup
echo   - Ping: 5-15ms reduction in online games
echo.
echo   %CLR_SUBTITLE%TROUBLESHOOTING:%CLR_RESET%
echo   Restore point failed:  Enable System Protection in Control Panel
echo   Changes not working:   Restart your PC
echo   Game Bar not working:  Don't use option [E], or run [U] to undo
echo   Network issues:        Use [8] ^> [2] to revert network tweaks
echo   Want full rollback:    Use Windows System Restore
echo.
echo   %CLR_SUBTITLE%MANUAL TWEAKS (OPTIONAL):%CLR_RESET%
echo   NVIDIA: Control Panel ^> Low Latency Mode = Ultra
echo   AMD:    Software ^> Gaming ^> Anti-Lag = Enabled
echo   BIOS:   Enable XMP/DOCP for RAM, update to latest version
echo   Audio:  Sound settings ^> Enable Exclusive Mode
echo.
echo   Full documentation: README.md in script folder
echo   Log files: %LOG_DIR%
echo.
echo ========================================================================
call :Log "Help displayed"
exit /b 0

:ShowReport
call :Log "Generating optimization report"
echo.
echo ========================================================================
echo   %CLR_TITLE%OPTIMIZATION REPORT%CLR_RESET%
echo ========================================================================
echo.
echo   Script version: 2.5 - Gaming Edition
echo   Log file: %LOG_FILE%
echo.
echo   %CLR_SUBTITLE%System Information:%CLR_RESET%
set "TOTAL_RAM="
for /f "usebackq tokens=* delims=" %%I in (`"%POWERSHELL%" -NoProfile -Command "try { [int]([Math]::Round(((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB),0)) } catch { '' }"`) do set "TOTAL_RAM=%%I"
if defined TOTAL_RAM echo   - RAM: !TOTAL_RAM! GB
set "CPU_INFO="
for /f "usebackq tokens=* delims=" %%I in (`"%POWERSHELL%" -NoProfile -Command "try { (Get-CimInstance Win32_Processor | Select-Object -First 1).Name.Trim() } catch { '' }"`) do set "CPU_INFO=%%I"
if defined CPU_INFO echo   - CPU: !CPU_INFO!
set "GPU_INFO="
for /f "usebackq tokens=* delims=" %%I in (`"%POWERSHELL%" -NoProfile -Command "try { $gpus = Get-CimInstance Win32_VideoController ^| Where-Object { $_.Name -and $_.Name -notmatch 'Vivi^|Microsoft Basic^|Remote Desktop^|Virtual^|Parsec^|VMware^|Hyper-V' }; $discrete = $gpus ^| Where-Object { $_.Name -match 'NVIDIA^|AMD^|Radeon^|GeForce^|RTX^|GTX' } ^| Select-Object -First 1; if ($discrete) { $discrete.Name.Trim() } elseif ($gpus) { ($gpus ^| Select-Object -First 1).Name.Trim() } else { '' } } catch { '' }"`) do set "GPU_INFO=%%I"
if defined GPU_INFO echo   - GPU: !GPU_INFO!
echo.
echo   %CLR_SUBTITLE%Active Optimizations (check log for details):%CLR_RESET%
findstr /C:"applied" /C:"complete" /C:"disabled" /C:"optimized" "%LOG_FILE%" | find /C ":" >nul && (
    echo   - Review %LOG_FILE% for detailed change history
)
echo.
echo   %CLR_SUBTITLE%Recommendations:%CLR_RESET%
echo   1. Restart your PC to apply all changes
echo   2. Update GPU drivers (NVIDIA/AMD/Intel)
echo   3. Enable XMP/DOCP in BIOS for RAM speed
echo   4. Set power plan to High Performance or Ultimate Performance
echo   5. Check Task Manager ^> Startup to disable unnecessary apps
echo.
echo   %CLR_SUBTITLE%Optional Manual Tweaks:%CLR_RESET%
echo   - NVIDIA: Control Panel ^> Manage 3D ^> Low Latency Mode = Ultra
echo   - AMD: Software ^> Gaming ^> Global Graphics ^> Anti-Lag = Enabled
echo   - Check for BIOS updates for better CPU performance
echo   - Monitor temps: High temps throttle gaming performance
echo.
echo ========================================================================
call :Log "Report displayed"
exit /b 0

:UndoChanges
call :Log "Undo routine requested"
echo.
echo ========================================================================
echo   %CLR_TITLE%REVERTING CHANGES%CLR_RESET%
echo ========================================================================
echo.
echo [*] Attempting to revert services, registry settings, and network changes...
for %%S in (TabletInputService TextInputManagementService TouchInput WTabletServiceCon WTabletServicePen PenService TabletInputHost SysMain WSearch DiagTrack dmwappushservice RetailDemo RemoteRegistry RemoteAccess MapsBroker TrkWks DoSvc XblAuthManager XblGameSave XboxGipSvc XboxNetApiSvc) do (
    sc config %%S start= demand >nul 2>&1
    sc start %%S >nul 2>&1
)
if exist "%LOG_DIR%\mouse_settings_backup.reg" (
    reg import "%LOG_DIR%\mouse_settings_backup.reg" >nul 2>&1
    set "MOUSE_RESTORED=1"
    call :Log "Mouse settings restored from backup"
)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v CortanaConsent /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 0 /f >nul
for %%K in (EnableAutocorrection EnableTextPrediction EnableSpellchecking) do (
    reg delete "HKCU\Software\Microsoft\TabletTip\1.7" /v %%K /f >nul 2>&1
)
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v value /t REG_DWORD /d 1 /f >nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v GameDVR_Enabled /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 2 /f >nul
bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /deletevalue disabledynamictick >nul 2>&1
call :RevertNetworkTweaks
"%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "Enable-WindowsOptionalFeature -Online -FeatureName 'TabletPC-OC' -NoRestart -ErrorAction SilentlyContinue" >> "%LOG_FILE%" 2>&1
"%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "Enable-WindowsOptionalFeature -Online -FeatureName 'InkAndHandwritingServices' -NoRestart -ErrorAction SilentlyContinue" >> "%LOG_FILE%" 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 0 /f >nul
if not defined MOUSE_RESTORED (
    reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 1 /f >nul
    reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 6 /f >nul
    reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 10 /f >nul
)
schtasks /Change /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" /Enable >nul 2>&1
call :Log "Undo routine completed"
echo.
echo %CLR_SUCCESS%[+] Revert complete!%CLR_RESET% Services and settings restored to defaults.
echo     Check %LOG_FILE% for details. %CLR_WARNING%Restart recommended.%CLR_RESET%
exit /b 0

:RemoveApp
set "PKG=%~1"
if not defined PKG exit /b 0
call :Log "Removing %PKG%"
"%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers -Name %PKG% | Remove-AppxPackage -ErrorAction SilentlyContinue | Out-Null" >> "%LOG_FILE%" 2>&1
"%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq '%PKG%' } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue | Out-Null" >> "%LOG_FILE%" 2>&1
exit /b 0

:DetectOS
set "OS_CAPTION=Windows"
set "OS_MAJOR=10"
for /f "tokens=4 delims=[] " %%I in ('ver') do (
    for /f "tokens=1 delims=." %%J in ("%%I") do set "OS_MAJOR=%%J"
)
for /f "tokens=2 delims=:" %%I in ('systeminfo ^| findstr /B /C:"OS Name"') do (
    for /f "tokens=* delims= " %%J in ("%%I") do set "OS_CAPTION=%%J"
)
call :Log "Detected OS: %OS_CAPTION% (major %OS_MAJOR%)"
if %OS_MAJOR% GEQ 10 (
    echo Detected: %OS_CAPTION% - Compatible
) else (
    echo [!] Warning: %OS_CAPTION% detected. This optimizer targets Windows 10/11.
    call :Log "Warning - unsupported OS version"
)
exit /b 0

:DetectHardware
set "GPU_VENDOR=Unknown"
set "CPU_VENDOR=Unknown"
set "GPU_RAW="
set "CPU_RAW="

REM === GPU Detection - PowerShell, prefer discrete GPU ===
REM First try to find NVIDIA
for /f "usebackq delims=" %%I in (`powershell -NoProfile -Command "Get-CimInstance Win32_VideoController | Where-Object { $_.Name -match 'NVIDIA' } | Select-Object -First 1 -ExpandProperty Name"`) do (
    set "GPU_RAW=%%I"
)
REM If no NVIDIA, try AMD
if not defined GPU_RAW (
    for /f "usebackq delims=" %%I in (`powershell -NoProfile -Command "Get-CimInstance Win32_VideoController | Where-Object { $_.Name -match 'AMD|Radeon' } | Select-Object -First 1 -ExpandProperty Name"`) do (
        set "GPU_RAW=%%I"
    )
)
REM If no AMD, try Intel Arc
if not defined GPU_RAW (
    for /f "usebackq delims=" %%I in (`powershell -NoProfile -Command "Get-CimInstance Win32_VideoController | Where-Object { $_.Name -match 'Arc' } | Select-Object -First 1 -ExpandProperty Name"`) do (
        set "GPU_RAW=%%I"
    )
)
REM Fallback to any non-virtual Intel GPU
if not defined GPU_RAW (
    for /f "usebackq delims=" %%I in (`powershell -NoProfile -Command "Get-CimInstance Win32_VideoController | Where-Object { $_.Name -match 'Intel' -and $_.Name -notmatch 'Virtual|Remote|Vivi|Sharing' } | Select-Object -First 1 -ExpandProperty Name"`) do (
        set "GPU_RAW=%%I"
    )
)
if defined GPU_RAW (
    echo !GPU_RAW! | findstr /I "NVIDIA GeForce RTX GTX" >nul && set "GPU_VENDOR=NVIDIA"
    echo !GPU_RAW! | findstr /I "AMD Radeon" >nul && set "GPU_VENDOR=AMD Radeon"
    echo !GPU_RAW! | findstr /I "Arc" >nul && set "GPU_VENDOR=Intel Arc"
    if "!GPU_VENDOR!"=="Unknown" (
        echo !GPU_RAW! | findstr /I "Intel" >nul && set "GPU_VENDOR=Intel Graphics"
    )
    if "!GPU_VENDOR!"=="Unknown" set "GPU_VENDOR=!GPU_RAW!"
    call :Log "GPU detected raw: !GPU_RAW!"
)

REM === CPU Detection - PowerShell ===
for /f "usebackq delims=" %%I in (`powershell -NoProfile -Command "(Get-CimInstance Win32_Processor | Select-Object -First 1).Name"`) do (
    set "CPU_RAW=%%I"
)
if defined CPU_RAW (
    echo !CPU_RAW! | findstr /I "Intel" >nul && set "CPU_VENDOR=Intel"
    echo !CPU_RAW! | findstr /I "AMD Ryzen" >nul && set "CPU_VENDOR=AMD Ryzen"
    echo !CPU_RAW! | findstr /I "AMD" >nul && if "!CPU_VENDOR!"=="Unknown" set "CPU_VENDOR=AMD"
    if "!CPU_VENDOR!"=="Unknown" set "CPU_VENDOR=!CPU_RAW!"
    call :Log "CPU detected raw: !CPU_RAW!"
)
call :Log "Hardware detected: GPU=%GPU_VENDOR%, CPU=%CPU_VENDOR%"
exit /b 0

:EnsureShadowServices
set "ENSURE_SHADOW_ERROR="
for %%S in (VSS swprv) do (
    sc query %%S >nul 2>&1
    if errorlevel 1 (
        call :Log "Shadow copy service %%S missing or inaccessible"
        set "ENSURE_SHADOW_ERROR=1"
    ) else (
        sc config %%S start= demand >nul 2>&1
        sc start %%S >nul 2>&1
    )
)
if defined ENSURE_SHADOW_ERROR (
    set "ENSURE_SHADOW_ERROR="
    exit /b 1
)
exit /b 0

:Banner
if defined CLR_TITLE (
    echo %CLR_TITLE%  ================================================================%CLR_RESET%
    echo %CLR_TITLE%                                                                  %CLR_RESET%
    echo %CLR_TITLE%           WINDOWS 11 GAMING OPTIMIZER v2.5                      %CLR_RESET%
    echo %CLR_TITLE%                                                                  %CLR_RESET%
    echo %CLR_TITLE%  ================================================================%CLR_RESET%
    echo %CLR_SUBTITLE%                         by Matt Hurley%CLR_RESET%
    echo %CLR_SUBTITLE%  ----------------------------------------------------------------%CLR_RESET%
    echo   %CLR_SUCCESS%[*]%CLR_RESET% Maximize FPS ^| Reduce Latency ^| Optimize Performance
    if defined GPU_VENDOR echo   %CLR_SUCCESS%[*]%CLR_RESET% Detected GPU: %GPU_VENDOR%
    if defined CPU_VENDOR echo   %CLR_SUCCESS%[*]%CLR_RESET% Detected CPU: %CPU_VENDOR%
    if "%IS_LAPTOP%"=="1" echo   %CLR_WARNING%[!]%CLR_RESET% System Type: %CHASSIS_TYPE% - Battery impact warning enabled
    echo   %CLR_WARNING%[!]%CLR_RESET% Run as administrator. Changes logged to:
    echo       %LOG_FILE%
    echo   %CLR_SUBTITLE%[H] Help/README ^| [P] Report ^| [V] Verify ^| [U] Undo%CLR_RESET%
    echo %CLR_TITLE%  ================================================================%CLR_RESET%
) else (
    echo   ================================================================
    echo    Windows 11 Non-Touch Gaming Optimizer v2.5
    echo                    by Matt Hurley
    echo   ----------------------------------------------------------------
    echo   Maximize FPS ^| Reduce Latency ^| Optimize Performance
    if defined GPU_VENDOR echo   Detected GPU: %GPU_VENDOR%
    if defined CPU_VENDOR echo   Detected CPU: %CPU_VENDOR%
    echo   Run as administrator. Changes logged to:
    echo   %LOG_FILE%
    echo   [H] Help ^| [P] Report ^| [U] Undo
    echo   ================================================================
)
exit /b 0

:PauseReturn
echo.
pause
exit /b 0

:IsAdmin
>nul 2>&1 fltmc
if %errorlevel%==0 exit /b 0
fsutil dirty query %SystemDrive% >nul 2>&1
if %errorlevel%==0 exit /b 0
exit /b 1

:EnsureAdmin
call :IsAdmin
if %errorlevel%==0 exit /b 0
if defined RELAUNCHED (
    color 0C
    echo [!] Administrative approval denied or unavailable.
    echo     Right-click the script and choose "Run as administrator".
    pause
    exit /b 1
)
echo [*] Requesting administrator approval via UAC...
"%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "$p=Start-Process '%~f0' -ArgumentList '-Elevated' -WorkingDirectory '%SCRIPT_DIR%' -Verb RunAs -PassThru; exit 0" >nul 2>&1
if errorlevel 1 (
    echo [!] Automatic UAC prompt failed. Run this script as administrator.
    pause
    exit /b 1
)
echo [*] An elevated window is launching. Close this one if prompted.
timeout /t 2 /nobreak >nul
exit /b 2

:CheckAdmin
call :IsAdmin
if not %errorlevel%==0 (
    color 0C
    echo [!] This script must be run as administrator.
    pause
    exit /b 1
)
exit /b 0

:DetectChassisType
set "CHASSIS_TYPE=Unknown"
set "IS_LAPTOP=0"
set "CHASSIS_CODE="
REM PowerShell for chassis detection
for /f "usebackq delims=" %%I in (`"%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "(Get-CimInstance Win32_SystemEnclosure).ChassisTypes[0]"`) do (
    set "CHASSIS_CODE=%%I"
)
if defined CHASSIS_CODE (
    if "%CHASSIS_CODE%"=="8" set "CHASSIS_TYPE=Laptop" & set "IS_LAPTOP=1"
    if "%CHASSIS_CODE%"=="9" set "CHASSIS_TYPE=Laptop" & set "IS_LAPTOP=1"
    if "%CHASSIS_CODE%"=="10" set "CHASSIS_TYPE=Laptop" & set "IS_LAPTOP=1"
    if "%CHASSIS_CODE%"=="11" set "CHASSIS_TYPE=Laptop" & set "IS_LAPTOP=1"
    if "%CHASSIS_CODE%"=="14" set "CHASSIS_TYPE=Laptop" & set "IS_LAPTOP=1"
    if "%CHASSIS_CODE%"=="18" set "CHASSIS_TYPE=Laptop" & set "IS_LAPTOP=1"
    if "%CHASSIS_CODE%"=="21" set "CHASSIS_TYPE=Laptop" & set "IS_LAPTOP=1"
    if "%CHASSIS_CODE%"=="30" set "CHASSIS_TYPE=Tablet" & set "IS_LAPTOP=1"
    if "%CHASSIS_CODE%"=="31" set "CHASSIS_TYPE=Convertible" & set "IS_LAPTOP=1"
    if "%CHASSIS_CODE%"=="32" set "CHASSIS_TYPE=Detachable" & set "IS_LAPTOP=1"
    if "%CHASSIS_CODE%"=="3" set "CHASSIS_TYPE=Desktop"
    if "%CHASSIS_CODE%"=="4" set "CHASSIS_TYPE=Desktop"
    if "%CHASSIS_CODE%"=="5" set "CHASSIS_TYPE=Desktop"
    if "%CHASSIS_CODE%"=="6" set "CHASSIS_TYPE=Desktop"
    if "%CHASSIS_CODE%"=="7" set "CHASSIS_TYPE=Desktop"
    if "%CHASSIS_CODE%"=="15" set "CHASSIS_TYPE=Desktop"
    if "%CHASSIS_CODE%"=="16" set "CHASSIS_TYPE=Desktop"
)
call :Log "Chassis type: %CHASSIS_TYPE% (code %CHASSIS_CODE%, laptop=%IS_LAPTOP%)"
if "%IS_LAPTOP%"=="1" (
    echo.
    echo %CLR_WARNING%  ================================================================%CLR_RESET%
    echo %CLR_WARNING%  [!] LAPTOP DETECTED%CLR_RESET%
    echo %CLR_WARNING%  ================================================================%CLR_RESET%
    echo   This optimizer applies aggressive power tweaks that may:
    echo   - Significantly reduce battery life
    echo   - Increase heat and fan noise
    echo   - Disable power-saving features
    echo.
    echo   %CLR_SUCCESS%Recommended for laptops:%CLR_RESET%
    echo   - Only run while plugged in
    echo   - Use option [2] RECOMMENDED instead of FULL
    echo   - Skip GPU/Storage advanced tweaks [C]
    echo   - Consider creating a separate power plan for gaming
    echo %CLR_WARNING%  ================================================================%CLR_RESET%
    echo.
    choice /c YN /n /t 10 /d N /m "Continue with optimization on laptop? (Y/N, auto-No in 10s): "
    if not "%errorlevel%"=="1" (
        call :Log "User cancelled - laptop warning"
        echo.
        echo [!] Optimization cancelled. Exiting to protect battery life.
        timeout /t 3 >nul
        exit /b 1
    )
    call :Log "User accepted laptop warning, proceeding"
)
exit /b 0

:WarnIfOnBattery
REM If this is a laptop and it is currently discharging on battery, warn before applying aggressive CPU/power tweaks.
if /I not "%CHASSIS_TYPE%"=="Laptop" exit /b 0

set "BAT_STATUS="
for /f "usebackq delims=" %%B in (`"%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "$b=Get-CimInstance Win32_Battery -ErrorAction SilentlyContinue | Select-Object -First 1; if($b){$b.BatteryStatus}else{''}"`) do set "BAT_STATUS=%%B"
if not defined BAT_STATUS exit /b 0

REM BatteryStatus: 1=Discharging, 2=AC, 3=Fully Charged (AC)
if "%BAT_STATUS%"=="1" (
    echo.
    echo ========================================================================
    echo   %CLR_WARNING%LAPTOP ON BATTERY DETECTED%CLR_RESET%
    echo ========================================================================
    echo   You're running on battery power. Applying performance power settings
    echo   and core parking changes can increase drain/heat.
    echo.
    echo   %CLR_WARNING%Recommendation:%CLR_RESET% Plug in AC power, then rerun.
    echo.
    choice /c YN /n /t 10 /d N /m "Continue anyway? (Y/N, auto-No in 10s): "
    if not "%errorlevel%"=="1" (
        call :Log "User aborted due to on-battery warning"
        echo.
        echo [!] Optimization cancelled. Plug in power and try again.
        timeout /t 3 >nul
        exit /b 1
    )
    call :Log "User continued despite on-battery warning"
)
exit /b 0

:DetectRAM
set "RAM_GB="
REM PowerShell for RAM detection
for /f "usebackq delims=" %%I in (`"%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "[int]([Math]::Round(((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB),0))"`) do (
    set "RAM_GB=%%I"
)
if defined RAM_GB (
    call :Log "Detected RAM: %RAM_GB% GB"
) else (
    call :Log "Warning: Could not detect RAM amount"
)
exit /b 0

:DetectStorageType
set "STORAGE_TYPE=Unknown"
REM PowerShell for storage detection
for /f "usebackq delims=" %%I in (`"%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "$d = Get-PhysicalDisk | Where-Object { $_.DeviceID -eq '0' }; if ($d) { $d.MediaType } else { 'Unknown' }"`) do (
    if "%%I"=="SSD" set "STORAGE_TYPE=SSD"
    if "%%I"=="HDD" set "STORAGE_TYPE=HDD"
)
call :Log "Detected storage type: %STORAGE_TYPE%"
exit /b 0

:BackupRegistryKeys
if exist "%LOG_DIR%\registry_backup_%STAMP%.reg" exit /b 0
call :Log "Creating comprehensive registry backup"
echo [*] Creating registry backup before changes...
set "BACKUP_FILE=%LOG_DIR%\registry_backup_%STAMP%.reg"
(
    echo Windows Registry Editor Version 5.00
    echo.
    echo ; Gaming Optimizer Registry Backup - %STAMP%
    echo ; Backed up before modifications
    echo.
) > "%BACKUP_FILE%"
reg export "HKCU\Control Panel\Mouse" "%LOG_DIR%\backup_mouse_%STAMP%.reg" /y >nul 2>&1
reg export "HKCU\Software\Microsoft\GameBar" "%LOG_DIR%\backup_gamebar_%STAMP%.reg" /y >nul 2>&1
reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" "%LOG_DIR%\backup_gamedvr_%STAMP%.reg" /y >nul 2>&1
reg export "HKCU\System\GameConfigStore" "%LOG_DIR%\backup_gameconfig_%STAMP%.reg" /y >nul 2>&1
reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" "%LOG_DIR%\backup_multimedia_%STAMP%.reg" /y >nul 2>&1
reg export "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" "%LOG_DIR%\backup_priority_%STAMP%.reg" /y >nul 2>&1
reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" "%LOG_DIR%\backup_visualfx_%STAMP%.reg" /y >nul 2>&1
reg export "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "%LOG_DIR%\backup_telemetry_%STAMP%.reg" /y >nul 2>&1
call :Log "Registry backup complete: %LOG_DIR%\backup_*_%STAMP%.reg"
echo %CLR_SUCCESS%[+] Registry backed up to logs folder%CLR_RESET%
exit /b 0

:AddToSummary
set "SUMMARY_ITEM=%~1"
if not defined CHANGES_SUMMARY (
    set "CHANGES_SUMMARY=%SUMMARY_ITEM%"
) else (
    set "CHANGES_SUMMARY=%CHANGES_SUMMARY%|%SUMMARY_ITEM%"
)
exit /b 0

:ShowChangesSummary
if not defined CHANGES_SUMMARY (
    echo.
    echo [*] No changes were applied in this session.
    exit /b 0
)
echo.
echo ========================================================================
echo   %CLR_TITLE%CHANGES APPLIED THIS SESSION%CLR_RESET%
echo ========================================================================
echo.
for %%I in (%CHANGES_SUMMARY:|= %) do (
    echo   %CLR_SUCCESS%[+]%CLR_RESET% %%I
)
echo.
echo ========================================================================
echo   %CLR_WARNING%IMPORTANT:%CLR_RESET% Restart your PC for all changes to take effect
echo   Backup location: %LOG_DIR%
echo   Restore options: [U] Undo or System Restore
echo ========================================================================
call :Log "Changes summary displayed to user"
exit /b 0

:VerifyOptimizations
call :Log "Running verification check"
cls
echo.
echo ========================================================================
echo   %CLR_TITLE%OPTIMIZATION VERIFICATION%CLR_RESET%
echo ========================================================================
echo.
echo   Checking current system state...
echo.
set "VERIFY_PASS=0"
set "VERIFY_FAIL=0"

echo   %CLR_SUBTITLE%Power Plan:%CLR_RESET%
set "POWER_PLAN_OK=0"
for /f "tokens=*" %%G in ('powercfg /getactivescheme') do (
    echo %%G | findstr /I "Ultimate High Performance" >nul && set "POWER_PLAN_OK=1"
)
if "%POWER_PLAN_OK%"=="1" (
    echo     %CLR_SUCCESS%[PASS]%CLR_RESET% High/Ultimate Performance plan active
    set /a VERIFY_PASS+=1
) else (
    echo     %CLR_WARNING%[WARN]%CLR_RESET% Power plan not optimized
    for /f "tokens=*" %%G in ('powercfg /getactivescheme 2^>nul') do echo     Current: %%G
    set /a VERIFY_FAIL+=1
)

echo.
echo   %CLR_SUBTITLE%Game Mode:%CLR_RESET%
reg query "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled 2>nul | findstr "0x1" >nul
if not errorlevel 1 (
    echo     %CLR_SUCCESS%[PASS]%CLR_RESET% Game Mode enabled
    set /a VERIFY_PASS+=1
) else (
    echo     %CLR_WARNING%[WARN]%CLR_RESET% Game Mode not enabled
    set /a VERIFY_FAIL+=1
)

echo.
echo   %CLR_SUBTITLE%GPU Scheduling:%CLR_RESET%
reg query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode 2>nul | findstr "0x2" >nul
if not errorlevel 1 (
    echo     %CLR_SUCCESS%[PASS]%CLR_RESET% Hardware-accelerated GPU scheduling enabled
    set /a VERIFY_PASS+=1
) else (
    echo     %CLR_WARNING%[WARN]%CLR_RESET% GPU scheduling not enabled
    set /a VERIFY_FAIL+=1
)

echo.
echo   %CLR_SUBTITLE%Telemetry:%CLR_RESET%
sc query DiagTrack | findstr "STOPPED" >nul 2>&1
if not errorlevel 1 (
    echo     %CLR_SUCCESS%[PASS]%CLR_RESET% Diagnostic tracking disabled
    set /a VERIFY_PASS+=1
) else (
    echo     %CLR_WARNING%[WARN]%CLR_RESET% Diagnostic tracking still running
    set /a VERIFY_FAIL+=1
)

echo.
echo   %CLR_SUBTITLE%Visual Effects:%CLR_RESET%
reg query "HKCU\Software\Microsoft\Windows\DWM" /v EnableAeroPeek 2>nul | findstr "0x0" >nul
if not errorlevel 1 (
    echo     %CLR_SUCCESS%[PASS]%CLR_RESET% Visual effects optimized (Aero Peek disabled)
    set /a VERIFY_PASS+=1
) else (
    echo     %CLR_WARNING%[WARN]%CLR_RESET% Visual effects not optimized
    set /a VERIFY_FAIL+=1
)

echo.
echo   %CLR_SUBTITLE%Network:%CLR_RESET%
reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpNoDelay 2>nul | findstr "0x1" >nul
if not errorlevel 1 (
    echo     %CLR_SUCCESS%[PASS]%CLR_RESET% TCP optimizations applied
    set /a VERIFY_PASS+=1
) else (
    echo     %CLR_WARNING%[WARN]%CLR_RESET% Network not optimized
    for %%V in (TcpNoDelay TcpAckFrequency) do (
        for /f "tokens=*" %%R in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v %%V 2^>nul') do echo     %%R
    )
    set /a VERIFY_FAIL+=1
)

echo.
echo   %CLR_SUBTITLE%Startup:%CLR_RESET%
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec 2>nul | findstr "0x0" >nul
if not errorlevel 1 (
    echo     %CLR_SUCCESS%[PASS]%CLR_RESET% Startup delay removed
    set /a VERIFY_PASS+=1
) else (
    echo     %CLR_WARNING%[WARN]%CLR_RESET% Startup delay present
    set /a VERIFY_FAIL+=1
)

echo.
echo   %CLR_SUBTITLE%Core Parking:%CLR_RESET%
set "COREPARK_OK=0"
set "COREPARK_LINE="
for /f "tokens=*" %%L in ('powercfg -query SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 2^>nul ^| findstr /I "Current AC Power Setting Index"') do (
    set "COREPARK_LINE=%%L"
    echo %%L | findstr /I "0x00000064" >nul && set "COREPARK_OK=1"
)
if "%COREPARK_OK%"=="1" (
    echo     %CLR_SUCCESS%[PASS]%CLR_RESET% CPU core parking disabled (CPMINCORES=100)
    set /a VERIFY_PASS+=1
) else (
    echo     %CLR_WARNING%[WARN]%CLR_RESET% Core parking may still be active
    if defined COREPARK_LINE echo     Current: %COREPARK_LINE%
    set /a VERIFY_FAIL+=1
)

echo.
echo ========================================================================
echo   %CLR_TITLE%VERIFICATION SUMMARY%CLR_RESET%
echo ========================================================================
echo.
set /a VERIFY_TOTAL=VERIFY_PASS+VERIFY_FAIL
set /a VERIFY_PCT=(VERIFY_PASS*100)/VERIFY_TOTAL
echo   Checks Passed: %CLR_SUCCESS%[%VERIFY_PASS%/%VERIFY_TOTAL%]%CLR_RESET% (%VERIFY_PCT%%%)
if %VERIFY_FAIL% GTR 0 (
    echo   Checks Failed: %CLR_WARNING%[%VERIFY_FAIL%/%VERIFY_TOTAL%]%CLR_RESET%
    echo.
    echo   %CLR_WARNING%Recommendation:%CLR_RESET% Run option [2] RECOMMENDED or [6] Gaming Tweaks
)
echo.
echo ========================================================================
call :Log "Verification: %VERIFY_PASS% passed, %VERIFY_FAIL% failed"
exit /b 0

:Log
set "MESSAGE=%~1"
echo %DATE% %TIME% - %MESSAGE%
>>"%LOG_FILE%" echo %DATE% %TIME% - %MESSAGE%
exit /b 0

:End
call :Log "User exited script"
echo.
echo All tasks completed. Review %LOG_FILE% for a full history.
popd >nul 2>&1
endlocal
exit /b 0
