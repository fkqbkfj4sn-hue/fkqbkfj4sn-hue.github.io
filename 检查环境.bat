@echo off
echo 剩余劳动价值论研究环境检查
echo ================================
echo.

echo 1. 检查Git安装...
where git >nul 2>nul
if %errorlevel%==0 (
    echo   ✅ Git已安装
) else (
    echo   ❌ Git未安装，请先安装Git
)

echo.
echo 2. 检查仓库目录...
if exist "C:\Users\wzm\Searches\Desktop\fkqbkfj4sn-hue.github.io" (
    echo   ✅ 仓库目录存在
) else (
    echo   ❌ 仓库目录不存在
)

echo.
echo 3. 检查工作脚本...
if exist "C:\Users\wzm\Searches\Desktop\fkqbkfj4sn-hue.github.io\work.sh" (
    echo   ✅ work.sh脚本存在
) else (
    echo   ❌ work.sh脚本不存在
)

if exist "C:\Users\wzm\Searches\Desktop\fkqbkfj4sn-hue.github.io\submit.sh" (
    echo   ✅ submit.sh脚本存在
) else (
    echo   ❌ submit.sh脚本不存在
)

echo.
echo 4. 检查网站可访问性...
echo   网站地址: https://fkqbkfj4sn-hue.github.io
echo   请手动在浏览器中打开检查

echo.
echo 5. 检查GitHub连接...
echo   仓库地址: https://github.com/fkqbkfj4sn-hue/fkqbkfj4sn-hue.github.io
echo   请手动在浏览器中打开检查

echo.
echo ================================
echo 环境检查完成！
echo.
echo 建议操作:
echo 1. 双击桌面"开始研究"快捷方式测试
echo 2. 上传2007年论文到 assets/pdfs/
echo 3. 运行"提交成果"上传到GitHub
echo ================================
pause
