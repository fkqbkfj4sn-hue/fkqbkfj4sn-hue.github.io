@echo off
echo 剩余劳动价值论研究 - 启动脚本
echo ================================
echo.
echo 请选择操作：
echo 1. 开始研究 (运行 work.sh)
echo 2. 提交成果 (运行 submit.sh)
echo 3. 直接进入目录
echo 4. 查看网站
echo 5. 退出
echo.
set /p choice="请选择 (1-5): "

if "%choice%"=="1" (
    start "" "C:\Program Files\Git\git-bash.exe" --cd="C:\Users\wzm\Searches\Desktop\fkqbkfj4sn-hue.github.io" -c "./work.sh"
)
if "%choice%"=="2" (
    start "" "C:\Program Files\Git\git-bash.exe" --cd="C:\Users\wzm\Searches\Desktop\fkqbkfj4sn-hue.github.io" -c "./submit.sh"
)
if "%choice%"=="3" (
    start "" "C:\Program Files\Git\git-bash.exe" --cd="C:\Users\wzm\Searches\Desktop\fkqbkfj4sn-hue.github.io"
)
if "%choice%"=="4" (
    start "" "https://fkqbkfj4sn-hue.github.io"
)
if "%choice%"=="5" (
    exit
)

echo.
echo 操作已执行！
echo ================================
pause
