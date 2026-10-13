---
name: architecture-outline-decision
description: >
  特定の具体的な作業を実施するWork型 Skill。
  PRDに基づき、Function Designに必要な、最小限のSystem Architectureの骨子を決める。
  Use when: PRD作成・更新後、Function Design作成・更新の直前。
  Do not use for: 個別機能や連携フロー、技術・実装の詳細の決定。
---
# Work Skill: architecture-outline-decision

## Summary
PRDに基づき、Function Designに必要な、最小限のSystem Architectureの骨子を決める。

## Inputs
- **Requirement Mode**: 本Skillにおける仕様定義の起点となった要求の性質によって、`INITIAL` または `CR` のいずれかに分かれる。

## Source
このファイルの内容をもとにArchitecture Outlineを決定する。
```
docs/persistent/product-requirements.md
```

## 前提条件
- **Source** のファイルが作成されており、内容が空でないこと。

## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- 各StepはExecutionStepsに記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。

## Discussion Guide for the Skill (`references/guide.md`)
Architecture Outlineの内容について、ユーザーと確認・議論の上で決定すべき事項を定める。このガイドを参照しながらDiscussionを進める。

## Artifact
Architecture Outlineは以下に記録・保存する:
```
docs/persistent/architecture-outline.md
```

## Goal
- ExecutionStepsに定義されたすべてのStepが完了していること。
- **Artifact** の作成が完了し、内容が承認されていること。

## Procedure
**Requirement Mode** に応じて、以下から該当するProcedureを一つ選択し、その内容を実行する。

- `INITIAL`: `references/procedure-on-initial.md`
- `CR`: `references/procedure-on-cr.md`


