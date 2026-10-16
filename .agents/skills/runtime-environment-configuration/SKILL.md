---
name: runtime-environment-configuration
description: >
  特定の具体的な作業を実施するWork型 Skill。
  担当Moduleについて、後続のImplementation Loopで継続的にBuild・Deploy・Runtime Verificationを実施するために必要なContainerおよびOrchestration Workloadの実行環境を初期構築または変更する。
  Use when: Executorが担当ModuleのImplementationに先立ってRuntime Environmentを構成するとき。
  Do not use for: Module本体の構築・開発・実装、Implementation Loopの進行に伴うRuntime Environmentの継続的な調整、CI/CD Pipelineの構築・変更、Test Specificationの作成やTestの実行。
---

# Work Skill: runtime-environment-configuration

## Summary
担当ModuleのSpecification、Task、既存・参考実装および関連するExternal Informationに基づき、後続のImplementation Loopで継続的にBuild・Deploy・Runtime Verificationを実施するためのRuntime Environmentを構成する。

Container Imageが対応対象の場合は、Build・実行に必要なContainer Configurationを構築または変更する。Orchestration Workloadが対応対象の場合は、対象EnvironmentへのDeploy・実行に必要なWorkload Configurationを構築または変更する。対応対象でない構成は変更せず、依存関係の確認に必要な範囲で参照する。

構成後は、現時点で実行可能な最小構成を使用してBuild・Deploy・Runtime Verificationの一連の経路を成立させ、後続のImplementation Loopから継続的に利用可能な状態であること、およびSpecificationとの整合性を確認する。

## Input
### **Domain**
担当するModuleの所属するDomain

### **Module**
担当するModule

### **Requirement Mode**
Current TrainのRequirement Mode
`INITIAL` / `CR` のいずれか。

### **Specification Sources**
担当Moduleの構築において参照するSpecificationのパス
複数指定可。


## Executor Rules
**Executor Rules** : Executorが作業全体を通して遵守する共通ルールを以下にて管理する。

```
.agents/resources/executor-rules.md
```

## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- 各Stepは**Execution Steps**に記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。
- Step内で具体的な手順や判断について **Guide** の該当プロセスに従うよう指定されている場合は、**Guide**にある当該Step名と同名の項目のプロセスの内容に従ってStepを実施する。


## Task
担当Taskが記録された `tasklist.md`あるいは、その内容。
```
docs/.steering/<current-train>/<module-name>/tasklist.md
```

## Guide for the Skill (`references/guide.md`)
このガイドの内容を踏まえながら、全てのStepを実行する。


## Runtime Environment Requirements
Specification Sourcesから抽出した、担当ModuleのRuntime Environmentに関する要求、仕様および制約を以下にて管理する。
```
docs/.steering/<current-train>/<module-name>/working/runtime-environment-requirements.md
```

## Existing and Reference Runtime Environments
担当Moduleの既存Runtime Environmentおよび同Domainの参考Runtime Environmentから、Runtime Environmentの構築・変更について前提または参考となる内容は、必要に応じて以下に整理する。
```
docs/.steering/<current-train>/<module-name>/working/runtime-environment-existing-and-reference.md
```

## Draft
Runtime Environmentの構築・変更に向けて検討・具体化したConfigurationの設計内容を以下にて管理する。
```
docs/.steering/<current-train>/<module-name>/working/runtime-environment-design.md
```

## External Information
他の担当またはユーザーから共有された、Runtime Environmentの構築・変更に関連する情報が含まれる可能性がある。
```
docs/.steering/<current-train>/shared/handover/*
```

## Pending Information
Runtime Environmentの構築・変更または実行に必要となる情報のうち、未確定または未提供の情報を以下にて管理する。
```
docs/.steering/<current-train>/<module-name>/working/pending-information.md
```

## Goal
- **Execution Steps**に定義されたすべてのStepが完了していること。

## List of Step
- Confirm Inputs
- Extract Runtime Environment Requirements
- Understand Existing and Reference Runtime Environments
- Draft Runtime Environment Configuration
- Check Required Information
- Configure Container
- Configure Orchestration Workload
- Build and Deploy Minimum Runtime
- Verify Runtime Environment
- Check Consistency with Specifications

## Execution Steps

### Step 0: Confirm Inputs
- **Inputs** によって引き継がれた情報を改めて確認する。
- **Task** を確認し、Container ImageおよびOrchestration Workloadの対応要否を特定する。
   - **Container Image**: [Setup Required / Change Required / No] のどれに該当するかを特定
   - **Orchestration Workload**: [Setup Required / Change Required / No] のどれに該当するかを特定
   - Container ImageとOrchestration WorkloadがともにNoの場合は、本Skillの呼び出し条件を満たしていないとして、後続Stepを実施せず、本Work Skillを終了する。

### Step 1: Extract Runtime Environment Requirements
**Guide** の該当プロセスに従い、Specification Sourcesから担当ModuleのRuntime Environmentの構築・変更に関係する要求、仕様および制約を抽出する。

抽出結果は **Runtime Environment Requirements** に整理する。

### Step 2: Understand Existing and Reference Runtime Environments
**Guide** の該当プロセスに従い、担当Moduleの既存実装および同Domainの参考実装から、Runtime Environmentの構築・変更において前提または参考となる内容を把握する。

把握した内容のうち後続Stepで参照する必要があるものは、**Existing and Reference Runtime Environment** に整理する。

### Step 3: Draft Runtime Environment Configuration
**Guide** の該当プロセスに従い、前項までで抽出・把握した情報をもとに、後続の**Implementation Loop**で継続的にBuild・Deploy・Runtime Verificationを行うためのRuntime Environmentを具体化し、**Draft** に整理する。

Container ImageおよびOrchestration Workloadについて、Step 0でSetup RequiredまたはChange Requiredと判定されたものだけを構築・変更対象とする。対応対象でない構成は、対象構成との依存関係や整合性を確認するための前提として扱い、変更対象へ追加しない。

### Step 4: Check Required Information
**Guide** の該当プロセスに従い、**Draft** に基づいてRuntime Environmentの構築・実行に必要な情報の充足状況を確認する。

未確定または未提供の情報が存在する場合は、**Pending Information** に整理する。


### Step 5: Configure Container
Container Imageが対応対象の場合に実施する。対応対象でない場合は本Stepをスキップする。

**Guide** の該当プロセスに従い、**Draft** に基づいて後続のImplementation Loopで継続的にBuildおよびRuntime Verificationを行うためのContainerを構築または変更する。


### Step 6: Configure Orchestration Workload
Orchestration Workloadが対応対象の場合に実施する。対応対象でない場合は本Stepをスキップする。

**Guide** の該当プロセスに従い、**Draft** に基づいて後続のImplementation Loopで継続的にDeployおよびRuntime Verificationを行うためのOrchestration Workloadを構築または変更する。


### Step 7: Build and Deploy Minimum Runtime
**Guide** の該当プロセスに従い、ContainerおよびOrchestration Workloadのうち対応対象として前項までで構成したものを使用して、現時点で実行可能な最小構成のRuntimeをBuild・Deployする。


### Step 8: Verify Runtime Environment
**Guide** の該当プロセスに従い、Build・DeployしたRuntime Environmentが、後続のImplementation Loopで継続的に利用可能な状態であることを確認する。


### Step 9: Check Consistency with Specifications
**Guide** の該当プロセスに従い、構築・変更したRuntime Environmentを **Specification Sources** および **Runtime Environment Requirements** と照合し、要求された内容が適切に反映されていることを確認する。また、対応対象でないContainer ImageまたはOrchestration Workloadへ不要な変更が加えられていないことを確認する。
