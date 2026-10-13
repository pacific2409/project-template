---
name: prepare-project-environment
description: >
  特定の具体的な作業を実施するWork型 Skill。
  Trainの開始にあたり、Requirement Modeに応じて、Projectでの作業およびGit運用に必要な領域・情報・Repositoryを準備する。
  Use when: Train開始時にProject Environmentを準備するとき。
  Do not use for: 要件定義、設計、開発など、Project Environmentの準備以外の工程。
---

# Work Skill: prepare-project-environment

## Summary
Trainの開始にあたり、Requirement Modeに応じて、Projectでの作業およびGit運用に必要な領域・情報・Repositoryを準備する。

## Inputs
- **Requirement Mode**: 本Skillにおける仕様定義の起点となった要求の性質によって、`INITIAL` または `CR` のいずれかに分かれる。

## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- **Procedure** には、**Execution Steps** が記載されている。
- 各Stepは**Execution Steps**に記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。

## Resources
- **Development Guidelines**: `docs/persistent/development-guidelines.md`
- **Repository Info**: `docs/repository-info.md`

## Goal
- ExecutionStepsに定義されたすべてのStepが完了していること。

## Procedure
**Requirement Mode** に応じて、以下から該当するProcedureを一つ選択し、その内容を実行する。

- `INITIAL`: `references/procedure-on-initial.md`
- `CR`: `references/procedure-on-cr.md`