# EARS 语法参考

EARS（Easy Approach to Requirements Syntax）由 Rolls-Royce（Alistair Mavin 等）于 2009 年提出，用于书写清晰、可测试、无歧义的需求。来源：https://alistairmavin.com/ears

## 五种模式

### 1. 常驻（Ubiquitous）— 无关键词
THE SYSTEM SHALL [行为]
> THE SYSTEM SHALL 对所有密码字段加密存储

### 2. 事件驱动（Event-driven）— When ★主力
WHEN [触发事件] THE SYSTEM SHALL [响应行为]
> WHEN 用户点击提交 THE SYSTEM SHALL 验证所有必填字段

### 3. 状态驱动（State-driven）— While
WHILE [系统状态] THE SYSTEM SHALL [持续行为]
> WHILE 用户处于登录状态 THE SYSTEM SHALL 每 5 分钟自动保存

### 4. 异常处理（Unwanted behavior）— If/Then ★主力
IF [异常条件] THEN THE SYSTEM SHALL [防护行为]
> IF 连续三次密码错误 THEN THE SYSTEM SHALL 锁定账户 30 分钟

### 5. 可选功能（Optional feature）— Where
WHERE [功能已启用] THE SYSTEM SHALL [行为]
> WHERE 通知已开启 THE SYSTEM SHALL 到期前 1 小时提醒

### 组合（Complex）
WHILE [状态] WHEN [触发] THE SYSTEM SHALL [响应]

## 书写原则

- 每条只描述一个行为
- 用 SHALL（不是 should / could）
- 触发条件要具体可观察
- 响应行为要可测试可验证
- 禁止模糊用语（"用户友好" → 改成具体指标）

## 实用建议（来自调研）

- **软件场景优先用 Event-driven（When）+ Unwanted（If/Then）**，二者覆盖约 80% 的软件需求（正常触发 + 异常处理），也最容易写对。
- **不要嵌套 SHALL**：一条里只放一个 SHALL，复杂逻辑拆成多条。
- **承认局限**：EARS 是半结构化自然语言，能大幅降低歧义但不能完全消除词汇歧义和高层模糊性——所以前置的对话澄清（消歧三法）才是无歧义的主要保障，EARS 是把澄清结果固化为可测试形式。

> 反驳视角与适用边界详见 ~/AI工作流/docs/research/requirement-discovery-prd-workflow-best-practices-20260601.md（小需求不值得写 EARS）。
