# Runtime Environment Configuration Guide


## Process for each Step

### Extract Runtime Environment Requirements

Agent `explorer` に **Specification Sources** のパスを連携し、担当ModuleのRuntime Environmentの構築・変更において考慮すべき要求、仕様および制約を抽出させる。

依頼時には、以下を抽出結果の出力先として連携する。 (変数<>となっている部分は適切に置き換えた上で連携する)

`docs/.steering/<current-train>/shared/information/runtime-environment-requirements-<module-name>.md` 


#### 依頼内容
```text
特に以下に関連する明示的な定義がある場合は抽出する。

- Container ImageのBuildおよびRuntime
- Base Image、Runtime、Versionその他のTechnology Stack
- Applicationの起動方法、CommandおよびPort
- Environment Variable、ConfigurationおよびSecret
- Container Imageの名称、TagおよびRegistry
- Health CheckおよびRuntime Verification
- Resource RequirementおよびResource Limit
- Network、Endpointおよび外部接続
- SecurityおよびPermission
- Orchestration Workload
- Deployment、Replica、Scalingその他のRuntime Configuration
- Environmentごとの差分
- その他、Build、DeployまたはRuntimeに関する制約

各事項について、その根拠となるSpecificationのFile、Section、Subsectionを併せて記録する。

Orchestration Workloadが対応対象でない場合でも、Specification上のRuntime Environmentを理解する上で関連する記述は抽出対象とする。ただし、Workload自体のConfigurationを独自に追加しない。

Specificationに明示されていないContainerまたはOrchestration Workloadの構成、Tool、実装方式等を独自に設計・補完しない。
```

#### 完了報告受領後

完了報告を受けたら内容を確認し、**Runtime Environment Requirements** のパスへ移動する。


### Understand Existing and Reference Runtime Environments

担当Moduleおよび同Domainの参考ModuleについてRuntime Environmentに関する既存実装が存在する場合、その内容を確認する。

1. 担当Moduleの **Workspace** に既存のContainerまたはOrchestration Workloadに関する実装が存在する場合、その構成、設定および関連ファイルを確認する。
2. **Requirement Mode** が `CR` の場合は、担当Moduleの既存実装を現在のRuntime Environmentとして扱い、**Runtime Environment Requirements** およびCurrent Trainの変更内容と照合する。
3. 同Domainの他Moduleに類似・参考実装が存在する場合は、**Executor Rules** に従ってRead-Onlyで確認する。
4. `shared/examples/` にRuntime Environmentに関するExampleが存在する場合は、その内容を参考情報として確認する。
5. ContainerとOrchestration Workloadの双方が存在する場合は、それぞれを区別して構成および関係を把握する。
6. 後続のBuild、DeployおよびRuntime Verificationに関係する既存のCommand、Script、Configuration等が存在する場合は併せて把握する。
7. 把握した内容から、維持すべき既存構成、今回変更を検討する必要がある構成、および参考実装から踏襲可能な構成を区別する。

後続Stepで参照する必要がある内容は、**Existing and Reference Runtime Environment** に整理する。


### Draft Runtime Environment Configuration
**Runtime Environment Requirements**、既存・参考実装、Task、Specificationおよび関連する **External Information** をもとに、担当ModuleのRuntime Environmentの全体構成と具体的なConfigurationを検討し、**Draft** に整理する。

本Stepでは、後続のImplementation Loopで継続的にBuild・Deploy・Runtime Verificationを実施できる状態を成立させるために必要な初期構成を対象とし、後続のImplementationに応じて調整可能な内容を過度に作り込まない。

以下の順序でRuntime Environment Configurationを具体化する。

ただし、具体化の対象はCurrent Trainにおいて新規構築または変更が必要な範囲に限定し、既存構成との整合性および依存関係を考慮する。

#### **1. Runtime Overview**

- 担当Moduleについて、BuildからRuntime Verificationまでの全体的な実行経路を整理する。
- Container ImageのBuild、Imageの配置、RuntimeへのDeploy、起動およびVerificationの関係を明確化する。
- Orchestration Workloadが対応対象の場合は、Container ImageとWorkloadの関係およびDeploy先を含めて整理する。
- Environmentごとの差異が存在する場合は、その関係を整理する。

