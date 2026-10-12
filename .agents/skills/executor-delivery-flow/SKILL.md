---
name: executor-delivery-flow
description: >
  工程の順序と進行を管理するExecutor型 Flow Skill。
  担当ModuleのImplementation Loop完了後、Specificationとの整合性確認、Code Review、Integration Test、Documentation、HandoffおよびRelease準備を行い、リリースと本番確認からModule完了報告までの工程を進行する。
  Use when: Executorとして担当ModuleのImplementation Loopが完了し、実装内容の全体レビューから、Integration Test、リリース、本番確認およびModule完了までの工程を進行するとき。
  Do not use for: 構想、要件定義、設計、Task Allocation、Train全体の進捗管理、通常の構築・開発工程。他Moduleの構築・開発。
---

# Flow Skill For Executor: executor-delivery-flow

## Summary

あなたの役割は、特定のModuleの構築・開発を担当するExecutorです。

このSkillを用いて、**executor-development-flow** において完了した担当ModuleのImplementationを引き継ぎ、Specificationとの整合性確認、Code Review、Integration Test、DocumentationおよびHandoffを進行してください。

その後、Release準備、リリースおよび本番確認を進行し、担当Moduleの対応結果を整理・報告して、Current Trainにおける担当Moduleの作業を完了させてください。

Workflow全体を通して **Executor Rules** に従い、各工程では **Common Guide** および担当Domainの **Domain Guide** を参照します。具体的な作業についてWork Skillが指定されている場合は、対応するWork Skillを使用して実施してください。


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
- **Ad Hoc Workflow Context** に基づくTaskの再実施および復帰については、記録された **Re-entry Task**、**Re-execution Scope** および **Origin Task** に従う。

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
本Workflowの進行状況は、以下のファイルの**executor-delivery-flow**の進捗表にて記録・管理する:

```
docs/.steering/<current-train>/<module-name>/flow-status.md
```

以下のルールに従って管理または更新する。
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

## Outgoing Handover Information
自身の担当Moduleから他Domain / Moduleへ引き継ぐ必要がある情報を整理・管理する。
```
docs/.steering/<current-train>/<module-name>/handover-from-<module-name>.md
```


## Goal
Workflowに定義されたすべてのTaskが完了し、その完了についてユーザーの承認を得ること。


## Workflow Initialization
Workflowを開始する場合、または中断していたWorkflowを途中から再開する場合は、各Taskの実行に先立って以下を行う。

### **Load Project Rules and Context**
- **Executor Rules**、`AGENTS.md`、 **Development Guidelines** を全て読み、その内容を以降のすべての作業の前提とする。
- `docs/persistent/product-requirement-definition.md`を読みプロジェクトの概要を把握する。
- `docs/change-requirements/` 配下にファイルが存在する場合は、Current Trainにおける変更対応の内容を確認する。
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
自身に割り当てられた担当をもとに、以降のWorkflowで使用するおよび **Domain Guide** を特定し、その内容を確認する。

1. 自身に割り当てられた担当から、担当DomainおよびModuleを特定する。
2. **Executor Rules** に従い、担当Moduleに対応するSteering領域を特定し、その内容を確認する。
3. 担当Domainに対応する **Domain Guide** を特定し、その内容を確認する。

## Workflow Overview
── Integration ──
- Verify Overall Specification Consistency
- Address Specification Review Findings
- Create Pull Requests
- Await Pull Request Reviews
- Address Pull Request Review Findings
- Merge for Integration Branch
- Execute Integration Test
- Review Integration Test Results and Address Issues

── Post-Integration ──
- Organize Module README
- Prepare Release Branch
- Prepare Release Instructions
- Finalize Module Handover
- Report Development Results

── Release ──
- Await Release Preparation
- Merge for Release Branch
- Execute Release and Production Verification
- Review Release Results and Address Issues
- Await Production Verification Completion
- Post-Release Actions
- Finalize Module in Current Train


## Task Sample
Workflow内にて、各Taskは以下の形式で定義する。
### Task X: Task Name
使用するWork Skillと、このTaskで実施する内容。
- 作業概要1
- 作業概要2
- 作業概要3

## Workflow

### Task 1: Verify Overall Specification Consistency
担当Moduleの **Workspace** にあるImplementationについて、Current Trainの担当TaskおよびSpecificationとの全体的な整合性を確認し、不整合や実装の欠落を抽出する。

