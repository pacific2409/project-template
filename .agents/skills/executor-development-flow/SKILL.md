---
name: executor-development-flow
description: >
  工程の順序と進行を管理するExecutor型 Flow Skill。
  ユーザーが特定Moduleの構築・開発の意思を示した場合に、Development Allocation MapおよびSpecificationに基づき、担当Moduleの作業準備から構築・開発、開発環境での検証完了までの工程を進行する。
  Use when: Development SpecificationおよびTask Allocation完了後、Executorとして担当Moduleの構築・開発を開始し、Implementation Loop完了までの工程を進行するとき。
  Do not use for: 構想、要件定義、設計、Task Allocation、Train全体の進捗管理、Integration Test以降の工程。他Moduleの構築・開発。
---

# Flow Skill For Executor: executor-development-flow

## Summary
あなたの役割は、特定のModuleの構築・開発を担当するExecutorです。

このSkillを用いて、**Development Allocation Map** から担当Moduleに割り当てられたTaskを特定し、関連するSpecificationを理解した上で、担当Moduleの **Workspace** において必要な作業準備、構築・開発および開発環境での検証を進行してください。

Workflow全体を通して **Executor Rules** に従い、各工程では **Common Guide** および担当Domainの **Domain Guide** を参照します。具体的な構築・開発等の作業についてWork Skillが指定されている場合は、対応するWork Skillを使用して実施してください。


## Glossary
**Workflowの再開時** : 中断していたWorkflowを途中から再開するとき

## Executor Rules

**Executor Rules** : Executorが作業全体を通して遵守する共通ルールを以下にて管理する。

```
.agents/resources/executor-rules.md
```

### Common Guide (`references/guide.md`)
Executor Flowの各Taskを実施する際に、Domainを問わず共通して適用するGuidelineを定義する。

### Domain Guide (`references/<domain-name>-executor-guide.md`)
Common Guideを前提として、Executor Flowの各Taskを実施する際に、担当Domainに応じて追加で適用するDomain固有のGuidelineおよび参照情報を定義する。


## Development Guidelines
開発や関連する作業についての指針やルールを示す。  
```
docs/persistent/development-guidelines.md
```

## Rule
### **Workflow Progression**
- 各Taskは、**Executor Rules** に従って実行する。
- 各TaskはWorkflowに記載された順序で実行する。
- 各Taskの完了条件を満たすまで次のTaskへ進まない。
- 各Taskの完了、および次のTaskへの進行にはユーザーの承認を得る。

### **Guide in Task**
- Task内で具体的な手順や判断について **Common Guide** の該当プロセスに従うよう指定されている場合は、**Common Guide**にある当該Task名と同名の項目のプロセスの内容に従ってTaskを実施する。
- **Common Guide** と **Domain Guide** の双方に対応するGuidelineが存在する場合は、両方を適用する。

### **Work Skill in Task**
- Task内でWork Skillが指定されている場合は、指定Skillを使用することで具体的な作業を実施していく。
- Work Skillの具体的な作業手順は、各Work Skill内の指定に従う。
- Work Skillの完了後は、その結果を当該Taskの成果として確認し、本Workflowの進行に戻る。
- 各Work Skillを実行する際は、Workflowの開始時または**再開時**に識別した **Requirement Mode** をInputとして引き継ぐ。

## **Git Operations**
- 作業全体を通じて、Git操作を行う際は、**Development Guidelines** (`docs/persistent/development-guidelines.md`) に従う。

## Default Inputs For Work Skill
以下は、Executor FlowからWork Skillへ共通して連携するInputの標準セットである。各Work Skillへの連携は、Task内で明示的に指定された場合に限る。

- **Domain**: 担当Domain
- **Module**: 担当Module
- **Requirement Mode**: **Workflow Initialization**で識別した**Requirement Mode**
- **Specification Sources**: **Domain Guide** の **Specification Sources** に指定されたパスのうち、実際に存在し、かつ `relevant-specifications.md` において`Non-Relevant`に分類されていないSpecificationのパス

## Train Status
**Train Status** : Project名およびCurrent Trainの情報を以下にて管理する。  
```
docs/train-status.md
```

## Executor Flow Status
本Workflowの進行状況は、以下のファイルの**executor-development-flow**の進捗表にて記録・管理する:

```
docs/.steering/<current-train>/<module-name>/flow-status.md
```

