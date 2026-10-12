---
name: system-architecture-design
description: >
  特定の具体的な作業を実施するWork型 Skill。
  PRDおよびFunction Designに基づき、System Architectureについての仕様書を作成する。
  Use when: システム・アーキテクチャ設計時
  Do not use for: インフラ・アーキテクチャ設計、詳細設計
---

# Work Skill: system-architecture-design

## Summary
PRDおよびFunction Designに基づき、System Architectureについての仕様書を作成する。

## Inputs
- **Requirement Mode**: 本Skillにおける仕様定義の起点となった要求の性質によって、`INITIAL` または `CR` のいずれかに分かれる。
- **Scope** *(Optional)*: 本Skillで扱う作業対象および変更対象の範囲

## Sources
このファイルの内容をもとにSystem Architectureの仕様書を作成する。
```
docs/persistent/product-requirements.md
docs/persistent/architecture-outline.md
docs/persistent/function-design.md
```

## 前提条件
- **Sources** のファイルが作成されており、いずれの内容も空でないこと。


## Content Guide for the Skill (`references/guide.md`)
System Architectureに定義する内容、その検討観点および記述内容の指針を定める。このガイドを参照しながら要求定義を進める。

## Affected Modules
```
modules/*/*
```

## Draft
要求内容の検討過程において、ユーザーと議論した内容を以下に記録する。
```
docs/drafts/system-architecture-draft.md
```

## Artifacts
System Architectureは以下に保存する:
```
docs/persistent/system-architecture.md
```

## Template for the Artifacts (`assets/template.md`)
**Artifacts**を作成する際に、テンプレートとして利用する。


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
### Procedure: Spec Definition
**Requirement Mode** に応じて、以下から該当するProcedureを一つ選択し、その内容を実行する。それによって、System Architectureを作成・更新する。

- `INITIAL`: **Initial Spec Establishment** (`.agents/resources/doc-procedure/initial-spec-establishment.md`)
- `CR`: **Change Requirement Definition** (`.agents/resources/doc-procedure/change-requirement-definition-flow.md`)

Procedureの実行にあたっては、以下を本Skillの定義から特定してInputとして使用する。

- **Sources**
- **Draft**
- **Artifacts**
- **Guide**
- **Template**
- **Specific Review Points Sheet**
- **Affected Modules** *(`CR`の場合のみ使用される)*
- **Scope** *(Optional: Inputとして指定されている場合)*

該当する **Procedure** から **Flow Required**=`False` が返却された場合、本Skillにおける以降のStepが存在しても、それらは実施せず、本Work Skillを終了する。