具体的な調査・抽出手順については、**Common Guide** の該当プロセスに従い、結果を `implementation-consistency-review.md` に整理する。

### Task 2: Address Specification Review Findings
前Taskで抽出した `implementation-consistency-review.md` の指摘事項について、妥当性および対応要否を確認し、必要な対応方針をユーザーと協議・決定する。

対応が必要な事項については必要なImplementationおよびVerificationを実施する。

具体的な対応手順については、**Common Guide** の該当プロセスに従う。

### Task 3: Create Pull Requests
**Development Guidelines** に従い、担当Moduleについて、現在対応中のブランチ(作業ブランチもしくはFixブランチ)から統合ブランチへのPull Request / Merge Requestを作成する。

使用するRemote Repositoryに応じて `gh` または `glab` などを使用し、必要な情報を整理してPR/MRを作成する。

具体的な作成・確認手順については、**Common Guide** の該当プロセスに従う。

### Task 4: Await Pull Request Reviews
作成したPull Request / Merge Requestについて、ユーザーにReviewの実施・進捗確認を依頼し、Review結果が確定した旨の報告を受けるまで待機する。

待機中の相談・対応依頼については都度対応するが、その対応によって当該Await Taskの完了条件が満たされたものとは扱わない。

Review結果の確定が報告された後、次のTaskへ進む。


### Task 5: Address Pull Request Review Findings
`gh` または `glab` などを使用してPull Request / Merge RequestのReview結果およびコメントを取得し、各指摘の妥当性と対応要否を確認する。

1. 対応が必要な指摘事項については、対応方針をユーザーと協議・決定し、`tasklist.md` の **Task Table** に追加した上で、**Common Guide** の **How to start the Implementation Loop** の手順に従って、必要なImplementationおよびVerificationを実施する。
2. 対応が完了した指摘事項については、各Review Commentへの返信内容をユーザーと協議・決定し、ユーザーに返信を依頼する。
3. 対応が必要な指摘事項が存在した場合は、対応および返信依頼の完了後、**Task: Await Pull Request Reviews** から本Taskまでを再実施する。

Review結果に対応が必要な指摘事項が存在せず、必要なReviewがすべて完了している場合は、本Taskを完了して次のTaskへ進む。

### Task 6: Merge for Integration Branch
Pull Request / Merge RequestのReviewが完了し、必要な対応がすべて実施された後、担当Moduleの作業ブランチから統合ブランチへのマージを実施して、統合ブランチへチェックアウトする。


Merge完了後、統合ブランチの状態を確認し、次のTaskへ進む。

### Task 7: Execute Integration Test
`test/test-specification.md` が存在する場合、Work Skill `$test-execution` を使用し、担当ModuleのIntegration Testを実施する。

**Default Inputs For Work Skill**をInputとして連携する。

`test/test-specification.md` が存在しない場合は、本Taskをスキップする。

### Task 8: Review Integration Test Results and Address Issues
Integration Testの実施結果を確認し、問題、不具合、期待結果との不一致および後続工程への進行を妨げる事項の有無を確認する。

これらの事項が存在しない場合は、本Taskを完了したものとして次のTaskへ進む。

これらの事項が存在する場合は、**Common Guide** の **Handling Issues After Verification** に規定されたプロセスに従って必要な調査・対応を実施し、同プロセスで決定したTaskおよび実施範囲に基づき、本Workflowを必要なTaskから再実施する。

対応状況、Verification結果および残存リスクを確認し、ユーザーと後続工程への進行可否を判断する。進行可能と判断された場合に限り、本Taskを完了して次のTaskへ進む。

### Task 9: Organize Module README
担当ModuleのImplementationおよびIntegration Testの結果を踏まえ、担当Moduleの **Workspace** にある `README.md` を作成または更新する。

READMEには、ProjectおよびModuleの概要、主要なSpecificationへの参照、Technology Stack、Repository Structure、構築・実行方法その他の利用・保守に必要な情報を整理する。

具体的な記載内容および構成は、**Common Guide** の該当プロセスに従う。

### Task 10: Prepare Release Branch
**Domain Guide** の **Branch Policy** においてリリースブランチが `Required` とされている場合、かつリリースブランチが存在しない場合は、**Development Guidelines** に従ってリリースブランチを準備する。

  - ブランチ名は、`<prefix>/<current-train-name>` の形式とする。

