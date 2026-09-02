---
name: requirement-discovery
description: 需求澄清与 PRD 生成的方法论、文档模板与参考资料。当用户用 /define-problem 启动结构化需求澄清，或需要把模糊想法变成清晰无歧义的需求文档（problem-definition / scenarios / EARS / design）时使用。承载消歧三法、五种开发者状态、设计思维五要素、EARS 语法。关键词：需求澄清、定义问题、PRD、问题定义、EARS、需求文档、define-problem。
---

# Requirement Discovery Skill

为「需求澄清 → PRD」工作流（`/define-problem` 命令）提供方法论、文档模板和参考资料。核心理念：让 AI 先当**探索者→策略师→实施者**，把模糊想法变成清晰、无歧义的需求，而非急着跳进技术实施。

## 目录

```
references/
  elicitation-playbook.md   — 需求挖掘方法论（问题价值排序 / 权威路由 / 消歧 / 状态账本 / 价值闸门）
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
  discovery-state.md        — 对话中断恢复用的二维状态账本
```

## 使用方式

- **`/define-problem` 命令（主线程）**：对话澄清阶段读 `references/elicitation-playbook.md` 获取完整方法论。
- **doc-generator 子代理**：生成文档时读取 `templates/` 与 `references/ears-syntax-guide.md`，模板提供结构框架，内容据对话成果填充。
- 输出目录：项目 `docs/specs/`（不存在则创建）。

## 核心运行原则

- 先读现有文档、代码和证据，再向用户提问；事实由 AI 查，价值与优先级由用户定。
- 按 `影响 × 不确定性 × 不可逆性 ÷ 回答成本` 动态选择高价值未知项，每轮只问 1–3 个问题。
- 用二维状态分开记录认知来源（证据/用户陈述/已确认决定/AI 推测）与工作状态（阻塞/开放/延后/默认/排除），推测不得冒充用户意见。
- 每轮把状态写入 `docs/specs/.discovery-state.md`，让长对话可中断恢复。
- 抽象体验难以说清时，用低成本样例 / 原型消歧；共同理解确认后才转写 PRD。

## 交互完整性确认（提交后必做）

在 PRD、设计与测试交付前，确认所有交互入口与结果都形成闭环：

1. 每个界面 / 原型入口都能追溯到一条功能需求与验收标准。
2. 对代码中的按钮、链接、快捷键、命令和 API 入口做反向扫描，避免文档漏项。
3. 每个入口都定义正常状态、加载/空/错误等关键状态，以及逆向流程与错误恢复。
4. 用户旅程覆盖入口、主路径、退出/取消、异常恢复、权限差异、数据边界与最终反馈。
5. 每条需求至少有一个覆盖测试；高风险需求包含能证明实现不是“假通过”的负向或反例测试。

发现缺口时回到澄清层，不用文档措辞掩盖未知项。

## 在工作流生态中的位置

```
/define-problem → [新项目: doc-standard/doc-init]
   → 探索层: problem-definition + persona + scenarios → 🔴确认探索层
   → 用途路由: 个人价值 / 内部采用 / venture-opportunity-review(仅商业创业)
   → research(/research) 现成方案与复用分析
   → prd + requirements-ears → 🔴确认 PRD
   → design.md → test-plan.md(宏观测试) → html(图文并茂, 默认开可关)
        ↓
   auto-dev(消费 requirements-ears.md 作 PRD 输入 + test-plan.md 宏观测试基准, 补细粒度单测) → closed-loop-test
```

任务拆解（tasks）不在本 skill 范围——交给下游 auto-dev / Plan Mode。
