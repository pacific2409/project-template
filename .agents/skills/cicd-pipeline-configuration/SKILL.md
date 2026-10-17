---
name: cicd-pipeline-configuration
description: >
  特定の具体的な作業を実施するWork型 Skill。
  担当ModuleのSpecification、既存・参考実装、Test Specification、開発上のDecisionおよび関連するHandoff情報に基づき、CI/CD Pipelineを新規構築または変更する。
  Use when: Executorが担当ModuleのCI/CD Pipelineを新規に構築、または既存Pipelineを変更するとき。
  Do not use for: Module本体の構築・開発・実装、Test Specificationの作成やTestの実行、RequirementやSpecificationの定義・変更。
---

# Work Skill: cicd-pipeline-configuration

## Summary
担当ModuleのSpecificationからCI/CDに関する要求・制約を特定し、既存・参考Pipeline、Test Specification、Static Analysisに関するDecision、および関連するHandoff情報を踏まえて、担当Moduleに必要なCI/CD Pipelineを構成する。

EnvironmentごとのPipeline要否とPipeline全体の構成を整理した上で、各JobおよびCI/CD Platform側・Repository側に必要なConfigurationを具体化し、CI/CD Platformの設定とPipeline Definitionの構築・変更を行う。

構築・変更後は、現時点で実行可能な範囲についてPipelineの動作を検証するとともに、Specificationおよび構築時に前提とした情報との整合性を確認する。

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
- **Executor Rules**に規定された**Phase Progression Principle** に沿って、またこれに矛盾しないよう、各Phaseの進行順序を遵守した内容になるように注意する。


## Task
担当Taskが記録された `tasklist.md`あるいは、その内容。
```
docs/.steering/<current-train>/<module-name>/tasklist.md
```

## Test Specification
担当ModuleにおけるTestの内容および実施方法が定義されている。
```
docs/.steering/<current-train>/<module-name>/test/test-specification.md
```

## Guide for the Skill (`references/guide.md`)
このガイドの内容を踏まえながら、全てのStepを実行する。


## CI/CD Requirements
Specification Sourcesから抽出した、担当ModuleのCI/CD Pipelineに関する要求、仕様および制約を以下にて管理する。
```
docs/.steering/<current-train>/<module-name>/working/ci-cd-requirements.md
```

## Existing and Reference CI/CD Pipelines
担当Moduleの既存Pipelineおよび同Domainの参考Pipelineから、CI/CD Pipelineの構築・変更について前提または参考となる内容は、必要に応じて以下に整理する。
```
docs/.steering/<current-train>/<module-name>/working/ci-cd-existing-and-reference.md
```

## Draft
CI/CD Pipelineの構築・変更に向けて検討・具体化したPipeline Configurationの設計内容を以下にて管理する。
```
docs/.steering/<current-train>/<module-name>/working/ci-cd-pipeline-design.md
```

## External Information
他の担当またはユーザーから共有された、CI/CD Pipelineの構築・変更に関連する情報が含まれる可能性がある。
```
docs/.steering/<current-train>/shared/handover/*
```

## Pending Information
CI/CD Pipelineの構築・変更または実行に必要となる情報のうち、未確定または未提供の情報を以下にて管理する。
```
docs/.steering/<current-train>/<module-name>/working/pending-information.md
```

## Goal
- **Execution Steps**に定義されたすべてのStepが完了していること。

## List of Step
- Confirm Inputs
- Extract CI/CD Requirements
- Understand Existing and Reference Pipelines
- Draft Pipeline Configuration
- Check Required Information
- Configure CI/CD Platform
- Implement Pipeline Definitions
- Validate Available Pipeline Behavior
- Configure CI/CD Platform After Implementation
- Check Consistency with Specifications

## Execution Steps

### Step 0: Confirm Inputs
- **Inputs** によって引き継がれた情報を改めて確認する。

### Step 1: Extract CI/CD Requirements

Agent `explorer` に **Specification Sources** のパスを連携し、担当ModuleのCI/CD Pipelineの構築・変更において考慮すべき要求、仕様および制約を抽出させる。

依頼時には、以下を抽出結果の出力先として連携する。 (変数<>となっている部分は適切に置き換えた上で連携する)

`docs/.steering/<current-train>/shared/information/ci-cd-requirements-<module-name>.md`

#### 依頼内容

