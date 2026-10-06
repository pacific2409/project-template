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

## Draft
要求内容の検討過程において、ユーザーと議論した内容を以下に記録する。
```
docs/drafts/ui-specification-draft.md
```

## Artifacts
UI Specificationは以下に画面ごとに作成・保存する:
```
docs/persistent/details/<screen-name>-screen-spec.md
```

## Template for the Artifacts (`assets/template.md`)
**Artifacts**を作成する際に、テンプレートとして利用する。

## Comparison Review Report
文書間の整合性確認の結果の出力先は以下のパスとする:
```
docs/reviews/ui-specifications-on-dependencies.md
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
### Pre Step 1: Identify Required Screens

Agent `explorer` に以下の上位設計を確認の上、Application Detail DesignとしてUI Specificationを作成すべきUIを抽出してもらう。

- `docs/persistent/function-design.md`
- `docs/persistent/system-architecture.md`

その際、下記観点もAgentに連携する。
- 上位設計で実装対象として確定している画面を対象とする。
- 上位設計から画面の存在を確認できない場合は、推測によって新たな画面を追加しない。

### Pre Step 2: Confirm Artifacts
抽出結果をもとに、作成・更新するUI Specificationの数、対象UIおよびArtifact名を確定する。

- 抽出の結果に作成すべき画面が存在しない場合は、以降のStepをすべてSkipし、本Work Skillを終了する。
- 同一画面について重複したArtifactを作成しない。
- 抽出した各画面について、対応するArtifact Pathを確定する。

### Initial Spec Establishment
以下を本Skillの定義および前項までの作業結果から特定した上で、**Initial Spec Establishment Flow**(`.agents/resources/common-flow/initial-spec-establishment-flow.md`)に従い、PRDの作成および関連作業を行う。

- **Sources**
- **Draft**
- **Artifacts**
- **Guide**
- **Template**
- **Comparison Review Report**
- **Specific Review Points Sheet**
- **Scope** *(Optional: Inputとして指定されている場合)*


