---
name: table-definition
description: >
  特定の具体的な作業を実施するWork型 Skill。
  Function DesignおよびSystem Architectureに基づき、各テーブルの仕様書を作成する。
  Use when: 各テーブルの定義時
  Do not use for: インフラ設計、全体設計、API設計
---

# Work Skill: table-definition

## Summary
Function DesignおよびSystem Architectureに基づき、各テーブルの仕様書を作成する。

## Inputs
- **Requirement Mode**: 本Skillにおける仕様定義の起点となった要求の性質によって、`INITIAL` または `CR` のいずれかに分かれる。
- **Scope** *(Optional)*: 本Skillで扱う作業対象および変更対象の範囲

## Sources
このファイルの内容をもとに各テーブルの仕様書を作成する。
```
docs/persistent/function-design.md
docs/persistent/system-architecture.md
docs/persistent/development-guidelines.md
docs/ideas/infrastructure-to-application-dependencies.md
docs/persistent/details/database-definition.md
```

## 前提条件
- **Sources** のファイルが作成されており、いずれの内容も空でないこと。


## Content Guide for the Skill (`references/guide.md`)
Table Definitionsに定義する内容、その検討観点および記述内容の指針を定める。このガイドを参照しながら要求定義を進める。

## Affected Modules

```
modules/database/*
modules/backend/*
```

## Draft
要求内容の検討過程において、ユーザーと議論した内容を以下に記録する。
```
docs/drafts/table-definition-draft.md
```

## Artifacts
Table Definitionは以下にテーブルごとに作成・保存する:
```
docs/persistent/details/table/<table-name>-table-spec.md
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
### Pre Step 1: Define Databases
Function DesignおよびSystem Architectureをもとに、Applicationで必要となるDatabaseを特定し、Database Definitionを作成または更新する。

- **INITIAL**
  - `docs/persistent/function-design.md`
  - `docs/persistent/system-architecture.md`
  - 上記から必要なDatabaseを特定し、`docs/persistent/details/database-definition.md`を作成する。

- **CR**
  - `docs/persistent/function-design.md`
  - `docs/persistent/system-architecture.md`
  - `docs/change-requirements/function-design.md`
  - `docs/change-requirements/system-architecture.md`
  - 現行定義と変更要求を比較し、Database構成への変更が必要な場合は、`docs/change-requirements/details/database-definition.md`に変更内容を定義する。
  - 確定した変更内容についてユーザーから承認を得た後、`docs/persistent/details/database-definition.md`へ反映する。

作成および反映はdatabase-definitionのテンプレート(`assets/database-definition-template.md`)を利用する。

Databaseの構成およびBoundaryについては、上位設計で確定した内容を前提とし、本Stepで独自に再設計しない。

### Pre Step 2: Identify Required Tables
まず**Artifacts** のパス規則に該当する既存のTable Definitionのファイルを確認し、対応するテーブル名を特定する。

Agent `explorer` に、特定した既存のテーブル名と以下の上位設計を連携し、Application Detail DesignとしてTable Definitionを作成すべきテーブルを抽出してもらう。

- `docs/persistent/function-design.md`
- `docs/persistent/system-architecture.md`

その際、以下の観点もAgentに連携する。

- 連携された既存のテーブル名を確定済みのものとして扱い、それらに加えてTable Definitionが必要なテーブルがないかを確認する。
- 新たにTable Definitionが必要なテーブルがある場合は、それらを全て抽出する。
- 既存のテーブル名が0件の場合は、上位設計からTable Definitionが必要なテーブルをすべて抽出する。
- 上位設計で実装対象として確定しているテーブルのみを対象とする。
- 上位設計からテーブルの存在を確認できない場合は、推測によって新たなテーブルを追加しない。

### Pre Step 3: Confirm Artifacts
既存のTable Definitionと前項の抽出結果を合わせ、本Skillで扱う **Artifacts** を確定する。

- 既存のTable Definitionはそのまま **Artifacts** として引き継ぐ。
- 新たに抽出された各テーブルについて、対応するArtifact Pathを確定し、**Artifacts** に追加する。
- 同一テーブルについて重複したArtifactを作成しない。
- 対象となる **Artifacts** が1つもない場合は、以降のStepをすべてスキップし、本Work Skillを終了する。

### Procedure: Spec Definition
**Requirement Mode** に応じて、以下から該当するProcedureを一つ選択し、その内容を実行する。それによって、Table Definitionを作成・更新する。

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
