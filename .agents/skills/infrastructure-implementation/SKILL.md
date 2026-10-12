---
name: infrastructure-implementation
description: >
  特定Domainの構築・開発を実施するWork Skill for Implementation Loop。
  Infrastructure Domainの担当Moduleについて、割り当てられたTaskごとにSpecificationおよび既存・参考実装を確認し、Infrastructureの実装、Static Validation、Environmentへの適用およびOperational Verificationを反復して実施する。
  Use when: Infrastructure DomainのModuleを担当するExecutorが、割り当てられたTaskのImplementationを実施するとき。
  Do not use for: Infrastructureの設計、Repository Structureの準備、Test Specificationの作成、CI/CD PipelineやRuntime Environmentの初期構成、正式なTest Execution、他DomainのImplementation。
---

# Work Skill: infrastructure-implementation
## Summary
Infrastructure Domainの担当Moduleについて、`tasklist.md` に割り当てられたTaskを単位として**Implementation Loop**を実施し、Specificationに定義されたInfrastructureを構築する。

各Taskでは、Specificationを正として既存・参考実装および使用するDependencyを理解した上でImplementationを行い、利用可能なStatic ValidationとSpecificationとの整合性確認を実施する。

Implementation後は、Environmentへの適用およびOperational Verificationの方法を事前に整理し、実際のEnvironmentへ適用した上で期待する構成・状態・動作となっていることを確認する。確認結果に問題がある場合は必要なStepまで戻って再度順に実施し、Taskが完了したら `tasklist.md` を更新して次のTaskのImplementation Loopへ進む。

## Input
### **Module**
担当するModule。

### **Requirement Mode**
Current TrainのRequirement Mode。
`INITIAL` / `CR` のいずれか。

### **Specification Sources**
担当Moduleの構築において参照するSpecificationのパス。
複数指定可。


## Executor Rules

**Executor Rules** : Executorが作業全体を通して遵守する共通ルールを以下にて管理する。

```
.agents/resources/executor-rules.md
```


## 前提条件
- 
## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- 各Stepは**Execution Steps**に記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。
- **Development Guidelines** を作業全体の前提とし、内容を常に確認しながら作業を進める。
- 対象Resourceについて複数Environmentの定義が必要な場合は、必要な全Environmentの定義の追加・変更をまとめて実施する。


## Draft
```
docs/.steering/<current-train>/<module-name>/working/implementation/task-<task-no>.md
```
- 各Implementation Loopでは、対象Taskに対応する **Draft**  を作業上の補助情報として使用する。
- 各工程の中で調査・把握・整理した内容のうち、後続Stepで参照する必要がある要点やメモを適宜記録する。
- 詳細な情報を複製するのではなく、後続作業に必要な要点と必要に応じて参照元を記録する。
- 本ファイルはTaskのSpecificationや正式なDecisionの代替とはしない。重要な判断は `decisions.md`、Blockerは `blockers.md` など、**Executor Rules** で定められた正規の管理先へ記録する。


## **Environment Lifecycle and Dormancy Strategy**
`docs/persistent/infrastructure-design.md` や `docs/change-requirements/infrastructure-design.md` に定義されるセクション。リソースや環境の停止、縮退、削除、再生成、復元等のLifecycle Strategyが記載されている。

## Task Table
以下にてTask Tableとその進捗が管理されている。
```
docs/.steering/<current-train>/<module-name>/tasklist.md
```

## External Information
他の担当またはユーザーから共有された、当該TaskのImplementationに関連する情報が含まれる可能性がある。
```
docs/.steering/<current-train>/shared/handover/*
```

## Pending Information
いずれかの工程の中で、未確定または未解決になった情報・項目を以下にて管理する。
```
docs/.steering/<current-train>/<module-name>/working/pending-information.md
```

- いずれかの工程の中で未確定または未解決の情報・項目が判明した場合は、ユーザーに報告の上、その時点で Pending Information に記録する。後続の作業によって解決・確定した場合は、その結果を反映して更新する。

## Test Specification
担当ModuleにおけるIntegration Testの内容および実施方法が定義されている。
```
docs/.steering/<current-train>/<module-name>/test/test-specification.md
```