#### **2. Container Configuration**

- Container ImageのBuildおよびRuntimeに必要となるConfigurationを具体化する。
- Base Image、Runtime、Build Context、Build手順、起動Command、Port、Environment Variableその他、ContainerのBuild・起動に必要な事項を整理する。
- Image Name、TagおよびRegistry等、後続のBuild・Deployで必要となるImageの管理方法を整理する。
- 既存・参考実装が存在する場合は、その構成との整合性を考慮する。

#### **3. Orchestration Workload Configuration**

Orchestration Workloadが対応対象の場合に実施する。

- Containerを対象Environmentで実行するために必要なWorkload Configurationを具体化する。
- Deploy対象、Namespace、Container Imageの参照、Port、Configuration、Secret、Health Check、Resourceその他、Workloadの実行に必要な事項を整理する。
- Infrastructure担当から共有されたEnvironmentやResourceに関する情報が存在する場合は、その内容を前提として構成する。
- `Setup Required` の場合は必要な初期構成を整理し、`Change Required` の場合は既存構成を維持しながらCurrent Trainで必要となる変更を整理する。

#### **4. Build / Deploy / Runtime Verification Plan**

- 後続のImplementation Loopで反復して利用できるBuild、DeployおよびRuntime Verificationの方法を整理する。
- Container ImageをどのようにBuildし、どのRuntimeへDeployし、どのように起動状態を確認するかを明確化する。
- Orchestration Workloadが対応対象でない場合は、Container単体でRuntime Verificationを行う方法を整理する。
- Orchestration Workloadが対応対象の場合は、実際のWorkloadへのDeployおよび起動確認までを対象とする。
- 本Skillで最初に実施する最小構成でのBuild・Deploy・Runtime Verificationと、後続のImplementation Loopで反復する方法が可能な限り同じ手順となるよう考慮する。

#### **5. External / Environment Information**

- Runtime Environmentの構築および実行に必要となるEnvironment、Registry、Cluster、Namespace、Endpoint、Credentialその他の外部情報を特定する。
- **External Information** にInfrastructureその他の担当からのHandoffが存在する場合は、その内容を確認して必要な情報を特定する。
- 必要な情報のうち未確定または未提供のものを明確化する。

上記の検討結果を、後続StepでContainerおよび必要に応じてOrchestration Workloadを構築・変更できる具体性まで **Draft** に整理する。

整理が完了したら、概要をユーザーに説明する。


### Check Required Information
**Draft** を確認し、Containerおよび対応対象の場合はOrchestration Workloadの構築・実行に必要となる情報が揃っているかを確認する。

1. ContainerのBuild、Imageの管理、起動およびRuntime Verificationに必要となる情報を確認する。
2. Orchestration Workloadが対応対象の場合は、DeployおよびRuntime Verificationに必要となるEnvironment、Registry、Cluster、Namespace、Endpoint、Credentialその他の情報を確認する。
3. **External Information** に関連するHandoff等が存在する場合は、その内容を確認する。
4. 必要な情報のうち未確定または未提供のものが存在する場合は、その内容、必要となる箇所および用途を **Pending Information** に整理する。
5. 現時点で確定している情報によって構築・検証可能な範囲を特定する。

未確定情報が存在する場合でも、それを必要としない作業については継続する。

### Configure Container
**Draft** に基づき、担当ModuleのContainer ImageをBuild・実行するために必要なConfigurationを **Workspace** に構築または変更する。

1. **Requirement Mode**、既存実装および **Draft** を確認し、新規構築または変更するContainer Configurationの範囲を特定する。
2. Base Image、Runtime、Build Context、Build手順、起動Command、Port、Environment Variableその他、ContainerのBuildおよび起動に必要なConfigurationを実装する。
3. Image Name、Tag、Registryその他、後続のBuild・Deployで必要となるImage管理に関するConfigurationを反映する。
4. 後続のImplementation Loopで継続的にBuildできる構成とし、特定の一時的な確認だけに依存する構成としない。
5. 未確定情報が必要となる箇所については、推測によって値やConfigurationを補完しない。

本Stepでは、後続のImplementation Loopを開始するために必要な初期Container Configurationを対象とし、Applicationの実装進行に伴う調整は後続のImplementation Loopで行う。


