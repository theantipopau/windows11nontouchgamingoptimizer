@echo off
setlocal EnableDelayedExpansion
echo ============================================
echo   Hardware Detection Debug Tool
echo ============================================
echo.
echo Running as: %USERNAME%
echo.

echo === GPU Detection ===
echo --- WMIC VideoController ---
wmic path win32_VideoController get Name 2>&1
echo.
echo --- PowerShell GPU ---
powershell -NoProfile -Command "Get-CimInstance Win32_VideoController | Select-Object Name" 2>&1
echo.

echo === CPU Detection ===
echo --- WMIC CPU ---
wmic cpu get Name 2>&1
echo.
echo --- PowerShell CPU ---
powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Select-Object Name" 2>&1
echo.

echo === RAM Detection ===
echo --- WMIC RAM ---
wmic computersystem get TotalPhysicalMemory 2>&1
echo.

echo === Chassis Detection ===
echo --- WMIC Chassis ---
wmic systemenclosure get ChassisTypes 2>&1
echo.

echo === Storage Detection ===
echo --- WMIC DiskDrive ---
wmic diskdrive where "Index=0" get MediaType 2>&1
echo.

echo === Test for /f parsing ===
echo --- Testing WMIC parsing ---
for /f "tokens=2 delims==" %%I in ('wmic cpu get Name /value 2^>nul') do (
    if not "%%I"=="" echo Found CPU: [%%I]
)
echo.

echo ============================================
echo   Copy everything above and send to debug
echo ============================================
pause
