@echo off
rem Bouwt eerst de hele Jabasoft-solution (incrementeel: een paar seconden als er niets veranderd is)
rem en start daarna de applicatie. Mislukt het bouwen, dan blijft dit venster open met de fouten
rem en wordt Jabasoft niet gestart.

set "SOLUTION=C:\Repos\Jabasoft.TheApp\Jabasoft.TheApp.slnx"
set "APP=C:\Repos\Jabasoft\Jabasoft.App\bin\Debug\net10.0-windows\Jabasoft.App.exe"

tasklist /FI "IMAGENAME eq Jabasoft.App.exe" 2>nul | find /I "Jabasoft.App.exe" >nul
if not errorlevel 1 (
    echo Jabasoft draait al - sluit die eerst als je de nieuwste code wilt starten.
    timeout /t 4 >nul
    exit /b 0
)

title Jabasoft - bouwen...
echo Jabasoft bouwen...
dotnet build "%SOLUTION%" --nologo -v quiet
if errorlevel 1 (
    echo.
    echo Bouwen mislukt - Jabasoft wordt niet gestart.
    pause
    exit /b 1
)

start "" "%APP%"
