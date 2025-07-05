@echo off
echo Installing Google Chrome and Adobe Acrobat Reader...

:: Install Chrome and Adobe Acrobat Reader via winget
winget install --id Google.Chrome --accept-source-agreements --accept-package-agreements
winget install --id Adobe.Acrobat.Reader.64-bit --accept-source-agreements --accept-package-agreements

echo Configuring Windows Performance Settings...

:: Set custom visual effects settings
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f

:: Disable animations and fading effects
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012078010000000 /f
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 0 /f

:: Disable "Fade or slide menus into view"
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v EnableMenuAnimation /t REG_DWORD /d 0 /f

:: Disable "Fade or slide Tooltips into view"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v EnableToolTips /t REG_DWORD /d 0 /f

:: Disable "Fade out menu items after clicking"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v MenuAnimation /t REG_DWORD /d 0 /f

:: Disable "Show shadows under windows"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f

:: Disable "Show translucent selection rectangle"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f

echo Adjusting Power Settings...

:: Prevent system from sleeping (on AC power)
powercfg /change standby-timeout-ac 0

:: Set screen to turn off after 30 minutes (on AC power)
powercfg /change monitor-timeout-ac 30

:: Apply changes immediately
echo Applying changes...
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

echo Setup complete! A restart is recommended for all changes to take effect.
pause
