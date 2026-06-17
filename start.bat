@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo.
echo ╔══════════════════════════════════════════════╗
echo ║       嘉佑AI 高血压辅助管理系统              ║
echo ║       一键启动 (解压即用)                    ║
echo ╚══════════════════════════════════════════════╝
echo.

:: ============================================
:: Step 1: 启动 Docker 服务（使用预编译 JAR，无需 Maven）
:: ============================================
echo [1/3] 启动 Docker 服务 (MySQL + Neo4j + InfluxDB + Redis + 后端)...
docker compose -f docker-compose.runnable.yml up -d

echo   等待 MySQL 就绪...
:wait_mysql
timeout /t 5 /nobreak >nul
docker compose -f docker-compose.runnable.yml ps mysql 2>nul | findstr "healthy" >nul
if errorlevel 1 goto wait_mysql

:: ============================================
:: Step 2: 等待后端就绪
:: ============================================
echo   等待后端就绪 (首次需安装 Python, 约 30 秒)...
:wait_backend
timeout /t 3 /nobreak >nul
curl -s -o nul -w "%%{http_code}" http://localhost:8080/ 2>nul | findstr "403 200 404" >nul
if errorlevel 1 goto wait_backend

:: ============================================
:: Step 3: 初始化 Neo4j 知识图谱
:: ============================================
echo   初始化 Neo4j 知识图谱...
docker exec jiayou-neo4j cypher-shell -u neo4j -p jiayou123 "MATCH (n) RETURN count(n)" 2>nul | findstr ""0"" >nul 2>&1
if errorlevel 1 (
    echo   Neo4j 已有数据，跳过初始化
) else (
    docker cp database\neo4j_init.cypher jiayou-neo4j:/tmp/init.cypher 2>nul
    type database\neo4j_init.cypher 2>nul | docker exec -i jiayou-neo4j cypher-shell -u neo4j -p jiayou123 2>nul
    echo   Neo4j 初始化完成
)

:: ============================================
:: Step 4: 启动前端
:: ============================================
echo.
echo [2/3] 启动前端...
cd frontend
start "嘉佑AI-前端" cmd /c "npm run dev"
cd ..

:: ============================================
:: 完成
:: ============================================
echo.
echo [3/3] 全部就绪！
echo.
echo ╔══════════════════════════════════════════════╗
echo ║  前端页面   http://localhost:5173            ║
echo ║  后端 API   http://localhost:8080            ║
echo ║  Neo4j      http://localhost:7474            ║
echo ╠══════════════════════════════════════════════╣
echo ║  管理员  admin    / admin123                 ║
echo ║  医生    doctor1  / doctor123                ║
echo ║  患者    patient1 / patient123               ║
echo ╚══════════════════════════════════════════════╝
echo.
start http://localhost:5173
pause
