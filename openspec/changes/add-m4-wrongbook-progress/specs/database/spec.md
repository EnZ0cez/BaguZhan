## 新增需求

### 需求：数据库 MUST 存储用户答题记录

数据库 MUST 包含 user_answers 表，记录每次答题的详细信息，用于统计和错题追踪。

#### 场景：创建答题记录表

- **给定** 数据库已初始化
- **当** 执行 Schema 创建脚本
- **那么** user_answers 表应包含以下字段：
  - `id` TEXT PRIMARY KEY
  - `user_id` TEXT NOT NULL (用户标识)
  - `question_id` TEXT NOT NULL (外键引用 questions.id)
  - `selected_option_id` TEXT NOT NULL
  - `is_correct` BOOLEAN NOT NULL
  - `answer_time_ms` INTEGER (答题耗时毫秒)
  - `answered_at` TIMESTAMP NOT NULL

#### 场景：查询用户答题历史

- **给定** 用户已答题多次
- **当** 查询 `SELECT * FROM user_answers WHERE user_id = ? ORDER BY answered_at DESC`
- **那么** 返回该用户的所有答题记录，按时间倒序排列

---

### 需求：数据库 MUST 存储错题本

数据库 MUST 包含 wrong_book 表，记录用户做错的题目，支持复习和去重。

#### 场景：创建错题本表

- **给定** 数据库已初始化
- **当** 执行 Schema 创建脚本
- **那么** wrong_book 表应包含以下字段：
  - `id` TEXT PRIMARY KEY
  - `user_id` TEXT NOT NULL
  - `question_id` TEXT NOT NULL (外键引用 questions.id)
  - `wrong_count` INTEGER DEFAULT 1 (错误次数)
  - `last_wrong_at` TIMESTAMP NOT NULL
  - `is_mastered` BOOLEAN DEFAULT FALSE (是否已掌握)
  - `mastered_at` TIMESTAMP (掌握时间)
  - UNIQUE(user_id, question_id) 约束（同一题目只记录一次）

#### 场景：错题去重和计数

- **给定** 用户已做错某题
- **当** 再次做错同一题
- **那么** 更新 `wrong_count` 和 `last_wrong_at`，不插入新记录

#### 场景：标记已掌握

- **给定** 错题本中有某道错题
- **当** 用户复习并答对
- **那么** 设置 `is_mastered = TRUE` 和 `mastered_at` 时间戳

---

### 需求：数据库 MUST 存储学习进度统计

数据库 MUST 包含 learning_progress 表，记录用户的学习统计数据。

#### 场景：创建学习进度表

- **给定** 数据库已初始化
- **当** 执行 Schema 创建脚本
- **那么** learning_progress 表应包含以下字段：
  - `id` TEXT PRIMARY KEY
  - `user_id` TEXT NOT NULL UNIQUE
  - `total_answered` INTEGER DEFAULT 0 (总答题数)
  - `total_correct` INTEGER DEFAULT 0 (正确数)
  - `current_streak` INTEGER DEFAULT 0 (当前连续答题天数)
  - `longest_streak` INTEGER DEFAULT 0 (最长连续天数)
  - `last_answered_at` TIMESTAMP (最后答题时间)
  - `updated_at` TIMESTAMP NOT NULL

#### 场景：更新学习进度

- **给定** 用户完成答题
- **当** 调用更新进度方法
- **那么** 更新 total_answered、total_correct 和正确率
- **并且** 如果跨天答题，重置 current_streak

---

### 需求：数据库 MUST 优化错题和学习进度查询

数据库 MUST 在错题本和学习进度查询上建立索引，确保性能。

#### 场景：错题本查询索引

- **给定** wrong_book 表已创建
- **当** 查询 `SELECT * FROM wrong_book WHERE user_id = ? AND is_mastered = FALSE`
- **那么** 查询应使用 `idx_wrong_book_user_mastered` 复合索引

#### 场景：答题记录查询索引

- **给定** user_answers 表已创建
- **当** 查询 `SELECT * FROM user_answers WHERE user_id = ? ORDER BY answered_at DESC`
- **那么** 查询应使用 `idx_user_answers_user_time` 复合索引
