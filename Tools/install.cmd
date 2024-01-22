@echo off

@REM Notepad++/VSCODE needs current working directory to be where Caprica.exe is 
cd "C:\Repositories\Public\Starfield Mods\starfield-npc-scaler-v2\Tools"

@echo "Deploying Main Archive to MO2 Mod DIR"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-npc-scaler-v2\Dist\ScaleTheWorldTheSequel - Main.ba2" "D:\MO2Staging\Starfield\mods\ScaleTheWorldTheSequel-Experimental"
