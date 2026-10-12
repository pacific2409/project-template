---
name: initialize-train
description: >
  特定の具体的な作業を実施するWork型 Skill。
  新たなTrainの開始にあたり、整理されたProduct ConceptをもとにProjectおよび本Trainを識別する名称を決定し、Trainの管理および作業に必要な領域・情報を初期化する。
  Use when: Train Initialization を実施するとき。
  Do not use for: Product Conceptの検討、要件定義、設計、開発以降の工程。
---

# Work Skill: initialize-train

## Summary
整理されたProduct ConceptをもとにProjectおよび本Trainを識別する名称を決定し、Train Status、Remote Repository、Steering等、本Trainの管理および作業開始に必要な領域・情報を初期化する。

## Input
- **Requirement Mode**: 本Skillにおける仕様定義の起点となった要求の性質によって、`INITIAL` または `CR` のいずれかに分かれる。

## Sources
このファイルの内容をもとにProjectやTrainのタイトルを導き出す。
```
docs/ideas/development-concept-planning.md
```

## 前提条件
- **Sources** のファイルが作成されている。
- また**Sources**に、プロダクトの基本的なアイデアが含まれている。

## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- 各Stepは**Execution Steps**に記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。

## Artifacts
```
docs/train-status.md
```

## Goal
- **Execution Steps**に定義されたすべてのStepが完了していること。
- 合意されたProject名およびTrain名が、**Artifacts** に記録されていること。
- `.steering/` 以下に、Current Trainと同名のディレクトリが**Execution Steps**に定められた内容とともに作成されていること。

## List of Step
- Name the Project and the Current Train
- Train Status Initialization
- Setup Branch for The Current Train
- Setup Remote Repository
- Steering Setup
- Create the Table for Flow Status

## Execution Steps

### Step 1: Name the Project and the Current Train
**Sources**にて整理されたDevelopment Conceptをもとに、本Trainを識別する名称を考え、ユーザーに提示し、決定する。

**Requirement Mode**=`INITIAL`の場合は、同文書にて整理されたProduct Conceptをもとに、Project名についても一緒に決定する。

いずれの名前も特徴を表しつつ簡潔な名前にする。

Trainの名称は、以下の命名規則に従う。

`[YYYYMMDD]-[開発タイトル]`

例：
- `20250115-initial-implementation`
- `20250115-add-tag-feature`


### Step 2: Train Status Initialization
Step **Name the Project and the Current Train** で決定した内容をもとに、**Artifacts** を作成もしくは更新する。

作成・更新にあたっては、`assets/train-status-template.md` をテンプレートとして利用・参照する。

### Step 3: Setup Branch for The Current Train
Git Branchを`feature/<current-train-name>` の形式で作成し、チェックアウトする。

### Step 4: Setup Remote Repository
**Requirement Mode**=`INITIAL`の場合にのみ、以下の手順を実行する。Otherwise, this Step is skipped.

1. **Development Guidelines** に従い、`docs/` のRemote Repositoryを各Providerに作成する。

  - 指定されたProviderにGitLabが含まれている場合は、Remote Repositoryの作成前に、ユーザーへ `<project-name>` のSubgroupの作成を依頼し、完了報告を受けるまで待機する。
  - GitLabのRepository RootにGroupが含まれている場合は、そのGroup配下に `<project-name>` のSubgroupが存在することを前提として、Subgroup配下にRepositoryを作成する。

2. 各ProviderにRemote Repositoryを作成した後、作成したRepositoryを `docs/` RepositoryのRemoteとして追加する。

3. 作成したRepositoryの情報を `docs/repository-info.md` の **Project Repositories** に記録する。


### Step 5: Steering Setup
`.steering/` 配下に、決定したCurrent Trainと同名のディレクトリおよびそのサブディレクトリを、以下の構成で作成する。
- `.steering/<current-train>/`
- `.steering/<current-train>/manager/`
- `.steering/<current-train>/manager/ideas/`
- `.steering/<current-train>/manager/drafts/`
- `.steering/<current-train>/manager/reviews/`
- `.steering/<current-train>/shared/`
- `.steering/<current-train>/shared/information/`
- `.steering/<current-train>/shared/examples/`
- `.steering/<current-train>/shared/executor-reports/`
- `.steering/<current-train>/shared/handover/`
- `.steering/<current-train>/shared/release-info/`
- `.steering/<current-train>/shared/reviews/`
- `.steering/<current-train>/shared/work-requests/`

**Requirement Mode**=`CR`の場合は、`.steering/<current-train>/manager/change-requirements/` ディレクトリも作成する。

`.steering/<current-train>/shared/examples/`については、docs/.gitignore に追加し、Git管理対象外とする。

また、末端の各ディレクトリには、.gitkeep ファイルを作成する。

### Step 6: Create the Table for Flow Status
- `.steering/<current-train>/manager/` 配下に、`flow-status.md` を下記形式で作成する。
- 上記の表に、本Task: Train Initializationを**development-specification-flow**の一つ目のTaskとして追加する。

```
# Flow Status

## development-specification-flow

| Task | Status | Started At | Completed At |
|------|--------|------------|--------------|
| [Task 1] | [IN_PROGRESS / COMPLETED] | [- / YYYY-MM-DD HH:mm] | [- / YYYY-MM-DD HH:mm] |
| [Task 2] | [IN_PROGRESS / COMPLETED] | [- / YYYY-MM-DD HH:mm] | [- / YYYY-MM-DD HH:mm] |
| [Task 3] | [IN_PROGRESS / COMPLETED] | [- / YYYY-MM-DD HH:mm] | [- / YYYY-MM-DD HH:mm] |

## dev-progress-management-flow

| Task | Status | Started At | Completed At |
|------|--------|------------|--------------|
|  |  |  |  |

```

