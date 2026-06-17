# 嘉佑AI — 高血压AI辅助管理系统

基于多模态数据（血压时序、用药记录、日常产品成分）的高血压风险AI辅助管理系统。

## 技术栈

| 层级 | 技术 |
|------|------|
| 前端 (Web) | Vue 3 + Vite + Element Plus + ECharts + TypeScript |
| 后端 | Spring Boot 3.1 + MyBatis-Plus + Spring Security + JWT |
| 数据库 | MySQL 8.0 + Neo4j 4.4 + InfluxDB 2.7 + Redis 6 |
| AI算法 | Python 3.12（规则引擎，Docker 内置） |

## 一键启动

### Windows

双击 `start.bat` 

或命令行：

```bash
# 1. 构建 JAR（首次）
cd backend && mvnw package -DskipTests && cd ..

# 2. 启动全部 Docker 服务（MySQL + Neo4j + InfluxDB + Redis + 后端）
docker compose up -d --build

# 3. 启动前端
cd frontend && npm install && npm run dev
```

### Mac / Linux

```bash
# 1. 构建 JAR
cd backend && ./mvnw package -DskipTests && cd ..

# 2. 启动全部服务
docker compose up -d --build

# 3. 启动前端
cd frontend && npm install && npm run dev
```

## 访问地址

| 服务 | 地址 | 账号/密码 |
|------|------|-----------|
| 前端页面 | http://localhost:5173 | — |
| 后端 Swagger | http://localhost:8080/swagger-ui.html | — |
| Neo4j Browser | http://localhost:7474 | neo4j / jiayou123 |
| InfluxDB UI | http://localhost:8086 | jiayou / jiayou123 |

## 项目结构

```
├── start.bat                  # Windows 一键启动
├── docker-compose.yml         # 5 服务编排
├── database/
│   ├── init.sql               # MySQL 20 表 + 种子数据
│   └── neo4j_init.cypher      # Neo4j 知识图谱初始化
├── backend/                   # Spring Boot 后端
│   ├── Dockerfile             # 后端容器（含 Python3）
│   └── src/main/java/com/jiayou/
│       ├── config/            # JWT/Security/Neo4j/InfluxDB/Redis 配置
│       ├── entity/            # 14 个实体类
│       ├── mapper/            # 14 个 MyBatis-Plus Mapper
│       ├── dto/               # 请求体 DTO
│       ├── service/           # 8 个业务服务
│       └── controller/        # 9 个 REST 控制器
├── frontend/                  # Vue 3 前端
│   └── src/
│       ├── views/             # 8 个页面
│       ├── layout/            # 侧边栏布局
│       ├── router/            # 路由 + 守卫
│       ├── stores/            # Pinia 状态管理
│       ├── api/               # Axios API 封装
│       └── utils/             # HTTP 拦截器
└── algorithm/                 # Python AI 算法
    ├── predict.py             # 规则引擎主入口
    ├── models/                # 模型文件（占位）
    └── data/                  # 测试数据
```

## 演示账号

| 角色 | 用户名 | 密码 |
|------|--------|------|
| 管理员 | `admin` | `admin123` |
| 医生 | `doctor1` | `doctor123` |
| 患者 | `patient1` | `patient123` |
