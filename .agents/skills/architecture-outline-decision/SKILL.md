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
docs/ideas/architecture-outline-decision.md
```

## Goal
- ExecutionStepsに定義されたすべてのStepが完了していること。
- **Artifact** の作成が完了し、内容が承認されていること。

## Execution Steps

### Step 0: Prepare for Discussion
- **Source** および **Guide** の内容を確認する。
- 空の**Artifact**を作成する。

### Step 1: Discuss the Architecture Outline
- 前項で確認した内容に基づき、**Guide**に記載のDecision Topicsついて、一つずつユーザーに確認する。
- 議論の上で方向性が一定具体化できたら、その内容を**Artifact**に追記した後、次の観点の確認へ進む。

#### **Guideline**
- 合意・承認状況については文書の末尾にて管理・更新する。
- **Artifact**には、後続の工程・Phaseや次以降のStepの予定・実施内容を記載しない。
- 確認は、それまでの内容を踏まえた複数の選択肢のサジェストとセットで行う。
- **Source**およびそれまでに確認・決定した内容から、対象のDecision TopicがProjectに適用されない、または本工程で決定する必要がない可能性がある場合は、無理に具体案を生成せず、`対象外`または`決定しない`ことも選択肢として提示し、ユーザーに確認する。

### Step 2: Finalize the Architecture Outline
- **Artifact**の内容全体を確認し、合意された内容の意味を変更しない範囲で、重複や記述の整理を行う。
- 最終的な内容からArchitecture Outlineの全体像を要約し、文書の冒頭にOverview(概要)として追加する。
- 最終的な**Artifact**の内容について、ユーザーの承認を得る。


