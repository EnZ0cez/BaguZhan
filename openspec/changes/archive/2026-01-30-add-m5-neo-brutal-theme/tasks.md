# 实施任务清单

## 1. 主题系统实现
- [x] 1.1 扩展 `AppTheme` 添加 Neo-Brutal 令牌（颜色、阴影、圆角）
- [x] 1.2 创建 `NeoBrutalTheme` 静态类
- [x] 1.3 添加深色模式支持

## 2. 核心 Widget 实现
- [x] 2.1 创建 `NeoContainer` - 基础容器组件
- [x] 2.2 创建 `NeoButton` - 硬阴影按钮（多种尺寸）
- [x] 2.3 创建 `NeoCard` - 统计卡片
- [x] 2.4 创建 `NeoProgressRing` - SVG 环形进度条
- [x] 2.5 创建 `NeoStatBar` - 顶部统计指标栏
- [x] 2.6 创建 `NeoUnitBanner` - 当前单元横幅
- [x] 2.7 创建 `NeoBottomNav` - 底部导航栏
- [x] 2.8 创建 `NeoIconButton` - 圆形图标按钮

## 3. 页面实现
- [x] 3.1 创建 `ProgressDashboardPage` - 学习进度仪表板
- [x] 3.2 创建 `CelebrationPage` - 章节/单元完成庆祝页
- [x] 3.3 创建 `AchievementGalleryPage` - 成就画廊页
- [x] 3.4 重构 `LearningReportPage` 使用 Neo 组件

## 4. 数据模型扩展
- [x] 4.1 扩展 `LearningProgressModel` 添加等级（Level）
- [x] 4.2 创建 `AchievementModel` - 成就数据模型
- [x] 4.3 创建 `UnitProgressModel` - 单元进度模型

## 5. 测试
- [x] 5.1 为 Neo 组件编写 Widget 测试
  - `test/presentation/widgets/neo/neo_button_test.dart`
  - `test/presentation/widgets/neo/neo_widgets_test.dart`
- [x] 5.2 添加 Golden 测试（视觉回归测试）
  - `test/presentation/widgets/neo/neo_golden_test.dart`
- [x] 5.3 集成测试：完整仪表板流程
  - `integration_test/dashboard_test.dart`

## 6. 文档
- [x] 6.1 更新 README 添加 Neo 组件使用说明
- [x] 6.2 创建组件示例页面
  - `lib/presentation/pages/neo_components_showcase_page.dart`
