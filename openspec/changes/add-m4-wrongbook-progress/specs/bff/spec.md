## 新增需求

### 需求：BFF MUST 提供错题本 API

BFF MUST 提供 RESTful API 端点，支持错题本的增删改查。

#### 场景：获取错题本列表

- **给定** 用户已登录且有错题记录
- **当** 发送 GET 请求到 `/api/wrong-book?userId={userId}`
- **那么** 返回 200 状态码和错题列表（包含题目详情）

#### 场景：添加错题

- **给定** 用户答错题目
- **当** 发送 POST 请求到 `/api/wrong-book`，请求体包含 userId、questionId
- **那么** 返回 201 状态码和创建的错题记录
- **并且** 如果已存在，更新 wrong_count

#### 场景：标记错题已掌握

- **给定** 错题本中有某道错题
- **当** 发送 PATCH 请求到 `/api/wrong-book/{id}/master`
- **那么** 返回 200 状态码，标记 is_mastered 为 true

#### 场景：删除错题

- **给定** 错题本中有某道错题
- **当** 发送 DELETE 请求到 `/api/wrong-book/{id}`
- **那么** 返回 204 状态码，删除该记录

---

### 需求：BFF MUST 提供学习进度 API

BFF MUST 提供 API 端点查询和更新用户学习进度。

#### 场景：获取学习进度

- **给定** 用户有答题记录
- **当** 发送 GET 请求到 `/api/progress?userId={userId}`
- **那么** 返回 200 状态码和学习进度数据：
  ```json
  {
    "totalAnswered": 100,
    "totalCorrect": 85,
    "accuracyRate": 0.85,
    "currentStreak": 5,
    "longestStreak": 12
  }
  ```

#### 场景：获取答题统计

- **给定** 用户有答题记录
- **当** 发送 GET 请求到 `/api/progress/stats?userId={userId}&period=week`
- **那么** 返回 200 状态码和指定周期的统计数据

---

### 需求：BFF MUST 记录用户答题

BFF MUST 提供 API 端点记录每次答题详情。

#### 场景：记录答题

- **给定** 用户完成答题
- **当** 发送 POST 请求到 `/api/answers`，请求体包含：
  - userId, questionId, selectedOptionId, isCorrect, answerTimeMs
- **那么** 返回 201 状态码，记录保存成功
- **并且** 自动更新学习进度统计

#### 场景：查询答题历史

- **给定** 用户有答题记录
- **当** 发送 GET 请求到 `/api/answers?userId={userId}&limit=20`
- **那么** 返回 200 状态码和答题历史列表
