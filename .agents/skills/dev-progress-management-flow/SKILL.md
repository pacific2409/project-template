---
name: dev-progress-management-flow
description: >
  工程の順序と進行を管理するFlow型 Skill。具体的な作業の実施については、都度対応するWork型 SkillまたはExecutorへの対応依頼によって進行する。
  Managerとして、Development Specification完了後のTask Allocation、Executorの作業領域準備、構築・開発の進捗管理、リリースおよび本番確認の進捗管理、Documentationの最終化、Train Closeまでの工程進行を管理する。
  Use when: Development Specification完了後、Current Trainの構築・開発からリリース、完了までの進行管理を行うとき。
  Do not use for: 構想、要件定義、設計などDevelopment Specificationまでの工程。各Moduleにおける具体的な構築・開発・リリース作業。
---
# Flow Skill For Manager: dev-progress-management-flow

## Summary
あなたの役割は、Development Specification完了後からTrain Closeまでの工程進行を担当するManagerです。
このSkillを用いて、Task AllocationとExecutorの作業領域準備を行い、**Development Allocation Map**に基づいて各Moduleの構築・開発を進行します。構築・開発完了後はリリース手順を整理し、各Moduleのリリースおよび本番確認を進行した上で、Documentationの最終化とTrain Closeまでを管理してください。

具体的な作業は、Workflowに従って対応するWork型 Skillを呼び出すか、担当Executorによる対応をユーザーへ依頼し、その完了報告を受けて進捗を更新することで進行します。

## Work Area
このFlow Skillにおける作業領域は以下とする。
- `docs/`
  - ※Task **Prepare Project Environment** で作成または整備される。
  - 作成後は、各Taskで明示的な指定がない限り、**作業ディレクトリ**とする。
  - `docs/.steering/` 配下については、`docs/.steering/<current-train>/` のみを作業対象とする。
- `modules/`
  - ※Executor用に新たにSetupが必要な場合、または既存実装の確認、および変更による影響範囲の調査が必要な場合にのみ使用する。

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
- Work Skillでの作業実施の際は、特に`Agents.md`や**Development Guidelines**の内容を遵守する。
- Work Skillの完了後は、その結果を当該Taskの成果として確認し、本Workflowの進行に戻る。
- 各Work Skillを実行する際は、Workflowの開始時または**再開時**に識別した **Requirement Mode** をInputとして引き継ぐ。

### **Git Operations**
- Task **Prepare Project Environment** 完了以降、Workflow全体を通じて、Git操作を行う際は、**Development Guidelines** (`docs/persistent/development-guidelines.md`) に従う。
- Task **Train Initialization** 以降、各Task完了時、コミットする内容があれば、そのTaskの完了承認をトリガーに **作業ディレクトリ** にてコミットおよびプッシュを行う。

## Train Status
**Train Status** : Project名およびCurrent Trainの情報を以下にて管理する。  
```
docs/train-status.md
```

## Flow Status
本Workflowの進行状況は、以下のファイルの**dev-progress-management-flow**の進捗表にて記録・管理する:

```
docs/.steering/<current-train>/manager/flow-status.md
```

以下のルールに従って管理または更新する。
- 各Taskの開始時に、当該Taskの行をStatus `IN_PROGRESS` として表の先頭に追加する。
- 各Taskの完了時に、当該TaskのStatusを `COMPLETED` に更新する。
- ただし、Development Progress ManagementおよびRelease Progress Managementでは、各Task内の指定に従って追加・更新を行う。
- Workflowの再開時は、本ファイルの内容を確認の上、どのTaskから再開するかを判断し、ユーザーに確認する。

### Guide For The Skill (`references/guide.md`)
本Skillの特定のTaskあるいはその中の特定のプロセスについての詳細な実施手順や注意点を示す。

## Development Allocation Map
下記にて、本フローで進捗を管理すべき構築・開発工程と順序の概要を確認できる。
```
docs/.steering/<current-train>/shared/information/development-allocation-map.md
```

※ただし、定義されている内容については、いずれも自分では実施せず、あくまで責務としては、ユーザーへの実施依頼とその結果報告を受けての進捗管理に限られる。


