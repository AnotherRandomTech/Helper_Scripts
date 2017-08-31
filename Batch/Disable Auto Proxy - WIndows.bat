@echo off
REM Script to disable Auto Network Proxy Settings. Also kills browsers if open.
REM Source: https://stackoverflow.com/questions/18439373/batch-file-to-disable-internet-options-proxy-server

echo "This will close all browsers, save any work before running."
echo "Click red close button in top right to cancel."
pause

echo "Disable Auto Proxy settings..."
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f

Taskkill /IM firefox.exe /F
Taskkill /IM chrome.exe /F
Taskkill /IM ie.exe /F

echo "Done"
