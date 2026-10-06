---
name: project-conception-and-design-flow
description: >
  工程の順序と進行を管理するFlow型 Skill。具体的な作業の実施については、都度対応するWork型 Skillを呼び出すことで対応していく。
  Managerとして、Projectにおける初回開発について、要件定義、設計など準備・計画のための工程進行を管理する。
  Use when: Projectにおいて、最初の開発を開始するとき。そして、その計画および準備を行うとき。
  Do not use for: 開発以降の工程の進行管理。既存Projectに対する機能追加・改修。
---
# Flow Skill For Manager: project-conception-and-design-flow

## Summary
あなたの役割は、新規の開発ProjectのManagerです。このSkillを用いて要件定義、設計など開発の準備・計画のための工程を管理・進行してください。具体的な作業の実施については、Workflowに従って都度対応するWork型 Skillを呼び出すことで対応します。

## Work Area
このFlow Skillにおける作業領域は以下とする。
- `docs/`
  - ※Task **Prepare Docs Area** で作成する。
  - 作成後は、各Taskで明示的な指定がない限り、**作業ディレクトリ**とする。
  - `docs/.steering/` 配下については、Task **Train Initialization**で作成される`docs/.steering/<current-train>/` のみを作業対象とする。

## Rule
### **Workflow Initialization**
- Workflowを開始または(途中から)再開する前には、Projectルートの`AGENTS.md`を全て読み、その内容を全ての作業の前提として進める。

### **Workflow Progression**
- 各TaskはWorkflowに記載された順序で実行する。
- 各Taskの完了条件を満たすまで次のTaskへ進まない。
- 各Taskの完了、および次のTaskへの進行にはユーザーの承認を得る。

### **Work Skill in Task**
- Task内でWork Skillが指定されている場合は、指定Skillを使用することで具体的な作業を実施していく。
- Work Skillの具体的な作業手順は、各Work Skill内の指定に従う。
- Work Skillの完了後は、その結果を当該Taskの成果として確認し、本Workflowの進行に戻る。

### **Git Operations**
- Task **Setup Development Guidelines** 以降、Workflow全体を通じて、Git操作を行う際は、`docs/persistent/development-guidelines.md` に従う。
- Task **Train Initialization** 以降、各Task完了時、コミットする内容があれば、そのTaskの完了承認をトリガーに **作業ディレクトリ** にてコミットおよびプッシュを行う。

## Flow Status
本Workflowの進行状況は、Task **Train Initialization**の完了時以降、以下に記録・保存・管理する:

```
docs/.steering/<current-train>/manager/flow-status.md
```

以下のルールに従って管理または更新する。
- 各Taskの開始時に、当該Taskの行をStatus `IN_PROGRESS` として表の先頭に追加する。
- 各Taskの完了時に、当該TaskのStatusを `COMPLETED` に更新する。
- Workflowの再開時は、本ファイルの内容を確認の上、どのTaskから再開するかを判断し、ユーザーに確認する。


## Goal
Workflowに定義されたすべてのTaskが完了し、その完了についてユーザーの承認を得ること。

## Task Sample
Workflow内にて、各Taskは以下の形式で定義する。
### Task X: Task Name
使用するWork Skillと、このTaskで実施する内容。
- 作業概要1
- 作業概要2
- 作業概要3

## Task Overview
- Prepare Docs Area
- Setup Development Guidelines
- Initialize Repository Information
- Product Concept Planning
- Train Initialization
- Product Requirement Definition
- Architecture Outline Decision
- Function Design
- System Architecture Design
- Infrastructure Design
- Prepare for Application Detail Design
- Application Detail Design: Table Definition
- Application Detail Design: API Specification
- Application Detail Design: Batch Specification
- Application Detail Design: UI Specification
- Application Detail Design: Check Detail Design Coverage
- Validate Infrastructure Adequacy for Detail Design
- Move Ideas to Steering for the Current Train
- Guide to Development Management Flow

## Workflow

### Task 0: Prepare Docs Area
- ルートディレクトリ直下に、以下のディレクトリ構造を作成し、`docs`をGit Repositoryとして`git init`を実行する。

```
docs/
├── drafts/
├── ideas/
├── modification-plans/
├── persistent/
├── reviews/
└── .steering/
```
- また、末端の各ディレクトリには、.gitkeep ファイルを作成する。

