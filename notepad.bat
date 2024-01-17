@echo OFF
set args_=%1
set /a counter=0
if not exist %1 echo.file not exist
if not exist %1 choice /c CS /m "(Create/Search)"
if not exist %1 if %errorlevel%==1 goto :next
if not exist %1 (for /f "tokens=*" %%i in ('echo %1') do for /f "tokens=*" %%a in ('type "%userprofile%\desktop\listofnotepads.txt" ^| find /I "%%~i"') do set /a counter+=1& echo Open File %%a ?&call :ask)&GOTO :EOF
:next
if exist %1 for /f "delims=" %%i in ('dir /b /s %1 2^>nul') do type "%userprofile%\desktop\listofnotepads.txt" | find /I "%%i" >NUL&&echo. >NUL || echo."%%i" >> "%userprofile%\desktop\listofnotepads.txt"
if exist %1 c:\windows\notepad.exe %1
if not exist %1 c:\Windows\notepad.exe %1

goto :eof

:ask
SET /A GOFORIT=0
choice /c YN 
if %errorlevel%==1 set /a goforit=1
set /a index=counter-1
if %goforit%==1 if %index%==0 for /f "tokens=*" %%i in ('echo %args_%') do for /f "delims=" %%a in ('type "%userprofile%\desktop\listofnotepads.txt" ^| find /I "%%~i"') do c:\Windows\notepad.exe %%a&goto :eof
if %goforit%==1 if %index% GTR 0 for /f "tokens=*" %%i in ('echo %args_%') do for /f "skip=%index% delims=" %%a in ('type "%userprofile%\desktop\listofnotepads.txt" ^| find /I "%%~i"') do c:\Windows\notepad.exe %%a&goto :eof


