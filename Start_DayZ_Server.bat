@echo off

:: If you don't have https://community.bistudio.com/wiki/DayZ:Server_Configuration open, you should :)

:: The full path to your DayZ Server folder (where you see "mpmissions" and "dta" folders)
set DayZ_Path=C:\DayZ_Server\
:: The name of the folder which logs and mod configuration files (if used) will be generated in
set Profiles=profiles
:: The full name of the DayZ Server executable (.exe)
set EXE_Name=DayZServer_x64.exe
:: The full name of the CFG file to use
set ServerCFG=serverDZ.cfg
:: The port number to be used as the game port (and direct connect port)
set GamePort=2302
:: CPUCores should be set to equal or less than what is available, check task manager
set CPUCores=2 
title DayZ Server

:loop
timeout 1 >nul
tasklist | find "%EXE_Name%" >nul
if %ERRORLEVEL% equ 1 (goto :check-again)
goto :loop

:: check-again might not be necessary, but my server did start twice at one point and after adding this it never happened again.
:check-again
timeout 1 >nul
tasklist | find "%EXE_Name%" >nul
if %ERRORLEVEL% equ 1 (goto :restart-dayzserver)
goto :loop

:restart-dayzserver
:: To add mods, use the line below. Using multiple mods (or servermods) should look like this (including the quotes): "-mod=%DayZ_Path%\Mod_1_Folder;%DayZ_Path%\Mod_2_Folder" 
start /HIGH "DayZ Server" /MIN "%DayZ_Path%\%EXE_Name%" "-config=%DayZ_Path%\%ServerCFG%" -port=%Game_Port% "-bePath=%DayZ_Path%\battleye" "-servermod=" "-mod=" -profiles=%Profiles% -cpuCount=%CPUCores% -doLogs -adminlog -freezecheck
echo (%time%) DayZServer started
goto :loop