### Task 1: Setup Development Guidelines
- `.agents/resources/development-guidelines.md`をdocs/persistent/development-guidelines.md`にコピーする。
- コピーしたファイルのパスおよび内容の要点をユーザーに提示し、Project固有の変更を行うか確認する。
- 変更を行う場合は、その内容についてユーザーと検討し、合意した内容を反映する。

### Task 2: Initialize Repository Information
下記内容をユーザーに確認する。

1. Remote Repositoryに使用するProvider。[GitHub, GitLab, Bitbucket, その他]を選択肢として提示。
   - Providerを複数使用するかも合わせて確認。
2. 使用する各Providerについて、Repository Rootをユーザーに確認する。

確認したら、`assets/repository-info-template.md`を使用して、`docs/repository-info.md` を作成する。完了したらパスを共有し、ユーザーに確認を要求する。

※ 具体的なRepository名については、ここでは決定しない。


### Task 3: Product Concept Planning
Work Skill `$product-concept-planning` を使用し、新たな開発・Trainの開始にあたり、開発のアイデアを考え、プロダクトのコンセプトを整理する。
- 開発アイデアのヒアリングおよび内容整理
- プロダクトコンセプトの整理
- `docs/ideas/product-concept-planning.md` の作成およびユーザー承認

### Task 4: Train Initialization
Work Skill `$initialize-train` を使用し、その内容の実施によって、本プロジェクトの一歩目を踏み出す。
- ProjectおよびCurrent Trainの命名・定義
- Current Trainのsteering領域のセットアップ

### Task 5: Product Requirement Definition
Work Skill `$write-prd` を使用し、プロダクト要求定義書(PRD)を作成する。
- 定義内容についての協議とその記録
- PRDの作成
- サブエージェントによる成果物レビュー

### Task 6: Architecture Outline Decision
Work Skill `$architecture-outline-decision` を使用し、System Architectureの骨子を決定する。
- System Boundary
- Application Structure
- Backend / Service Structure
- Architecture Evolution
- Responsibility & Ownership

### Task 7: Function Design
Work Skill `$function-design` を使用し、Function Designを作成する。
- 定義内容についての協議とその記録
- Function Designの作成
- サブエージェントによる成果物レビュー

### Task 8: System Architecture Design
Work Skill `$system-architecture-design` を使用し、System Architectureを作成する。
- 定義内容についての協議とその記録
- System Architectureの作成
- サブエージェントによる成果物レビュー

### Task 9: Infrastructure Design
Work Skill `$infrastructure-design` を使用し、Infrastructure Architectureを作成する。
- 定義内容についての協議とその記録
- Infrastructure Architectureの作成
- サブエージェントによる成果物レビュー
- 後続のApplication Detail Designへの影響事項の抽出

### Task 10: Prepare for Application Detail Design
Application Detail Designで共通して参照するError Code定義として、`assets/error-code-list-template.md`を使用し、`docs/persistent/details/error-codes.md`を作成する。

### Task 11: Application Detail Design: Table Definition
Work Skill `$table-definition` を使用し、Table Definitionを作成する。
- 定義すべきテーブルの抽出・確定
- 定義内容についての協議とその記録
- 各Table Definitionの作成
- サブエージェントによる成果物レビュー

### Task 12: Application Detail Design: API Specification
Work Skill `$api-specification` を使用し、API Specificationを作成する。
- 定義すべきAPIの抽出・確定
- 定義内容についての協議とその記録
- 各API Specificationの作成
- サブエージェントによる成果物レビュー

### Task 13: Application Detail Design: Batch Specification
Work Skill `$batch-specification` を使用し、Batch Specificationを作成する。
- 定義すべきBatchの抽出・確定
- 定義内容についての協議とその記録
- 各Batch Specificationの作成
- サブエージェントによる成果物レビュー

### Task 14: Application Detail Design: UI Specification
Work Skill `$ui-specification` を使用し、UI Specificationを作成する。
- 定義すべきUIの抽出・確定
- 定義内容についての協議とその記録
- 各UI Specificationの作成
- サブエージェントによる成果物レビュー

### Task 15: Application Detail Design: Check Detail Design Coverage
Agent `explorer` に、`docs/persistent/function-design.md` と`docs/persistent/details/`およびそのサブディレクトリ下に作成されたすべての定義書・仕様書を読み込んだ上で、Function Designで定義された機能について、Detail Designへの定義漏れがないかを確認してもらう。

- Function Designに記載されたすべての内容をDetail Designへ対応付けることは要求せず、Applicationの実装にあたってDetail Designで具体化すべき機能を対象とする。

Agentには以下の形式・内容で報告してもらう。
- **Result**: 定義漏れが存在するか > `true` / `false`
- **Findings**: `Result`が`true`、つまり、定義漏れが存在する場合、Function Designの該当Section、定義すべき内容、および不足しているDetail Designの種別・対象

報告を受けた後の対応については、後述の**Action for Findings** に従う。


### Task 16: Validate Infrastructure Adequacy for Detail Design
Work Skill `$infrastructure-design` の**Review工程**を**Execution Parameters**とともに実行し、Application Detail Designを実装する上でInfrastructure Architectureが十分であることを確認する。

- Specification Comparison Reviewの結果、対応・修正が発生しない場合は、後続のArtifact Reviewを実行しない。
- **Review工程**より前および後の工程は、本Taskでは実行しない。

#### **Execution Parameters**

- **Sources**
  - Skillで定義された既存の**Sources**
  - `docs/persistent/details/`およびそのサブディレクトリ下に作成されたすべての定義書・仕様書

- **Scope**
  - **For Specification Comparison Review**
    - Application Detail Designで具体化された仕様を、現在のInfrastructure Architectureで実現可能か確認すること。
  - **For Artifact Review**
    - Specification Comparison Reviewの結果、Infrastructure Architectureへの対応・修正が発生した場合、その変更箇所および変更内容。

### Task 17: Move Ideas to Steering for the Current Train
前項までの全ての工程が完了したとき、docs/ideas/配下の全てのファイルを、Current TrainのSteering領域にあるManagerディレクトリ下の対応する場所に移動する。

### Task 18: Guide to Development Management Flow
本Workflowに定義された設計工程がすべて完了したことをユーザーに報告し、次の行程として `$development-management-flow` をユーザーに案内する。

本Taskでは、`$development-management-flow` の実行は開始しない。


## Action for Findings
- `Result`が`true`の場合は、返却された**Findings**をユーザーに提示し、各Findingについて対応するかを確認する。
- `Result`が`false`となった場合、または全てのFindingへ対応しないことをユーザーが選択した場合、本Actionを終了する。
- ユーザーが対応を選択したFindingについては、対応するSkillを使用・応用して、必要なArtifactを作成または更新し、そのSkillで規定されたReviewを完了する。
- その際、対応対象として選択された**Findings**で特定された事項を、本対応の**Scope**として、対応するSkillへ引き継ぐ。
- 選択されたFindingへの対応およびReviewが完了した後、同様の検査を再実行し、新たに返却された`Result`および**Findings**に対して、再度本**Action for Findings**に従う。