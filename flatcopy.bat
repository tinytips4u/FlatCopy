::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSjk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCiDJE2B51YMLklRAgGaOQs=
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal enabledelayedexpansion

:: --------------------------------------------
:: Parse arguments
:: Usage: flatcopy_counter.bat -src "C:\path\source" -dst "C:\path\destination"
:: --------------------------------------------

set "SRC="
set "DST="

:parse
if "%~1"=="" goto check_args
if /I "%~1"=="-src" (
    set "SRC=%~2"
    shift & shift & goto parse
)
if /I "%~1"=="-dst" (
    set "DST=%~2"
    shift & shift & goto parse
)
echo Unknown argument: %1
exit /b 1

:check_args
if "%SRC%"=="" (
    echo ERROR: Source folder not provided. Use: -src "path"
    exit /b 1
)
if "%DST%"=="" (
    echo ERROR: Destination folder not provided. Use: -dst "path"
    exit /b 1
)

:: Ensure destination folder exists
if not exist "%DST%" mkdir "%DST%"

echo Copying files from:
echo SRC = "%SRC%"
echo DST = "%DST%"
echo.

:: --------------------------------------------
:: Copy with numbered suffixes
:: --------------------------------------------
for /r "%SRC%" %%F in (*) do (
    set "name=%%~nF"
    set "ext=%%~xF"
    set "target=%DST%\!name!!ext!"

    :: If file exists, add suffix
    set "count=1"
    if exist "!target!" (
        :check_suffix
        set "target=%DST%\!name!_!count!!ext!"
        if exist "!target!" (
            set /a count+=1
            goto check_suffix
        )
    )

    echo Copying: %%~nxF  to  !target!
    copy "%%F" "!target!" >nul
)

echo.
echo All files copied successfully.
endlocal
exit /b 0
