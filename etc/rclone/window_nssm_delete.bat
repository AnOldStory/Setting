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

CALL :DELETESERVICE "Onedrive-hanyang", "Z" 
CALL :DELETESERVICE "Onedrive-naver", "X"


echo "Delete_Success"
pause >nul
GOTO :EOF

::main_end::


rem param1=<service_name> param2=<drive number>
:DELETESERVICE
IF [%~1]==[] GOTO:EOF
nssm.exe stop rclone-%~1

nssm.exe remove rclone-%~1 confirm


pause >nul