## Outgoing Handover Information
自身の担当Moduleから他Domain / Moduleへ引き継ぐ必要がある情報を整理・管理する。
```
docs/.steering/<current-train>/<module-name>/handover-from-<module-name>.md
```


## Goal
- **Execution Steps**に定義されたすべてのStepが完了していること。

## List of Step
- Confirm Inputs

── Part A: Preparation ──
- Select Task
- Understand Specifications
- Understand Existing and Reference Implementation
- Plan Implementation
- Prepare Dependencies
- Understand Dependencies

── Part B: Implementation & Pre-Apply Verification ──
- Implement
- Static Validation
- Check Specification Consistency

── Part C: Apply & Operational Verification ──
- Plan Operational Verification
- Resolve Pending Information
- Restore Environment if Required
- Verify Environment Restoration
- Apply to Environment
- Perform Operational Verification

── Part D: Completion ──
- Update Outgoing Handover Information
- Confirm Completion

## Execution Steps
### Step 0: Confirm Inputs
- **Inputs** によって引き継がれた情報を改めて確認する。

### Step 1: Select Task
**Task Table** から、次に実施する未完了のTaskを選択し、本Implementation Loopの対象とする。

選択したTaskについて、以下にTask単位の **Draft** を作成する。

**Task Table** にて選択したTaskのStatusを更新し、以降のStepでは当該Taskを対象として作業する。

### Step 2: Understand Specifications
選択したTaskについて、**Specification Sources**、`relevant-specifications.md` および `tasklist.md` を確認し、実装対象となる仕様、制約および関連する技術要素を理解する。

必要に応じて元のSpecificationを改めて確認し、抽出・整理された情報のみから推測によって仕様を補完しない。

### Step 3: Understand Existing and Reference Implementation
選択したTaskの実装に関係する既存実装が存在する場合は、その内容や`existing-implementation.md` を確認し、今回のImplementationにおいて維持・変更・追加する範囲を把握する。

同Domainの他Moduleに類似・参考実装が存在する場合は、必要に応じてその内容を確認し、実装上参考となる構造・方式を把握する。

既存実装や参考実装から把握できない内容を推測によって補完しない。

### Step 4: Plan Implementation
選択したTaskについて、Specificationを正として、前Stepまでで理解した既存・参考実装を踏まえ、今回実施するImplementationの内容と手順をユーザーと整理し、完了したら作業概要イメージをユーザーに提示する。

- 新規作成・変更する対象
- 既存実装のうち維持する対象
- 使用する既存Component、Module、Libraryその他のDependency
- Implementationの実施順序
- 対象Resourceについて定義・実装が必要となるEnvironment、およびEnvironment間の構成・設定差分
- 実装後に確認する内容

実装方法について必ず考慮すべき点については、**Guide** の **Implementation Policy** を参照する。

**External Information**に関連する情報が存在する場合は、これも整理内容に含める。

また、**Task Table**全体における本Taskの立ち位置や、本Work Skillの**List of Step** も確認し、作業全体の流れも含めて本TaskのImplementation Planを整理する。

Specificationに定義されていない設計を独自に追加せず、実装上の判断が必要な場合はProjectのルールに従って確認・決定する。

### Step 5: Prepare Dependencies
選択したTaskのImplementationで使用する外部Module、Library、Framework、Plugin、その他のDependencyについて、実装前にその内容を確認できる状態へ準備する。

- 前項までに使用することが確定したDependencyを対象とする。
- Dependencyを取得・解決するための標準的なToolまたはCommandが存在する場合は、それを使用して実際のDependencyを取得する。
- Dependencyの取得にConfigurationやCodeが必要な場合は、Dependencyを取得・確認するために必要な最小限の内容のみを作成する。
- Dependencyの取得を目的として、Specificationに基づく本来のImplementationを先行して行わない。
- 既に必要なDependencyが取得済みであり、その内容を確認可能な場合は、不要な再取得を行わない。

InfrastructureにおいてTerraformまたはTerragruntの公開Moduleや共有Moduleを使用する場合は、原則として `terraform init` / `terragrunt init` 等の標準的な方法によってModuleを取得し、実際のModule Sourceを確認可能な状態にする。


