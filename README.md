# 需求澄清工作流 · Requirement Discovery (`/define-problem`)

把模糊的想法，通过结构化对话变成清晰、可确认、可测试的需求与 PRD —— 让 AI 先当**探索者**（问题值不值得解决）、再当**策略师**（有没有现成轮子可复用），最后才碰实施。仓库同时包含面向 Claude Code 的命令和可供 Codex / 兼容 Agent 使用的 Skills。

> 解决的核心痛点：AI 收到需求就急着跳进技术实施（一上来问技术栈），跳过了"这值不值得做、有没有现成轮子、问题到底是什么"。

## 它做什么

`/define-problem 我想做一个……` 触发一位"资深产品顾问"与你对话 2-5 轮，然后产出：

职责单一、互相引用，不重复内容：

| 文档 | 层 | 给谁看 | 内容 |
|------|-----|--------|------|
| `problem-definition.md` | WHY | 人 | 问题、动机、当前替代方案+土办法、市场洞察、假设三级（引用 persona/scenarios） |
| `persona.md` | WHO | 人 | 1-2 个用户画像：背景/目标/痛点/决策角色 |
| `scenarios.md` | 怎么用 | 人 | 3-5 个核心使用场景（含异常场景） |
| `prd.md` | WHAT | 人 | 产品需求：功能 Must/Nice/Out、成功指标、范围，3-30-300 架构（**不含市场洞察**） |
| `requirements-ears.md` | WHAT(可测试) | AI/开发 | 把 PRD 功能形式化为 EARS 验收标准（auto-dev 的 PRD 输入） |
| `design.md` | HOW | 人/AI | 技术方案（**先联网调研"有无现成轮子"再选型**） |
| `test-plan.md` | 验证 | 人 | 宏观测试：场景测试 + 端到端 + 验收映射（细粒度单测交 auto-dev） |

输出到项目 `docs/specs/`。小需求（< 1 天工作量）自动走轻量模式，只产 `problem-definition.md` + 精简 `prd.md`，避免文档过载。

## 方法论亮点

- **高价值问题队列**：按影响 × 不确定性 × 不可逆性 ÷ 回答成本选择下一问
- **权威路由**：事实由 AI 查，价值/优先级/红线由用户定，市场行为由证据或实验回答，体验问题用原型回答
- **用途分流**：个人自用、组织内部、商业创业采用不同价值闸门；只有商业路线使用 office-hours 式市场验证
- **状态账本**：事实、用户决定、AI 推测、开放项、延后项与排除项绝不混写
- **消歧三法**：直接追问 / 对比锚定 / 场景验证（含反例）——让关键行为和边界足够执行、足够验收
- **五种开发者状态 + 逐话题自适应**：不给人贴标签走流程
- **设计思维隐性嵌入**：土办法挖掘（需求真实性最强证据）、止痛药测试（过滤 Must Have）、Five Whys 化为追问节奏
- **默认答案三级策略**：把握大→陈述确认；几个选项→给选项；动机愿景→开放式
- **假设分级**：✓已验证 / ⚠️合理 / ❓待验证，优先验证高风险假设
- **价值判断闸门**：调研现有方案后给 go/no-go，先有市场洞察再考虑实施
- **规模护栏**：小需求跳过重流程（应对 spec-driven 被诟病的"小任务负收益"）
- **双确认门**：先确认共同理解，再确认规格可执行；沉默不等于同意

设计依据见末尾的调研来源。

## 组件结构

```
commands/define-problem.md              # 主线程对话命令（可用 AskUserQuestion）
agents/doc-generator.md                 # 文档生成子代理（子代理无法交互，故对话留主线程）
skills/requirement-discovery/
  SKILL.md
  references/elicitation-playbook.md    # 完整需求挖掘方法论
  references/ears-syntax-guide.md       # EARS 五模式语法
  references/html-rendering-guide.md    # 人读文档→图文并茂 HTML（mermaid+SVG）
  templates/{problem-definition,persona,scenarios,prd,requirements-ears,design,test-plan}.md
skills/management-context-interview/
  SKILL.md                              # 创业者 / 高管 / 负责人管理上下文访谈
  references/context-card.md            # 企业管理上下文卡模板
  references/strategy-okr.md             # 战略与年度 OKR 专用路由
skills/venture-opportunity-review/
  SKILL.md                              # 仅商业创业项目的机会验证
  references/opportunity-review.md      # 商业机会验证卡模板
docs/research/clarification-skills-landscape-20260903.md
```