## Goal
Workflowに定義されたすべてのTaskが完了し、その完了についてユーザーの承認を得ること。


## Workflow Initialization
Workflowを開始する場合、または中断していたWorkflowを途中から再開する場合は、各Taskの実行に先立って以下を行う。

### **Load Project Rules**
- Projectルートの `AGENTS.md` を全て読み、その内容を以降のすべての作業の前提とする。
- `docs/persistent/product-requirement-definition.md`を読みプロジェクトの概要を把握する。
- `docs/change-requirements/` 配下に.gitkeep以外のファイルが存在する場合は、Current Trainにおける変更対応の内容を確認する。

### **Identify Workflow Position**
**Workflowの再開時** には、**Flow Status**を確認し、本Workflowの実行状況と再開位置を特定し、ユーザーに確認の上、その位置からWorkflowを再開する。

### **Identify Requirement Mode**
`docs/train-status.md` を確認し、本Workflowにおける **Requirement Mode** を識別する。

- `Train Type = LAUNCH` かつ `Status = CLOSED` のレコードが存在する場合、**Requirement Mode** を `CR` とする。
- 上記に該当しない場合、**Requirement Mode** を `INITIAL` とする。

識別した **Requirement Mode** は、本Workflowが完了するまで不変とする。

各Work Skillを実行する際は、ここで識別した **Requirement Mode** をInputとして引き継ぐ。

## Workflow Overview
── Prepare Development Management ──
- Prepare Project Environment
- Task Allocation
- Requirement Verification Allocation
- Setup Required Modules for Executors
- Steering Setup for Executors

── Progress Management Loop and Related Tasks ──
- Development Progress Management
- Development Phase Completion
- Prepare Release Procedure
- Release Progress Management
- Release Phase Completion

── Train Closing ──
- Finalize Documentation
- Close Train


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

### Task 1: Task Allocation
Work Skill `$task-allocation` を使用し、Development SpecificationからCurrent Trainで必要となる構築・開発・変更Taskを各Executorへ割り当て、依存関係および実施順序を整理する。
- 構築・開発・変更対象の特定
- 各ExecutorへのTask Allocation
- Task間の依存関係および実施順序の整理
- **Development Allocation Map** の作成

### Task 2: Requirement Verification Allocation
Work Skill `$requirement-verification-allocation` を使用し、Product Requirements Definitionから抽出した検証対象をDevelopment Allocation Mapに定義された各Moduleへ割り当て、その網羅性と妥当性を確認する。
- 検証対象の抽出
- 各Moduleへの検証責務の割当
- **Requirement Verification Matrix** の作成
- 検証網羅性の確認

### Task 3: Setup Required Modules for Executors
**Development Allocation Map** において **Action: Create** と定義されたModuleについて、Executorが作業するWorkspaceを準備する。

各Moduleについて、Domainごとに`modules/` 配下の対応するサブディレクトリを確認し、そのDomainディレクトリ下にModuleのディレクトリが存在しない場合は、以下を実施する。

1. 対応するDomainのサブディレクトリ配下に、Module名のディレクトリを作成する。
2. 作成したディレクトリをGit Repositoryとして初期化する。
3. **Development Guidelines** に従い、**Repository Info** に定義されたProvider上に対応するRemote Repositoryを作成する。作成時は、可能な限りREADME等の初期ファイルを自動生成しない。
4. Local RepositoryにRemote Repositoryを設定する。
5. 各Local Repositoryについて、以下を実施する。
   - `master` ブランチを作成してチェックアウトする。
   - 初回Commitが存在しない場合は、空の `.gitkeep` を作成して初回Commitを行う。
   - `master` ブランチをRemote RepositoryへPushする。
   - Providerの仕様上可能な場合は、Remote RepositoryのDefault Branchを `master` に設定する。
   - Remote Repositoryに `main` ブランチが存在する場合は削除する。
6. 作成したリポジトリの情報について、`docs/repository-info.md` に記録する。

> 本Taskでは、ModuleのWorkspaceおよびRepositoryの作成のみを行う。各々Module内のソースコード、Directory Structure、Dependency、Build設定、CI/CD、Container、Infrastructure等、Repository内部の構築・設定は行わない。

