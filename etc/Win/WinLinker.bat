rem <Github - Cloud Linker>
rem Create a local storage shortcut on the cloud storage

%echo off 
set /p name=Input Folder Name : 

set ID="Your Account Name"
set GITHUB="Your Directory"

echo GitHubDir : https://github.com/%ID%/%name%
echo.

echo.
echo TargetDir : %GITHUB%\%name%
echo.

mkdir %name%

cd %name%

git clone https://github.com/%ID%/%name% %GITHUB%\%name%


echo [InternetShortcut] > %name%.URL
echo URL=https://github.com/%ID%/%name% >> %name%.URL
echo IconFile=http://www.google.com/favicon.ico >> %name%.URL
echo IconIndex=0 >> %name%.URL

echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "%name%.lnk" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "%GITHUB%\%name%" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs
cscript CreateShortcut.vbs
del CreateShortcut.vbs
