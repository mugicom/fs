@echo off
chcp 65001 & REM Türkçe karakterlerin düzgün çalışması için.
color b & REM Renklendirme
cls & REM Ekranı temizler.
net session > nul 2>&1 & REM Yönetici olarak çalıştırma kontrolü. 
if %errorlevel% == 2 (goto :EXIT) else (goto START:)
:START
winget > nul 2>&1 & REM Winget yüklü mü kontrolü.
if not %errorlevel% == 0 (goto :EXIT2) else (goto :formatsonrasi)
:formatsonrasi
PowerShell -ExecutionPolicy RemoteSigned -Command "Enable-ComputerRestore -Drive "C:"" & REM Sistem geri yüklemeyi aktif eder.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /t REG_DWORD /v ShowTaskViewButton /d 0 /f & REM Görev görünüm düğmesini gizler.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /t REG_DWORD /v ShowCortanaButton /d 0 /f & REM Cortanayı gizler.
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /t REG_DWORD /v SearchboxTaskbarMode /d 1 /f & REM Arama çubuğunu simge hâline getirir.
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /t REG_DWORD /v ShellFeedsTaskbarOpenOnHover /d 0 /f & REM Haberler ve ilgi alanlarında fareyi üzerine getirince açılmasını engeller.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /t REG_DWORD /v {20D04FE0-3AEA-1069-A2D8-08002B30309D} /d 0 /f & REM Masaüstüne Bu bilgisayar simgesini getirir.
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {59031a47-3f72-44a7-89c5-5595fe6b30ee} /t REG_DWORD /d 0 /f & REM Masaüstüne user klasörünü getirir.
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" /v {59031a47-3f72-44a7-89c5-5595fe6b30ee} /t REG_DWORD /d 0 /f & REM Masaüstüne user klasörünü getirir.
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f & REM Dozya gezginini Bu bilgisayar olarak başlatır.
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f & REM Dosya uzantılarını gösterir.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f & REM Anında Toplantıyı gizler.
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /v Flags /t REG_SZ /d 506 /f & REM Yapışkan tuşları kapatır.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "Allow Telemetry" /t REG_DWORD /d 0 /f & REM Telemetry kapatır.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft" /v LetAppsRunInBackground /t REG_DWORD /d 0 /f & REM Arka plan uygulamalarını kapatır.
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f & REM Arka plan uygulamalarını kapatır.
reg add "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_SZ /d 2 /f & REM Numlock varsayılan olarak açık kalır.
echo Görev çubuğu düzenlendi.
powercfg.exe /change monitor-timeout-ac 0 & REM Ekran kapanma süresini 0 yapar.
powercfg.exe /change standby-timeout-ac 0 & REM Uyku modunu kapatır.
echo Uyku ve ekran kapanması kapatıldı.
taskkill /f /im explorer.exe & REM Değişikliklerin görünmesi için explorerı kapatır.
start explorer.exe & REM Explorerı başlatır.
echo Gerekli programlar yükleniyor...
winget install winget --accept-source-agreements --accept-package-agreements
winget install --id=Google.Chrome -e -h
if %ERRORLEVEL% EQU 0 (Set colorc=Green && Set Chrome=Chrome başarıyla kuruldu!) Else (Set colorc=Red && Set Chrome=Chrome kurulamadı!)
winget install --id=RARLab.WinRAR -e -h
if %ERRORLEVEL% EQU 0 (Set colorw=Green && Set Winrar=WinRAR başarıyla kuruldu!) Else (Set colorw=Red && Set Winrar=WinRAR kurulamadı!)
winget install --id=VideoLAN.VLC -e -h
if %ERRORLEVEL% EQU 0 (Set colorv=Green && Set VLC=VLC başarıyla kuruldu!) Else (Set colorv=Red && Set VLC=VLC kurulamadı!)
winget install --id=Oracle.JavaRuntimeEnvironment -e -h
if %ERRORLEVEL% EQU 0 (Set colorj=Green && Set Java=Java başarıyla kuruldu!) Else (Set colorj=Red && Set Java=Java kurulamadı!)
winget install --id=Adobe.Acrobat.Reader.64-bit -e -h
if %ERRORLEVEL% EQU 0 (Set colora=Green && Set Acro=Acrobat Reader başarıyla kuruldu!) Else (Set colora=Red && Set Acro=Acrobat Reader kurulamadı!)
winget install --id=Valve.Steam -e -h
if %ERRORLEVEL% EQU 0 (Set colora=Green && Set steam=steam başarıyla kuruldu!) Else (Set colora=Red && Set steam=steam kurulamadı!)
winget install --id=Discord.Discord -e -h
if %ERRORLEVEL% EQU 0 (Set colora=Green && Set discord=discord başarıyla kuruldu!) Else (Set colora=Red && Set discord=discord kurulamadı!)
echo Gereksiz programlar kaldırılıyor...
winget uninstall Microsoft.SkypeApp_kzf8qxf38zg5c -h
winget uninstall Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe -h
winget uninstall Microsoft.MixedReality.Portal_8wekyb3d8bbwe -h
winget uninstall SpotifyAB.SpotifyMusic_zpdnekdrzrea0 -h
winget uninstall Microsoft.YourPhone_8wekyb3d8bbwe -h
winget uninstall Microsoft.549981C3F5F10_8wekyb3d8bbwe -h
winget uninstall Microsoft.BingFinance_8wekyb3d8bbwe -h
winget uninstall Microsoft.BingSports_8wekyb3d8bbwe -h
winget uninstall Microsoft.People_8wekyb3d8bbwe -h
winget uninstall Disney.37853FC22B2CE_6rarf9sa4v8jt -h
winget uninstall Microsoft.GetHelp_8wekyb3d8bbwe -h
winget uninstall Microsoft.Getstarted_8wekyb3d8bbwe -h
winget uninstall Microsoft.Wallet_8wekyb3d8bbwe -h
winget uninstall Microsoft.Office.OneNote_8wekyb3d8bbwe -h
winget uninstall Microsoft.WindowsFeedbackHub_8wekyb3d8bbwe -h
winget uninstall Microsoft.MicrosoftOfficeHub_8wekyb3d8bbwe -h
echo Gereksiz programları kaldırma işlemi tamamlandı.
echo -----------------------------------------------------
powershell -ExecutionPolicy ByPass -Command Write-Host -fore %colorc% %Chrome%
powershell -ExecutionPolicy ByPass -Command Write-Host -fore %colorw% %Winrar%
powershell -ExecutionPolicy ByPass -Command Write-Host -fore %colorv% %VLC%
powershell -ExecutionPolicy ByPass -Command Write-Host -fore %colorj% %Java%
powershell -ExecutionPolicy ByPass -Command Write-Host -fore %colora% %Acro%
powershell -ExecutionPolicy ByPass -Command Write-Host -fore %colora% %steam%
powershell -ExecutionPolicy ByPass -Command Write-Host -fore %colora% %discord%
cd "C:\Users\Public\Desktop\"
del vlc* /s /q
del Adob* /s /q
cd "%userprofile%\Desktop\"
del "Microsoft Edge.lnk" /s /q
pause
exit
:EXIT
echo -                                -
echo Yönetici olarak çalıştırmalısınız!
echo -                                -
ping 127.0.0.1 > nul
exit
:EXIT2
Echo winget kuruluyor...
powershell -ExecutionPolicy ByPass -Command "$ScriptFromGitHub=Invoke-WebRequest "https://raw.githubusercontent.com/GokhanTurk/FormatSonrasi.bat/main/SilentWinget.ps1" -UseBasicParsing;Invoke-Expression $($ScriptFromGitHub.Content)" & REM winget kurulumu yapan ps scripti çalıştırır.
goto :formatsonrasi