### Task 4: Steering Setup for Executors
**Development Allocation Map** に列挙された各Moduleについて、担当Executorが使用するSteering領域を以下の構成で作成する。尚、各ファイルは空の状態で作成し、内容は記載しない。

```text
.steering/<current-train>/<module-name>/
├── tasklist.md
├── blockers.md
├── decisions.md
├── adhoc-workflow-context.md
├── relevant-specifications.md
├── handover-from-<module-name>.md
├── working/
│   ├── implementation/
│   └── issues/
├── archive/
└── test/
     └── result/
```

ファイルの存在しない末端の各ディレクトリには、.gitkeep ファイルを作成する。


### Task X: Development Progress Management
**Development Allocation Map** に定義されたDomainおよびModuleのExecution Orderに従って、各Moduleの構築・開発を順次進行する。

本Taskでは、1つのModuleに対する構築・開発の進行管理を1回のTaskとして扱い、以下を実施する。

1. 次に対応するModuleを **Development Allocation Map** から特定する。
2. **Flow Status** に対象Moduleの進行状況を `Development Progress Management: <module-name>`の形式で新たなTaskとして記録する。
3. 対象Moduleの担当Executorによる構築・開発を開始するようユーザーへ対応を依頼する。
4. ユーザーから対象Moduleの完了報告を受けたら、**Guide** の**Confirm Module Development Completion**に従って当該ModuleのDevelopment Completionを確認し、完了として扱える場合は進捗を完了として**Flow Status**を更新する。
5. 未完了のModuleが存在する場合は本Taskを終了し、次のModuleについて新たに本Taskを開始する。
6. すべてのModuleが完了している場合は、本Taskを終了して次のTaskへ進む。

Moduleの進行順序は **Development Allocation Map** に従い、先行するModuleの完了が必要な場合は、その完了を確認してから後続Moduleの対応を開始する。

ユーザーからの完了報告を待つ間も、Current Trainに関する仕様、設計、進行その他の相談や対応依頼があった場合は、必要に応じて対応する。ただし、それによって対象Moduleの完了を未確認のまま次のModuleへ進めてはならない。

### Task after X: Development Phase Completion
すべてのModuleのDevelopmentが完了した後、Current TrainにおけるDevelopment Phase全体の完了状態を確認し、Release Phaseへ進行可能な状態であることを確認する。

**Development Report** (`docs/.steering/<current-train>/shared/executor-reports/<module-name>-development-report.md`)

1. 全Moduleの **Development Report** および各ModuleのWorkspaceにある `README.md`を横断して確認し、Current TrainにおけるDevelopment結果、対応内容、Verification結果、未解決事項および残存リスクを全体として確認する。
2. 各Development Reportに記録されたRequirement Verificationの実施結果を **Requirement Verification Matrix** と照合し、完了が確認された項目の `Status` を `TODO` から `VERIFIED` へ更新する。複数Moduleが同じRequirementを担当する場合は、そのうちいずれかの担当Moduleで完了が確認された時点で `VERIFIED` へ更新する。
3. **Development Allocation Map**、**Requirement Verification Matrix**、各ModuleのDevelopment Reportその他の関連成果物を確認し、Current TrainがRelease Phaseへ進行可能な状態であることを確認する。
4. Releaseへの進行を妨げる未完了事項、不整合または未解決事項が存在する場合は、必要な対応を完了した上で本Taskを再確認する。
5. Development Phaseの完了についてユーザーの承認を得て、次のTaskへ進む。

### Task before Y: Prepare Release Procedure
Current TrainでRelease対象となる各Moduleの **Release Instructions**、**Development Allocation Map** および関連するSpecificationをもとに、Module間の依存関係を踏まえたCurrent Train全体のRelease Procedureを作成する。

**Guide** の **Prepare Release Procedure** に従って、各ModuleのReleaseおよびProduction Verificationの実施順序、前提条件その他のModule間調整が必要となる内容を整理し、以下に**Release Procedure**として記録する。

`.steering/<current-train>/manager/release-procedure.md`

作成したRelease Procedureについてユーザーの確認・承認を得た上で、次のTaskへ進む。

