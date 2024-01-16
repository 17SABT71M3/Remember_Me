@echo off
set /a goforit=0
set args_=%1
set /a counter=0
if not exist %1 choice /c yn /m "file not exist, search for previous file?"
if not exist %1 if %errorlevel%==2 goto :next
if not exist %1 for /f "tokens=*" %%i in ('echo %1') do for /f "tokens=*" %%a in ('type "%userprofile%\desktop\listofnotepads.txt" ^| find "%%~i"') do set /a counter+=1& echo Open File %%a ?&call :ask

goto :eof
:next
if exist %1 for /f "delims=" %%i in ('dir /b /s %1') do type "%userprofile%\desktop\listofnotepads.txt" | find "%%i" >NUL&&echo. >NUL || echo."%%i" >> "%userprofile%\desktop\listofnotepads.txt"
if not exist %1 c:\Windows\notepad.exe %1

goto :eof

:ask
choice /c YN 
if %errorlevel%==1 set /a goforit=1
set /a index=counter-1
if %goforit%==1 if %index%==0 for /f "tokens=*" %%i in ('echo %args_%') do for /f "delims=" %%a in ('type "%userprofile%\desktop\listofnotepads.txt" ^| find "%%~i"') do c:\Windows\notepad.exe %%a&goto :eof
if %goforit%==1 if %index% GTR 0 for /f "tokens=*" %%i in ('echo %args_%') do for /f "skip=%index% delims=" %%a in ('type "%userprofile%\desktop\listofnotepads.txt" ^| find "%%~i"') do c:\Windows\notepad.exe %%a&goto :eof

if /i "%cd%"=="%userprofile%\desktop" pushd ..\
if /i "%cd%"=="%userprofile%\desktop" notepad .\desktop\%args_%
if /i "%cd%"=="%userprofile%\desktop" popd
