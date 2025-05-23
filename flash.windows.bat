@echo off
:: params:
:: %1: config path 
:: %2: drive path
:: %3: image filepath
:: %4: wifi config file

set logfile=%1\flash-tool.log

echo START %date% %time% >> %logfile%
echo params=%1 %2 %3 %4 >> %logfile%

:: flash drive
%1\balena.exe local flash %3 --drive %2 --yes --unsupported
echo balena-cli returncode=%ERRORLEVEL% >> %logfile%
if %ERRORLEVEL% NEQ 0 ( echo END %date% %time% >> %logfile% & exit %ERRORLEVEL% )

:: no wifi config specified jump to end of script
if [%4] EQU [""] GOTO :END

:: force volume rescan
echo rescan > rescan.txt
diskpart /s rescan.txt
del rescan.txt
ping 127.0.0.1 -n 3 > nul

:: search for "boot" labeled volume
for /f %%D in ('wmic volume get DriveLetter^, Label ^| find "boot"') do set bootvolume=%%D
echo bootvolume=%bootvolume% >> %logfile%

:: copy wifi config to boot volume
echo > %bootvolume%\cleep-network.conf
copy "%4" %bootvolume%\cleep-network.conf >> %logfile%

:END
echo returncode=%ERRORLEVEL% >> %logfile%
echo END %date% %time% >> %logfile%
if %ERRORLEVEL% NEQ 0 ( exit %ERRORLEVEL% )
