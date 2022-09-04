@echo off
echo Administrative permissions required. Detecting permissions...

net session >nul 2>&1
if NOT %errorLevel% == 0 (
	echo Failure: Current permissions inadequate.
	pause >nul
	GOTO :EOF
) 

echo Success: Administrative permissions confirmed.


::main_start::
cd "%~dp0"

CALL :DELETESERVICE "Onedrive-hanyang"
CALL :DELETESERVICE "Onedrive-naver"
CALL :DELETESERVICE "Googledrive-hanyang"
CALL :DELETESERVICE "Googledrive-gmail"
CALL :DELETESERVICE "Dropbox-naver"

echo "Delete_Success"
pause >nul
GOTO :EOF

::main_end::


rem param1=<service_name>
:DELETESERVICE
IF [%~1]==[] GOTO:EOF
nssm.exe stop rclone-%~1

nssm.exe remove rclone-%~1 confirm
