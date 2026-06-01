# 需求澄清工作流 · Requirement Discovery (`/define-problem`)

把模糊的想法，通过结构化对话变成清晰、无歧义的需求与 PRD —— 让 AI 先当**探索者**（问题值不值得解决）、再当**策略师**（有没有现成轮子可复用），最后才碰实施。专为 Claude Code 设计的 Slash Command + Subagent + Skill 组合。

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

- **消歧三法**：直接追问 / 对比锚定 / 场景验证（含反例）——目标是完全无歧义
- **五种开发者状态 + 逐话题自适应**：不给人贴标签走流程
- **设计思维隐性嵌入**：土办法挖掘（需求真实性最强证据）、止痛药测试（过滤 Must Have）、Five Whys 化为追问节奏
- **默认答案三级策略**：把握大→陈述确认；几个选项→给选项；动机愿景→开放式
- **假设分级**：✓已验证 / ⚠️合理 / ❓待验证，优先验证高风险假设
- **价值判断闸门**：调研现有方案后给 go/no-go，先有市场洞察再考虑实施
- **规模护栏**：小需求跳过重流程（应对 spec-driven 被诟病的"小任务负收益"）

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
```

> **HTML 版**：交付时默认为给人看的文档（problem-definition / persona / scenarios / prd / design / test-plan）生成单文件、图文并茂的 HTML（mermaid 图表 + SVG/CSS 卡片，不调 AI 生图，高对比易读），输出到 `docs/specs/html/`。可说"跳过 HTML"。

## 安装

```bash
./install.sh          # 复制到 ~/.claude/（commands / agents / skills）
```

然后**手动**在 `~/.claude/CLAUDE.md` 的「需求澄清」段落追加一行（见 `CLAUDE.md.snippet`，install.sh 不会自动改你的全局 CLAUDE.md）。

重启/重载 Claude Code 窗口后，即可 `/define-problem ...`。

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

方法论综合自：原始需求澄清 spec + 业界调研（GitHub Spec-Kit、AWS Kiro 的 EARS 实践、BMAD elicitation、JTBD painkiller/vitamin、需求 elicitation 中 observation>interview）及其反驳视角（spec-driven 的瀑布复辟/spec drift/小任务负收益、EARS 的半结构化局限）。

> 文件中引用的 `~/AI工作流/docs/research/...`、`~/projects/...` 等为作者本机路径，仅作参考指针，不影响功能。

## License

MIT
