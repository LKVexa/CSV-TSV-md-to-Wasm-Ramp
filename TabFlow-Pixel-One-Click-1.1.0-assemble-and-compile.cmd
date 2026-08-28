@echo off
rem SPDX-License-Identifier: Apache-2.0
rem Copyright 2026 TabFlow Dream Bridge contributors
setlocal EnableExtensions DisableDelayedExpansion
cd /d "%~dp0"

set "TF_PART1=%CD%\TabFlow-Pixel-One-Click-1.1.0-equal-part-01.tfp"
set "TF_PART2=%CD%\TabFlow-Pixel-One-Click-1.1.0-equal-part-02.tfp"
set "TF_DEST=%CD%\TabFlow-1.1.0-build"
set "TF_ARCHIVE=%TF_DEST%\TabFlow-Pixel-One-Click-1.1.0-package.zip"
set "TF_ROOT=%TF_DEST%\TabFlow-Pixel-One-Click-1.1.0"

echo.
echo TabFlow Pixel One-Click 1.1.0 equal-parts compiler
echo ==================================================

for %%F in ("%TF_PART1%" "%TF_PART2%") do if not exist "%%~F" (
  echo ERROR: Missing equal part: %%~nxF
  exit /b 2
)

for %%F in ("%TF_PART1%" "%TF_PART2%") do if not "%%~zF"=="22616092" (
  echo ERROR: %%~nxF is not the expected 22,616,092 bytes.
  exit /b 3
)

call :sha256 "%TF_PART1%" TF_PART1_SHA
call :sha256 "%TF_PART2%" TF_PART2_SHA
if /I not "%TF_PART1_SHA%"=="5ab7427d41fb5ecf3175f8b4d1fbd1e5b6a5822675dba16619a87eaf55bd2a75" (
  echo ERROR: Part 01 failed SHA-256 verification.
  exit /b 4
)
if /I not "%TF_PART2_SHA%"=="65587a78d07acb41c1fb187056556ade334b52d517e406da5a5a550973bd50b1" (
  echo ERROR: Part 02 failed SHA-256 verification.
  exit /b 5
)

if not exist "%TF_DEST%" mkdir "%TF_DEST%"
echo [1/3] Reassembling the verified package...
copy /b /y "%TF_PART1%"+"%TF_PART2%" "%TF_ARCHIVE%" >nul
if errorlevel 1 exit /b 6

call :sha256 "%TF_ARCHIVE%" TF_ARCHIVE_SHA
if /I not "%TF_ARCHIVE_SHA%"=="24bca69865b9274dfa271b00e840717172dd2114b2dec4c220930cb5fecdcf34" (
  echo ERROR: The reassembled package failed SHA-256 verification.
  exit /b 7
)

where tar.exe >nul 2>nul
if errorlevel 1 (
  echo ERROR: Windows tar.exe was not found and the package cannot be extracted.
  exit /b 8
)

echo [2/3] Extracting source, components, license, and notice...
tar.exe -xf "%TF_ARCHIVE%" -C "%TF_DEST%"
if errorlevel 1 exit /b 9
if not exist "%TF_ROOT%\compile-one-click.cmd" (
  echo ERROR: The verified archive did not produce the expected compiler folder.
  exit /b 10
)

echo [3/3] Compiling TabFlow Pixel One-Click 1.1.0...
call "%TF_ROOT%\compile-one-click.cmd"
if errorlevel 1 exit /b 11

echo.
echo EQUAL-PARTS BUILD SUCCEEDED
echo %TF_ROOT%\dist\TabFlow-Pixel-Virtual-Program-One-Click-1.1.0.exe
echo.
exit /b 0

:sha256
set "TF_HASH_LINE="
for /f "skip=1 tokens=* delims=" %%H in ('certutil -hashfile "%~1" SHA256') do if not defined TF_HASH_LINE set "TF_HASH_LINE=%%H"
set "TF_HASH_LINE=%TF_HASH_LINE: =%"
set "%~2=%TF_HASH_LINE%"
exit /b 0
