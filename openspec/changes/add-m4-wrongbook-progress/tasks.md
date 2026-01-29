## 1. 数据库层
- [ ] 1.1 创建 `user_answers` 表（用户答题记录）
- [ ] 1.2 创建 `wrong_book` 表（错题本）
- [ ] 1.3 创建 `learning_progress` 表（学习进度统计）
- [ ] 1.4 创建索引优化查询性能
- [ ] 1.5 编写数据库迁移脚本

## 2. BFF 后端
- [ ] 2.1 实现错题本 Repository 层
- [ ] 2.2 实现错题本 Service 层
- [ ] 2.3 添加错题本 API 端点（CRUD）
- [ ] 2.4 添加学习进度 API 端点
- [ ] 2.5 添加答题记录 API 端点
- [ ] 2.6 编写单元测试

## 3. Flutter 数据层
- [ ] 3.1 创建 WrongBook 数据模型
- [ ] 3.2 创建 LearningProgress 数据模型
- [ ] 3.3 实现 WrongBookRepository（远程 + 本地缓存）
- [ ] 3.4 实现本地缓存（SharedPreferences/SQLite）
- [ ] 3.5 编写数据层测试

## 4. Flutter 状态管理
- [ ] 4.1 创建 WrongBookProvider
- [ ] 4.2 创建 LearningProgressProvider
- [ ] 4.3 集成到答题流程（答错自动记录）
- [ ] 4.4 编写 Provider 测试

## 5. Flutter UI
- [ ] 5.1 创建错题本列表页面
- [ ] 5.2 创建错题详情页面（支持重新答题）
- [ ] 5.3 创建学习报告页面
- [ ] 5.4 在首页添加入口导航
- [ ] 5.5 编写 Widget 测试

## 6. 集成与测试
- [ ] 6.1 端到端集成测试
- [ ] 6.2 性能测试（大数据量查询）
- [ ] 6.3 更新文档
