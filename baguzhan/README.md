# 八股斩 (BaguZhan)

程序员面试准备应用，采用 Neo-Brutalism（新粗犷主义）设计风格，提供游戏化的学习体验。

## 功能特性

- 📚 **丰富的题库** - 涵盖 JavaScript、React、TypeScript 等前端技术栈
- 🎮 **游戏化学习** - 连击系统、成就徽章、等级进度
- 📊 **学习统计** - 正确率追踪、学习进度可视化
- 📝 **错题本** - 自动记录错题，支持复习和掌握标记
- 🏆 **成就系统** - 完成挑战解锁徽章

## Neo-Brutalism 组件库

本项目采用 Neo-Brutalism（新粗犷主义）设计风格，特点包括：
- 硬阴影（无模糊）
- 粗边框（3px）
- 高对比度配色
- 大圆角（16-24px）

### 基础组件

#### NeoContainer
基础容器组件，提供 Neo-Brutal 风格的边框和阴影。

```dart
NeoContainer(
  child: Text('内容'),
  color: NeoBrutalTheme.surface,
  onTap: () {},
)
```

#### NeoButton
硬阴影按钮，支持多种类型和尺寸。

```dart
NeoButton(
  onPressed: () {},
  type: NeoButtonType.primary, // primary, secondary, accent, outline
  size: NeoButtonSize.medium,  // small, medium, large
  child: Text('按钮'),
)

// 便捷构造函数
NeoTextButton(
  text: '提交',
  onPressed: () {},
)
```

#### NeoCard
卡片容器，默认白色背景。

```dart
NeoCard(
  child: Text('卡片内容'),
)
```

### 展示组件

#### NeoProgressRing
环形进度条，支持动画效果。

```dart
NeoProgressRing(
  progress: 0.75, // 0.0 - 1.0
  size: 144,
  showPercentage: true,
)
```

#### NeoProgressButton
带中央按钮的进度环，用于学习仪表板。

```dart
NeoProgressButton(
  progress: 0.75,
  size: 160,
  buttonIcon: Icons.play_arrow,
  buttonLabel: 'START',
  onPressed: () {},
)
```

#### NeoStatBar
顶部统计栏，展示连续天数、正确率、总题数、积分。

```dart
NeoStatBar.standard(
  streak: 15,
  accuracy: 0.92,
  totalQuestions: 450,
  xp: 1250,
)
```

#### NeoUnitBanner
当前学习单元横幅。

```dart
NeoUnitBanner(
  unit: 1,
  part: 7,
  topic: 'JavaScript Closures',
  subtitle: 'Master memory & scope',
)
```

### 主题配置

```dart
// 颜色
NeoBrutalTheme.primary    // 主色 - 亮绿 #58CC02
NeoBrutalTheme.secondary  // 辅助色 - 天蓝 #1CB0F6
NeoBrutalTheme.accent     // 强调色 - 金黄 #FFC800
NeoBrutalTheme.charcoal   // 炭灰 - 边框、阴影 #2D3436
NeoBrutalTheme.fire       // 火焰橙 - 连续天数 #FF6B35
NeoBrutalTheme.diamond    // 钻石紫 - 积分 #6366F1

// 阴影
NeoBrutalTheme.shadowSm   // 小阴影 (0, 4)
NeoBrutalTheme.shadowMd   // 中阴影 (0, 6)
NeoBrutalTheme.shadowLg   // 大阴影 (0, 8)

// 圆角
NeoBrutalTheme.radiusSm   // 12px
NeoBrutalTheme.radiusMd   // 16px
NeoBrutalTheme.radiusLg   // 24px

// 文字样式
NeoBrutalTheme.styleHeadlineLarge
NeoBrutalTheme.styleHeadlineMedium
NeoBrutalTheme.styleBodyLarge
```

## 项目结构

```
lib/
├── core/
│   └── theme/
│       ├── app_theme.dart          # 应用主题配置
│       └── neo_brutal_theme.dart   # Neo-Brutal 主题令牌
├── data/
│   ├── models/                      # 数据模型
│   │   ├── achievement_model.dart   # 成就模型
│   │   ├── learning_progress_model.dart
│   │   └── unit_progress_model.dart
│   └── repositories/                # 数据仓库
├── presentation/
│   ├── pages/                       # 页面
│   │   ├── achievement_gallery_page.dart
│   │   ├── celebration_page.dart
│   │   ├── progress_dashboard_page.dart
│   │   └── ...
│   ├── widgets/                     # 组件
│   │   └── neo/                     # Neo 风格组件
│   │       ├── neo_button.dart
│   │       ├── neo_container.dart
│   │       ├── neo_progress_ring.dart
│   │       ├── neo_stat_bar.dart
│   │       └── ...
│   └── providers/                   # 状态管理
└── main.dart
```

## 运行测试

```bash
# 运行所有测试
flutter test

# 运行特定测试文件
flutter test test/presentation/widgets/neo/

# 运行 Golden 测试
flutter test --update-goldens test/presentation/widgets/neo/neo_golden_test.dart

# 运行集成测试
flutter test integration_test/
```

## 开始开发

```bash
# 安装依赖
flutter pub get

# 运行应用
flutter run

# 构建发布版本
flutter build apk --release
flutter build ios --release
```

## 技术栈

- **Flutter** - UI 框架
- **Provider** - 状态管理
- **Dio** - 网络请求
- **Shared Preferences** - 本地存储

## 贡献

欢迎提交 Issue 和 Pull Request！

## 许可证

MIT License
