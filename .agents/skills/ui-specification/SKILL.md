---
name: ui-specification
description: >
  特定の具体的な作業を実施するWork型 Skill。
  Function DesignおよびSystem Architectureに基づき、各画面の仕様書を作成する。
  Use when: 各画面仕様の詳細設計時
  Do not use for: インフラ設計、全体設計、API設計
---

# Work Skill: ui-specification

## Summary
Function DesignおよびSystem Architectureに基づき、各画面の仕様書を作成する。

## Inputs
- **Requirement Mode**: 本Skillにおける仕様定義の起点となった要求の性質によって、`INITIAL` または `CR` のいずれかに分かれる。
- **Scope** *(Optional)*: 本Skillで扱う作業対象および変更対象の範囲

## Sources
このファイルの内容をもとに各画面の仕様書を作成する。
```
docs/persistent/function-design.md
docs/persistent/system-architecture.md
docs/persistent/development-guidelines.md
docs/persistent/details/error-codes.md
docs/persistent/details/api/*.md
docs/ideas/infrastructure-to-application-dependencies.md
```

## 前提条件
- **Sources** のファイルが作成されており、いずれの内容も空でないこと。


## Content Guide for the Skill (`references/guide.md`)
UI Specificationsに定義する内容、その検討観点および記述内容の指針を定める。このガイドを参照しながら要求定義を進める。

## Affected Modules

```
modules/frontend/*
```

## Draft
要求内容の検討過程において、ユーザーと議論した内容を以下に記録する。
```
docs/drafts/ui-specification-draft.md
```

## Artifacts
UI Specificationは以下に画面ごとに作成・保存する:
```
docs/persistent/details/view/<screen-name>-screen-spec.md
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
### Pre Step 1: Identify Required Screens
まず**Artifacts** のパス規則に該当する既存のUI Specificationのファイルを確認し、対応する画面名を特定する。

Agent `explorer` に、特定した既存の画面名と以下の上位設計を連携し、Application Detail DesignとしてUI Specificationを作成すべき画面を抽出してもらう。

- `docs/persistent/function-design.md`
- `docs/persistent/system-architecture.md`

その際、以下の観点もAgentに連携する。

- 連携された既存の画面名を確定済みのものとして扱い、それらに加えてUI Specificationが必要な画面がないかを確認する。
- 新たにUI Specificationが必要な画面がある場合は、それらを全て抽出する。
- 既存の画面名が0件の場合は、上位設計からUI Specificationが必要な画面をすべて抽出する。
- 上位設計で実装対象として確定している画面のみを対象とする。
- 上位設計から画面の存在を確認できない場合は、推測によって新たな画面を追加しない。

### Pre Step 2: Confirm Artifacts
既存のUI Specificationと前項の抽出結果を合わせ、本Skillで扱う **Artifacts** を確定する。

- 既存のUI Specificationはそのまま **Artifacts** として引き継ぐ。
- 新たに抽出された各画面について、対応するArtifact Pathを確定し、**Artifacts** に追加する。
- 同一画面について重複したArtifactを作成しない。
- 対象となる **Artifacts** が1つもない場合は、以降のStepをすべてスキップし、本Work Skillを終了する。


### Procedure: Spec Definition
**Requirement Mode** に応じて、以下から該当するProcedureを一つ選択し、その内容を実行する。それによって、UI Specificationを作成・更新する。

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