以下のルールに従って管理または更新する。
- 作成・更新の際は所定のテンプレート(`assets/executor-flow-status-template.md`)を使用する。
- 各Taskの開始時に、当該Taskの行をStatus `IN_PROGRESS` として表の先頭に追加する。
- 各Taskの完了時に、当該TaskのStatusを `COMPLETED` に更新する。
- Workflowの再開時は、本ファイルの内容を確認の上、どのTaskから再開するかを判断し、ユーザーに確認する。


## Development Allocation Map
下記にて、本フローで管理するModuleの担当範囲と本Trainにおける立ち位置が確認できる。
```
docs/.steering/<current-train>/shared/information/development-allocation-map.md
```

## Pending Information
いずれかの工程の中で、未確定または未解決になった情報・項目を以下にて管理する。
```
docs/.steering/<current-train>/<module-name>/working/pending-information.md
```

## Goal
Workflowに定義されたすべてのTaskが完了し、その完了についてユーザーの承認を得ること。


## Workflow Initialization
Workflowを開始する場合、または中断していたWorkflowを途中から再開する場合は、各Taskの実行に先立って以下を行う。

### **Load Project Rules and Context**
- **Executor Rules**、`AGENTS.md`、 **Development Guidelines** を全て読み、その内容を以降のすべての作業の前提とする。
- `docs/persistent/product-requirement-definition.md`を読みプロジェクトの概要を把握する。
- `docs/change-requirements/` 配下に.gitkeep以外のファイルが存在する場合は、Current Trainにおける変更対応の内容を確認する。
- 担当Moduleの **Workspace** に `README.md` が存在する場合は、そこからプロジェクトの全体像のイメージを掴み、Moduleの概要、構成、利用方法および関連するSpecificationへの参照情報を把握する。

### **Identify Workflow Position**
**Workflowの再開時** には、**Flow Status**を確認し、本Workflowの実行状況と再開位置を特定し、ユーザーに確認の上、その位置からWorkflowを再開する。

### **Identify Requirement Mode**
`docs/train-status.md` を確認し、本Workflowにおける **Requirement Mode** を識別する。

- `Train Type = LAUNCH` かつ `Status = CLOSED` のレコードが存在する場合、**Requirement Mode** を `CR` とする。
- 上記に該当しない場合、**Requirement Mode** を `INITIAL` とする。

識別した **Requirement Mode** は、本Workflowが完了するまで不変とする。

各Work Skillを実行する際は、ここで識別した **Requirement Mode** をInputとして引き継ぐ。

### **Identify Executor Context**
自身に割り当てられた担当をもとに、以降のWorkflowで使用する担当Module、Steering領域および **Domain Guide** を特定し、その内容を確認する。

1. 自身に割り当てられた担当から、担当DomainおよびModuleを特定する。
2. **Executor Rules** に従い、担当Moduleに対応するSteering領域を特定し、その内容を確認する。
3. 担当Domainに対応する **Domain Guide** を特定し、その内容を確認する。

## Workflow Overview
- Prepare Workflow
- Clarify Assigned Tasks
- Understand Specifications
- Extract Relevant Specifications
- Understand Existing Implementation
- Understand Domain Implementation Conventions
- Prepare Branch for Implementation
- Prepare Repository Structure
- Establish Module Quality Gate
- Test Specification
- Determine Static Analysis
- Configure CI/CD Pipeline
- Prepare Runtime Environment
- Execute Implementation Loop
- Resolve Remaining Pending Information
- Guide to Executor Delivery Flow


## Task Sample
Workflow内にて、各Taskは以下の形式で定義する。
### Task X: Task Name
使用するWork Skillと、このTaskで実施する内容。
- 作業概要1
- 作業概要2
- 作業概要3

## Workflow
### Task 0: Prepare Workflow
**Flow Status** を指定のパスに作成し、本Task: Prepare Workflowを**executor-development-flow**の一つ目のTaskとして追加する。

作成の際は所定のテンプレート(`assets/executor-flow-status-template.md`)を使用する。

### Task 1: Clarify Assigned Tasks
**Development Allocation Map**から自身のModuleに割り当てられた内容を確認し、**Current Train**における自身の担当Taskを明確化する。具体的な手順については、**Common Guide** の該当プロセスに従って実施する。

### Task 2: Understand Specifications
**Domain Guide**に定義された**Specification Sources**を確認し、自身の担当Moduleの構築・開発に必要となるSpecificationを理解する。具体的な手順については、**Common Guide** の該当プロセスに従って実施する。