```text
Specification Sourcesを参照し、担当ModuleのCI/CD Pipelineの構築・変更において考慮すべき要求、仕様および制約を抽出し、指定された出力先へ整理して記録する。

特に以下に関連する明示的な定義がある場合は抽出すること。

- CI/CD Pipelineを必要とするEnvironment
- PipelineのTriggerおよびBranch
- Build、Test、Static Analysisその他のVerification
- ArtifactおよびContainer Image等の生成・管理
- DeploymentおよびRelease
- Infrastructure、External Serviceその他の接続先
- Authentication、Authorization、Secretその他のSecurity
- Pipelineの実行条件、順序、依存関係その他の制約

各事項について、その根拠となるSpecificationのFile、Section、Subsectionを併せて記録する。

Specificationに明示されていないCI/CD Pipelineの構成、Job、Tool、実装方式等を独自に設計・補完しない。
```

#### 完了報告受領後

完了報告を受けたら出力結果を確認し、**CI/CD Requirements**のパスへ移動する。

### Step 2: Understand Existing and Reference Pipelines

担当Moduleおよび同Domainの参考Moduleについて既存のCI/CD Pipelineが存在する場合、その実装を確認し、後続のPipeline Configurationで前提または参考となる構成・設定を理解する。

1. 担当Moduleの **Workspace** に既存のCI/CD Pipelineが存在する場合、そのPipeline Definition、Scriptその他の関連実装を確認し、現在の構成、Environment、Job、Trigger、依存関係その他のPipeline Configurationを把握する。
2. 同Domainの他ModuleにCI/CD Pipelineの類似・参考実装が存在する場合は、**Executor Rules** に従ってRead-Onlyで確認し、担当Moduleでも参考となる構成・設定を把握する。
3. `docs/.steering/<current-train>/shared/examples/` にCI/CD Pipelineに関するExampleが存在する場合は、その内容を参考情報として確認する。
4. **Requirement Mode** が `CR` の場合は、担当Moduleの既存Pipelineを現在の実装状態として扱い、前項で抽出したCI/CD RequirementsおよびCurrent Trainの変更内容と照合し、維持する部分と変更を検討する必要がある部分を把握する。

把握した内容のうち、後続のPipeline Configurationで参照する必要があるものは、**CI/CD Requirements** とは分離して、**Existing and Reference CI/CD Pipelines** に整理する。

### Step 3: Draft Pipeline Configuration

前項までで抽出したCI/CD Requirements、把握した既存・参考Pipeline、および **Guide** をもとに、担当Moduleで構築・変更するCI/CD Pipelineの全体構成と具体的なConfigurationを検討し、**Draft** に整理する。この工程では特に本Skillの**Rule**を遵守すること。

また、`test/test-specification.md`、`decisions.md`、および **External Information** に担当ModuleのCI/CD Pipelineに関連する情報が存在する場合は、それらも確認しながら検討する。

以下の順序でPipeline Configurationを具体化する。

ただし、具体化の対象はCurrent Trainにおいて新規構築または変更が必要な範囲に限定し、既存構成との整合性および依存関係を考慮する。

1. **Environment Pipeline**
   - Specification、Taskおよび **Guide** を踏まえ、dev / stg / prod等の各EnvironmentについてPipelineの要否を特定する。
   - その要否に関わらず、環境ごとに実際のデプロイや適用についてユーザーとAgentのどちらが主導で行うかを明確にする。
   - 各Environmentについて、Pipelineが担う範囲および他Environmentとの関係を整理する。

2. **Pipeline Overview**
   - EnvironmentごとのPipeline要否を前提として、Pipeline全体のStage、実行順序、Trigger、Branchとの関係および主要な処理の流れを整理する。
   - 既存Pipelineが存在する場合は、維持する構成と追加・変更する構成を区別する。

3. **Job Configuration**
   - Pipeline Overviewをもとに必要なJobを特定し、それぞれの目的、実行内容、実行条件、依存関係および対象Environmentを整理する。
   - **Test Specification** に自動実行可能なTestが定義されている場合は、Pipelineへの組み込み要否を検討する。
   - `decisions.md` にStatic Analysisに関する決定が記録されている場合は、その内容をPipelineへ反映する。

4. **Platform and Repository Configuration**
   - 各JobおよびPipeline全体を成立させるために必要な設定を、CI/CD Platform側で行うConfigurationとRepository側で定義するConfigurationに分類する。
   - CI/CD Platform側については、Variable、Secret、Permission、Runnerその他のPlatform上で必要となる設定を整理する。
   - Repository側については、Pipeline Definition、Scriptその他Repository内で管理する必要がある定義を整理する。

