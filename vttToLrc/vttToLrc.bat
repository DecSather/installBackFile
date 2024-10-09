@echo off
chcp 65001
setlocal EnableDelayedExpansion
set b=":"
set counter=0
set c="^[0-9]*$"
for %%f in (*.vtt) do (
    echo Converting: %%f
    set "base_name=%%~nf"
    set "base_name=!base_name:.vtt=!"
    echo. > "!lrc_file!"
    for /f "tokens=* delims=" %%i in (%%f) do (
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
                f !counter!==1 (
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