### Task Y: Release Progress Management
前項で整理した、**Release Procedure** に従って、Current Trainで対応した各ModuleのReleaseおよびProduction Verificationを順次進行する。

本Taskでは、1つのModuleに対するReleaseおよびProduction Verificationの進行管理を1回のTaskとして扱い、以下を実施する。

1. 次にReleaseするModuleを **Release Procedure** から特定する。
2. **Flow Status** に対象Moduleの進行状況を `Release Progress Management: <module-name>`の形式で新たなTaskとして記録する。
3. 対象Moduleについて、ReleaseおよびProduction Verificationを実施するようユーザーへ対応を依頼する。
4. ユーザーから対象ModuleのReleaseおよびProduction Verificationの完了報告を受けたら、**Guide** の **Confirm Module Release Completion** に従って当該ModuleのRelease結果を確認し、完了として扱える場合は進捗を完了として**Flow Status**を更新する。
5. 未完了のModuleが存在する場合は本Taskを終了し、次のModuleについて新たに本Taskを開始する。
6. すべてのModuleが完了している場合は、本Taskを終了して次のTaskへ進む。

Moduleの進行順序は **Release Procedure** に従い、先行するModuleのReleaseおよびProduction Verificationが必要な場合は、その完了を確認してから後続Moduleの対応を開始する。

ユーザーからの完了報告を待つ間も、Current Trainに関する仕様、設計、Release、進行その他の相談や対応依頼があった場合は、必要に応じて対応する。ただし、それによって対象Moduleの完了を未確認のまま次のModuleへ進めてはならない。

### Task after Y: Release Phase Completion
すべてのModuleのReleaseおよびProduction Verificationが完了した後、**Guide** の該当プロセスに従って**Current Train**におけるRelease結果を横断して確認する。

各ModuleのRelease結果、Production Verification結果、未解決事項および残存リスクを確認し、Release Phase全体を完了として扱えることを確認する。

Release Phaseの完了についてユーザーの承認を得た上で、Current TrainのTrain Closeに関する後続Taskへ進む。


### Last Step 1: Finalize Documentation

すべてのModuleについてリリースおよび本番確認が完了していることを確認した後、Current Trainの最終処理として以下を実施する。それぞれ作成後に内容の要約をユーザーに報告し、承認を得る。

※使用する各Templateは抽象的な構成例であり、Sectionの要否および記載内容はProjectの実態に応じて調整する。READMEおよびRelease Noteでは、既存の正本となる情報を再定義しない。

1. `docs/persistent/` 配下の最新の内容を一通り確認し、現在のProjectおよびSystemの全体像を把握できるよう `docs/README.md` を作成または更新する。その際はテンプレート(`assets/Readme-template.md`) を参照する。
   - `docs/persistent/` の内容を正とし、READMEに新たな仕様・設計を定義しない。
   - 既存のREADMEが存在する場合は、最新の状態に合わせて必要な箇所を更新する。

2. `docs/change-requirements/` 配下に.gitkeep以外のファイルが存在する場合は、そこからCurrent Trainにおける変更内容を一通り確認し、今回のRelease内容をまとめたRelease Noteを `docs/release-notes/<current-train>.md` として作成する。その際はテンプレート(`assets/release-note-template.md`) を参照する。
   - Current Trainで実際にReleaseされた変更内容を記録する。
   - Release Noteに新たな仕様・設計を定義しない。

3. `docs/change-requirements/` 配下に.gitkeep以外のファイルが存在する場合は、Current TrainのManagerのSteering領域(`docs/.steering/<current-train>/manager/change-requirements/`)へ移動する。

4. **Development Guidelines** に従い、`docs/` Repositoryの現在チェックアウト中のCurrent Train用Branchについて、以下の手順でmasterへ変更を統合する。
   1. Current Train用Branchに残っている変更をCommitし、Remote RepositoryへPushする。
   2. `master` ブランチへCheckoutする。
   3. Remote Repositoryから最新の変更を取得し、`master` を最新化する。
   4. Current Train用Branchを`master`へMergeする。
   5. Merge結果を確認し、`master` をRemote RepositoryへPushする。

### Last Step 2: Close Train
Current Trainの **Train Status** を `CLOSED` に更新する。

以上が完了したら、Current Trainを終了する。