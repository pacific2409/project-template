---
name: functional-design
description: >
  特定の具体的な作業を実施するWork型 Skill。
  PRDに基づき、Function Designを作成する。
  Use when: 基本設計、全体設計時
  Do not use for: 技術選定等のアーキテクチャ、詳細設計
---

# Work Skill: functional-design

## Summary
PRDに基づき、Function Designを作成する。

## Inputs
- **Scope** *(Optional)*: 本Skillで扱う作業対象および変更対象の範囲

## Sources
このファイルの内容をもとにFunction Designを作成する。
```
docs/persistent/product-requirements.md
docs/ideas/architecture-outline-decision.md
```

## 前提条件
- **Sources** のファイルが作成されており、いずれの内容も空でないこと。


## Content Guide for the Skill (`references/guide.md`)
Function Designに定義する内容、その検討観点および記述内容の指針を定める。このガイドを参照しながら要求定義を進める。

## Draft
要求内容の検討過程において、ユーザーと議論した内容を以下に記録する。
```
docs/drafts/function-design-draft.md
```

## Artifacts
Function Designは以下に保存する:
```
docs/persistent/function-design.md
```

## Template for the Artifacts (`assets/template.md`)
**Artifacts**を作成する際に、テンプレートとして利用する。

## Comparison Review Report
文書間の整合性確認の結果の出力先は以下のパスとする:
```
docs/reviews/function-on-prd-and-architecture-comparison.md
```

## Specific Review Points Sheet (`references/review-points.md`)
Artifactsレビューを依頼する際に、レビュアーに提供する本ドキュメント特有のレビュー観点を定めている。

## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- 各StepはExecutionStepsに記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。ただし、承認不要と明記のあるStepはその内容を優先する。
- Execution Stepsの開始時、既存の**Artifacts**が存在する場合は、既存の構造と内容を維持しながら更新を行う。

## Goal
- ExecutionStepsに定義されたすべてのStepが完了していること。
- **Artifacts** の作成およびレビューが完了し、内容が承認されていること。

## Execution Steps
### Initial Spec Establishment
以下を本Skillの定義から特定した上で、**Initial Spec Establishment Flow**(`.agents/resources/common-flow/initial-spec-establishment-flow.md`)に従い、PRDの作成および関連作業を行う。

- **Sources**
- **Draft**
- **Artifacts**
- **Guide**
- **Template**
- **Comparison Review Report**
- **Specific Review Points Sheet**
- **Scope** *(Optional: Inputとして指定されている場合)*


