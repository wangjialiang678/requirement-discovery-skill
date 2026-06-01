---
name: requirement-discovery
description: 需求澄清与 PRD 生成的方法论、文档模板与参考资料。当用户用 /define-problem 启动结构化需求澄清，或需要把模糊想法变成清晰无歧义的需求文档（problem-definition / scenarios / EARS / design）时使用。承载消歧三法、五种开发者状态、设计思维五要素、EARS 语法。关键词：需求澄清、定义问题、PRD、问题定义、EARS、需求文档、define-problem。
---

# Requirement Discovery Skill

为「需求澄清 → PRD」工作流（`/define-problem` 命令）提供方法论、文档模板和参考资料。核心理念：让 AI 先当**探索者→策略师→实施者**，把模糊想法变成清晰、无歧义的需求，而非急着跳进技术实施。

## 目录

```
references/
  elicitation-playbook.md   — 需求挖掘方法论（消歧三法 / 五种开发者状态 / 默认答案策略 / 设计思维五要素 / 价值闸门）
  ears-syntax-guide.md      — EARS 五模式语法参考
  html-rendering-guide.md   — 人读文档→图文并茂 HTML（mermaid+SVG/CSS，不调 AI 生图）
templates/
  problem-definition.md     — 问题定义（WHY：问题/动机/替代方案/市场洞察/假设）
  persona.md                — 用户画像（WHO）
  scenarios.md              — 场景需求（怎么用，含异常场景）
  prd.md                    — 产品需求（WHAT：功能/成功指标/范围，3-30-300）
  requirements-ears.md      — EARS 验收标准（给 AI 执行，兼容 auto-dev）
  design.md                 — 技术方案（需联网调研后生成）
  test-plan.md              — 宏观测试方案（场景测试+端到端+验收；细粒度单测交 auto-dev）
```

## 使用方式

- **`/define-problem` 命令（主线程）**：对话澄清阶段读 `references/elicitation-playbook.md` 获取完整方法论。
- **doc-generator 子代理**：生成文档时读取 `templates/` 与 `references/ears-syntax-guide.md`，模板提供结构框架，内容据对话成果填充。
- 输出目录：项目 `docs/specs/`（不存在则创建）。

## 在工作流生态中的位置

```
/define-problem → [新项目: doc-standard/doc-init]
   → 探索层: problem-definition + persona + scenarios → 🔴确认探索层
   → research(/research) 价值闸门(go/no-go)
   → prd + requirements-ears → 🔴确认 PRD
   → design.md → test-plan.md(宏观测试) → html(图文并茂, 默认开可关)
        ↓
   auto-dev(消费 requirements-ears.md 作 PRD 输入 + test-plan.md 宏观测试基准, 补细粒度单测) → closed-loop-test
```

任务拆解（tasks）不在本 skill 范围——交给下游 auto-dev / Plan Mode。
