# 重点
生成的需求或者其他文档，用中文，如果生成了，改成中文
本项目所有开发决策均应优先服务于 MVP 验证目标。
如需求不明确，应优先选择最简单、最快速、最易维护的实现方案，避免过度设计和提前优化。

# AI 绘本老师

## 产品概述

AI 绘本老师是一款面向 3-6 岁幼儿园儿童的 AI 绘本学习应用。

产品目标：

通过绘本阅读、语音讲故事和互动问答，培养儿童的阅读兴趣、语言理解能力和表达能力。

核心原则：

* 简单易用
* 儿童友好
* 无需注册
* 优先移动端体验
* 优先验证产品价值
* 避免复杂功能

---

# 目标用户

* 3-6 岁幼儿园儿童

---

# 技术要求

除非仓库现有技术栈有明确约束，否则优先采用以下方案：

## 前端

* Next.js
* TypeScript
* Tailwind CSS

## 状态管理

* React Hooks
* Context API

避免引入额外状态管理库。

## AI 服务

* OpenAI API

## 语音能力

MVP 阶段优先使用免费的浏览器语音合成 API（Speech Synthesis API）实现故事朗读。

- 不依赖任何付费服务
- 保证可在大部分现代浏览器上运行
- 可根据后续需要升级到 OpenAI TTS 或其他付费服务
## 测试

* Vitest
* React Testing Library

---

# MVP 功能需求

## 绘本故事库

提供少量预置经典绘本故事。

例如：

* 三只小猪
* 龟兔赛跑
* 小红帽
* 狮子与老鼠
* 丑小鸭

MVP 阶段可使用静态数据存储。

---

## 绘本阅读

儿童可以：

* 浏览绘本
* 打开绘本
* 阅读故事内容
* 查看插图

要求：

* 大按钮设计
* 简单操作流程
* 适合儿童使用

---

## AI 语音讲故事

系统自动朗读绘本内容。

支持：

* 开始播放
* 暂停播放
* 继续播放

要求：

* 语音自然清晰
* 自动按顺序朗读故事内容

---

## 互动问答

故事结束后自动进入问答环节。

要求：

* 每个故事提供 3 个简单问题
* 使用选择题形式
* 儿童通过点击选项作答

示例：

问题：

兔子为什么输了比赛？

选项：

* 因为睡着了
* 因为迷路了
* 因为回家了

---

## 鼓励反馈

回答后立即给予反馈。

回答正确：

“太棒了，你答对啦！”

回答错误：

“没关系，我们再试试！”

要求：

* 使用积极鼓励语言
* 不出现批评或负面评价

---

## 星星奖励

完成学习后给予奖励。

规则：

* 完成一个故事：⭐ +1
* 完成全部问题：⭐ +1

首页展示累计获得的星星数量。

---

# MVP 范围之外

以下功能不属于当前阶段：

* 用户注册
* 用户登录
* 家长端
* 会员订阅
* 支付系统
* 社交功能
* 用户上传绘本
* AI 自由聊天
* 语音识别
* 视频生成
* AR / VR 功能
* 多语言支持
* 课程体系管理

---

# 成功标准

儿童无需家长帮助即可完成以下流程：

1. 打开应用
2. 选择绘本
3. 听故事
4. 回答问题
5. 获得反馈
6. 获得星星奖励

整个学习过程应简单、流畅且有趣。


































# Symphony Elixir

This directory contains the Elixir agent orchestration service that polls Linear, creates per-issue workspaces, and runs Codex in app-server mode.

## Environment

- Elixir: `1.19.x` (OTP 28) via `mise`.
- Install deps: `mix setup`.
- Main quality gate: `make all` (format check, lint, coverage, dialyzer).


## Codebase-Specific Conventions

- Runtime config is loaded from `WORKFLOW.md` front matter via `SymphonyElixir.Workflow` and `SymphonyElixir.Config`.
- Keep the implementation aligned with [`../SPEC.md`](../SPEC.md) where practical.
  - The implementation may be a superset of the spec.
  - The implementation must not conflict with the spec.
  - If implementation changes meaningfully alter the intended behavior, update the spec in the same
    change where practical so the spec stays current.
- Prefer adding config access through `SymphonyElixir.Config` instead of ad-hoc env reads.
- Workspace safety is critical:
  - Never run Codex turn cwd in source repo.
  - Workspaces must stay under configured workspace root.
- Orchestrator behavior is stateful and concurrency-sensitive; preserve retry, reconciliation, and cleanup semantics.
- Follow `docs/logging.md` for logging conventions and required issue/session context fields.

## Tests and Validation

Run targeted tests while iterating, then run full gates before handoff.

```bash
make all
```

## Required Rules

- Public functions (`def`) in `lib/` must have an adjacent `@spec`.
- `defp` specs are optional.
- `@impl` callback implementations are exempt from local `@spec` requirement.
- Keep changes narrowly scoped; avoid unrelated refactors.
- Follow existing module/style patterns in `lib/symphony_elixir/*`.

Validation command:

```bash
mix specs.check
```

## PR Requirements

- PR body must follow `../.github/pull_request_template.md` exactly.
- Validate PR body locally when needed:

```bash
mix pr_body.check --file /path/to/pr_body.md
```

## Docs Update Policy

If behavior/config changes, update docs in the same PR:

- `../README.md` for project concept and goals.
- `README.md` for Elixir implementation and run instructions.
- `WORKFLOW.md` for workflow/config contract changes.