> **HTML 版**：交付时默认为给人看的文档（problem-definition / persona / scenarios / prd / design / test-plan）生成单文件、图文并茂的 HTML（mermaid 图表 + SVG/CSS 卡片，不调 AI 生图，高对比易读），输出到 `docs/specs/html/`。可说"跳过 HTML"。

## 安装

```bash
./install.sh          # 先归档旧版本，再复制到 ~/.claude/
```

然后**手动**在 `~/.claude/CLAUDE.md` 的「需求澄清」段落追加一行（见 `CLAUDE.md.snippet`，install.sh 不会自动改你的全局 CLAUDE.md）。

重启/重载 Claude Code 窗口后，即可 `/define-problem ...`。

## 企业管理上下文访谈

`management-context-interview` 适合创业者、企业高管、业务/职能负责人和领域专家。它围绕一个真实管理主题一次一问，最终生成由本人确认的“企业管理上下文卡”，严格区分用户陈述、已确认判断、AI 推测、外部证据和开放项。它覆盖战略与年度 OKR、重要管理决策、“什么叫做好”和组织暗知识萃取；不是审问或给建议，而是把管理者脑中的判断标准变成团队可复用的上下文。

一次使用 DeepSeek V4 Flash 模拟“年度战略与 OKR”访谈的完整原始对话、问题分析和修订后回归结果，见 [`docs/evaluations/management-context-interview-deepseek-v4-flash-20260903.md`](docs/evaluations/management-context-interview-deepseek-v4-flash-20260903.md)。

完整竞品比较与第一性原理推导见 [`docs/research/clarification-skills-landscape-20260903.md`](docs/research/clarification-skills-landscape-20260903.md)。

## 三个 Skill，三种终点

| Skill | 什么时候用 | 终点 |
|---|---|---|
| `management-context-interview` | 需要把创业者、高管或负责人的隐性判断说清楚 | 本人确认的企业管理上下文卡与是/否评估表 |
| `venture-opportunity-review` | 明确要验证面向外部市场的商业创业机会 | 停止 / 先验证 / 推进最窄楔子的阶段建议 |
| `requirement-discovery` | 已经决定要把某个产品或工具做清楚 | 经确认、可测试、可追溯的需求与 PRD |

`requirement-discovery` 内部再按个人自用、组织内部、商业创业做价值路由；只有商业创业分支调用 `venture-opportunity-review`。这样个人小产品不会被迫回答 TAM、付费与分发问题，而商业项目也不会跳过必要的机会验证。

## 在工作流生态中的位置

```
/define-problem → [新项目: doc-standard 初始化文档结构]
               → research 调研 → 价值闸门(go/no-go) → design.md
                                                    ↓
                          auto-dev(消费 requirements-ears.md) → closed-loop-test
```

任务拆解（tasks）不在本工作流——交给下游 auto-dev / Plan Mode。

## 关键约束

**Subagent 无法使用 AskUserQuestion**，所以所有用户对话在 Slash Command（主线程）完成，Subagent 只负责对话结束后的文档生成。

## 设计来源

方法论综合自：原始需求澄清 spec + 业界调研（Matt Pocock grill-me、gstack office-hours、Superpowers brainstorming、GitHub Spec Kit、GSD、BMAD、OpenSpec、AWS Kiro 的 EARS 实践、JTBD）及其反驳视角（问卷疲劳、AI 锚定、spec drift、小任务负收益、EARS 的半结构化局限）。

> 文件中引用的 `~/AI工作流/docs/research/...`、`~/projects/...` 等为作者本机路径，仅作参考指针，不影响功能。

## License

MIT
