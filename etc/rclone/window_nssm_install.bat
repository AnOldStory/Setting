@echo off
echo Administrative permissions required. Detecting permissions...

net session >nul 2>&1
if NOT %errorLevel% == 0 (
	echo Failure: Current permissions inadequate.
	pause >nul
	GOTO :EOF
)

echo Success: Administrative permissions confirmed.


::main::
cd "%~dp0"

CALL :MAKESERVICE "Onedrive-hanyang", "Z"
CALL :MAKESERVICE "Onedrive-naver", "X"

echo "Install_Success"
pause >nul
GOTO :EOF

::main_end::

rem param1=<service_name> param2=<drive number>
:MAKESERVICE
IF [%~1]==[] GOTO:EOF

nssm.exe install rclone-%~1 ^
%userprofile%\rclone\rclone.exe mount %~1:/ %~2: ^
--allow-other ^
--allow-non-empty ^
--fast-list ^
--drive-skip-gdocs ^
--poll-interval=15s ^
--vfs-cache-mode=full ^
--vfs-write-back=5s ^
--bwlimit-file=16M ^
--buffer-size=16M ^
--vfs-read-chunk-size=32M ^
--vfs-read-chunk-size-limit=2048M ^
--vfs-cache-max-size=1G ^
--vfs-cache-max-age=336h ^
--vfs-read-ahead=32M ^
--dir-cache-time=1000h ^
--log-level=INFO ^
--log-file="%userprofile%\rclone\rclone_mount.log" ^
--cache-dir=/volume1/cache ^
--timeout=1h ^
--config "%userprofile%\rclone\rclone.conf"

nssm.exe start rclone-%~1