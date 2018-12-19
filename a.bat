@echo off
set BACKNAME=GKH%DATE:~3,2%%DATE:~0,2%.zip
set ARH=ARH
set zippatch=d:\Program Files\7-Zip\
echo backupname : %BACKNAME%


set lcl=%~dp0
For /D %%a In ("%lcl:~0,-1%.txt") Do Set lcl=%%~na
echo we are there %lcl%
echo zip here %ARH%\%BACKNAME%

"%zippatch%7z.exe" a %ARH%\%BACKNAME% *.*
"%zippatch%7z.exe" a %ARH%\%BACKNAME% WorkBase\*
::"%zippatch%7z.exe" a %ARH%\%BACKNAME% FBaseForms\*.*
::"%zippatch%7z.exe" a %ARH%\%BACKNAME% Frames\*.*
::"%zippatch%7z.exe" a %ARH%\%BACKNAME% InfoForms\*.*
::"%zippatch%7z.exe" a %ARH%\%BACKNAME% Menus\*.*
::"%zippatch%7z.exe" a %ARH%\%BACKNAME% Reestr\*.*
::"%zippatch%7z.exe" a %ARH%\%BACKNAME% System\*.*
::cd..
::"%zippatch%7z.exe" a  %lcl%\%ARH%\%BACKNAME% TermButtons\*.* 

exit