### Task 11: Prepare Release Instructions
担当ModuleのImplementation、CI/CD PipelineおよびRuntime Environmentの構成を確認し、Releaseに必要な操作、実行順序、事前条件、Verificationおよび問題発生時の対応方法を整理したRelease Instructionsを**Common Guide** の該当プロセスに従って作成する。

### Task 12: Finalize Module Handover
**Domain Guide** にて、 **Handover** が `Required` の場合、または `Optional` で **Outgoing Handover Information** に引き継ぐべき情報が存在する場合に本Taskを**Common Guide** の該当プロセスに従って実施する。

### Task 13: Report Development Results
担当ModuleのImplementation、Integration Testおよび関連する対応結果を整理し、Current Trainにおける担当ModuleのDevelopment Report を**Common Guide** の該当プロセスに従って作成する。

### Task 14: Await Release Preparation
**Ad Hoc Workflow Context** の **Active Context** に、本Taskを **Origin Task** とするContext(対応したCorrection Requestについて)が存在する場合は、**Common Guide** の **Finalize Correction Request Responses** に従って必要な対応を実施する。

担当ModuleのReleaseに必要な準備が整った旨の報告および進行指示をユーザーから受けるまで待機する。

待機中の相談・対応依頼については、**Common Guide** の **Handling Requests During Await** に従って対応する。

### Task 15: Merge for Release Branch
Release準備が完了した旨の報告および進行指示をユーザーから受けた後、**Development Guidelines** に従い、担当Moduleの統合ブランチからリリースブランチへのマージを実施して、リリース用ブランチへチェックアウトする。

Mergeにあたっては、対象BranchおよびCommit、未反映の変更、Merge Conflictの有無を確認し、Release対象となる変更が適切に反映されたことを確認する。

Merge完了後、リリースブランチの状態を確認し、次のTaskへ進む。

### Task 16: Execute Release and Production Verification
Work Skill `$release-execution` を使用し、担当ModuleのRelease Instructionsに従ってReleaseおよびProduction Verificationを実施する。

**Default Inputs For Work Skill**をInputとして連携する。

### Task 17: Review Release Results and Address Issues
ReleaseまたはProduction Verificationの実施結果を確認し、問題、不具合、期待結果との不一致および後続工程への進行を妨げる事項の有無を確認する。

これらの事項が存在しない場合は、本Taskを完了したものとして次のTaskへ進む。

これらの事項が存在する場合は、**Common Guide** の **Handling Issues After Verification** に規定されたプロセスに従って必要な調査・対応を実施し、同プロセスで決定したTaskおよび実施範囲に基づき、本Workflowを必要なTaskから再実施する。

対応状況、Verification結果および残存リスクを確認し、ユーザーと後続工程への進行可否を判断する。進行可能と判断された場合に限り、本Taskを完了して次のTaskへ進む。

### Task 18: Await Production Verification Completion
**Ad Hoc Workflow Context** の **Active Context** に、本Taskを **Origin Task** とするContext(対応したCorrection Requestについて)が存在する場合は、**Common Guide** の **Finalize Correction Request Responses** に従って必要な対応を実施する。


Current TrainについてProject全体のProduction Verificationが完了した旨の報告および進行指示をユーザーから受けるまで待機する。

待機中の相談・対応依頼については、**Common Guide** の **Handling Requests During Await** に従って対応する。

### Task 19: Post-Release Actions
**Domain Guide** にて、 **Post-Release Actions** が要求されている場合は、その内容に従って必要な作業を実施する。

該当する定義が存在しない場合は、本Taskをスキップする。

### Task 20: Finalize Module in Current Train
担当Moduleについて、Current Trainにおける必要な作業および関連する対応がすべて完了していることを確認し、Moduleの作業を終了する。
1. **Development Guidelines** に従い、リリース用BranchのMaster Mergeおよび整理を行い、MasterブランチへCurrent Trainの変更が反映されていることを確認する。
2. 担当Moduleの **Workspace** について、未コミットの変更や未追跡ファイルが残っていないことを確認する。
3. `tasklist.md`、`blockers.md`、`pending-information.md` その他のSteering情報を確認し、未完了の作業や未解決事項について必要な対応・判断が完了していることを確認する。
4. 担当ModuleのCurrent Trainにおける作業完了をユーザーに報告する。

