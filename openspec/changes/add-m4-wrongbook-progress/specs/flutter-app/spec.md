## 新增需求

### 需求：Flutter MUST 实现错题本数据模型

Flutter 应用 MUST 定义错题本相关的数据模型，与后端 API 结构一致。

#### 场景：WrongBookModel 包含完整字段

- **当** 创建 WrongBookModel 实例
- **那么** 包含以下字段：
  - id (String) - 唯一标识
  - userId (String) - 用户标识
  - question (QuestionModel) - 关联的题目
  - wrongCount (int) - 错误次数
  - lastWrongAt (DateTime) - 最后错误时间
  - isMastered (bool) - 是否已掌握
  - masteredAt (DateTime?) - 掌握时间

#### 场景：LearningProgressModel 包含完整字段

- **当** 创建 LearningProgressModel 实例
- **那么** 包含以下字段：
  - totalAnswered (int) - 总答题数
  - totalCorrect (int) - 正确数
  - accuracyRate (double) - 正确率
  - currentStreak (int) - 当前连续天数
  - longestStreak (int) - 最长连续天数
  - lastAnsweredAt (DateTime?) - 最后答题时间

#### 场景：支持 JSON 序列化

- **当** 模型与 JSON 互相转换
- **那么** `fromJson()` 和 `toJson()` 方法正确处理所有字段

---

### 需求：Flutter MUST 实现错题本 Repository

Flutter 应用 MUST 通过 Repository 模式管理错题本数据，支持远程和本地缓存。

#### 场景：获取错题本列表

- **给定** 用户已登录
- **当** 调用 `wrongBookRepository.getWrongBooks()`
- **那么** 从 BFF API 获取数据
- **并且** 缓存到本地供离线使用

#### 场景：本地缓存优先

- **给定** 本地有缓存数据
- **当** 调用 `getWrongBooks()` 且网络不可用
- **那么** 返回本地缓存数据

#### 场景：添加错题

- **给定** 用户答错题目
- **当** 调用 `wrongBookRepository.addWrongBook(questionId)`
- **那么** 发送到 BFF API
- **并且** 更新本地缓存

#### 场景：标记已掌握

- **给定** 错题本中有某道错题
- **当** 调用 `wrongBookRepository.markAsMastered(wrongBookId)`
- **那么** 发送到 BFF API 更新状态
- **并且** 从活跃错题列表中移除

---

### 需求：Flutter MUST 实现学习进度 Repository

Flutter 应用 MUST 管理学习进度数据的获取和缓存。

#### 场景：获取学习进度

- **给定** 用户已登录
- **当** 调用 `progressRepository.getProgress()`
- **那么** 返回 LearningProgressModel
- **并且** 缓存到本地

#### 场景：刷新学习进度

- **给定** 用户完成答题
- **当** 调用 `progressRepository.refreshProgress()`
- **那么** 从 BFF 获取最新数据并更新缓存
