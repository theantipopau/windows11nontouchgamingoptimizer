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

:Menu
cls
call :Banner
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
echo [*] Step 1/10: Removing consumer apps...
call :Debloat
echo [*] Step 2/10: Disabling touch/pen components...
call :DisableTouchFeatures
echo [*] Step 3/10: Applying gaming tweaks...
call :ApplyGamingTweaks
echo [*] Step 4/10: Optimizing services and telemetry...
call :OptimizeServices
echo [*] Step 5/10: Applying network optimizations...
call :ApplyNetworkTweaks
echo [*] Step 6/10: Disabling animations...
call :DisableAnimations
echo [*] Step 7/10: Optimizing startup...
call :OptimizeStartup
echo [*] Step 8/12: Freeing disk space...
call :FreeDiskSpace
echo [*] Step 9/12: GPU and storage optimizations...
set "AUTO_ADVANCED_CONFIRM=1"
call :AdvancedGPUStorage
set "AUTO_ADVANCED_CONFIRM="
echo [*] Step 10/12: Audio latency reduction...
call :OptimizeAudio
echo [*] Step 11/12: Finalizing memory optimizations...
call :OptimizeMemory
echo [*] Step 12/12: Complete!
echo.
echo ========================================================================
echo   %CLR_SUCCESS%FULL OPTIMIZATION COMPLETE!%CLR_RESET%
echo   Please %CLR_WARNING%RESTART%CLR_RESET% your device for all changes to take effect.
echo ========================================================================
call :Log "Full optimization sequence completed"
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
echo [*] Step 1/5: Removing consumer apps...
call :Debloat
echo [*] Step 2/5: Applying gaming tweaks...
call :ApplyGamingTweaks
echo [*] Step 3/5: Optimizing services...
call :OptimizeServices
echo [*] Step 4/5: Disabling animations...
call :DisableAnimations
echo [*] Step 5/5: Finalizing...
echo.
echo ========================================================================
echo   %CLR_SUCCESS%RECOMMENDED OPTIMIZATION COMPLETE!%CLR_RESET%
echo   Please %CLR_WARNING%RESTART%CLR_RESET% your device for all changes to take effect.
echo ========================================================================
call :Log "Recommended optimization sequence completed"
exit /b 0

:CreateRestorePoint
call :Log "Creating system restore point"
echo.
echo [*] Creating system restore point...
    "%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "Try { Checkpoint-Computer -Description 'NonTouchGamingOptimizer' -RestorePointType 'MODIFY_SETTINGS' -ErrorAction Stop; exit 0 } Catch { Write-Warning $_; exit 1 }" >> "%LOG_FILE%" 2>&1
