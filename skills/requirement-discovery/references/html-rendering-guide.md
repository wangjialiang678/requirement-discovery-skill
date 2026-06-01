# HTML 渲染指南（图文并茂，自动图表）

把"给人看"的需求文档渲染成**单文件、图文并茂的 HTML**。**用确定性的图表/示意图（mermaid + SVG/HTML 卡片），不调用 AI 生图**——快、信息密度高、不耗 token。

## 何时 / 哪些文档

- **时机**：交付时**默认生成**；用户说"跳过 HTML"则不生成。
- **范围（给人看的）**：`problem-definition` · `persona` · `scenarios` · `prd` · `design` · `test-plan`。
- **不渲染**：`requirements-ears.md`（给 AI 执行，非人读）。
- **输出**：`docs/specs/html/<name>.html`（每篇一个独立文件）。

## 技术约束

- **单文件 standalone**：内嵌 CSS，不依赖本地资源。
- **图表用 mermaid**：通过 CDN 引入 `mermaid.js`（`https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js`），客户端渲染流程图/架构图/旅程图。HTML 顶部注释提示"图表需联网渲染"。
- **卡片/矩阵用语义化 HTML + CSS**（必要时内联 SVG），不用位图。
- **不调用 nano-banana 等 AI 生图**。
- 美学参考 `frontend-design` 技能：避免通用 AI 风，排版克制专业。**高对比、易读**（深色文字/浅底或反之，确保正文与背景对比充足）。

## 每类文档建议的图

| 文档 | 建议可视化 |
|------|-----------|
| problem-definition | 顶部一句话摘要 banner；**假设三级**用三色卡（✓绿/⚠️黄/❓灰）；当前替代方案"正式/土办法/忍着"对比卡 |
| persona | **persona 卡片**（首字母色块或 emoji 头像，不用 AI 图）：背景/目标/痛点/决策角色分区 |
| scenarios | 每个场景一张 **mermaid 用户旅程/流程图**（flowchart 或 journey）；异常分支高亮 |
| prd | **功能需求三栏看板**（必须有/最好有/明确不做）；REQ 编号徽章；3-30-300 信息层级（摘要置顶卡） |
| design | **mermaid 架构图 + 数据流图**；技术选型表（含事实/推测标记与来源链接） |
| test-plan | **需求→测试 追溯矩阵**（高亮表格，覆盖缺口标红）；mermaid 测试场景/端到端流程图 |

## 结构模板（每个 HTML）

1. `<head>`：内嵌 CSS + mermaid CDN + `mermaid.initialize({startOnLoad:true})`
2. 顶部：标题 + 一句话摘要 banner + 文档元信息（日期、相关文档链接，互相 `<a href>` 跳转）
3. 正文：markdown 内容转 HTML，章节卡片化
4. 图表：mermaid `<pre class="mermaid">` 代码块 / 内联 SVG 卡片
5. 底部：与其他 HTML 文档的导航链接（problem-definition ↔ persona ↔ scenarios ↔ prd ↔ design ↔ test-plan）

## 注意

- 图来自**文档内容**，不要编造数据；矩阵/旅程要忠实映射 md 里的需求与场景。
- 保持 md 为单一事实源，HTML 是其可视化视图；md 更新后重新生成 HTML。