### Task 3: Extract Relevant Specifications

**Domain Guide** の **Overall Design Specifications** に指定されたパスにSpecificationが存在する場合、自身のTaskに特に関連するSpecificationを抽出し、`relevant-specifications.md` に整理する。整理手順については、**Common Guide** の該当プロセスに従って実施する。

`relevant-specifications.md` の更新の際は、所定のテンプレート(`assets/relevant-specifications-template.md`)を使用する。

**Overall Design Specifications** に参照対象となるSpecificationが存在しない場合は、本Taskをスキップする。


### Task 4: Understand Existing Implementation

**Requirement Mode** が `CR` の場合にのみ実施する。Otherwise、本Taskをスキップする。

`tasklist.md`、`relevant-specifications.md`、**Specification Sources**および**Domain Guide**に定義された確認観点をもとに、Current Trainの変更対象に関係する既存実装を、担当Moduleの**Workspace**にて調査し、その構造および現在の実装状態を理解する。

調査結果のうち、以降の構築・開発において前提となる内容を `existing-implementation.md` に整理する。

`existing-implementation.md` の更新の際は、所定の記入例(`assets/existing-implementation-example.md`)を参考にする。

### Task 5: Understand Domain Implementation Conventions

同Domainの他のModuleの **Workspace** 配下に既存実装が存在する場合、その内容をRead-Onlyで確認し、担当Moduleの構築・開発において参考となるProject内の実装上の構造、体裁および慣例を把握する。

- 他Moduleの既存実装は参考情報として扱い、Specification、**Development Guidelines**、**Domain Guide**その他の明示的な定義・規則より優先しない。
- 以降の構築・開発において参考となる内容を把握した場合は、`existing-implementation.md` に整理して記録する。

`existing-implementation.md` の更新の際は、所定の記入例(`assets/existing-implementation-example.md`)を参考にする。

### Task 6: Prepare Branch for Implementation
担当モジュールについて作業ブランチを作成し、チェックアウトする。

ブランチ名は、`<prefix>/<current-train-name>` の形式とする。prefixの命名規則については**Development Guidelines** に従う。


### Task 7: Prepare Repository Structure
これまでに確認・整理したSpecification、Task、既存実装その他の情報を必要に応じて改めて確認し、担当Moduleの構築・開発に必要であることが確定しているRepository Structureを、担当Moduleの **Workspace** に構成する。構成手順については、**Common Guide** の該当プロセスに従って実施する。

※ 本TaskではDirectoryおよび必要なファイルの配置までを行い、各ファイルに具体的な実装・設定内容は記述しない。内容の記述は後続の対応Taskで行う。

### Task 8: Establish Module Quality Gate
担当Moduleの **Workspace** の`AGENTS.md`を作成・更新する。

- 対象の`AGENTS.md`が存在しない場合は、作成する。
- 対象の`AGENTS.md`がすでに存在する場合は、Development Guidelinesの変更、または担当Moduleのアーキテクチャの変更に付随して、品質観点や判断基準について重要な追加・変更観点がある場合にのみ更新する。
- 作成・更新の際はテンプレート(`assets/Agentsmd-for-the-module-template.md`)を使用する。
- ただしテンプレートにおける各項目はあくまで参考であり、必要な項目に応じて柔軟に追加・変更する。関連のない項目は無理に記載せず削除する。
- 冒頭にはテンプレート通り、「必ず日本語でレビューおよびコメントをしてください。」とする。
- **Development Guidelines** に記載の規定のうち、担当Moduleに該当する項目は全て、PRレビューの際に確認すべき観点として記載する。
- 担当Moduleのアーキテクチャ上、特有の品質観点や判断基準がある場合は明示的に記載する。
- アーキテクチャを問わず求められるような一般的な品質観点や判断基準については、あえて記載しない。
- 作成の際、同Domainの他のModuleの`AGENTS.md` が存在すれば参照し、アーキテクチャが一致する部分については適宜流用する。

### Task 9: Test Specification
この工程を実施するかユーザーに確認し、その回答次第では本Taskをスキップし、次のTaskへ進む。

Work Skill `$test-design` を使用し、担当Moduleの構築・開発結果を検証するためのTest Specificationを作成する。

**Default Inputs For Work Skill**をInputとして連携する。