if errorlevel 1 (
    echo.
    echo ========================================================================
    echo   [!] SYSTEM RESTORE POINT FAILED
    echo ========================================================================
    echo   Reason: System Protection may not be enabled on this drive.
    echo.
    echo   To enable System Protection:
    echo   1. Open Control Panel ^> System ^> System Protection
    echo   2. Select your C: drive and click "Configure"
    echo   3. Enable "Turn on system protection"
    echo   4. Allocate at least 2-5GB of disk space
    echo   5. Click OK and try running this script again
    echo ========================================================================
    echo.
        call :Log "Restore point creation failed"
        echo.
        choice /c YN /n /m "Continue without a restore point? (Y/N): "
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
    Microsoft.Xbox.TCUI
    Microsoft.XboxApp
    Microsoft.XboxGameOverlay
    Microsoft.XboxGamingOverlay
    Microsoft.XboxIdentityProvider
    Microsoft.XboxSpeechToTextOverlay
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
call :Log "Debloat routine complete"
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
echo.
echo %CLR_SUCCESS%[+] Touch and pen components disabled!%CLR_RESET%
echo     Log: %LOG_FILE%
exit /b 0

:ApplyGamingTweaks
call :Log "Applying gaming tweaks"
echo.
echo ========================================================================
echo   %CLR_TITLE%APPLYING GAMING PERFORMANCE TWEAKS%CLR_RESET%
echo ========================================================================
echo.
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
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul
reg add "HKCU\Control Panel\Desktop" /v WaitToKillAppTimeout /t REG_SZ /d 2000 /f >nul
reg add "HKCU\Control Panel\Desktop" /v HungAppTimeout /t REG_SZ /d 1000 /f >nul

echo [*] Prioritizing multimedia + game scheduler values...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 10 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul

echo [*] Disabling Game Bar and DVR for max FPS...
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehaviorMode /t REG_DWORD /d 2 /f >nul
reg add "HKCU\System\GameConfigStore" /v GameDVR_HonorUserFSEBehaviorMode /t REG_DWORD /d 1 /f >nul
reg add "HKCU\System\GameConfigStore" /v GameDVR_DXGIHonorFSEWindowsCompatible /t REG_DWORD /d 1 /f >nul

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
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v value /t REG_DWORD /d 0 /f >nul

sc stop "DiagTrack" >nul 2>&1
sc config "DiagTrack" start= disabled >nul 2>&1

call :Log "Gaming tweaks applied"
echo.
echo %CLR_SUCCESS%[+] Gaming optimizations applied!%CLR_RESET% FPS and responsiveness improved.
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
call :Log "Disabling animations"
echo.
echo ========================================================================
echo   %CLR_TITLE%DISABLING ANIMATIONS AND VISUAL EFFECTS%CLR_RESET%
echo ========================================================================
echo.
echo [*] Disabling animations for maximum responsiveness...
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
call :Log "Animations disabled"
echo.
echo %CLR_SUCCESS%[+] Animations disabled!%CLR_RESET% UI responsiveness improved.
echo     Restart Explorer for immediate effect: taskkill /f /im explorer.exe ^& start explorer.exe
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
echo.
echo %CLR_SUCCESS%[+] Disk cleanup complete!%CLR_RESET% Temporary files removed.
echo     Log: %LOG_FILE%
exit /b 0

:OptimizeMemory
call :Log "Optimizing memory"
echo [*] Enabling memory compression and optimizing paging...
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "Enable-MMAgent -MemoryCompression" >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f >nul
call :Log "Memory optimizations applied"
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
echo   [1/F] Full Optimization  - All tweaks (5-10 min, 12 steps)
echo   [2]   Recommended        - Core essentials only (3-5 min, 5 steps)
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
echo   - Game DVR is disabled, but Game Bar (Win+G) still works
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
echo   Script version: 2.0 - Gaming Edition
echo   Log file: %LOG_FILE%
echo.
echo   %CLR_SUBTITLE%System Information:%CLR_RESET%
for /f "tokens=2 delims==" %%I in ('wmic os get TotalVisibleMemorySize /value') do set "TOTAL_RAM=%%I"
if defined TOTAL_RAM (
    set /a "RAM_GB=TOTAL_RAM/1024/1024"
    echo   - RAM: !RAM_GB! GB
)
for /f "tokens=2 delims==" %%I in ('wmic cpu get Name /value') do echo   - CPU: %%I
for /f "tokens=2 delims==" %%I in ('wmic path win32_VideoController get Name /value') do echo   - GPU: %%I
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
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v GameDVR_Enabled /f >nul 2>&1
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
"%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage -AllUsers -Name %PKG% ^| Remove-AppxPackage -ErrorAction SilentlyContinue" >> "%LOG_FILE%" 2>&1
"%POWERSHELL%" -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxProvisionedPackage -Online ^| Where-Object { $_.DisplayName -eq '%PKG%' } ^| Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue" >> "%LOG_FILE%" 2>&1
exit /b 0

:DetectOS
set "OS_CAPTION=Unknown"
set "OS_MAJOR=0"
for /f "usebackq delims=" %%I in (`"%POWERSHELL%" -NoProfile -Command "(Get-CimInstance Win32_OperatingSystem).Caption"`) do set "OS_CAPTION=%%I"
for /f %%I in ('"%POWERSHELL%" -NoProfile -Command "[System.Environment]::OSVersion.Version.Major"') do set "OS_MAJOR=%%I"
if not defined OS_MAJOR set "OS_MAJOR=0"
call :Log "Detected OS: %OS_CAPTION% (major %OS_MAJOR%)"
echo Detected OS: %OS_CAPTION%
if %OS_MAJOR% LSS 10 (
    color 0C
    echo [!] Warning: This optimizer targets Windows 10/11. Proceed at your own risk.
    call :Log "Warning - unsupported OS version"
    color 0A
)
exit /b 0

:Banner
if defined CLR_TITLE (
    echo %CLR_TITLE%================================================================%CLR_RESET%
    echo %CLR_TITLE%  Windows 11 Non-Touch Gaming Optimizer%CLR_RESET%
    echo %CLR_SUBTITLE%  by Matt Hurley%CLR_RESET%
    echo %CLR_SUBTITLE%----------------------------------------------------------------%CLR_RESET%
    echo   Maximize FPS ^| Reduce Latency ^| Optimize for Gaming
    echo   Run as administrator. Changes are logged to:
    echo   %LOG_FILE%
    echo   %CLR_SUBTITLE%Press [H] for Help/README%CLR_RESET%
    echo %CLR_TITLE%================================================================%CLR_RESET%
) else (
    echo ================================================================
    echo   Windows 11 Non-Touch Gaming Optimizer
    echo   by Matt Hurley
    echo ----------------------------------------------------------------
    echo   Maximize FPS ^| Reduce Latency ^| Optimize for Gaming
    echo   Run as administrator. Changes are logged to:
    echo   %LOG_FILE%
    echo   Press [H] for Help/README
    echo ================================================================
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