### Step 6: Understand Dependencies
前項で準備したDependencyについて、選択したTaskのImplementationに必要な範囲で実際の内容を確認し、その使用方法、制約およびImplementationへの影響を理解する。

- 公開されている説明やDocumentだけでなく、必要に応じて取得したDependencyの実体を確認する。
- 今回使用するInterface、Input、Output、Configuration、Default Behaviorその他、Implementationに必要となる内容を確認する。
- Dependency内部の実装について、今回のTaskに必要な範囲を超えて網羅的に調査しない。
- 把握した内容のうち後続Stepで参照する必要がある要点は、対象Taskの **Draft** に整理する。
- Dependencyの実際の内容から確認できない事項を推測によって補完しない。

TerraformまたはTerragruntのModuleを使用する場合は、取得したModule Sourceを確認し、少なくとも今回使用するInput、Output、Default値、Resource構成および利用上の制約について、Implementationに必要な範囲で把握する。

### Step 7: Implement
前Stepまでで確認・整理したSpecification、既存・参考実装、DependencyおよびImplementation Planに基づき、選択したTaskを実装する。

- Specificationを正として実装する。
- 既存実装を変更する場合は、必要な変更範囲に限定する。
- 実装方法について必ず考慮すべき点については、**Guide** の **Implementation Policy** を参照する。
- 実装中に新たな調査・確認が必要になった場合は、必要に応じて実際の実装やSpecificationへ戻って確認する。
- 実装上の重要な判断が発生した場合は、**Executor Rules** に従って記録する。
- 実装中に把握・整理した補助的な情報は、必要に応じて対象Taskの **Draft** に記録する。

### Step 8: Static Validation
担当ModuleについてStatic Analysis / Validationの方法が定義されており、現在の構成で実行可能な場合は、実装した内容に対してStatic Validationを実施する。

実施可能なStatic Validationが一部のみ存在する場合はその範囲で実施し、実施可能なものが存在しない場合は本Stepをスキップする。

1. 既存のStatic Analysis / Validationに関するConfigurationを確認する。
2. `decisions.md` にCurrent TrainでのStatic Analysis / Validationの追加・変更に関するDecisionが存在する場合は、その内容を確認する。
3. 確認した方法のうち、現在のImplementationに対して実行可能なStatic Validationについて実行方法をユーザーに連携の上、実施する。
4. 問題が確認された場合は必要な修正を行い、再度Static Validationを実施する。

### Step 9: Check Specification Consistency
実装した内容を、選択したTaskに関連する **Specification Sources** と照合し、要求された内容が欠落なく適切に反映されていることを確認する。

1. 前工程で確認したSpecificationおよび対象Taskの **Draft** をもとに、実装内容との対応を確認する。
2. 必要に応じて元の **Specification Sources** を改めて確認し、整理・要約した情報のみに依存して判定しない。
3. Specificationに定義された構造、Configuration、制約その他の内容について、実装との不整合や欠落がないことを確認する。
4. 不整合または欠落が確認された場合は必要なStepまで戻って、再度順にStepを実施する。


### Step 10: Plan Operational Verification
**Guide** の **Plan Operational Verification** に従い、選択したTaskのImplementationについて、Environmentへの適用および**Operational Verification**の方法と手順を整理する。

### Step 11: Resolve Pending Information
**Pending Information** を確認し、選択したTaskのImplementation、Environmentへの適用またはVerificationによって解決・確定できる可能性のある情報・項目を特定する。

- 現時点ですでに提供・確定できる情報がある場合は、その内容を反映して **Pending Information** を更新する。
- Environmentへの適用またはVerificationによって確定できる情報がある場合は、その内容と確認方法を把握し、後続Stepで確認対象とする。
- 選択したTaskとは関係せず、本Taskによって解決できない項目については変更しない。

### Step 12: Restore Environment if Required
本Trainの **Requirement Mode** が `CR` であり、かつ選択したTaskのImplementationを適用・検証する前提となる開発・構築環境（dev等）またはその構成要素が停止・縮退・削除された状態にある場合は、本Stepを実施する。

**Draft** に整理した方法と手順、および **Environment Lifecycle and Dormancy Strategy** に従い、定義されたLifecycle Action、CI/CD Pipelineその他の利用可能な方法によって、後続のImplementationの適用およびOperational Verificationに必要となるEnvironmentを復元する。

