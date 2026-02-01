# 变更：添加 Neo-Brutalism 主题系统 (M5)

## 为什么

M1-M4 已完成基础功能实现，当前 UI 采用类 Duolingo 的柔和风格。但根据用户提供的 HTML 原型设计，项目需要转向更年轻化、更有冲击力的 **Neo-Brutalism（新粗犷主义）** 风格。

Neo-Brutalism 的特点（硬边框、硬阴影、高对比度）更适合：
- 游戏化的学习体验（进度、成就、连击）
- 吸引年轻开发者用户群体
- 区别于传统枯燥的面试准备应用

## 变更内容

### 新增
- **统一主题系统** - NeoBrutalTheme 包含完整的色彩、阴影、圆角规范
- **核心 UI 组件库**
  - `NeoContainer` - 新粗犷风格容器
  - `NeoButton` - 硬阴影按钮
  - `NeoCard` - 数据统计卡片
  - `NeoProgressRing` - 环形进度条
  - `NeoStatBar` - 顶部统计指标栏
  - `NeoUnitBanner` - 当前学习单元横幅
  - `NeoBottomNav` - 底部导航栏
- **学习进度仪表板页面** - 游戏化的学习主页
- **成就系统 UI** - 徽章展示、解锁动画

### 修改
- **AppTheme** - 扩展现有主题，添加 Neo-Brutal 令牌
- **颜色系统** - 统一主色为 `#58CC02`，保持与现有 Duo 绿一致
- **LearningReportPage** - 重构为 Neo 风格

### 设计原则
- 保持轻量级实现，优先复用现有 Flutter 组件
- 所有组件支持深色模式
- 动画延续现有的 Duolingo 风格时长和曲线

## 影响

- 受影响规范：ui-components, flutter-app
- 受影响代码：
  - `baguzhan/lib/core/theme/` - 扩展主题
  - `baguzhan/lib/presentation/widgets/` - 新增 neo/ 子目录
  - `baguzhan/lib/presentation/pages/` - 新增进度仪表板页面
- **非破坏性变更** - 新增组件，旧代码继续工作，逐步迁移

## 参考资料

- 用户提供的 HTML 原型设计（4个页面）
- Neo-Brutalism 设计系统最佳实践
- 现有 AppTheme（`lib/core/theme/app_theme.dart`）