5. **Environment and External Information**
   - **External Information** にInfrastructureその他の担当からのHandoffが存在する場合は、Pipelineの実行に必要となるEnvironment、接続先、Resource、Credentialその他の情報を特定する。
   - 必要な情報のうち未確定または未提供のものを明確化する。

6. 上記の検討結果を、後続StepでCI/CD Pipelineを構築・変更できる具体性まで **Draft** に整理する。

7. 整理が完了したら、概要をユーザーに説明する。

### Step 4: Check Required Information
**Draft** を確認し、Pipelineの構築・変更および実行に必要となる情報が揃っているかを確認する。

1. CI/CD Platform側の設定、Repository側のPipeline Definition、および各Jobの実行に必要となる情報を特定する。
2. **External Information** に関連するHandoff等が存在する場合は、その内容を確認する。
3. 必要な情報のうち未確定または未提供のものが存在する場合は、その内容、必要となる箇所および用途を **Pending Information** に整理する。
4. 現時点で確定している情報によって実施可能な範囲を特定する。

未確定情報が存在する場合でも、それを必要としない作業については継続する。

### Step 5: Configure CI/CD Platform
**Draft** に定義したCI/CD Platform側のConfigurationについて、現時点で実施可能な設定を行う。

1. CI/CD Platform側で設定する項目とその設定内容を**Draft**から確認する。
2. 実施する設定、目的および対象範囲をユーザーに提示し、承認を得る。
3. 承認された設定をCI/CD Platformへ適用する。
4. 設定結果を確認し、実施内容および結果をユーザーへ報告する。

未確定情報に依存する設定については実施せず、**Pending Information** に記録された状態を維持する。

### Step 6: Implement Pipeline Definitions
**Draft** に基づき、Repository側で管理するPipeline Definition、Scriptその他のConfigurationを担当Moduleの **Workspace** に実装する。

1. **Draft** に定義されたPipeline全体構成およびJob Configurationに従って実装する。
2. **Guide** にCI/CD Pipelineに関するGuidelineが存在する場合は、その内容に従う。
3. Test SpecificationにPipelineへ組み込むTestがある場合は、その実行を組み込む。
4. Static Analysisについて決定済みの内容がある場合は、その実行を組み込む。
5. 未確定情報が必要となる箇所については、確定していない値を推測によって補完しない。

### Step 7: Validate Available Pipeline Behavior
構築・変更したCI/CD Pipelineについて、現時点の実装および利用可能な情報によって検証可能な範囲を確認する。

1. Pipeline DefinitionおよびScriptについて、利用可能なStatic Validationを実施する。
2. 実際のPipelineを実行可能な場合は、現時点で実行可能なJobについて動作を確認する。
3. 後続Implementationが未完了であること等により本来の処理を実行できない場合は、必要に応じてDummy処理等を用いてPipelineのTrigger、Stage / Jobの接続、実行順序その他の現時点で検証可能な動作を確認する。
4. 検証できなかった内容については、その理由と後続で必要となる確認を整理する。
5. 検証によって問題が確認された場合は、必要な修正を行い、再度検証する。

### Step 8: Configure CI/CD Platform After Implementation
前項までのImplementationを踏まえ、CI/CD Platform側のConfigurationについて、現時点で実施可能な設定を行う。

1. 実装した内容からCI/CD Platform側で設定が必要かつ、現段階で設定可能な項目とその設定内容を確認・特定する。
2. 実施する設定、目的および対象範囲をユーザーに提示し、承認を得る。
3. 承認された設定をCI/CD Platformへ適用する。
4. 設定結果を確認し、また、適用内容について可能な範囲で動作を確認し、実施内容および結果をユーザーへ報告する。


### Step 9: Check Consistency with Specifications
構築・変更したCI/CD Pipelineについて、**Specification Sources** および **CI/CD Requirements** と照合し、要求された内容が欠落なく適切に反映されていることを確認する。

1. Step 1で抽出した各CI/CD Requirementが、CI/CD Platform側のConfigurationまたはRepository側のPipeline Definitionに適切に反映されていることを確認する。
2. 必要に応じて元の **Specification Sources** を改めて確認し、抽出結果のみに依存せず、構築・変更した内容との不整合や欠落がないことを確認する。
3. **Test Specification**、Static Analysisに関するDecision、関連するHandoff等、Pipeline Configurationの前提として使用した情報についても、必要な内容が反映されていることを確認する。
4. 不整合または欠落が確認された場合は必要な修正を行い、Step 7の検証および本Stepの確認を再度実施する。



