---
name: development-specification-flow
description: >
  工程の順序と進行を管理するFlow型 Skill。具体的な作業の実施については、都度対応するWork型 Skillを呼び出すことで対応していく。
  Managerとして、Projectにおける初回開発やその後の機能追加・改修といった新たなTrainの開始にあたり、開発内容の構想、要件定義、設計など、開発に向けた準備・計画のための工程進行を管理する。
  Use when: Projectにおいて最初の開発を開始するとき、または既存Projectに対する機能追加・変更・改修など、新たなTrainの計画および準備を行うとき。
  Do not use for: 開発以降の工程の進行管理。進行中のTrainにおける既存の構想・要件・設計への修正のみを行うとき。
---
# Flow Skill For Manager: development-specification-flow

## Summary
あなたの役割は、Projectにおける開発や改修の構想・設計を担当するManagerです。
このSkillを用いて、開発内容の構想、要件定義、設計など、開発の準備・計画のための工程を管理・進行してください。具体的な作業の実施については、Workflowに従って都度対応するWork型 Skillを呼び出すことで対応します。

## Work Area
このFlow Skillにおける作業領域は以下とする。
- `docs/`
  - ※Task **Prepare Project Environment** で作成または整備される。
  - 作成後は、各Taskで明示的な指定がない限り、**作業ディレクトリ**とする。
  - `docs/.steering/` 配下については、Task **Train Initialization**で作成される`docs/.steering/<current-train>/` のみを作業対象とする。
- `modules/`
  - ※既存実装の確認、および変更による影響範囲の調査が必要な場合にのみ使用する。

## Glossary
**Workflowの再開時** : 中断していたWorkflowを途中から再開するとき

## Rule
### **Workflow Progression**
- 各TaskはWorkflowに記載された順序で実行する。
- 各Taskの完了条件を満たすまで次のTaskへ進まない。
- 各Taskの完了、および次のTaskへの進行にはユーザーの承認を得る。

### **Work Skill in Task**
- Task内でWork Skillが指定されている場合は、指定Skillを使用することで具体的な作業を実施していく。
- Work Skillの具体的な作業手順は、各Work Skill内の指定に従う。
- Work Skillの完了後は、その結果を当該Taskの成果として確認し、本Workflowの進行に戻る。
- 各Work Skillを実行する際は、Workflowの開始時または**再開時**に識別した **Requirement Mode** をInputとして引き継ぐ。

### **Git Operations**
- Task **Prepare Project Environment** 完了以降、Workflow全体を通じて、Git操作を行う際は、**Development Guidelines** (`docs/persistent/development-guidelines.md`) に従う。
- Task **Train Initialization** 以降、各Task完了時、コミットする内容があれば、そのTaskの完了承認をトリガーに **作業ディレクトリ** にてコミットおよびプッシュを行う。

## Train Status
**Train Status** : Project名およびCurrent Trainの情報を以下にて管理する。Task **Train Initialization** 似て作成または更新される。
```
docs/train-status.md
```

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


## Workflow Initialization
Workflowを開始する場合、または中断していたWorkflowを途中から再開する場合は、各Taskの実行に先立って以下を行う。

### **Load Project Rules**
Projectルートの `AGENTS.md` を全て読み、その内容を以降のすべての作業の前提とする。

### **Identify Workflow Position**
**Workflowの再開時** には、**Flow Status**を確認し、本Workflowの実行状況と再開位置を特定し、ユーザーに確認の上、その位置からWorkflowを再開する。

### **Identify Requirement Mode**
`docs/train-status.md` を確認し、本Workflowにおける **Requirement Mode** を識別する。

- `Train Type = LAUNCH` かつ `Status = CLOSED` のレコードが存在する場合、**Requirement Mode** を `CR` とする。
- 上記に該当しない場合、**Requirement Mode** を `INITIAL` とする。

識別した **Requirement Mode** は、本Workflowが完了するまで不変とする。

各Work Skillを実行する際は、ここで識別した **Requirement Mode** をInputとして引き継ぐ。

## Workflow Overview
- Prepare Project Environment
- Development Concept Planning
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


## Task Sample
Workflow内にて、各Taskは以下の形式で定義する。
### Task X: Task Name
使用するWork Skillと、このTaskで実施する内容。
- 作業概要1
- 作業概要2
- 作業概要3

## Workflow

### Task 0: Prepare  Project Environment
Work Skill `$prepare-project-environment` を使用し、プロジェクトの作業環境を整備する。
- プロジェクトの作業環境の整備
- **Development Guidelines** の確認

### Task 1: Development Concept Planning
Work Skill `$development-concept-planning` を使用し、新たなTrainの開始にあたり、開発のアイデアを考え、そのコンセプトを整理する。
- 開発アイデアのヒアリングおよび内容整理
- 開発コンセプトの整理・記録およびユーザー承認

### Task 2: Train Initialization
Work Skill `$initialize-train` を使用し、本Trainあるいは、それに加えてProjectについて定義し、本格的な作業開始にあたり、必要な領域・情報を初期化する。
- Current Trainあるいは、それに加えてProjectの命名・定義
- Train Statusの初期化・更新
- Current Trainのsteering領域のセットアップ
- Flow Statusの初期化

### Task 3: Product Requirement Definition
Work Skill `$product-requirement-definition` を使用し、プロダクト要求定義書(PRD)を作成する。
- 定義内容についての協議とその記録
- PRDの作成
- サブエージェントによる成果物レビュー

### Task 4: Architecture Outline Decision
Work Skill `$architecture-outline-decision` を使用し、System Architectureの骨子を決定・更新する。
- System Boundary
- Application Structure
- Backend / Service Structure
- Architecture Evolution
- Responsibility & Ownership

