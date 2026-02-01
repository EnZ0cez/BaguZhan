# 设计文档：前端页面 Neo-Brutal 风格重构

## 上下文

M5 完成了 Neo-Brutal 主题系统和核心组件。现有页面需要迁移到新风格。

## 目标 / 非目标

### 目标
- 统一所有页面的视觉风格
- 提升用户体验的一致性
- 复用 M5 创建的组件

### 非目标
- 修改现有交互逻辑
- 改变页面导航结构

## 页面映射

| 现有页面 | 使用组件 | 优先级 |
|----------|----------|--------|
| HomePage | NeoStatBar, NeoBottomNav, NeoCard | P0 |
| QuestionPage | NeoProgressRing, NeoButton, NeoContainer | P1 |
| ResultPage | NeoStatRow, NeoProgressRing, NeoButton | P1 |
| TopicSelectionPage | NeoCard | P2 |

## 设计原则

- **渐进式重构** - 每个页面独立完成，可随时暂停
- **保持功能** - 只修改视觉风格，不改变交互逻辑
- **组件复用** - 优先使用 M5 创建的 Neo 组件
