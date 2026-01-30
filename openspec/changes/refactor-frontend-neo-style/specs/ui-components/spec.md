# UI Components Specification Increment

## ADDED Requirements

### Requirement: CelebrationPage

系统 MUST 在完成单元/章节后显示庆祝动画页面。

#### Scenario: 显示庆祝页面

- **当** 用户完成一个单元
- **那么** 全屏显示庆祝页面，包含成就徽章、统计数据、继续按钮

#### Scenario: 彩带动画

- **当** 庆祝页面显示
- **那么** 播放彩带飘落动画

### Requirement: AchievementGalleryPage

系统 MUST 显示用户的成就徽章集合。

#### Scenario: 显示已解锁和未解锁成就

- **当** 用户打开成就页面
- **那么** 已解锁显示彩色，未解锁显示灰色虚线边框

## MODIFIED Requirements

### Requirement: HomePage

现有首页 MUST 使用 Neo-Brutal 风格组件重新设计。

#### Scenario: 顶部统计栏

- **当** 用户进入首页
- **那么** 显示 NeoStatBar 展示连续天数、积分等

#### Scenario: 主题卡片

- **当** 显示主题列表
- **那么** 使用 NeoCard 展示每个主题

#### Scenario: 底部导航

- **当** 显示底部导航
- **那么** 使用 NeoBottomNav 组件

### Requirement: QuestionPage

现有答题页 MUST 适配 Neo-Brutal 风格。

#### Scenario: 进度显示

- **当** 答题进行中
- **那么** 使用 Neo 风格进度条组件

#### Scenario: 选项卡片

- **当** 显示选项
- **那么** 选项卡片使用硬阴影和粗边框

### Requirement: ResultPage

现有结果页 MUST 使用 Neo 组件展示数据。

#### Scenario: 统计展示

- **当** 进入结果页
- **那么** 使用 NeoStatRow 展示统计数据

#### Scenario: 正确率展示

- **当** 显示正确率
- **然后** 使用 NeoProgressRing 环形展示
