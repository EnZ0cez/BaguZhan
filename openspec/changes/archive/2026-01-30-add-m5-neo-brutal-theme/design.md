# 设计文档：Neo-Brutalism 主题系统

## 上下文

八股斩当前采用类 Duolingo 的柔和设计风格。根据用户需求和目标用户群体（年轻开发者），需要转向更有冲击力的 Neo-Brutalism 风格。

**约束条件：**
- 必须保持与现有 AppTheme 的兼容性
- 需要支持深色模式
- 保持轻量级实现，避免过度工程化

## 目标 / 非目标

### 目标
- 统一的 Neo-Brutal 视觉语言（硬边框、硬阴影、高对比度）
- 游戏化的学习体验（进度环、成就、连击）
- 可复用的组件库
- 与现有主题共存

### 非目标
- 完全替换现有 Duolingo 风格（共存迁移）
- 复杂的动画系统（复用现有动画）
- Web 平台优先（移动优先）

## 设计决策

### 1. 颜色系统

| 令牌 | 颜色 | 用途 |
|------|------|------|
| `primary` | `#58CC02` | 主操作、进度（保持现有 Duo 绿） |
| `secondary` | `#1CB0F6` | 辅助信息 |
| `accent` | `#FFC800` | 成就、奖励、高亮 |
| `charcoal` | `#2D3436` | 边框、阴影 |
| `background` | `#F9FAFB` | 页面背景 |
| `fire` | `#FF6B35` | 连续天数火焰 |
| `diamond` | `#6366F1` | 积分/经验值 |

### 2. 阴影系统

Neo-Brutalism 的核心是**硬阴影**（无模糊）：

```dart
// Flutter 实现
static const List<BoxShadow> shadowSm = [
  BoxShadow(
    color: charcoal,
    offset: Offset(0, 4),
    blurRadius: 0,  // 关键：无模糊
    spreadRadius: 0,
  ),
];

static const List<BoxShadow> shadowMd = [
  BoxShadow(color: charcoal, offset: Offset(0, 6), blurRadius: 0),
];

static const List<BoxShadow> shadowLg = [
  BoxShadow(color: charcoal, offset: Offset(0, 8), blurRadius: 0),
];
```

### 3. 边框和圆角

| 属性 | 值 | 说明 |
|------|-----|------|
| 边框宽度 | `3px` | 硬边框 |
| 边框颜色 | `#2D3436` | 炭灰色 |
| 小圆角 | `12px` | 小组件 |
| 中圆角 | `16px` | 卡片、按钮 |
| 大圆角 | `24px` | 大容器 |

### 4. 按下状态

按下时，阴影消失，元素"下沉"：

```dart
// 正常状态
offset: Offset(0, 0)
shadow: [BoxShadow(offset: Offset(0, 6))]

// 按下状态
offset: Offset(4, 4)  // 向下偏移
shadow: []            // 无阴影
```

## 组件层次

```
NeoBrutalTheme (静态类)
├── 颜色令牌
├── 阴影令牌
├── 尺寸令牌
└── 文字样式

NeoContainer (基础容器)
├── NeoCard
├── NeoButton
│   ├── NeoPrimaryButton
│   ├── NeoSecondaryButton
│   └── NeoIconButton
├── NeoStatBar
├── NeoProgressRing
└── NeoUnitBanner
```

## 页面结构

### ProgressDashboardPage
```
┌─────────────────────────────────────┐
│  🔥15  ✅92%  📚450  💎1.2k         │  ← NeoStatBar
├─────────────────────────────────────┤
│  ████████  Unit 1, Part 7           │  ← NeoUnitBanner
│         JavaScript Closures         │
├─────────────────────────────────────┤
│           ┌─────────┐               │
│           │    ⭐    │               │  ← NeoProgressRing
│           └─────────┘               │     + Central Button
│                                     │
│      📄  ⭐  🕒  ⚙️               │  ← NeoIconButton (垂直)
├─────────────────────────────────────┤
│  🗺️  🏆  💪  📬  👤  🛒            │  ← NeoBottomNav
└─────────────────────────────────────┘
```

## 风险 / 权衡

| 风险 | 缓解措施 |
|------|----------|
| 风格变化可能让现有用户困惑 | 渐进式迁移，保持旧功能可用 |
| 过多组件增加维护负担 | 复用现有 Flutter Widget，最小化代码 |
| SVG 进度环性能问题 | 使用 CustomPainter 而非 flutter_svg |

## 迁移计划

1. **第一阶段** - 主题和基础组件（Week 1）
2. **第二阶段** - 核心页面（Week 2）
3. **第三阶段** - 逐步迁移现有页面（Week 3+）

## 待决问题

- [ ] 是否需要 Web 平台的专门适配？
- [ ] 成就系统的后端 API 设计（M6+）
