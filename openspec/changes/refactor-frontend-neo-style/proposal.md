# 变更：前端页面重构为 Neo-Brutal 风格

## 为什么

M5 已完成 Neo-Brutal 主题系统和核心组件的实现，但现有页面（HomePage、QuestionPage、ResultPage 等）仍使用旧风格。

为了保持 UI 一致性并提升用户体验，需要将现有页面逐步迁移到 Neo-Brutal 风格。

## 变更内容

### 重构
- **HomePage** - 使用 NeoStatBar、NeoBottomNav 等组件
- **QuestionPage** - 使用 Neo 风格的进度条和选项卡片
- **ResultPage** - 使用 NeoCard、NeoProgressRing 展示结果
- **TopicSelectionPage** - 使用 NeoContainer 重新设计主题选择

### 新增
- **CelebrationPage** - 章节/单元完成庆祝页面
- **AchievementGalleryPage** - 成就徽章展示页面

## 影响

- 受影响规范：ui-components, flutter-app
- 受影响代码：
  - `baguzhan/lib/presentation/pages/` - 重构现有页面
- **非破坏性变更** - 逐步迁移，每页独立完成
