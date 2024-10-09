@echo off
chcp 65001
setlocal EnableDelayedExpansion
set b=":"
set counter=0
set c="^[0-9]*$"
for %%f in (*.txt) do (
    echo Converting: %%f
    set "base_name=%%~nf"
    set "base_name=!base_name:.txt=!"
    set "lrc_file=!base_name!.lrc"
    echo. > "!lrc_file!"
    for /f "delims=" %%i in (%%f) do (
        echo "%%i"| findstr %b% >nul && (
            set ttt=%%i
            set counter=1
        )||(
            echo %%i| findstr /r %c% >nul &&(
                echo %%i
            )||(
                if !counter!==2 (
                    echo %%i>>"!lrc_file!"
                )
                if !counter!==1 (
                    echo [!ttt:~3,8!]%%i>>"!lrc_file!"
                    set counter=2
                )
            )
        )
    )
)
setlocal DisableDelayedExpansion
:end
pause
