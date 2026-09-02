# Requirements: [功能名称]

> 把 `prd.md` 的功能需求形式化为可测试的 EARS 验收标准 ｜ 给 AI / 开发执行 ｜ 可直接作为 auto-dev 的 PRD 输入

<!-- 初稿日期: YYYY-MM-DD ｜ 最近 review: YYYY-MM-DD -->

## 概述

[简要背景：这组需求要交付什么。]

## 需求列表

> 下列结构对**每一条**需求重复，不能只给第一条补状态和测试。

### REQ-001：[标题] [Must Have / Nice to Have]

- **来源场景**：SCN-___
- **来源证据 / 决定**：EVID-___ / DEC-___
- **用户故事**：作为 [角色]，我想要 [功能]，以便 [收益]

**验收标准:**

1. **AC-001** — WHEN [触发条件] THE SYSTEM SHALL [期望行为]
2. **AC-002** — WHEN [异常条件] THE SYSTEM SHALL [错误处理]
3. **AC-003** — IF [可选条件] THEN THE SYSTEM SHALL [条件响应]

**交互状态:**

- 正常：
- 加载 / 空状态：
- 错误：
- 权限或数据边界：
- 取消 / 撤回 / 重试：

**覆盖测试:**

- **TEST-001 正向**：[证明 AC-___ 与需求成立]
- **TEST-002 负向 / 反例**：[证明实现不会假通过]

## 成功指标

[可量化指标。]

## 约束条件

[限制。]

## 不在范围内

[排除项。任务拆解交给下游，不在此文档。]

## 追溯检查

- [ ] 每个 REQ 至少链接一个 SCN。
- [ ] 每个 Must Have REQ 至少链接一个 EVID/DEC 与一个 AC。
- [ ] 每个 AC 至少链接一个 TEST。
- [ ] 没有孤儿需求、孤儿验收或孤儿测试。

---

> 书写规范见 references/ears-syntax-guide.md。优先用 Event-driven（When/SHALL）与 Unwanted behavior（If/Then/SHALL）。每条 AC 只描述一个行为。
