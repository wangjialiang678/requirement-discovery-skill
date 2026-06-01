# Requirements: [功能名称]

> 把 `prd.md` 的功能需求形式化为可测试的 EARS 验收标准 ｜ 给 AI / 开发执行 ｜ 可直接作为 auto-dev 的 PRD 输入

<!-- 初稿日期: YYYY-MM-DD ｜ 最近 review: YYYY-MM-DD -->

## 概述

[简要背景：这组需求要交付什么。]

## 需求列表

### 需求 1: [标题] [Must Have]

**用户故事:** 作为 [角色]，我想要 [功能]，以便 [收益]

**验收标准:**
1. WHEN [触发条件] THE SYSTEM SHALL [期望行为]
2. WHEN [异常条件] THE SYSTEM SHALL [错误处理]
3. IF [可选条件] THEN THE SYSTEM SHALL [条件响应]

### 需求 2: [标题] [Must Have]

**用户故事:** 作为 [角色]，我想要 [功能]，以便 [收益]

**验收标准:**
1. WHEN [触发条件] THE SYSTEM SHALL [期望行为]

### 需求 3: [标题] [Nice to Have]

**用户故事:** 作为 [角色]，我想要 [功能]，以便 [收益]

**验收标准:**
1. WHEN [触发条件] THE SYSTEM SHALL [期望行为]

## 成功指标

[可量化指标。]

## 约束条件

[限制。]

## 不在范围内

[排除项。任务拆解交给下游，不在此文档。]

---

> 书写规范见 references/ears-syntax-guide.md。优先用 Event-driven（When/SHALL）与 Unwanted behavior（If/Then/SHALL）。每条只描述一个行为，编号保持需求→任务可追溯。
