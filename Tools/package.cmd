@echo off

REM Get latest 7zip cli from https://www.7-zip.org/download.html (Want x64 7Zip Extras package) see https://documentation.help/7-Zip/syntax.htm for online docs

REM Get version from args
if [%1]==[] goto error_no_version

@echo Building package and GitHub release for version %1

REM Notepad++/VSCODE needs current working directory to be where Caprica.exe is 
cd "C:\Repositories\Public\Starfield Mods\starfield-npc-scaler-v2\Tools"

REM Clear Dist DIR
del /q "C:\Users\degre\Downloads\ScaleTheWorldTheSequel.zip"

REM Archive Dist Dir
"D:\Program Files\PexTools\7za.exe" a -tzip "C:\Users\degre\Downloads\ScaleTheWorldTheSequel.zip" "C:\Repositories\Public\Starfield Mods\starfield-npc-scaler-v2\Dist\*.*"

REM Upload the zip as a release to GitHub
@echo Creating GitHub release for version %1
gh release create "%1" "C:\Users\degre\Downloads\ScaleTheWorldTheSequel.zip" --verify-tag --latest --title "Version %1" -F "../CHANGELOG.md"
goto end

:error_no_version
@echo ERROR: You must provide the version number
EXIT

:end