### Configure Orchestration Workload
Orchestration Workloadが対応対象の場合、**Draft** に基づき、担当ModuleのContainer Imageを対象EnvironmentへDeploy・実行するために必要なWorkload Configurationを **Workspace** に構築または変更する。

1. Taskに定義されたOrchestration Workloadの対応種別、既存実装および **Draft** を確認し、新規構築または変更する範囲を特定する。
2. Deploy対象、Namespace、Container Imageの参照、Port、Configuration、Secret、Health Check、Resourceその他、Workloadの実行に必要なConfigurationを実装する。
3. Infrastructureその他の担当から提供された **External Information** が必要な場合は、その情報を使用して対象Environmentとの接続を構成する。
4. 後続のImplementation LoopでContainer Imageを継続的に更新・Deployできる構成とする。
5. 未確定情報が必要となる箇所については、推測によって値やConfigurationを補完しない。

本Stepでは、後続のImplementation Loopを開始するために必要な初期Workload Configurationを対象とし、Applicationの実装進行に伴う調整は後続のImplementation Loopで行う。


### Build and Deploy Minimum Runtime
前項までで構築・変更したConfigurationを使用し、後続のImplementation Loopで使用する経路に沿って、現時点で実行可能な最小構成のRuntimeをBuild・Deployする。

1. **Draft** に定義したBuild / Deploy / Runtime Verification Planを確認し、現時点で実行可能な範囲を特定する。
2. 担当ModuleのContainer ImageをBuildする。
3. BuildしたContainer Imageについて、後続のRuntimeで利用するために必要なImage Name、Tagその他の情報を確定する。
4. Orchestration Workloadが対応対象でない場合は、BuildしたContainer Imageを実行し、Runtime Verificationを実施できる状態にする。
5. Orchestration Workloadが対応対象の場合は、BuildしたContainer Imageを必要なRegistry等へ配置し、構成したWorkloadを対象EnvironmentへDeployする。
6. Applicationの実装が未完了であること等により本来のRuntimeを構成できない場合は、必要に応じて最小限のDummyまたは暫定的な実装を使用し、BuildからDeployまでの経路を成立させる。
7. 実施したBuild・Deployの方法が、後続のImplementation Loopから継続的に再実行可能であることを確認する。

本Stepでは、Applicationとしての機能完成を目的とせず、後続のImplementation Loopで継続的に利用するBuild・Deploy経路を成立させることを目的とする。

### Verify Runtime Environment
Build・DeployしたRuntime Environmentについて、後続のImplementation Loopで継続的にRuntime Verificationを行える状態であることを確認する。

1. Containerが期待する方法で起動し、異常終了していないことを確認する。
2. Orchestration Workloadが対応対象の場合は、DeployしたWorkloadが対象Environment上で期待する起動状態となっていることを確認する。
3. Port、Health Check、Network、Configurationその他、現時点で確認可能なRuntime Configurationが期待どおり機能していることを確認する。
4. **Draft** に定義したRuntime Verification方法を実行し、後続のImplementation Loopでも同じ方法によってRuntimeの状態を確認できることを確認する。
5. Applicationの実装が未完了であること等により確認できない内容については、その理由と後続のImplementation Loopで必要となる確認を整理する。
6. 問題が確認された場合は、ContainerまたはOrchestration WorkloadのConfigurationを必要な範囲で修正し、Build・DeployおよびRuntime Verificationを再実施する。

### Check Consistency with Specifications
構築・変更したRuntime Environmentについて、**Specification Sources** および **Runtime Environment Requirements** と照合し、要求された内容が欠落なく適切に反映されていることを確認する。

1. **Runtime Environment Requirements** に抽出された各要求、仕様および制約が、ContainerまたはOrchestration WorkloadのConfigurationに適切に反映されていることを確認する。
2. 必要に応じて元の **Specification Sources** を改めて確認し、抽出結果のみに依存せず、構築・変更した内容との不整合や欠落がないことを確認する。
3. **External Information**、既存・参考実装その他、Runtime Environment Configurationの前提として使用した情報についても、必要な内容が適切に反映されていることを確認する。
4. 不整合または欠落が確認された場合は必要な修正を行い、Build・Deploy、Runtime Verificationおよび本Stepの確認を再度実施する。