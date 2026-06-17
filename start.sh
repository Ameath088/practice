#!/bin/bash
echo "=========================================="
echo "  嘉佑AI 高血压辅助管理系统 — 一键启动"
echo "=========================================="
echo ""

echo "[1/4] 启动 Docker 基础设施..."
docker-compose up -d
echo "等待 MySQL 就绪..."
sleep 15

echo ""
echo "[2/4] 验证基础设施状态..."
docker-compose ps
echo ""

echo "[3/4] 启动后端服务..."
echo "请在新终端窗口中执行:"
echo "  cd backend && ./mvnw spring-boot:run"
echo ""

echo "[4/4] 启动前端服务..."
echo "请在新终端窗口中执行:"
echo "  cd frontend && npm install && npm run dev"
echo ""

echo "=========================================="
echo "  MySQL:    localhost:3306"
echo "  Neo4j:    http://localhost:7474 (neo4j/jiayou123)"
echo "  InfluxDB: http://localhost:8086"
echo "  Redis:    localhost:6379"
echo "  后端:    http://localhost:8080"
echo "  前端:    http://localhost:5173"
echo "  Swagger:  http://localhost:8080/swagger-ui.html"
echo "=========================================="
echo ""
echo "演示账号:"
echo "  管理员: admin / admin123"
echo "  医生:   doctor1 / doctor123"
echo "  患者:   patient1 / patient123"
echo ""
