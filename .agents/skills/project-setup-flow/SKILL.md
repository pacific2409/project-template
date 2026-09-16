---
name: project-setup-flow
description: >
  工程の順序と進行を管理するFlow型 Skill。具体的な作業の実施については、都度対応するWork型 Skillを呼び出すことで対応していく。
  Managerとして、Projectにおける初回開発について、要件定義、設計など準備・計画のための工程進行を管理する。
  Use when: Projectにおいて、最初の開発を開始するとき。そして、その計画および準備を行うとき。
  Do not use for: 開発以降の工程の進行管理。既存Projectに対する機能追加・改修。
---
# Flow Skill For Manager: project-setup-flow

## Summary
あなたの役割は、新規の開発ProjectのManagerです。このSkillを用いて要件定義、設計など開発の準備・計画のための工程を管理・進行してください。具体的な作業の実施については、Workflowに従って都度対応するWork型 Skillを呼び出すことで対応します。

## Work Area
このFlow Skillにおける作業領域は以下とする。
- `docs/`
- `.steering/<current-train>/`
  - ※Task 1でCurrent Train決定後に作成する
- `workspace/`
  - ※各Executor担当用の作業領域の初回作成・セットアップにおいてのみ

## Rule
- Workflowを開始する前に、Projectルートの`AGENTS.md`を全て読み、その内容を全ての作業の前提として進める。
- 各TaskはWorkflowに記載された順序で実行する。
- 各Taskの完了条件を満たすまで次のTaskへ進まない。
- 各Taskの完了、および次のTaskへの進行にはユーザーの承認を得る。
- Task内でWork Skillが指定されている場合は、指定Skillを使用することで具体的な作業を実施していく。
- Work Skillの具体的な作業手順は、各Work Skill内の指定に従う。
- Work Skillの完了後は、その結果を当該Taskの成果として確認し、本Workflowの進行に戻る。

## Goal
Workflowに定義されたすべてのTaskが完了し、その完了についてユーザーの承認を得ること。

## Task Sample
Workflow内にて、各Taskは以下の形式で定義する。
### Task X: Task Name
使用するWork Skillと、このTaskで実施する内容。
- 作業概要1
- 作業概要2
- 作業概要3

## Workflow

### Task 1: Train Initialization
Work Skill `$initialize-train` を使用し、その内容の実施によって、本プロジェクトの一歩目を踏み出す。
- 開発アイデアのヒアリングおよび開発内容の整理
- ProjectおよびCurrent Trainの命名・定義
- Current Trainのsteering領域のセットアップ

### Task 2: Process Retrospective
Task 1で実施した工程を振り返り、Agentの観点から、工程の進めやすさおよび改善すべき課題についてユーザーへ報告する。

- 工程全体の進めやすさ
- 指示や手順の分かりやすさ
- 判断に迷った点
- 冗長または不足していると感じた工程
- Skillやテンプレートについて改善できる点