- 復元対象および現在のLifecycle Stateを確認する。
- Preservation対象となっているState、Data、Artifact、Configurationその他の情報を必要に応じて確認する。
- 定義されたRestorationの順序およびDependencyに従って復元を実施する。
- Agentまたはユーザーの実行主体については、**Draft** に整理した内容に従う。
- ユーザーが実施主体となる操作については、必要な操作内容、対象、手順および完了条件を提示し、ユーザーからの完了報告を受ける。

Environmentの復元が不要な場合は、本Stepをスキップする。

### Step 13: Verify Environment Restoration
前StepでEnvironmentまたはその構成要素を復元した場合は、**Draft** に整理したVerification方法および **Environment Lifecycle and Dormancy Strategy** に従い、後続のImplementationの適用およびOperational Verificationを実施可能な状態へ復元されていることを確認する。

- 復元対象となったResourceが必要な状態で存在・稼働していることを確認する。
- 後続のImplementationの適用に必要となるInfrastructure上のDependencyが利用可能であることを確認する。
- 必要に応じてInfrastructure Health、Network Connectivity、Configuration / Secret、State / Dataその他の復元対象を確認する。
- 復元後に必要となるConfigurationまたは関連Resourceが利用可能な状態であることを確認する。
- 問題または期待結果との不一致が確認された場合は、原因に応じて必要なStepまで戻り、再度順にStepを実施する。

前StepでEnvironmentの復元を実施していない場合は、本Stepをスキップする。


### Step 14: Apply to Environment
前工程で整理した方法と手順に従い、選択したTaskのImplementationを開発・構築環境(dev等)へ適用する。


Agentが実施主体となる操作はProjectの実行ルールに従って実施する。

ユーザーが実施主体となる操作については、必要な操作内容、対象、手順および完了条件を提示し、ユーザーからの完了報告を受けて結果を確認する。

適用中に問題が確認された場合は、原因に応じて必要なStepまで戻り、再度順にStepを実施する。


### Step 15: Perform Operational Verification
前工程で整理したVerification方法および手順に従い、開発・構築環境(dev等)へ適用したImplementationが期待する状態・動作となっていることを確認する。

- ResourceまたはWorkloadが期待する状態で存在・稼働していることを確認する。
- Specificationおよび選択したTaskに基づき、Environment上で確認すべき構成・状態・動作を確認する。
- Verificationに必要な操作については、前工程で決定した実行主体に従って実施する。
- 複数Environmentへ適用した場合は、適用した各Environmentについて、それぞれのSpecificationに基づく構成・状態・動作を確認する。
- 問題または期待結果との不一致が確認された場合は、原因に応じて必要なStepまで戻り、再度順にStepを実施する。

開発・構築環境(dev等)への適用またはVerificationの結果によって **Pending Information** の情報・項目を解決または確定できた場合は、その内容を反映して更新する。

### Step 16: Update Outgoing Handover Information

選択したTaskのImplementation、Environmentへの適用およびOperational Verificationを通じて確定した情報のうち、後続Moduleへの引き継ぎに必要となる内容を **Outgoing Handover Information** に記録・更新する。

- **Guide** の **Module Handover Policy** に定義された項目のうち、選択したTaskの対応内容に該当するものを確認する。
- Environmentごとに情報が異なる場合は、その対応関係を明確にする。
- 既存の記録がある場合は、その内容を維持しながら必要な追加・更新を行う。
- 引き継ぎ対象となる情報が存在しない場合は、本Stepをスキップする。

### Step 17: Confirm Completion
選択したTaskについて、本**Implementation Loop**で必要となるImplementation、Validation、Environmentへの適用およびVerificationが完了していることを確認する。

1. 選択したTaskについて、本Work Skillの各Stepが必要な範囲で完了していることを確認する。
2. `tasklist.md` の対象Taskを完了状態へ更新し、必要に応じてProgressを更新する。
3. `tasklist.md` に未完了のTaskが存在する場合は、次のTaskを対象として **Step 1** からImplementation Loopを継続する。
4. すべてのTaskが完了している場合は、本Work SkillおよびImplementation Loopを終了する。