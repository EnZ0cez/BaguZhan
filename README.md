# 八股斩 (BaguZhan)

八股斩是一款帮助开发者学习和巩固前端八股文知识的移动应用。

## 项目概述

八股斩采用 Flutter + Node.js BFF 架构，支持按主题和难度筛选题目，提供答题、解析、口诀等功能。

## 技术架构

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   Flutter App   │────▶│  BFF (Node.js)  │────▶│   SQLite DB     │
│                 │ HTTP │                 │ SQL │                 │
│  - 答题界面      │      │  - REST API     │     │  - 题库数据      │
│  - 状态管理      │      │  - 数据筛选      │     │  - 索引优化      │
│  - Dio 客户端    │      │  - 随机出题      │     │                 │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

## 项目结构

```
BaguZhan/
├── baguzhan/           # Flutter 应用
│   ├── lib/
│   │   ├── data/       # 数据层（Repository、Model）
│   │   ├── domain/     # 领域层
│   │   ├── network/    # 网络层（Dio 配置）
│   │   ├── presentation/# 表现层（Pages、Widgets、Providers）
│   │   └── core/       # 核心配置（主题、常量）
│   └── test/           # 测试
├── server/             # BFF 后端服务
│   ├── src/
│   │   ├── routes/     # 路由
│   │   ├── controllers/# 控制器
│   │   ├── services/   # 业务逻辑
│   │   ├── repositories/# 数据访问
│   │   └── database/   # 数据库
│   └── tests/          # 测试
└── openspec/           # 规范文档
```

## 快速开始

### 后端服务

```bash
cd server

# 安装依赖
npm install

# 初始化数据库
npm run db:migrate
npm run db:seed

# 启动服务
npm run dev
```

服务默认运行在 `http://localhost:37123`（可通过环境变量 `PORT` 覆盖）

### Flutter 应用

```bash
cd baguzhan

# 获取依赖
flutter pub get

# 运行应用
flutter run
```

## 功能特性

### M1 阶段（已完成）
- [x] 基础 UI 原型
- [x] 答题流程
- [x] 主题选择
- [x] 答题结果统计

### M2 阶段（已完成）
- [x] BFF 后端服务
- [x] SQLite 数据库
- [x] RESTful API
- [x] Flutter Dio 集成
- [x] 网络状态管理
- [x] 错误处理

### 未来规划
- [ ] 用户认证
- [ ] 答题历史
- [ ] 错题本
- [ ] 数据同步

## API 文档

详见 [server/README.md](./server/README.md)

## 测试

### 后端测试

```bash
cd server
npm test
```

### Flutter 测试

```bash
cd baguzhan
flutter test
```

### 集成测试

```bash
cd baguzhan
flutter test integration_test/
```

## 开发规范

- 使用 OpenSpec 进行规范驱动开发
- 遵循 Clean Architecture 分层架构
- 代码提交前运行 lint 检查

## 许可证

MIT
