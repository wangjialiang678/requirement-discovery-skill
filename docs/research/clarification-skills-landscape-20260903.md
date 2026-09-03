# AI 主动提问与需求澄清 Skills 调研

> 调研日期：2026-09-03。GitHub Star / Fork 是仓库级热度快照，不等于单个 Skill 的质量或使用量。本文把源码中明确规定的行为视为事实；适用性判断与设计建议标为“推导”。

## 结论先行

这些 Skill 表面上都在“让 AI 问问题”，实质上解决的是三个不同问题：

1. **压力测试一个想法**：`grill-me` 追到决策树前沿为空，让隐含选择暴露出来。
2. **把产品意图变成可执行规格**：Spec Kit、Superpowers、GSD、BMAD、OpenSpec 与本仓库 `requirement-discovery`，重点是范围、边界、验收和确认门。
3. **萃取人的判断标准**：管理者 / 专家访谈重点不是完整规格，而是忠实记录其目标、证据、取舍、红线和例外，防止 AI 的观点污染原始上下文。

因此，不应把所有模式串成一套巨型问卷。更好的架构是共享一个提问内核，并保留三个用途明确的 Skill：

- `requirement-discovery`：产品开发前的需求澄清，终点是经过确认、可测试、可追溯的 PRD 基线。
- `management-context-interview`（界面名“企业管理上下文访谈”）：课程或真实管理场景中的隐性知识萃取，终点是经过本人确认的企业管理上下文卡。
- `venture-opportunity-review`：只用于商业创业机会，终点是停止、先验证或推进最窄市场楔子的阶段建议。

## 一、重点样本对比