### Task 5: Function Design
Work Skill `$function-design` を使用し、Function Designを作成・更新する。
- 定義内容についての協議とその記録
- Function Designの作成・更新
- サブエージェントによる成果物レビュー

### Task 6: System Architecture Design
Work Skill `$system-architecture-design` を使用し、System Architectureを作成・更新する。
- 定義内容についての協議とその記録
- System Architectureの作成・更新
- サブエージェントによる成果物レビュー

### Task 7: Infrastructure Design
Work Skill `$infrastructure-design` を使用し、Infrastructure Architectureを作成・更新する。
- 定義内容についての協議とその記録
- Infrastructure Architectureの作成・更新
- サブエージェントによる成果物レビュー
- 後続のApplication Detail Designへの影響事項の抽出

### Task 8: Prepare for Application Detail Design
1. `docs/persistent/details/`および、`docs/change-requirements/details/`について、それぞれ存在しなければディレクトリを作成する。
2. `docs/persistent/details/error-codes.md`にファイルが存在しない場合は、Application Detail Designで共通して参照するError Code定義として、`assets/error-code-list-template.md`を使用して同ファイルを作成する。

### Task 9: Application Detail Design: Table Definition
Work Skill `$table-definition` を使用し、Table Definitionを作成・更新する。
- 定義すべきテーブルの抽出・確定
- 定義内容についての協議とその記録
- 各Table Definitionの作成・更新
- サブエージェントによる成果物レビュー

### Task 10: Application Detail Design: API Specification
Work Skill `$api-specification` を使用し、API Specificationを作成・更新する。
- 定義すべきAPIの抽出・確定
- 定義内容についての協議とその記録
- 各API Specificationの作成・更新
- サブエージェントによる成果物レビュー

### Task 11: Application Detail Design: Batch Specification
Work Skill `$batch-specification` を使用し、Batch Specificationを作成・更新する。
- 定義すべきBatchの抽出・確定
- 定義内容についての協議とその記録
- 各Batch Specificationの作成・更新
- サブエージェントによる成果物レビュー

### Task 12: Application Detail Design: UI Specification
Work Skill `$ui-specification` を使用し、UI Specificationを作成・更新する。
- 定義すべきUIの抽出・確定
- 定義内容についての協議とその記録
- 各UI Specificationの作成・更新
- サブエージェントによる成果物レビュー

### Task 13: Application Detail Design: Check Detail Design Coverage
Agent `explorer` に、`docs/persistent/function-design.md` と`docs/persistent/details/*/*`に作成されたすべての定義書・仕様書を読み込んだ上で、Function Designで定義された機能について、Detail Designへの定義漏れがないかを確認してもらう。

- Function Designに記載されたすべての内容をDetail Designへ対応付けることは要求せず、Applicationの実装にあたってDetail Designで具体化すべき機能を対象とする。

Agentには以下の形式・内容で報告および`docs/reviews/detail-design-coverage-report-<yyyymmddhhmm>.md`に記録してもらう。
- **Result**: 定義漏れが存在するか > `true` / `false`
- **Findings**: `Result`が`true`、つまり、定義漏れが存在する場合、Function Designの該当Section、定義すべき内容、および不足しているDetail Designの種別・対象

報告を受けた後の対応については、後述の**Action for Findings** に従う。


### Task 14: Validate Infrastructure Adequacy for Detail Design
Work Skill `$infrastructure-design` の**On-Demand Execution** : **Request Specification Comparison Review** を **Execution Parameters**とともに実行し、Application Detail Designを実装する上でInfrastructure Architectureが十分であることを確認する。

- Specification Comparison Reviewの結果、対応・修正が発生しない場合は、後続のArtifact Reviewを実行しない。

#### **Execution Parameters**

- **Review Sources**
  - Skillで定義された既存の**Sources**
  - `docs/persistent/details/`およびそのサブディレクトリ下に作成されたすべての定義書・仕様書

- **Comparison Review Report**(`docs/reviews/infrastructure-architecture-on-detail-design.md`)

- **Scope**
  - **For Specification Comparison Review**
    - Application Detail Designで具体化された仕様を、現在のInfrastructure Architectureで実現可能か確認すること。
  - **For Artifact Review**
    - Specification Comparison Reviewの結果、Infrastructure Architectureへの対応・修正が発生した場合、その変更箇所および変更内容。

### Task 15: Move Ideas to Steering for the Current Train
前項までの全ての工程が完了したとき、docs/ideas/配下の全てのファイルを、Current TrainのSteering領域にあるManagerディレクトリ下の対応する場所に移動する。

### Task 16 : Guide to Development Management Flow
本Workflowに定義された設計工程がすべて完了したことをユーザーに報告し、次の行程として `$dev-progress-management-flow` をユーザーに案内する。

本Taskでは、`$dev-progress-management-flow` の実行は開始しない。


## Action for Findings
- `Result`が`true`の場合は、返却された**Findings**をユーザーに提示し、各Findingについて対応するかを確認する。
- `Result`が`false`となった場合、または全てのFindingへ対応しないことをユーザーが選択した場合、本Actionを終了する。
- ユーザーが対応を選択したFindingについては、対応するSkillを使用・応用して、必要なArtifactを作成または更新し、そのSkillで規定されたReviewを完了する。
- その際、対応対象として選択された**Findings**で特定された事項を、本対応の**Scope**として、対応するSkillへ引き継ぐ。
- 選択されたFindingへの対応およびReviewが完了した後、同様の検査を再実行し、新たに返却された`Result`および**Findings**に対して、再度、本**Action for Findings**に従う。