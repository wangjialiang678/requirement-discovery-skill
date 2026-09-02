# 产品需求文档（PRD）：[项目名称]

> 聚焦"**做什么**"。背景见 `problem-definition.md`，用户见 `persona.md`，场景见 `scenarios.md`。
> **不重复市场洞察 / 当前替代方案**（那些属于问题定义层）。

<!-- 初稿日期: YYYY-MM-DD ｜ 最近 review: YYYY-MM-DD ｜ 相关: problem-definition.md · persona.md · scenarios.md · requirements-ears.md -->

## 执行摘要

- **一句话（3 秒）**：[这个产品是什么]
- **30 秒**：目标 + 核心功能 3-5 条 + 成功指标
- 下文为完整内容（5 分钟读完）

## 产品目标

[这个产品要达成什么？尽量可量化。它如何回应 problem-definition.md 里的问题。]

## 功能需求

### 必须有（止痛药测试通过：没有会非常痛苦）
- **[REQ-001]** [需求]（来源：SCN-___；EVID/DEC-___）
- **[REQ-002]** [需求]（来源：SCN-___；EVID/DEC-___）

### 最好有（没有只是有点不便）
- **[REQ-NNN]** [需求]（来源：SCN-___；EVID/DEC-___）

### 明确不做（Out of Scope）
- [排除项及原因]

## 成功指标

[怎样算"做好了"？可观察、可量化的标准。]

## 范围与依赖

- **In scope**：[本期要做的边界]
- **Out of scope**：[明确不在本期]
- **外部依赖**：[依赖的服务/数据/团队]

## 未解项处理

| 项目 | 状态（BLOCKER / DEFERRED / DEFAULT） | 对范围或验收的影响 | 负责人 / 触发时点 |
|---|---|---|---|
|  |  |  |  |

## 🔴 关键决策点

> 🔴 **需要确认**: [决策问题]
> [为什么这个决策重要]

## 验收标准

功能需求的可测试形式化见 `requirements-ears.md`（EARS 格式，供 AI / auto-dev 执行）。

## 追溯关系

每条 `REQ-NNN` 应能追溯到 `SCN-NNN`、`EVID/DEC-NNN` 和 `AC-NNN`；每条 `AC-NNN` 至少链接一个 `TEST-NNN`。生成后检查孤儿需求、孤儿验收和孤儿测试；无法追溯的内容需删除或标为待确认。