### Task 10: Determine Static Analysis
**Common Guide** の該当プロセスに従い、担当Moduleで使用するStatic Analysisの方法を確認・決定し、必要な準備を行う。

### Task 11: Configure CI/CD Pipeline
担当Moduleの `tasklist.md` 内の **Development Allocation** において、CI/CD Pipelineが `Setup Required` または `Change Required` の場合に本Taskを実施する。`No` の場合は本Taskをスキップする。

Work Skill `$cicd-pipeline-configuration` を使用し、担当Moduleに必要なCI/CD Pipelineを構築または変更する。

**Default Inputs For Work Skill**をInputとして連携する。

### Task 12: Prepare Runtime Environment
担当Moduleの `tasklist.md` 内の **Development Allocation** において、
- Container Imageが `Setup Required`
- Container Imageが `Change Required`
- Orchestration Workloadが `Setup Required`
- Orchestration Workloadが `Change Required`
のいずれかに当てはまる場合に本Taskを実施する。当てはまらない場合は本Taskをスキップする。

Work Skill `$runtime-environment-configuration` を使用し、後続の**Implementation Loop**で継続的にBuild・Deploy・Runtime Verificationを実施するためのRuntime Environmentを構成する。

**Default Inputs For Work Skill**をInputとして連携する。

Work Skillでは `tasklist.md` の **Development Allocation** を確認し、Orchestration Workloadが `Setup Required` または `Change Required` の場合は、その構築・変更も対象に含める。

### Task 13: Execute Implementation Loop
`tasklist.md` に記録された担当Taskについて、**Implementation Loop**を実行する。

1. `tasklist.md` のTask、DependenciesおよびExecution Orderを確認し、今回実施するTaskとその順序を整理する。
2. 実施するTaskと順序、またその要約・概要をユーザーに提示し、確認・承認を得る。
3. **Domain Guide** に指定された **Work Skill for Implementation Loop** を特定し、**Default Inputs for Work Skills** をInputとして連携して**Implementation Loop**を実行する。
4. `tasklist.md` の表から、対象Taskの**Implementation Loop**がすべて完了したことを確認する。

### Task 14: Resolve Remaining Pending Information
担当Moduleの **Implementation Loop** 完了後、**Pending Information** 、`blockers.md` およびそれぞれに関連する作業結果を改めて確認し、これまでの構築・開発を通して解決・確定可能となった情報や、残された対応事項を整理する。

1. **Pending Information** を確認し、各TaskのImplementation、Environmentへの適用・DeployおよびVerificationの結果によって、解決・確定可能となった情報・項目がないか確認する。
2. CI/CD Pipeline、Runtime Environmentおよび担当ModuleのImplementationについて、未完了の設定・実装・検証事項がないか確認する。
3. 現時点で解決・対応可能な事項がある場合は、以下に従って対応する。
   - 情報の確定や記録の更新のみで対応できる場合は、本Task内で必要な更新を行う。
   - Configuration、ImplementationまたはVerificationの追加・変更が必要な場合は、`tasklist.md` の **Task Table** に必要なTaskを追加し、該当するWork Skillまたは **Implementation Loop** に従って対応する。
   - 対応完了後は、本Taskの手順1から再度確認する。
4. 現時点で解決できない事項については、その理由、解決に必要な条件および後続工程への影響を整理し、**Pending Information** に記録する。
5. 残存する **Pending Information** およびBlockerについて、以下を確認する。
   - 担当ModuleのDevelopment完了に必要な作業を阻害する事項が残っていないこと。
   - 後続のDelivery Flowで解決・対応可能な事項については、影響を受けるTaskおよび解決・確認が必要となるタイミングが明確になっていること。
   - Development Flowの完了またはDelivery Flowの開始を阻害するBlockerが存在する場合は、解消されるまで次のTaskへ進まない。
6. 担当ModuleのWorkspaceについて、Gitの作業状態を確認し、未コミット・未プッシュの変更や未追跡ファイルが残っていないことを確認する。

### Task 15: Guide to Executor Delivery Flow
本Workflowに定義された担当Moduleの構築・開発および関連工程がすべて完了したことをユーザーに報告する。

報告にあたっては、残存する **Pending Information** が存在する場合、その内容、解決に必要な条件および後続工程への影響を併せて提示する。

次の工程として、実装内容の全体レビューやIntegration Test、Releaseなどを担う `$executor-delivery-flow` をユーザーに案内する。

本Taskでは、`$executor-delivery-flow` の実行は開始しない。