| Skill / 工作流 | 仓库热度快照 | 它最擅长解决什么 | 提问机制 | 产物与停止条件 | 独特价值 | 主要风险 |
|---|---:|---|---|---|---|---|
| [Matt Pocock / grill-me](https://www.aihero.dev/skills-grill-me) | `mattpocock/skills` 244,868★ / 20,822 forks | 任意模糊想法的压力测试 | 每轮询问当前所有前置条件已满足的问题；答案打开新分支 | 无文件、无持久状态；“问题前沿为空”停止 | 通用、便携；承认有些问题只能靠原型回答 | 一轮可达数十问；无持久证据链；用户易被选项锚定或被动点头 |
| [gstack / office-hours](https://github.com/garrytan/gstack/tree/main/office-hours) | 131,120★ / 19,665 forks | 创业想法与产品方向诊断 | Startup 模式追需求证据、当前替代、具体用户、最窄楔子、意外发现、未来契合；模糊答案下钻 1–2 层 | 多方案比较、设计文档、决策与排除理由；评审后确认 | 把“有人说想要”推进到行为证据、付费楔子和前提挑战 | YC 风格可能把增长偏好带入所有场景；流程偏重 |
| [Superpowers / brainstorming](https://github.com/obra/superpowers/blob/main/skills/brainstorming/SKILL.md) | 280,750★ / 25,156 forks | 创意工作开始前形成设计共识 | 先按 Spike / Bounded / Architectural 分级，再澄清目标、约束、成功与方案 | 分段展示设计并获人类批准后才实施 | 深度随风险缩放，但确认门不消失 | 对非代码决策和知识萃取不够自然 |
| [GitHub Spec Kit / clarify](https://github.com/github/spec-kit/blob/main/templates/commands/clarify.md) | 133,040★ / 11,966 forks | 让已有规格达到可计划、可测试 | 扫描功能、数据、UX、NFR、依赖、边界、术语、验收等缺口；按影响×不确定性排序，最多约 5 个高价值问题 | 每个答案立即写回 spec；高影响歧义消除或达到配额停止 | 最像“需求质量闸门”，约束强、重复性好 | 假如最初问题定义错了，可能把错误方向写得非常精确 |
| [GSD](https://github.com/gsd-build/get-shit-done) | 64,604★ / 5,458 forks | 从目标到阶段上下文 | WHAT 与 HOW 分开；目标、边界、约束、验收评分；按角色找缺口 | CURRENT / TARGET / IN / OUT / 可验证需求与歧义分数 | 显式管理状态与停止阈值 | 评分看似精确，实际仍依赖模型判断 |
| [BMAD Method](https://github.com/bmad-code-org/BMAD-METHOD) | 52,596★ / 5,983 forks | 从创意、研究到 PRD 的协作式分析 | 先 brain dump；按 stakes 选 Fast / Coaching；多角色评审 | Brief / PRD、假设、开放项、排除项、决策记忆 | 高风险任务加深、保留决策历史 | 角色和文档较多，容易仪式化 |
| [OpenSpec](https://github.com/Fission-AI/OpenSpec) | 67,043★ / 4,616 forks | 对现有系统提出可审查的变更 | Explore 阶段保持开放；Propose 只问影响范围/兼容/验收的主要歧义 | proposal、delta spec、design、tasks；后续显式 apply | 探索与正式承诺分离；用变更增量而非重写全规格 | 更适合已有代码库，不是早期商业问题发现工具 |

补充：gstack 仓库在调研时自报累计 24,817 次 office-hours session、14,965 installs、305,309 skill calls；这是项目方遥测口径，不能等同于独立审计数据。

## 二、`grill-me` 的技术原理与步骤

`grill-me` 不是固定问题表，而是一个**隐式决策树遍历器**。

1. 用户提供一个松散想法。
2. AI 建立当前已知事实、尚未拍板的决策与依赖关系。
3. 找到“问题前沿”：前置条件已经确定、现在可以回答的问题。
4. 一轮提出整个前沿上的问题；互相依赖的问题留到下一轮。
5. 用户回答后，决策树展开新的分支，再计算前沿。
6. 遇到“说不清、必须看东西才知道”的问题，停止语言追问，做一次性原型后再回来判断。
7. 当前范围内不再有沉默假设时停止；上下文留在对话中，可接 `to-spec`，但 Skill 本身不写文件。

它最重要的贡献不是“问得狠”，而是两点：

- **依赖感知**：不在前提未定时提前问下游细节。
- **承认语言的边界**：体验、布局、手感等问题需要原型，不应无限换一种问法。

它与 `define-problem` 的关系是“同一族，不同终点”。两者都做动态追问和隐含假设暴露；`grill-me` 是无状态、跨场景的思维压力测试，`define-problem` 是有状态、面向产品研发的规格生产线，后者还要处理证据、范围、现成方案、EARS、测试追溯和两次确认门。

## 三、其他提问场景

| 场景 | 代表机制 | 人类拥有的权威 | 适合产物 |
|---|---|---|---|
| 专家知识萃取 | STORM：根据已有观点、未使用证据和对话历史生成下一问 | 经验中的例外、判断线索 | 主题图谱 / 专家上下文卡 |
| 表单与业务收集 | Rasa Collect：显式 slot，缺什么问什么；类型校验失败就重问 | 正确字段值与授权 | 完整、校验通过的结构化记录 |
| 文档共创 | Anthropic doc-coauthoring：先收上下文，再逐节候选与选择，最后冷读测试 | 写作目的、受众、取舍 | 可被陌生读者理解的文档 |
| 苏格拉底教学 | 一次一个引导问题，卡住时给脚手架，最后让学习者复述 | 自己是否真正理解 | 学习者自己的解释与迁移答案 |
| 教练 / 人生决策 | 事实、假设、偏好、选择分离；方案作为可回退实验 | 价值观与人生代价 | 决策记录 / 小实验 |
| 故障诊断 | 症状→复现→边界→证据→最小排除实验 | 现场上下文、复现事实 | 可证伪的故障假设树 |
| 研究访谈 | 开放叙事→关键事件→行为证据→反例→成员确认 | 亲历事实与意义解释 | 经受访者确认的研究笔记 |

这些场景证明：好提问并不总是“多问”。Slot 收集追求完整字段；教学追求学习者认知变化；产品澄清追求可执行规格；管理上下文访谈追求观点忠实度。停止条件必须由场景目标决定。

## 四、第一性原理推导

### 4.1 根本问题

AI 做错事通常不是因为少了一份长问卷，而是因为：

`行动关键的信息缺口 + 回答权威分配错误 + 隐含假设没有显性化`

由此得到最小提问内核：

1. **先读上下文**：从文件、代码、历史决策和公开资料拿到可查事实。
2. **维护状态**：事实 / 证据、用户决定、AI 推测、开放项、延后项、排除项分开。
3. **识别权威**：事实由工具和证据回答；价值、优先级、红线由人回答；市场行为由实验回答；体验由原型回答。
4. **选择下一问**：最大化 `影响 × 不确定性 × 不可逆性 ÷ 回答成本`。
5. **把抽象变成可观察**：追真实案例、正反例、边界、当前土办法和失败条件。
6. **答案改变下一问**：问题队列是动态树，不是固定清单。
7. **立即沉淀**：答案随时写入状态账本，保留证据、推测和被排除理由。
8. **明确停止**：达到“适合下一步行动”的标准，而非追求穷尽世界。
9. **人类确认**：先确认共同理解，再确认规格可执行；不能把沉默当同意。

### 4.2 对产品研发的最低充分条件

进入 PRD 前，至少应能回答：

- 为什么现在要解决，谁在什么场景受影响？
- 有什么真实行为证据，用户现在怎么凑合？
- 最窄但仍有价值的闭环是什么？
- 什么在范围内，什么明确不做？
- 哪些约束与红线不能被优化掉？
- 怎样观察到成功，怎样算即使“功能正常”也失败？
- 哪些是事实、用户决定、AI 推测和待验证假设？

未解项不必全部消灭，但必须被归类为 `BLOCKER`、`DEFERRED` 或可回退的 `DEFAULT`。

## 五、对 `define-problem` 的改造决策

先做一个关键分流：`define-problem` 覆盖个人自用、组织内部与商业创业三类产品。`office-hours` 的行为/付费证据、市场楔子与分发检查只进入商业创业分支；个人产品可以因为“我有真实痛点、会持续使用、开发维护成本可接受”而成立，不需要证明市场前景。组织内部工具则看流程净收益、采用与治理成本。

本次吸收的核心要素：

- 从 Spec Kit 吸收高影响歧义扫描与答案即时回填。
- 从 `grill-me` 吸收依赖感知的问题前沿与“原型逃生口”。
- 从 office-hours 吸收行为证据、当前替代、最窄楔子、前提挑战、替代方案及排除理由。
- 从 Superpowers / BMAD 吸收按 stakes 缩放深度，以及共同理解确认门。
- 从 GSD 吸收 WHAT / HOW 分离和显式状态管理。
- 从 OpenSpec 吸收探索与正式承诺分离、增量变更意识。
- 保留原 Skill 已有的土办法、止痛药测试、Must/Nice/Out、go/no-go、EARS、场景→需求→测试追溯与交互完整性检查。

没有吸收的部分：`grill-me` 一轮几十问的默认规模、gstack 的 YC 价值偏好、多个框架串行运行、伪精确的自动评分。这些会增加疲劳或把外部价值观偷偷带进用户决策。

## 六、课程适配：为什么不叫 Grill Me Lite

“Grill”强调压力测试，适合对想法找漏洞；你的课程更核心的动作是**让管理者把隐性判断说出来，并让团队以后能复用**。考虑创业者、高管、业务负责人都可能是受访者，因此正式名称调整为“企业管理上下文访谈”（内部名 `management-context-interview`）。

建议课堂结构：

1. 学员选择一个正在发生的真实业务决策。
2. 管理者先自由讲 2–3 分钟。
3. AI 一次一问，共 6–8 问；优先目标、证据、判断标准、红线、反例和条件变化。
4. 每 2–3 问做一次带状态标签的镜像回放。
5. 生成一页决策上下文卡，标明 `CONFIRMED / INFERRED / OPEN`。
6. 管理者勾选“表达准确”和“无 AI 推测冒充本人意见”。
7. 团队用一个新案例做回放测试：能否仅凭卡片做出与管理者一致的判断。

这一版本可以同时用于蚂蚁课程和个人项目：课程用 6–8 问的快速模式；真实项目用深度模式，直到没有会显著改变建议、风险或验收的高影响未知项。

## 参考来源

- [AI Hero: The /grill-me Skill](https://www.aihero.dev/skills-grill-me)
- [mattpocock/skills](https://github.com/mattpocock/skills)
- [gstack office-hours](https://github.com/garrytan/gstack/tree/main/office-hours)
- [Superpowers brainstorming](https://github.com/obra/superpowers/blob/main/skills/brainstorming/SKILL.md)
- [GitHub Spec Kit clarify](https://github.com/github/spec-kit/blob/main/templates/commands/clarify.md)
- [GSD](https://github.com/gsd-build/get-shit-done)
- [BMAD Method](https://github.com/bmad-code-org/BMAD-METHOD)
- [OpenSpec](https://github.com/Fission-AI/OpenSpec)
- [Stanford STORM](https://github.com/stanford-oval/storm)
- [Rasa Collect](https://rasa.com/docs/studio/build/flow-building/collect/)
- [Anthropic doc-coauthoring](https://github.com/anthropics/skills/tree/main/skills/doc-coauthoring)
