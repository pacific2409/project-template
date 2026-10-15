# Infrastructure Design

<!--
使用方法:
- guide.mdを正本とし、先行するFunction Design / System Architectureの要求・DecisionをInfrastructureとして具体化する。Applicationの機能・内部設計、API / Batch / Data / UI仕様やApplication Delivery戦略は再定義しない。
- 各章・節は該当する設計事項がある場合にのみ記載する。要求・先行成果物・本設計の決定から適用有無を確認し、該当しない章・節は省略する。一般論・推測・将来の可能性だけで埋めない。
- [ ]内を対象Projectの内容で置き換える。表の行と環境列は実際の対象に合わせて増減し、例示技術や環境数を採用済みと扱わない。条件付きの記入枠・列は適用するもののみ残す。
- 表だけでは表せない具体設定・制約・根拠は、表の直後に箇条書き等で補足する。図の記入欄には指定の構造を描き、条件付きの図は必要な場合に記載する。
- Infrastructureは基本設計と詳細設計へ分割せず、構築・運用・再生成可能な具体仕様まで確定する。ただし実測が必要な値は、確定値・初期値・Constraint・後続確認対象を区別し、未確認値を確定値にしない。
- Resource / Workload / Environment / Contractの名称とBoundaryを全章で統一し、上位要求とResourceの存在理由を追跡できるよう参照する。後続節で判明した制約は前の節へ戻して整合させる。
- IaC / Manifest / Pipeline実装本文を複製しない。仕様反映後はCode / Configurationを具体設定の正本とし、本書から参照する。
- Secret実値・Private Key等を記載しない。動的Endpoint等の実値は管理元を正とし、ApplicationへのHandoffには安定したKey / Referenceを定義する。
- Business DataのMigration / Schema Evolution / Retention / Archiving戦略は別設計。必要な基盤のBackup / Recoveryは本書で扱う。
- 記入完了後、不要な記入枠・作成用コメントを取り除く。
-->

## 0. Change History

<!-- 初回は設計工程のレビュー・再レビューを終えて確定した時点で1件を記録する。同一工程内の修正は個別記録せず、確定後・後続Trainでの正式な設計変更を追記する。 -->

| Change | Date | Train | Summary |
| --- | --- | --- | --- |
| [Changeを記入] | [Dateを記入] | [Trainを記入] | [Summaryを記入] |

## 1. Infrastructure Overview

### 1.1 Infrastructure Purpose and Scope

[上位設計・要求の参照、Cloud / On-premise / Hybrid等の形態、Provider、対象Environment、提供する基盤領域、System Architectureとの責務境界]

<!-- 記載範囲: 個々のInfrastructure Resource、Network、Cluster、Security、Scaling等の具体構成はここでは定義しない。また、Application / Service自体のArchitectureや機能仕様を再定義しない。 -->

### 1.2 Infrastructure Architecture Summary

[環境分離、Network、実行基盤、Data / Messaging、外部接続、Security、Availability / Scaling、Provisioning、Lifecycleの主要方針を要約。詳細は対応節を参照]

<!-- 記載範囲: 後続Sectionで定義するResource名、CIDR、Instance Type、Cluster / Namespace構成、IAM、Scaling値等の具体仕様を網羅的に再掲しない。 -->

### 1.3 Application and Infrastructure Mapping Overview

<!-- 上位設計のApplication / Service / Workloadと必要な基盤機能を対応付ける。具体的な配置は7章を参照 -->

| Application / Service / Workload | Infrastructure Role / Requirement | High-Level Placement |
| --- | --- | --- |
| [Application / Service / Workloadを記入] | [Infrastructure Role / Requirementを記入] | [High-Level Placementを記入] |

<!-- 記載範囲: Application / Serviceの機能責務、内部Architecture、Deployment Unit等を再定義しない。また、具体的なCluster / Namespace / Node等への配置もここでは決定しない。 -->

### 1.4 Infrastructure Architecture Diagram

<!-- 外部との境界、Environment、Network、実行基盤、Application、Data / Messaging、Traffic Entry、外部接続の論理関係 -->

<!-- 図の記載: Mermaid flowchartで外部→Traffic Entry→実行基盤内のWorkload→Data / Messaging・外部接続を表し、Environment / Network Boundaryを囲む。正式な別形式の構成図を管理する場合は、その参照先を記載する。 -->

[構成・関係図をここに記載、または正式な構成図への参照を記載]

<!-- 記載範囲: Subnet / Route、Security Group、Node、Pod、Listener、IAM Role等の個別Resourceを網羅的に表現しない。また、個々のInfrastructure Resourceの設定値やApplication内部の処理Flowも記載しない。 -->

## 2. Environment Separation Architecture

<!-- 本章では、Systemを構成するEnvironmentを定義し、それぞれの目的、Isolation Level、およびInfrastructure ResourceをEnvironment間で分離・共有する方針を定義する。 -->

### 2.1 Environment Definition and Purpose

<!-- 採用するEnvironmentとその目的・利用範囲・本番Dataの扱い。必要以上に環境を増やさない -->

| Environment | Purpose | Usage | Production Data |
| --- | --- | --- | --- |
| [Environmentを記入] | [Purposeを記入] | [Usageを記入] | [Production Dataを記入] |

<!-- 記載範囲: 各Environmentの具体的なResource構成、Resource Size、Deployment方法、休眠方法等はここでは定義しない。 -->

### 2.2 Environment Isolation Model

<!-- Account / Network / Cluster / Namespace等、採用するBoundaryごとの共有・分離モデル。具体的なIDやCIDRは対応節へ -->

| Boundary | [環境1] | [環境2] | [環境3] | Separation Policy |
| --- | --- | --- | --- | --- |
| [Boundaryを記入] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] | [Separation Policyを記入] |

<!-- 図の記載: 必要に応じてMermaid flowchartで採用するAccount / Network / Cluster / Namespace等の包含・共有・分離関係を表す。環境の数や分離単位を例示に合わせて増やさない。 -->

[構成・関係図をここに記載]

<!-- 記載範囲: Account ID、VPC CIDR、Cluster名、Namespace名等の具体値や、各Boundary内部のResource構成はここでは定義しない。 -->

### 2.3 Infrastructure Sharing and Separation

<!-- 共有・独立させる基盤、対象Environment、干渉・Security・Capacity・障害影響からの根拠と制約 -->

| Infrastructure | Sharing Policy | Shared Between | Reason / Constraint |
| --- | --- | --- | --- |
| [Infrastructureを記入] | [Sharing Policyを記入] | [Shared Betweenを記入] | [Reason / Constraintを記入] |

<!-- 記載範囲: 共有Resource自体の具体的なInfrastructure構成やCapacityは対応する後続Sectionで定義する。 -->

### 2.4 Network Isolation and Cross-Environment Connectivity

<!-- 記載条件: Environmentを跨ぐ接続の許可・禁止を定義する場合。単一環境など該当事項がなければ省略する。 -->

<!-- Environment間の通信可否、方向、用途、許可条件。具体的なRouteは5章、制御は10章を参照 -->

| Source Environment | Target Environment | Connectivity | Purpose / Constraint |
| --- | --- | --- | --- |
| [Source Environmentを記入] | [Target Environmentを記入] | [Connectivityを記入] | [Purpose / Constraintを記入] |

<!-- 記載範囲: Route TableやPrivate接続等の具体的な経路は5章、Security Group / Network Policy / Firewall Rule等の通信制御は10章で定義する。 -->

### 2.5 Data Isolation and Cross-Environment Data Policy

<!-- 記載条件: Environmentを跨ぐData利用・共有の方針が必要な場合。 -->

<!-- Environment間のData共有・持ち込み・複製の可否、本番Dataの非本番利用条件、匿名化や合成Dataの要否。処理方式は別設計 -->

| Data Flow | Policy | Constraint |
| --- | --- | --- |
| [Data Flowを記入] | [Policyを記入] | [Constraintを記入] |

<!-- 記載範囲: 具体的なData Migration / Replication方式、Backup / Restore方式、Anonymization処理等はここでは定義しない。Data Lifecycleに関する戦略はData Strategyを正とする。 -->

### 2.6 Identity and Security Separation

[Environment間のIdentity / IAM境界、管理者権限、Workload Identity / Credential分離、跨環境Accessの可否、共有基盤へのAccess方針。具体的な制御は10章]

<!-- 記載範囲: IAM Role / Policy、ServiceAccount、Kubernetes RBAC等のIdentity・権限は10章、Secret Storeと供給方式は11章で定義する。 -->

### 2.7 External Service Environment Separation

<!-- 記載条件: 外部Serviceを利用する場合。実接続とStubの違いも対象とする。 -->

<!-- 上位設計の外部Service利用方針に基づく環境別の実Service / Stub、接続先・外部Resourceの分離または共有。具体設定は9・10・11章 -->

| External Service | [環境1] | [環境2] | [環境3] | Separation Policy |
| --- | --- | --- | --- | --- |
| [External Serviceを記入] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] | [Separation Policyを記入] |

<!-- 記載範囲: External Serviceへの具体的なNetwork経路、VPC Endpoint、PrivateLink、DNS、Credential等は後続のNetwork / External Connectivity / Security関連Sectionで定義する。 -->

## 3. Infrastructure Technology Stack and Tooling

<!-- 本章では、Infrastructureを構築・実行・構成管理・運用するために採用する主要なTechnologyおよびToolを定義する。 -->

### 3.1 Cloud Platform

<!-- 記載条件: Cloud / On-premise等のPlatform選定が設計対象にある場合。 -->

<!-- 利用するPlatformと対象領域・責務。複数Cloud / On-premiseを採用する場合は使い分け -->

| Scope | Platform | Purpose |
| --- | --- | --- |
| [Scopeを記入] | [Platformを記入] | [Purposeを記入] |

<!-- 記載範囲: VPC、EKS、RDS等の個々のCloud Resourceや具体的なResource構成は定義しない。それらは対応する後続Sectionで定義する。 -->

### 3.2 Compute and Container Platform

<!-- Workload種別ごとのOrchestration / Platform、Compute、Container Runtimeの選定と用途 -->

| Workload Type | Orchestration / Platform | Compute | Container Runtime |
| --- | --- | --- | --- |
| [Workload Typeを記入] | [Orchestration / Platformを記入] | [Computeを記入] | [Container Runtimeを記入] |

<!-- 記載範囲: Cluster、Node Group、Namespace、Pod、Instance Type等の具体的なInfrastructure構成は定義しない。これらはCompute and Container Platform Architectureで扱う。 -->

### 3.3 Operating System and Infrastructure Runtime

<!-- 記載条件: OS / Infrastructure Runtimeを選定・管理する場合。 -->

<!-- Infrastructure側で選定・管理するOS / Runtimeと用途。Applicationの言語・Frameworkは再定義しない -->

| Target | OS / Runtime | Purpose |
| --- | --- | --- |
| [Targetを記入] | [OS / Runtimeを記入] | [Purposeを記入] |

<!-- 記載範囲: Application RuntimeはSystem ArchitectureのTechnology Stackを正とする。また、OS Image IDやNodeごとの具体的な設定は後続の対応するInfrastructure設計で扱う。 -->

### 3.4 Infrastructure as Code

<!-- 記載条件: IaCを利用する場合。 -->

<!-- IaC技術の選定、適用範囲、責務分担。Module / State / 適用方式は16章 -->

| Technology | Scope | Purpose |
| --- | --- | --- |
| [Technologyを記入] | [Scopeを記入] | [Purposeを記入] |

<!-- 記載範囲: Module構造、State構成、Environment別Directory、Plan / Apply方式等の具体的なIaC ArchitectureはInfrastructure Provisioning and Deliveryで定義する。 -->

### 3.5 Infrastructure Configuration and Deployment Tooling

<!-- Infrastructure Configuration / Deployment / 管理Toolの選定と担当範囲。利用構造は16章 -->

| Tool | Scope | Purpose |
| --- | --- | --- |
| [Toolを記入] | [Scopeを記入] | [Purposeを記入] |

<!-- 記載範囲: 各ToolのDirectory構成、Manifest構成、具体的なCommandやPipeline上の実行方法はInfrastructure Provisioning and Deliveryで定義する。 -->

### 3.6 Infrastructure Tool and Component Dependencies

<!-- 記載条件: Tool・Component間に設計上明示すべき依存がある場合。図は複数の関係を可視化する必要がある場合に記載する。 -->

<!-- Tool・Component間の依存、接続・互換性上の制約。Resourceの構築順序は16.5 -->

| Source | Dependency | Relationship / Constraint |
| --- | --- | --- |
| [Sourceを記入] | [Dependencyを記入] | [Relationship / Constraintを記入] |

<!-- 図の記載: 必要に応じてMermaid flowchartでTool→対象Componentの管理・設定・依存関係とTechnology境界を表す。 -->

[構成・関係図をここに記載]

<!-- 記載範囲: 具体的なResource間DependencyやProvisioningの実行順序を網羅的に定義しない。それらはInfrastructure Provisioning and Deliveryで扱う。 -->

### 3.7 Version and Compatibility Policy

<!-- Versionまたは許容範囲、Provider / Pluginを含む互換性、Support期間、Upgrade・廃止対応方針 -->

| Technology / Tool | Version / Range | Compatibility / Constraint |
| --- | --- | --- |
| [Technology / Toolを記入] | [Version / Rangeを記入] | [Compatibility / Constraintを記入] |

<!-- 記載範囲: Application Language、Framework、Library等のVersionはSystem Architecture / Dependency Managementを正とする。また、個々のInfrastructure Resource固有のVersion設定は、対応するResource設計で定義する。 -->

### 3.8 Infrastructure Development and Delivery Technologies

<!-- InfrastructureのSource管理、Repository、CI/CD等の技術と用途。Application側と共用するかも判断し、無条件に同一にしない -->

| Category | Technology / Platform | Scope | Purpose |
| --- | --- | --- | --- |
| [Categoryを記入] | [Technology / Platformを記入] | [Scopeを記入] | [Purposeを記入] |

<!-- 記載範囲: Repository構造、Branch / Trigger、Pipeline Stage、Terraform / Kubernetes Pipelineの分離・実行方式等はInfrastructure Provisioning and Deliveryで定義する。また、Application側のSCM / Repository / CI/CD PlatformはSystem Architectureを正とする。 -->

## 4. Cloud and Infrastructure Resource Architecture

<!-- 本章では、System ArchitectureおよびEnvironment Separation Architectureをもとに、Systemを成立させるために必要な主要Infrastructure Resourceを特定し、それぞれの役割、Environmentごとの配置有無、およびResource間の論理的な関係を定義する。 -->

### 4.1 Infrastructure Resource Inventory

<!-- 上位設計に対応する主要Resourceの一覧。Compute、Data、Messaging、Registry、Traffic、DNS、管理、外部接続、観測等の採用Resourceを含める -->

| Resource | Category | Role | Used By |
| --- | --- | --- | --- |
| [Resourceを記入] | [Categoryを記入] | [Roleを記入] | [Used Byを記入] |

<!-- 記載範囲: Subnet、Security Group、IAM Role等、他Resourceを構成・制御する詳細ResourceをすべてInventoryとして列挙しない。また、Instance Type、Capacity、設定値等のResource内部仕様は対応する後続Sectionで定義する。 -->

### 4.2 Environment Resource Matrix

<!-- 各Resourceの環境別配置・共有・分離・非配置。2章のBoundaryと整合させる -->

| Resource | [環境1] | [環境2] | [環境3] | Sharing / Separation |
| --- | --- | --- | --- | --- |
| [Resourceを記入] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] | [Sharing / Separationを記入] |

<!-- 記載範囲: Environmentごとの具体的なResource Name、Endpoint、Capacity、Network配置等は記載しない。また、Environment分離方針そのものをここで再判断せず、Environment Separation Architectureを正とする。 -->

### 4.3 Resource Responsibilities and Ownership

<!-- 各Resourceの責務、主要な利用者・関心事、担わない責務 -->

| Resource | Responsibility | Primary Consumer / Concern | Excluded Responsibility |
| --- | --- | --- | --- |
| [Resourceを記入] | [Responsibilityを記入] | [Primary Consumer / Concernを記入] | [Excluded Responsibilityを記入] |

<!-- 記載範囲: Application / Service側の機能責務やData Ownershipを再定義しない。また、ResourceへのAccess Control等のSecurity仕様はInfrastructure Security and Identityで定義する。 -->

### 4.4 Logical Resource Relationships

<!-- 主要Resource間の利用・依存・接続関係。Port・Route・IAMは対応節を参照 -->

| Source Resource | Relationship | Target Resource |
| --- | --- | --- |
| [Source Resourceを記入] | [Relationshipを記入] | [Target Resourceを記入] |

<!-- 記載範囲: Protocol、Port、Route、Security Rule等の具体的な接続仕様は定義しない。また、Application内部のFunctional FlowやService間Interfaceを再定義しない。 -->

### 4.5 Logical Cloud Infrastructure Diagram

<!-- 環境・主要Resource群の論理的な配置と関係。全体を把握する粒度とし、個別設定は展開しない -->

<!-- 図の記載: Mermaid flowchartでEnvironment内の主要Resource群と論理関係を表す。正式な別形式の構成図を管理する場合は、その参照先を記載する。 -->

[構成・関係図をここに記載、または正式な構成図への参照を記載]

<!-- 記載範囲: CIDR、Subnet、Route、Security Group、Listener、Node、Pod、IAM Role等の詳細Resourceおよび具体設定を網羅的に表現しない。 -->

## 5. Network Architecture

<!-- 本章では、Environment Separation ArchitectureおよびCloud and Infrastructure Resource Architectureを前提として、各Infrastructure Resourceを接続するNetwork構造、Address Space、Subnet、Routing、Ingress / Egress、DNS、Private ConnectivityおよびExternal Connectivityを実装可能な仕様まで定義する。 -->

### 5.1 Network Topology

<!-- Environment、Network / VPC、Region、Network間の独立・共有・Peering / Transit等の関係 -->

| Environment | Network / VPC | Region | Isolation / Relationship |
| --- | --- | --- | --- |
| [Environmentを記入] | [Network / VPCを記入] | [Regionを記入] | [Isolation / Relationshipを記入] |

<!-- 記載範囲: Application / Workloadの具体的な配置や、Security Group等による通信許可Ruleはここでは定義しない。 -->

### 5.2 Address Space and Subnet Design

<!-- Network全体とSubnetの実CIDR、種別、AZ、用途。重複回避、接続先のAddress Space、将来の拡張余地を確認 -->

| VPC / Network | Subnet | Type | Availability Zone | CIDR | Purpose |
| --- | --- | --- | --- | --- | --- |
| [VPC / Networkを記入] | [Subnetを記入] | [Typeを記入] | [Availability Zoneを記入] | [CIDRを記入] | [Purposeを記入] |

<!-- 記載範囲: Subnet上へ配置する個々のPod / Workload等は定義しない。Application / Workload PlacementおよびCompute and Container Platform Architectureを正とする。 -->

### 5.3 Routing Architecture

<!-- Route Table、関連Subnet、宛先、Gateway / NAT / Peering等のTargetを具体化。許可・拒否制御は10章 -->

| Route Table | Associated Subnet | Destination | Target | Purpose |
| --- | --- | --- | --- | --- |
| [Route Tableを記入] | [Associated Subnetを記入] | [Destinationを記入] | [Targetを記入] | [Purposeを記入] |

<!-- 記載範囲: Trafficを許可・拒否するSecurity Ruleは定義しない。また、Application LayerでのRoutingやLoad Balancingは本項目では扱わない。 -->

### 5.4 Ingress and Egress Architecture

<!-- 外部・内部・管理Trafficの入口と出口、公開・非公開、SourceからDestinationまでのNetwork経路 -->

| Traffic | Source | Destination | Entry / Exit | Network Path |
| --- | --- | --- | --- | --- |
| [Trafficを記入] | [Sourceを記入] | [Destinationを記入] | [Entry / Exitを記入] | [Network Pathを記入] |

<!-- 記載範囲: Load BalancerのListener / Target等のApplication Traffic制御はTraffic Management and External Connectivityで定義する。また、通信許可のSecurity RuleはInfrastructure Security and Identityで定義する。 -->

### 5.5 Private Connectivity and Endpoints

<!-- 記載条件: Private接続・Endpointが必要な場合。 -->

<!-- Private接続が必要な対象、VPN / 専用線 / Private Endpoint等の採用方式、Endpoint / Connection、経路・利用目的 -->

| Source | Target | Connectivity | Endpoint / Connection | Purpose |
| --- | --- | --- | --- | --- |
| [Sourceを記入] | [Targetを記入] | [Connectivityを記入] | [Endpoint / Connectionを記入] | [Purposeを記入] |

<!-- 記載範囲: External Serviceを利用するApplication側のClient / Adapter ArchitectureはSystem Architectureを正とする。また、EndpointへのAccess Permission / IAMはInfrastructure Security and Identityで定義する。 -->

### 5.6 DNS and Name Resolution

<!-- DNS Zone / Domain、Public / Private区分、環境、内部・外部の名前解決、必要なResolver / Forwarding。Traffic宛先Recordは9.5 -->

| Zone / Domain | Type | Environment | Purpose |
| --- | --- | --- | --- |
| [Zone / Domainを記入] | [Typeを記入] | [Environmentを記入] | [Purposeを記入] |

<!-- 記載範囲: CDN / Load Balancerへの具体的なTraffic Routing RuleはTraffic Management and External Connectivityで扱う。 -->

### 5.7 Network Segmentation

[公開・非公開、Application・Data・管理・外部接続等のNetwork区画、そのBoundaryと必要・不要な通信関係。Enforcementは10.6]

<!-- 記載範囲: Security Group、Network Policy、Firewall Rule等によってSegmentationをどのようにEnforceするかはInfrastructure Security and Identityで定義する。 -->

### 5.8 Network Connectivity Matrix

<!-- 必要な通信ごとのSource、Destination、Protocol / Port、方向、用途。Security Ruleの入力として具体化 -->

| Source | Destination | Protocol / Port | Direction | Purpose |
| --- | --- | --- | --- | --- |
| [Sourceを記入] | [Destinationを記入] | [Protocol / Portを記入] | [Directionを記入] | [Purposeを記入] |

<!-- 記載範囲: 具体的なSecurity Group IDやRule Resourceは定義しない。 -->

### 5.9 Network Availability and Failure Considerations

[AZ / Subnet配置、NAT / Gateway / DNS / 外部接続の単一障害点と影響、環境ごとのAvailability要件への適合。復旧構成は13章]

<!-- 記載範囲: Application側のRetry / Circuit Breaker / Fallback等はSystem Architectureを正とする。また、Infrastructure Resource全体のRecovery StrategyはAvailability, Recovery and Infrastructure Healthで扱う。 -->

## 6. Compute and Container Platform Architecture

<!-- 本章では、Infrastructure Technology Stack and Toolingで選定したCompute / Container Platformについて、Application / Workloadを実行可能にするためのCluster、Node / Compute、Namespace、Container RuntimeおよびKubernetes等のPlatform Resourceを実装可能な仕様まで定義する。 -->

### 6.1 Compute and Container Platform Structure

<!-- 環境ごとのPlatform、Compute Model、Cluster / Execution Unit。異種Platformを使う場合の責務分担 -->

| Environment | Platform | Compute Model | Cluster / Execution Unit |
| --- | --- | --- | --- |
| [Environmentを記入] | [Platformを記入] | [Compute Modelを記入] | [Cluster / Execution Unitを記入] |

<!-- 記載範囲: Application / Serviceごとの具体的な配置先は定義しない。また、Platform Technologyそのものの選定理由はInfrastructure Technology Stack and Toolingを正とする。 -->

### 6.2 Cluster Architecture

<!-- 記載条件: Clusterを採用する場合。 -->

<!-- Clusterの環境、Version、用途、共有範囲、Control Plane、Endpoint公開・Access方式、必要なAdd-on、Upgrade制約 -->

| Cluster | Environment | Platform Version | Access | Purpose |
| --- | --- | --- | --- | --- |
| [Clusterを記入] | [Environmentを記入] | [Platform Versionを記入] | [Accessを記入] | [Purposeを記入] |

<!-- 記載範囲: Cluster間のEnvironment分離方針自体を再定義しない。また、ClusterへのNetwork RouteやSecurity Controlの詳細はNetwork / Security関連Sectionを正とする。 -->

### 6.3 Node and Compute Architecture

<!-- 記載条件: Node / Compute Groupの構成を管理する場合。 -->

<!-- Node / Compute Group、Managed / Self-managed、Instance Family / Type、OS / Image、CPU Architecture、Capacity種別、Label / Taint等。数量は12章 -->

| Node / Compute Group | Compute | OS | Architecture | Capacity | Purpose |
| --- | --- | --- | --- | --- | --- |
| [Node / Compute Groupを記入] | [Computeを記入] | [OSを記入] | [Architectureを記入] | [Capacityを記入] | [Purposeを記入] |

<!-- 記載範囲: 個々のApplication / BatchをどのNode Groupへ配置するかはApplication and Workload Placementで定義する。また、Pod単位のCPU / Memory値はResource, Performance and Scaling Architectureを正とする。 -->

### 6.4 Infrastructure Runtime

<!-- 記載条件: Infrastructure Runtimeに設計対象がある場合。 -->

<!-- Node / Container等のInfrastructure Runtime、Version、互換性・実行制約。Application Runtimeは上位設計を参照 -->

| Target | Runtime | Version | Constraint |
| --- | --- | --- | --- |
| [Targetを記入] | [Runtimeを記入] | [Versionを記入] | [Constraintを記入] |

<!-- 記載範囲: Java / Node.js等のApplication RuntimeはSystem Architectureを正とする。また、Runtime TechnologyのVersion PolicyそのものはInfrastructure Technology Stack and Toolingと整合させる。 -->

### 6.5 Namespace Architecture

<!-- 記載条件: Namespaceを持つPlatformを採用する場合。 -->

<!-- guideの環境＋Application単位／環境単位の二つの例は、採用した分離粒度を同じ記入枠で表す。両方を必須にしない。 -->

<!-- Namespaceの名前、用途、分離Boundary。環境単位・環境＋Application単位等から要件に合う粒度を選び、System用Namespaceも必要に応じて含める -->

| Cluster | Namespace | Purpose | Isolation Boundary |
| --- | --- | --- | --- |
| [Clusterを記入] | [Namespaceを記入] | [Purposeを記入] | [Isolation Boundaryを記入] |

<!-- 記載範囲: Namespace内に配置する具体的なApplication / ServiceはApplication and Workload Placementで定義する。また、NamespaceごとのRBAC / Network Policy等はInfrastructure Security and Identityで定義する。 -->

### 6.6 Kubernetes Resource Architecture

<!-- 記載条件: Kubernetesを採用する場合。 -->

<!-- 採用するKubernetes Resource種別と用途・役割。個別Workload配置、Resource設定、権限等は対応節で具体化 -->

| Resource Type | Usage | Architectural Role |
| --- | --- | --- |
| [Resource Typeを記入] | [Usageを記入] | [Architectural Roleを記入] |

<!-- 記載範囲: 個々のApplicationのDeployment名、Image、Replica数、Environment Variable等の具体設定を一括してここで定義しない。それぞれのConcernに応じてApplication and Workload Placement、Resource / Scaling、Configuration等のSectionで定義する。 -->

### 6.7 Workload Execution Models

<!-- 常駐処理、Scheduled / On-demand Job等のExecution ModelとPlatform Resource、起動・終了Lifecycle。個別Workloadは7章 -->

| Workload Type | Execution Model | Platform Resource | Lifecycle |
| --- | --- | --- | --- |
| [Workload Typeを記入] | [Execution Modelを記入] | [Platform Resourceを記入] | [Lifecycleを記入] |

<!-- 記載範囲: 「Batch AをCronJobとして配置する」等の個別Workloadとの具体的な対応付けはApplication and Workload Placementで定義する。 -->

### 6.8 Pod and Workload Baseline

[共通のContainer / Sidecar / Init構成、Restart、Graceful Shutdown、Health、Temporary Storage、実行Identityの単位・Baseline。Workload固有値は対応節]

<!-- 記載範囲: Application固有のContainer設定、具体的なCPU / Memory、Probe値、Secret / Config値等は本項目では定義しない。それぞれ対応する後続Sectionで具体化する。 -->

### 6.9 Compute and Container Platform Diagram

<!-- Environment、Platform / Cluster、Node / Compute Group、Namespace等の関係。Namespaceを特定Nodeの内部と誤表現しない -->

<!-- 図の記載: Mermaid flowchartでEnvironment→Platform / Cluster、そこに属するNode / Compute Group・Namespace等を表す。論理的分離と物理的配置を区別する。 -->

[構成・関係図をここに記載]

<!-- 記載範囲: VPC / Subnet / Route等のNetwork全体構成や、Application間のFunctional Flowは表現しない。 -->

## 7. Application and Workload Placement

<!-- 本章では、System Architectureで定義されたApplication / Service / Batch等の実行対象を、Compute and Container Platform Architectureで定義されたInfrastructure上の実行基盤へ対応付ける。 -->

### 7.1 Application and Workload Inventory

<!-- 上位設計で確定した配置対象Workload、種別、Deployment Unit、実行要件。機能単位を勝手に新しい配置単位にしない -->

| Application / Workload | Type | Deployment Unit | Execution Requirement |
| --- | --- | --- | --- |
| [Application / Workloadを記入] | [Typeを記入] | [Deployment Unitを記入] | [Execution Requirementを記入] |

<!-- 記載範囲: Application / Serviceの機能責務、内部Architecture、Deployment Unit等をここで新たに決定しない。また、Infrastructure上に独立して配置されないClass / Module等のApplication内部要素は対象としない。 -->

### 7.2 Environment Placement Matrix

<!-- 各Workloadの環境ごとの配置有無・実行基盤の差異。配置しない場合は明記 -->

| Application / Workload | [環境1] | [環境2] | [環境3] |
| --- | --- | --- | --- |
| [Application / Workloadを記入] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] |

<!-- 記載範囲: Environment自体のCluster / Namespace共有・分離方針を再定義しない。また、EnvironmentごとのDeployment方法はSystem ArchitectureのDeployment Architecture and Strategyを前提とする。 -->

### 7.3 Workload-to-Platform Mapping

<!-- 各WorkloadとPlatform、Execution Model、Platform Resourceの対応 -->

| Application / Workload | Platform | Execution Model | Platform Resource |
| --- | --- | --- | --- |
| [Application / Workloadを記入] | [Platformを記入] | [Execution Modelを記入] | [Platform Resourceを記入] |

<!-- 記載範囲: Deployment / CronJob等のResource Type自体のArchitecture上の役割を再定義しない。また、Application内部の処理方式も扱わない。 -->

### 7.4 Cluster and Namespace Placement

<!-- 記載条件: Cluster / Namespaceへの配置を行う場合。 -->

<!-- 環境別の具体的なCluster / Namespace配置先。6章の構造と整合 -->

| Environment | Application / Workload | Cluster | Namespace |
| --- | --- | --- | --- |
| [Environmentを記入] | [Application / Workloadを記入] | [Clusterを記入] | [Namespaceを記入] |

<!-- 記載範囲: Cluster / Namespaceそのものの作成仕様やVersion等はCompute and Container Platform Architectureを正とする。Namespace間のSecurity RuleはInfrastructure Security and Identityで定義する。 -->

### 7.5 Compute and Node Placement

<!-- 記載条件: WorkloadにCompute / Node配置制約がある場合。 -->

<!-- Compute Groupへの配置条件、Label / Taint / Toleration / Affinity等、Architecture・Capacity制約、その理由 -->

| Application / Workload | Compute Group | Placement Constraint | Reason |
| --- | --- | --- | --- |
| [Application / Workloadを記入] | [Compute Groupを記入] | [Placement Constraintを記入] | [Reasonを記入] |

<!-- 記載範囲: Node GroupのInstance Type、Capacity、Scaling Range等はCompute and Container Platform ArchitectureおよびResource, Performance and Scaling Architectureを正とする。 -->

### 7.6 Workload Isolation and Co-location

<!-- 記載条件: Workload間の分離・同居を判断する必要がある場合。 -->

<!-- Workload間の同居・分離方針と、Resource競合・Security・障害・運用上の根拠。Resource値は12章、制御は10章 -->

| Workload A | Workload B | Placement Policy | Reason |
| --- | --- | --- | --- |
| [Workload Aを記入] | [Workload Bを記入] | [Placement Policyを記入] | [Reasonを記入] |

<!-- 記載範囲: 具体的なCPU / Memory Requests / Limits等によるResource IsolationはResource, Performance and Scaling Architectureで定義する。また、Network Policy等による通信分離はInfrastructure Security and Identityで扱う。 -->

### 7.7 Application and Workload Placement Diagram

<!-- Environment、実行基盤、Namespace等のBoundary内に各Workloadを配置し、重要なCompute配置制約を表現 -->

<!-- 図の記載: Mermaid flowchartでEnvironment→Platform / Cluster→Namespace等→Workloadの配置関係を表す。Compute制約は関係として示し、環境ごとに必要に応じて図を分ける。 -->

[構成・関係図をここに記載]

<!-- 記載範囲: Application間のFunctional Flow、API / Event等の連携関係や、VPC / Subnet / Route等のNetwork構造を本図の主目的として表現しない。 -->

## 8. Data and Messaging Infrastructure

<!-- 本章では、System Architectureで定義されたData Persistence ArchitectureおよびIntegration Architectureを、Database、Cache、Object Storage、Queue / Broker等の具体的なInfrastructure Resourceとして実現する構成を定義する。 -->

### 8.1 Persistence Infrastructure Mapping

<!-- 上位設計のPersistence Domain、Data Owner、Persistence ModelとResource / Managed Serviceの対応 -->

| Data / Persistence Domain | Owner | Persistence Model | Infrastructure Resource | Managed Service |
| --- | --- | --- | --- | --- |
| [Data / Persistence Domainを記入] | [Ownerを記入] | [Persistence Modelを記入] | [Infrastructure Resourceを記入] | [Managed Serviceを記入] |

<!-- 記載範囲: Table / Column / Index等のData Structureや、Data Ownershipそのものを再定義しない。また、ApplicationからPersistenceを利用するLibrary / Repository等のApplication実装も扱わない。 -->

### 8.2 Database Infrastructure

<!-- 記載条件: Databaseを利用する場合。 -->

<!-- 環境別のEngine / Version、Service、Instance / Cluster、Class、Storage種別・容量・拡張、AZ / Network配置、Endpoint参照、Parameter / Option、接続制約。Schemaは再設計しない -->

| Environment | Database | Engine / Version | Instance / Cluster | Storage | Placement |
| --- | --- | --- | --- | --- | --- |
| [Environmentを記入] | [Databaseを記入] | [Engine / Versionを記入] | [Instance / Clusterを記入] | [Storageを記入] | [Placementを記入] |

<!-- 記載範囲: Schema、Table、Column、PK / FK、Index等はData Detail Designを正とする。Backup / Retention等の要求・戦略そのものはData Strategyで定義する。 -->

### 8.3 Cache Infrastructure

<!-- 記載条件: Cacheを利用する場合。 -->

<!-- Cacheの環境、Engine / Version、Cluster / Node、Capacity、Availability、接続先参照、Network、Scaling、永続化設定。ApplicationのCache戦略は上位設計 -->

| Cache | Environment | Engine | Cluster / Node | Capacity | Used By |
| --- | --- | --- | --- | --- | --- |
| [Cacheを記入] | [Environmentを記入] | [Engineを記入] | [Cluster / Nodeを記入] | [Capacityを記入] | [Used Byを記入] |

<!-- 記載範囲: Cache対象、Source of Truth、Cache Invalidation等のApplication Architecture上の方針はSystem Architectureを正とする。また、具体的なCache Key設計等は扱わない。 -->

### 8.4 Object Storage Infrastructure

<!-- 記載条件: Object Storageを利用する場合。 -->

<!-- Object StorageのService、Bucket等の管理単位、環境、Class、暗号化、公開・非公開、接続先参照、利用者。Lifecycle設定は既存Data方針を実現する範囲 -->

| Storage | Environment | Used By | Purpose | Access |
| --- | --- | --- | --- | --- |
| [Storageを記入] | [Environmentを記入] | [Used Byを記入] | [Purposeを記入] | [Accessを記入] |

<!-- 記載範囲: Retention / Archiving / Lifecycleの方針そのものはData Strategyを正とする。本章では、その方針を実現するLifecycle Configuration等が必要な場合にInfrastructure構成として反映する。 -->

### 8.5 Messaging Infrastructure

<!-- 記載条件: Messagingを利用する場合。 -->

<!-- Queue / Topic / Broker等の環境、Producer / Consumer、構成・Capacity・Throughput、Ordering / Delivery制約、Retention、DLQ、Endpoint参照。Message意味・Payloadは上位設計 -->

| Messaging Resource | Type | Environment | Producer | Consumer | Infrastructure Configuration |
| --- | --- | --- | --- | --- | --- |
| [Messaging Resourceを記入] | [Typeを記入] | [Environmentを記入] | [Producerを記入] | [Consumerを記入] | [Infrastructure Configurationを記入] |

<!-- 記載範囲: Event / Messageの意味、Payload Schema、Producer / Consumerの機能責務、同期 / 非同期の使い分け等はSystem Architectureを正とする。 -->

### 8.6 Environment Separation and Placement

<!-- Data / Messaging Resourceの環境別分離・共有と配置。Data Ownerおよび2章のBoundaryを維持 -->

| Resource | [環境1] | [環境2] | [環境3] | Separation / Sharing |
| --- | --- | --- | --- | --- |
| [Resourceを記入] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] | [Separation / Sharingを記入] |

<!-- 記載範囲: Environment Separation Policyそのものを再定義しない。また、Environment間でProduction Dataを移動可能とするか等のData PolicyはEnvironment Separation Architecture / Data Strategyを正とする。 -->

### 8.7 Backup, Replication and Recovery Implementation

<!-- 記載条件: Data Strategy等にBackup / Replication / Recoveryの方針がある場合。その方針を再定義しない。方針がない場合も基盤に必要なBackup・復元は8章・13章の該当節で設計する。 -->

<!-- Data Strategy等のBackup / Replication / Recovery要求に対するSchedule、Snapshot、保存先、Replica、Multi-AZ / Region、復元Resourceの具体構成 -->

| Strategy Requirement | Infrastructure Implementation | Target Resource |
| --- | --- | --- |
| [Strategy Requirementを記入] | [Infrastructure Implementationを記入] | [Target Resourceを記入] |

<!-- 記載範囲: RPO / RTO、Retention期間、Replicationの必要性、Recovery Policy等を本章で新たに決定しない。これらはData Strategyを正とする。 -->

### 8.8 Data and Messaging Infrastructure Diagram

<!-- Application / WorkloadとDatabase / Cache / Object Storage / Messagingの接続、必要な環境Boundary -->

<!-- 図の記載: Mermaid flowchartでWorkload→Data Store / Cache / Object Storage、およびProducer→Messaging→Consumerを採用した範囲で表す。Data Modelは描かない。 -->

[構成・関係図をここに記載]

<!-- 記載範囲: Application内部のFunctional FlowやData Modelを表現しない。また、VPC / Subnet / Route等のNetwork構造はNetwork Architectureを正とする。 -->

## 9. Traffic Management and External Connectivity

<!-- 本章では、Network Architectureで定義されたNetwork Connectivityを前提として、Application Trafficの入口、Routing、Distribution、およびExternal System / External Serviceとの接続を実現するInfrastructure構成を定義する。 -->

### 9.1 Traffic Entry and Exposure Architecture

<!-- Trafficと利用Application、Source、Public / Private、Entry Point、対象環境 -->

| Traffic / Application | Source | Exposure | Entry Point | Environment |
| --- | --- | --- | --- | --- |
| [Traffic / Applicationを記入] | [Sourceを記入] | [Exposureを記入] | [Entry Pointを記入] | [Environmentを記入] |

<!-- 記載範囲: Public / Private SubnetやInternet Gateway等、Entry Pointへ到達するためのNetwork PathはNetwork Architectureを正とする。また、ApplicationとしてAPIを公開するかどうか等のInterface設計はSystem Architectureを正とする。 -->

### 9.2 Load Balancing Architecture

<!-- 記載条件: Load Balancerを利用する場合。 -->

<!-- Load Balancerの種別・共有、Listener / Port、Target / Target Group、Health Check参照、Cross-zone等の設定、環境 -->

| Load Balancer | Exposure | Listener | Target | Environment |
| --- | --- | --- | --- | --- |
| [Load Balancerを記入] | [Exposureを記入] | [Listenerを記入] | [Targetを記入] | [Environmentを記入] |

<!-- 記載範囲: Load Balancerが配置されるSubnetやRoute等はNetwork Architectureを正とする。また、TargetとなるApplication / Workloadの配置そのものはApplication and Workload Placementを正とする。 -->

### 9.3 Application Traffic Routing

<!-- Host / Path / Protocol等のRouting条件、Default動作、Entry PointからService / Workloadへの対応。API内部処理は含めない -->

| Entry Point | Condition | Destination | Purpose |
| --- | --- | --- | --- |
| [Entry Pointを記入] | [Conditionを記入] | [Destinationを記入] | [Purposeを記入] |

<!-- 記載範囲: Application内部のEndpoint / Controller Routing等は扱わない。また、API Contract自体はApplication側の対応する設計を正とする。 -->

### 9.4 API Gateway and Edge Architecture

<!-- 記載条件: API Gateway / CDN / Edgeを利用する場合。 -->

<!-- API Gateway / CDN / EdgeのResource、対象Traffic、Origin、用途、環境、必要な設定。Cache設定は上位方針を実現 -->

| Edge Resource | Traffic | Origin / Target | Purpose |
| --- | --- | --- | --- |
| [Edge Resourceを記入] | [Trafficを記入] | [Origin / Targetを記入] | [Purposeを記入] |

<!-- 記載範囲: Application Cache StrategyそのものはSystem Architectureを正とする。また、CDN等の具体的なCache Policyについて、Application仕様に依存する判断を本章で新たに行わない。 -->

### 9.5 DNS Traffic Routing

<!-- Domain / RecordのType、Alias / Target、環境、Routing / Failover等の設定。Zone・名前解決基盤は5.6 -->

| Domain / Record | Environment | Destination | Routing Purpose |
| --- | --- | --- | --- |
| [Domain / Recordを記入] | [Environmentを記入] | [Destinationを記入] | [Routing Purposeを記入] |

<!-- 記載範囲: Hosted ZoneそのもののNetwork / Name Resolution ArchitectureはNetwork Architectureを正とする。 -->

### 9.6 External System Connectivity

<!-- 記載条件: External Systemとの接続がある場合。 -->

<!-- External Systemとの通信方向、環境、Endpoint参照、接続方式、Source・経路・関連Resource。Integration Contractは再定義しない -->

| External System | Direction | Environment | Connectivity | Traffic Path |
| --- | --- | --- | --- | --- |
| [External Systemを記入] | [Directionを記入] | [Environmentを記入] | [Connectivityを記入] | [Traffic Pathを記入] |

<!-- 記載範囲: External Systemとの機能上の責務、Request / Response、Interface Contract等はSystem Architecture / Interface Designを正とする。VPN等のNetwork Connection自体の詳細構成はNetwork Architectureを正とする。 -->

### 9.7 External Service Connectivity

<!-- 記載条件: External Serviceとの接続がある場合。 -->

<!-- External Serviceの環境別接続、Endpoint / Resource参照、利用者。Stubを用い実Serviceへ接続しない環境も区別 -->

| External Service | Environment | Connectivity | Endpoint / Resource | Used By |
| --- | --- | --- | --- | --- |
| [External Serviceを記入] | [Environmentを記入] | [Connectivityを記入] | [Endpoint / Resourceを記入] | [Used Byを記入] |

<!-- 記載範囲: External Service Client / Adapter、Stub切替等のApplication ArchitectureはSystem Architectureを正とする。Identity / IAM Permissionは10章、Credentialの管理・供給は11章で定義する。 -->

### 9.8 Deployment Traffic Switching

<!-- 記載条件: Deployment StrategyをInfrastructureのTraffic切替で実現する場合。 -->

<!-- 上位Deployment Strategyを実現する新旧Target、Traffic配分・切替条件・方式とRollback経路 -->

| Application / Service | Deployment Strategy | Traffic Switching | Rollback |
| --- | --- | --- | --- |
| [Application / Serviceを記入] | [Deployment Strategyを記入] | [Traffic Switchingを記入] | [Rollbackを記入] |

<!-- 記載範囲: Rolling / Blue / Green等のApplication側Deployment Strategyを本章で新たに決定しない。本章ではSystem Architectureで決定されたStrategyをInfrastructureとしてどう実現するかを定義する。 -->

### 9.9 Traffic Management Diagram

<!-- 外部利用者、DNS、Edge / Gateway / Load Balancer、Workload、External System / Serviceの主要Traffic経路 -->

<!-- 図の記載: Mermaid flowchartで利用者→DNS / Edge / Gateway / Load Balancer→Workloadと、外部System / ServiceへのTraffic経路を表す。Routing・切替Boundaryを明示する。 -->

[構成・関係図をここに記載]

<!-- 記載範囲: Subnet / Route等のNetwork TopologyやApplication内部のFunctional Flowを本図の主目的として表現しない。 -->

## 10. Infrastructure Security and Identity

<!-- 本章では、System Architectureで定義されたSecurity ArchitectureおよびInfrastructure上のTrust Boundaryを、IAM、Kubernetes RBAC、Security Group、Network Policy、WAF、Encryption等の具体的なInfrastructure Security Controlとして実現する構成を定義する。 -->

### 10.1 Infrastructure Trust Boundaries

<!-- 上位Security要求に基づくTrust Boundary、Source / Target、境界に必要な制御 -->

| Trust Boundary | Source | Target | Required Control |
| --- | --- | --- | --- |
| [Trust Boundaryを記入] | [Sourceを記入] | [Targetを記入] | [Required Controlを記入] |

<!-- 記載範囲: System Architecture上のTrust BoundaryやApplication Security Requirementそのものを再定義しない。また、VPC / Subnet等のNetwork Segmentation自体はNetwork Architectureを正とする。 -->

### 10.2 Infrastructure Identity Model

<!-- Workload、管理者、Delivery / IaC実行主体等とInfrastructure Identity、Scope・環境、用途 -->

| Principal | Infrastructure Identity | Scope | Purpose |
| --- | --- | --- | --- |
| [Principalを記入] | [Infrastructure Identityを記入] | [Scopeを記入] | [Purposeを記入] |

<!-- 記載範囲: Application内部のUser Identity / Role Modelを再定義しない。また、Application Credentialの利用方法そのものはSystem Architectureを正とする。 -->

### 10.3 IAM Architecture

<!-- 記載条件: IAMによる権限管理を行う場合。 -->

<!-- Role、Principal、許可Resource / Action・Scope、信頼・引受条件、環境、Cross-accountの可否。最小権限を具体化し、Policy全文は複製しない -->

| Role | Principal | Allowed Resources | Permission Scope | Environment |
| --- | --- | --- | --- | --- |
| [Roleを記入] | [Principalを記入] | [Allowed Resourcesを記入] | [Permission Scopeを記入] | [Environmentを記入] |

<!-- 記載範囲: Application上のAuthorization RuleをIAM Policyへ置き換えて再定義しない。IAMはInfrastructure Resource Accessを制御するために使用する。 -->

### 10.4 Workload Identity and Cloud Access

<!-- 記載条件: WorkloadからCloud等のResourceへIdentityを用いてAccessする場合。非KubernetesではNamespace / ServiceAccount列を採用基盤のIdentity単位に置き換える。 -->

<!-- Workloadから基盤ResourceへAccessするIdentity対応。Kubernetes採用時はNamespace / ServiceAccountとCloud Identityを対応付ける -->

| Workload | Namespace | ServiceAccount | Cloud Identity | Accessible Resource |
| --- | --- | --- | --- | --- |
| [Workloadを記入] | [Namespaceを記入] | [ServiceAccountを記入] | [Cloud Identityを記入] | [Accessible Resourceを記入] |

<!-- 記載範囲: Application内部でIdentityをどのように利用してBusiness Authorizationを行うかはSystem Architectureを正とする。 -->

### 10.5 Kubernetes Authorization and Isolation

<!-- 記載条件: Kubernetesを採用する場合。 -->

<!-- Kubernetes採用時のSubject、Namespace / Cluster Scope、Role / ClusterRole・Binding等の権限、隔離制御とNetwork制御の組合せ -->

| Subject | Scope | Permission | Kubernetes Control |
| --- | --- | --- | --- |
| [Subjectを記入] | [Scopeを記入] | [Permissionを記入] | [Kubernetes Controlを記入] |

<!-- 記載範囲: Application AuthorizationにおけるRBAC / ABAC等はSystem Architectureを正とする。ここでいうRBACはKubernetes Infrastructure ResourceへのAuthorizationを指す。 -->

### 10.6 Network Security Controls

<!-- 5.8の通信を実現するSecurity Group / Firewall / NetworkPolicy等の適用先とRule。必要な許可と不要な通信の拒否を明示 -->

| Source | Destination | Protocol / Port | Security Control | Policy |
| --- | --- | --- | --- | --- |
| [Sourceを記入] | [Destinationを記入] | [Protocol / Portを記入] | [Security Controlを記入] | [Policyを記入] |

<!-- 記載範囲: 通信経路、Subnet、Route等はNetwork Architectureを正とする。 -->

### 10.7 Edge and Application Protection

<!-- 記載条件: Edge / Application入口にInfrastructure側の保護が必要な場合。 -->

<!-- 必要な入口保護、WAF / DDoS / Infrastructure Rate Limit / IP制限等の適用先・設定・目的。Business側制限は再定義しない -->

| Entry Point | Protection | Applied Control | Purpose |
| --- | --- | --- | --- |
| [Entry Pointを記入] | [Protectionを記入] | [Applied Controlを記入] | [Purposeを記入] |

<!-- 記載範囲: Application内部のInput ValidationやBusiness Rate Limit等はSystem / Application Architectureを正とする。 -->

### 10.8 Infrastructure Encryption and Key Management

<!-- 保存時・通信時の暗号化対象、方式、Key管理元・環境分離・Rotation、上位保護要件との対応。Certificate管理は11.7 -->

| Resource / Traffic | Encryption | Key / Mechanism | Environment |
| --- | --- | --- | --- |
| [Resource / Trafficを記入] | [Encryptionを記入] | [Key / Mechanismを記入] | [Environmentを記入] |

<!-- 記載範囲: Data Classificationや「何を暗号化すべきか」というApplication / Data側のRequirementを本章で再定義しない。本章では要求をInfrastructureとしてどう実現するかを定義する。 -->

### 10.9 Resource Access Control Matrix

<!-- PrincipalからResourceへのAccess関係、権限範囲、適用Controlと環境。具体的な制御定義は本章の対応節を参照 -->

| Principal | Resource | Access | Control | Environment |
| --- | --- | --- | --- | --- |
| [Principalを記入] | [Resourceを記入] | [Accessを記入] | [Controlを記入] | [Environmentを記入] |

<!-- 記載範囲: 各Policy Document等の記述を重複して掲載しない。本MatrixはAccess関係の正本として使用し、具体的なControl設定は対応するSubsectionを正とする。 -->

## 11. Configuration, Secrets and Certificates

<!-- 本章では、Application / WorkloadおよびInfrastructure Resourceが必要とするConfiguration、Secret、CredentialおよびCertificateについて、管理場所、Environment分離、供給方式、Injection方式、更新・Rotationおよび利用Boundaryを実装可能な仕様まで定義する。 -->

### 11.1 Configuration Classification

<!-- Configuration / Secretの分類、機密性、共通・環境固有、管理方針 -->

| Classification | Sensitive | Environment-specific | Management Policy |
| --- | --- | --- | --- |
| [Classificationを記入] | [Sensitiveを記入] | [Environment-specificを記入] | [Management Policyを記入] |

<!-- 記載範囲: ApplicationのBusiness Configurationや個々の機能仕様そのものを本章で新たに定義しない。本章ではInfrastructureから管理・供給するConfigurationを対象とする。 -->

### 11.2 Configuration Inventory and Source

<!-- 利用Configurationの分類、Consumer、Source of Truth、環境差分、生成・提供主体。Secret実値や動的生成値を転記しない -->

| Configuration | Classification | Consumer | Source | Environment-specific |
| --- | --- | --- | --- | --- |
| [Configurationを記入] | [Classificationを記入] | [Consumerを記入] | [Sourceを記入] | [Environment-specificを記入] |

<!-- 記載範囲: Secretの実値を設計書へ記載しない。また、Infrastructure Resourceから自動的に生成されるEnvironment固有値をpersistentな設計書の固定値として管理しない。 -->

### 11.3 Configuration Management and Distribution

<!-- 非機密Configurationの管理元、配布先、環境変数・File・Runtime取得等の供給方式、更新・反映方法 -->

| Configuration Type | Management | Distribution | Consumer |
| --- | --- | --- | --- |
| [Configuration Typeを記入] | [Managementを記入] | [Distributionを記入] | [Consumerを記入] |

<!-- 記載範囲: Application内部でConfigurationをどのClass / Framework APIから読み込むか等の実装詳細は定義しない。 -->

### 11.4 Secret and Credential Management

<!-- 記載条件: Secret / Credentialを管理する場合。 -->

<!-- Secret / Credentialの保存先、Consumer、供給方式、環境分離。Code・Repository・Imageへ機密値を含めず、Identity利用との使い分けを明示 -->

| Secret / Credential | Store | Consumer | Supply Method | Environment |
| --- | --- | --- | --- | --- |
| [Secret / Credentialを記入] | [Storeを記入] | [Consumerを記入] | [Supply Methodを記入] | [Environmentを記入] |

<!-- 記載範囲: SecretへのAccess PermissionはInfrastructure Security and Identityを正とする。また、Secretの実値は記載しない。 -->

### 11.5 Secret Injection and Workload Integration

<!-- 記載条件: SecretをWorkloadへ供給・取得する場合。 -->

<!-- Secret SourceからInjection / Retrieval先への接続、Runtime / 起動時取得、Mount / 環境変数等の方式、更新検知・反映・Restart -->

| Source | Injection / Retrieval | Target | Refresh Behavior |
| --- | --- | --- | --- |
| [Sourceを記入] | [Injection / Retrievalを記入] | [Targetを記入] | [Refresh Behaviorを記入] |

<!-- 記載範囲: Application固有のConfiguration Binding Code等は定義しない。 -->

### 11.6 Rotation and Configuration Update Strategy

<!-- 記載条件: Configuration変更・Secret Rotationに反映方式や制約の設計が必要な場合。 -->

[Configuration変更・Secret Rotationの契機／必要な周期、更新主体、反映タイミング、新旧併存、Restart要否、失敗時と環境差異]

<!-- 記載範囲: Application ReleaseそのもののPromotion / Deployment StrategyはSystem Architectureを正とする。また、具体的なRotation ScheduleはSecurity / Operational Requirementに基づいて必要な場合のみ定義する。 -->

### 11.7 Certificate and TLS Asset Management

<!-- 記載条件: Certificate / TLS Assetを利用する場合。 -->

<!-- Certificateの利用先・Domain / Endpoint、CA・発行主体、Private Key管理元、配置・供給、更新・反映方法 -->

| Certificate | Used By | Managed By | Placement | Renewal |
| --- | --- | --- | --- | --- |
| [Certificateを記入] | [Used Byを記入] | [Managed Byを記入] | [Placementを記入] | [Renewalを記入] |

<!-- 記載範囲: TLSを必要とする通信BoundaryそのものはSystem Architecture / Infrastructure Security and Identityを正とする。本項目ではそのRequirementを実現するCertificate Infrastructureを定義する。 -->

### 11.8 Environment-specific Configuration

<!-- 環境ごとのConfiguration / Secretの管理・参照・分離差異。Secret値そのものは記載しない -->

| Configuration / Secret | [環境1] | [環境2] | [環境3] | Separation Policy |
| --- | --- | --- | --- | --- |
| [Configuration / Secretを記入] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] | [Separation Policyを記入] |

<!-- 記載範囲: Environment固有の実値を設計書へ固定的に転記することを目的としない。実値のSource of TruthとEnvironment間の分離関係を定義する。 -->

### 11.9 Configuration and Secret Flow

<!-- Infrastructure OutputからConfiguration / Secret Source、Deployment / Workloadへの生成・登録・供給・取得経路 -->

<!-- 図の記載: Mermaid flowchartでInfrastructure→Output→Configuration / Secret Source→Deployment / Applicationの供給経路を表す。Runtime取得とDeployment時Injectionを区別する。 -->

[構成・関係図をここに記載]

<!-- 記載範囲: Application内部でConfigurationを利用する処理Flowや、Secret値そのものを図示しない。 -->

## 12. Resource, Performance and Scaling Architecture

<!-- 本章では、System Architectureで定義されたPerformance / Capacity RequirementおよびPerformance and Scalability Architectureを、具体的なInfrastructure Resource、CapacityおよびScaling構成として実現する。 -->

### 12.1 Resource Requirements and Sizing

<!-- 要求に基づくResource、Baseline、上限、単位、Sizing根拠。初期値・確定値・Constraint・実測後の確認対象を区別 -->

| Target | Resource | Baseline | Maximum / Limit | Basis |
| --- | --- | --- | --- | --- |
| [Targetを記入] | [Resourceを記入] | [Baselineを記入] | [Maximum / Limitを記入] | [Basisを記入] |

<!-- 記載範囲: Performance Requirementそのものを本章で新たに定義しない。また、Application内部のAlgorithmやResource効率化方式はSystem / Application側の設計を正とする。 -->

### 12.2 Workload Resource Allocation

<!-- 記載条件: WorkloadのResource割当を管理する場合。非Container基盤では同等の割当項目に調整する。 -->

<!-- Workload別CPU / Memory Request・Limit、必要なEphemeral Storage等。Platform・Node Capacityと整合 -->

| Workload | CPU Request | CPU Limit | Memory Request | Memory Limit |
| --- | --- | --- | --- | --- |
| [Workloadを記入] | [CPU Requestを記入] | [CPU Limitを記入] | [Memory Requestを記入] | [Memory Limitを記入] |

<!-- 記載範囲: WorkloadをどのNamespace / Node Groupへ配置するかはApplication and Workload Placementを正とする。 -->

### 12.3 Workload Replica and Concurrency

<!-- Replica / 同時実行の最小・通常・最大、根拠と環境差異。Application側の並列実行制約を維持 -->

| Workload | Minimum | Normal | Maximum | Scaling / Concurrency Basis |
| --- | --- | --- | --- | --- |
| [Workloadを記入] | [Minimumを記入] | [Normalを記入] | [Maximumを記入] | [Scaling / Concurrency Basisを記入] |

<!-- 記載範囲: Application内部のThread数や並列処理Algorithm等は本章では定義しない。 -->

### 12.4 Workload Auto Scaling

<!-- 記載条件: Workload Auto Scalingを採用する場合。 -->

<!-- Workload Auto Scalingの機構、Metric / 閾値、Scale-out / in条件、安定化、最小・最大、環境差異 -->

| Workload | Scaling Mechanism | Metric | Scale-out | Scale-in | Range |
| --- | --- | --- | --- | --- | --- |
| [Workloadを記入] | [Scaling Mechanismを記入] | [Metricを記入] | [Scale-outを記入] | [Scale-inを記入] | [Rangeを記入] |

<!-- 記載範囲: Application側でScaling可能にするためのStateless化等はSystem Architectureを正とする。 -->

### 12.5 Node and Compute Capacity

<!-- 記載条件: Node / Compute Capacityを管理する場合。 -->

<!-- Compute GroupのInstance Type / Capacity、最小・通常・最大、対象Workload、System Resource分の余裕、Capacity種別の制約 -->

| Compute Group | Instance Type / Capacity | Minimum | Desired | Maximum | Workloads |
| --- | --- | --- | --- | --- | --- |
| [Compute Groupを記入] | [Instance Type / Capacityを記入] | [Minimumを記入] | [Desiredを記入] | [Maximumを記入] | [Workloadsを記入] |

<!-- 記載範囲: Node Group自体の構造・用途はCompute and Container Platform Architectureを正とする。本項目ではCapacity / Sizingを具体化する。 -->

### 12.6 Infrastructure Auto Scaling

<!-- 記載条件: Infrastructure Auto Scalingを採用する場合。 -->

[Node / Compute等のAuto Scaling機構、Trigger、最小・最大、Scale-in時の影響と制約、Workload Scalingとの連動、環境差異。計画的休眠は17章]

<!-- 記載範囲: Environmentを長期間利用しない場合のScale-to-zero / Destroy等は Environment Lifecycle and Dormancy Strategy を正とする。 -->

### 12.7 Data and Messaging Capacity

<!-- 記載条件: Data / Messaging Resourceを利用する場合。 -->

<!-- Data / Messaging ResourceのCompute・Storage・Connection・Throughput等のCapacity、初期値、拡張条件・上限・Quota -->

| Resource | Capacity Dimension | Initial Capacity | Scaling / Limit |
| --- | --- | --- | --- |
| [Resourceを記入] | [Capacity Dimensionを記入] | [Initial Capacityを記入] | [Scaling / Limitを記入] |

<!-- 記載範囲: Data Retention / Archiving等によってData量を管理する方針は、必要になった場合のData Strategyを正とする。また、Data Model / Query Optimization等はApplication / Data側の設計を正とする。 -->

### 12.8 Environment-specific Capacity

<!-- 環境別Capacity差異と要求・費用・検証目的上の理由。具体値の正本は対応節を参照して重複を避ける -->

| Resource / Workload | [環境1] | [環境2] | [環境3] | Reason |
| --- | --- | --- | --- | --- |
| [Resource / Workloadを記入] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] | [Reasonを記入] |

<!-- 記載範囲: Environmentを使用しない期間のResource削除 / 停止等はEnvironment Lifecycle and Dormancy Strategyで定義する。 -->

### 12.9 Capacity Constraints and Bottlenecks

<!-- Quota・Connection・Throughput・External依存等の制約とBottleneck、影響Scope、限界、基盤側対応。ApplicationのFallbackは再設計しない -->

| Constraint / Bottleneck | Affected Scope | Limit / Risk | Infrastructure Strategy |
| --- | --- | --- | --- |
| [Constraint / Bottleneckを記入] | [Affected Scopeを記入] | [Limit / Riskを記入] | [Infrastructure Strategyを記入] |

<!-- 記載範囲: External Service側のApplication-level Fallback等はSystem Architectureを正とする。 -->

## 13. Availability, Recovery and Infrastructure Health

<!-- 本章では、System Architectureで定義されたAvailability / Continuity Requirementを満たすため、Infrastructure Resourceの冗長化、Failure Isolation、Failover、Health Detectionおよび障害発生後のRecovery Architectureを定義する。 -->

### 13.1 Availability Requirements Mapping

<!-- 環境・対象ごとの上位Availability要件とInfrastructureへの含意 -->

| Target | Environment | Availability Requirement | Infrastructure Implication |
| --- | --- | --- | --- |
| [Targetを記入] | [Environmentを記入] | [Availability Requirementを記入] | [Infrastructure Implicationを記入] |

<!-- 記載範囲: Application側のAvailability RequirementやFallback / Retry等のApplication Architectureを再定義しない。 -->

### 13.2 Resource Redundancy and Failure Domains

<!-- ResourceのFailure Domain、Replica / AZ等の冗長構成、環境。単に数を増やすのではなく耐えられる故障を明示 -->

| Resource | Failure Domain | Redundancy | Environment |
| --- | --- | --- | --- |
| [Resourceを記入] | [Failure Domainを記入] | [Redundancyを記入] | [Environmentを記入] |

<!-- 記載範囲: Replica数やNode数等のCapacity値そのものはResource, Performance and Scaling Architectureを正とする。 -->

### 13.3 Failover Architecture

<!-- 記載条件: Failoverを必要とする場合。 -->

<!-- 故障対象、切替先、検知・Trigger、Automatic / Manual、切替方式と継続条件 -->

| Failure | Failover Target | Trigger | Method |
| --- | --- | --- | --- |
| [Failureを記入] | [Failover Targetを記入] | [Triggerを記入] | [Methodを記入] |

<!-- 記載範囲: Application内部のFallback LogicやCircuit Breaker等はSystem Architectureを正とする。また、Traffic Routingの具体構成はTraffic Management and External Connectivityと整合させる。 -->

### 13.4 Infrastructure Health Model

<!-- Readiness / Liveness / Startup / LB / Resource Healthの対象・役割・故障時の影響。一般的なMetrics監視は15章 -->

| Target | Health Type | Purpose | Failure Effect |
| --- | --- | --- | --- |
| [Targetを記入] | [Health Typeを記入] | [Purposeを記入] | [Failure Effectを記入] |

<!-- 記載範囲: Metrics、Logs、Traces等による一般的なSystem MonitoringはObservability Architectureで定義する。本項目ではInfrastructureの制御・復旧判断に直接使用するHealthを対象とする。 -->

### 13.5 Readiness, Liveness and Health Check Configuration

<!-- Health Checkの方式、Endpoint / Command、間隔・Timeout・失敗回数・猶予、Failure Action。Applicationへの要求は18章へ接続 -->

| Target | Check | Configuration | Failure Action |
| --- | --- | --- | --- |
| [Targetを記入] | [Checkを記入] | [Configurationを記入] | [Failure Actionを記入] |

<!-- 記載範囲: Application内部でHealth Endpointがどの依存先を確認するか等のApplication実装仕様はここでは定義しない。 -->

### 13.6 Infrastructure Recovery Strategy

<!-- 障害時の復旧対象・方法・Source・Dependency / 順序。Code、State、Configuration、Backup等からの再現性 -->

| Failure Target | Recovery Method | Recovery Source | Dependency |
| --- | --- | --- | --- |
| [Failure Targetを記入] | [Recovery Methodを記入] | [Recovery Sourceを記入] | [Dependencyを記入] |

<!-- 記載範囲: 意図的なEnvironment削除後の再生成はDormancy Strategyを正とする。また、Provisioning Pipeline自体の構成はInfrastructure Provisioning and Deliveryで定義する。 -->

### 13.7 Infrastructure Rollback Strategy

<!-- 記載条件: Infrastructure変更のRollback・Roll-forwardの判断が必要な場合。 -->

[IaC / Platform設定のRollback・再生成可否、Stateful Resourceの制約・Roll-forward、Application互換性。Application Artifact戦略は上位設計]

<!-- 記載範囲: Application ArtifactのRollbackはSystem ArchitectureのDeployment Architecture and Strategyを正とする。 -->

### 13.8 Data Recovery Infrastructure

<!-- 記載条件: Dataを保持・復元するInfrastructureがある場合。 -->

[Backup / Snapshot、保存先、復元対象・環境・依存Resource。Data Strategyがあれば従い、なくても必要な基盤のBackup・復元構成は8章と本章で確定。Migration・Schema Evolution・Business Retentionは含めない]

<!-- 記載範囲: Data Migration、Schema Evolution、Retention / Archiving等のData Lifecycle Strategyを本項目で広げて定義しない。 -->

### 13.9 Failure and Recovery Matrix

<!-- 主要故障のImpact、Detection、Failover / Recovery、Service影響。13.2〜13.8の構成と対応付け、Runbookは複製しない -->

| Failure | Impact | Detection | Failover / Recovery | Service Impact |
| --- | --- | --- | --- | --- |
| [Failureを記入] | [Impactを記入] | [Detectionを記入] | [Failover / Recoveryを記入] | [Service Impactを記入] |

<!-- 記載範囲: 障害対応手順書やOperator向けRunbookそのものは作成しない。必要な場合はOperational Documentationとして別途定義する。 -->

## 14. Environment Access and Management Architecture

<!-- 本章では、構築済みのEnvironmentおよびInfrastructure Resourceに対して、Administrator / Operator / Developer等が管理、調査、保守および検証を行うためのAccess Architectureを定義する。 -->

### 14.1 Management Access Model

<!-- 管理目的・頻度・対象・Security要求に基づく環境別Access Model、入口、Public / Private、直接接続の可否・共有。環境名だけで決めない -->

| Environment | Access Model | Entry Point | Public Access | Primary Purpose |
| --- | --- | --- | --- | --- |
| [Environmentを記入] | [Access Modelを記入] | [Entry Pointを記入] | [Public Accessを記入] | [Primary Purposeを記入] |

<!-- 記載範囲: IAM Role / Policy、Security Group Rule等の具体的なAccess Permissionは定義しない。また、Management Accessに必要なSubnet / Route等のNetwork構造はNetwork Architectureを正とする。 -->

### 14.2 Bastion and Administrative Access

<!-- 記載条件: 管理Resourceの要否を判断する場合。配置しない場合は代替方式を示し、表はBastion / Management Hostを採用するときに使用する。 -->

<!-- Bastion / Management Hostの要否、環境配置・共有、Access方式、Public IP / SSHの可否、対象と用途、常時稼働・必要時起動。代替の管理Serviceで足りるならBastionは不要 -->

| Management Resource | Environment | Access Method | Managed Target | Purpose |
| --- | --- | --- | --- | --- |
| [Management Resourceを記入] | [Environmentを記入] | [Access Methodを記入] | [Managed Targetを記入] | [Purposeを記入] |

<!-- 記載範囲: BastionのInstance Type、CPU / Memory等のResource SizingはResource, Performance and Scaling Architectureを正とする。また、Session Manager利用に必要なIAM / Endpoint / Security Group等の具体構成は対応するSecurity / Network Sectionで定義する。 -->

### 14.3 Management and Verification Targets

<!-- 管理・調査・検証対象、環境、目的、Access元、必要Capability。通常Application経路の代用としない -->

| Target | Environment | Access Purpose | Access From | Required Capability |
| --- | --- | --- | --- | --- |
| [Targetを記入] | [Environmentを記入] | [Access Purposeを記入] | [Access Fromを記入] | [Required Capabilityを記入] |

<!-- 記載範囲: Application機能のTest Scenario / Test CaseやDatabase上の具体的な確認Query等は定義しない。また、対象Resource自体のArchitectureを再定義しない。 -->

### 14.4 Management Tooling and Execution Environment

<!-- Cloud / Platform CLI、Data・HTTP・DNS等のToolと実行環境、対象、用途。Versionは3章、具体CommandはRunbook -->

| Tool / Capability | Execution Environment | Target | Purpose |
| --- | --- | --- | --- |
| [Tool / Capabilityを記入] | [Execution Environmentを記入] | [Targetを記入] | [Purposeを記入] |

<!-- 記載範囲: 個々のCommand、SQL、kubectl操作等の具体的なOperation Procedureは記載しない。継続的に必要となる操作手順は、必要に応じてRunbook等のOperational Documentationで管理する。 -->

### 14.5 Management Access Flow

<!-- Operator / Developerから認証・管理Service / Hostを経由してPrivate Resourceへ到達する主要経路 -->

<!-- 図の記載: 必要に応じてMermaid flowchartで管理主体→認証・管理入口→管理Resource→Private Targetを表す。採用しない中継要素は追加せず、複数方式は主要Flowごとに分ける。 -->

[構成・関係図をここに記載]

<!-- 記載範囲: Applicationの通常Traffic FlowやSystem間Integration Flowを本図へ混在させない。また、Security Group RuleやIAM Policy等の具体設定を図へ展開しない。 -->

### 14.6 Environment-specific Management Access

<!-- 環境ごとの管理目的、Access、Bastion、Private API / DB / Platform検証、制約の差異と要求上の根拠 -->

| Concern | [環境1] | [環境2] | [環境3] |
| --- | --- | --- | --- |
| [Concernを記入] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] |

<!-- 記載範囲: Environment Isolation Modelそのものを再定義しない。Account / VPC / Cluster / Namespace等のEnvironment BoundaryはEnvironment Separation Architectureを正とする。 -->

### 14.7 Management Identity and Access Requirements

<!-- 管理主体、環境、対象、最小権限、Temporary / Session Access、特権制限・追跡要件。実際のIAM / RBACは10章へ -->

| Principal | Environment | Management Target | Required Access | Security Control |
| --- | --- | --- | --- | --- |
| [Principalを記入] | [Environmentを記入] | [Management Targetを記入] | [Required Accessを記入] | [Security Controlを記入] |

<!-- 記載範囲: 具体的なIAM Policy Document、RoleBinding等のSecurity Resourceは本項目で重複して定義しない。 -->

### 14.8 Management Access Audit and Traceability

<!-- 誰が・いつ・どの環境で何を管理操作したかのAudit Source・連携先・目的。収集・保存・検索構成は15章 -->

| Access / Activity | Audit Source | Destination | Purpose |
| --- | --- | --- | --- |
| [Access / Activityを記入] | [Audit Sourceを記入] | [Destinationを記入] | [Purposeを記入] |

<!-- 記載範囲: Observability Backend、Retention、Dashboard、Alert等の具体構成は本項目で再定義しない。 -->

### 14.9 Management Resource Lifecycle

<!-- 記載条件: Bastion等の管理専用Resourceを配置する場合。 -->

<!-- 管理ResourceのActive / Inactive扱い、Stop / Destroy、Tool / Configurationの再現元。17章と整合し、休眠・再生成を妨げない構成 -->

| Management Resource | Active Usage | Inactive Strategy | Recreate From |
| --- | --- | --- | --- |
| [Management Resourceを記入] | [Active Usageを記入] | [Inactive Strategyを記入] | [Recreate Fromを記入] |

<!-- 記載範囲: Environment全体のLifecycle Strategyを本項目で再定義しない。また、ResourceのDestroy / Restore PipelineそのものはInfrastructure Provisioning and Deliveryを正とする。 -->

## 15. Observability Architecture

<!-- 本章では、ApplicationおよびInfrastructureの状態・挙動を継続的に観測・分析できるよう、Metrics、Logs、Traces等のTelemetryを生成・収集・転送・保存・可視化・通知するObservability Infrastructureを定義する。 -->

### 15.1 Observability Scope and Signals

<!-- Metrics / Logs / Traces / Events等のSignal、Application・Platform・Managed Service等の対象、目的、環境差異 -->

| Signal | Source | Purpose | Environment |
| --- | --- | --- | --- |
| [Signalを記入] | [Sourceを記入] | [Purposeを記入] | [Environmentを記入] |

<!-- 記載範囲: 個々のApplicationが出力する具体的なLog MessageやBusiness Metricの定義を本章で新たに決定しない。本章では、それらを収集・管理可能にするInfrastructureを対象とする。 -->

### 15.2 Metrics Architecture

<!-- 記載条件: Metricsを収集・管理する場合。 -->

<!-- Metrics Source、Pull / Push等の収集、Backend・保存構成、環境。Scaling条件は12章、必要Metricの提供は本節 -->

| Metrics Source | Collection | Backend | Environment |
| --- | --- | --- | --- |
| [Metrics Sourceを記入] | [Collectionを記入] | [Backendを記入] | [Environmentを記入] |

<!-- 記載範囲: HPA等のScaling条件そのものはResource, Performance and Scaling Architectureを正とする。ただし、Scalingに利用するMetricsを提供するために必要なObservability Infrastructureは本項目で定義する。 -->

### 15.3 Logging Architecture

<!-- 記載条件: Logsを収集・管理する場合。 -->

<!-- Application / Platform / Access / Audit Log等の収集・転送・保存・検索構成、環境分離。基盤連携に必要な出力要件を明示 -->

| Log Source | Collector | Destination | Purpose |
| --- | --- | --- | --- |
| [Log Sourceを記入] | [Collectorを記入] | [Destinationを記入] | [Purposeを記入] |

<!-- 記載範囲: Application Logの具体的なMessage FormatやLogging CodeはApplication側の設計を正とする。ただし、Infrastructureへ連携するために必要なFormat / Output Requirementは定義してよい。 -->

### 15.4 Distributed Tracing Architecture

<!-- 記載条件: Distributed Tracingを採用する場合。 -->

<!-- Trace対象、標準、Export / Collector / Backend、Sampling、Context伝播・外部境界の前提。InstrumentationやSpan内部設計は含めない -->

| Trace Source | Collection / Export | Collector | Backend |
| --- | --- | --- | --- |
| [Trace Sourceを記入] | [Collection / Exportを記入] | [Collectorを記入] | [Backendを記入] |

<!-- 記載範囲: Application Code上の具体的なInstrumentationやSpan設計を本章で詳細化しない。ただし、Infrastructureとの接続に必要なExporter / Endpoint等は定義する。 -->

### 15.5 Telemetry Collection and Processing

<!-- 記載条件: Collector / Agent / Gateway等を使用する場合。 -->

<!-- Collector / Agent / GatewayのSignal、配置方式・環境、Source / Destination、集約・Filter・Enrichment・Buffering・障害時の影響 -->

| Collector | Signals | Placement | Source | Destination |
| --- | --- | --- | --- | --- |
| [Collectorを記入] | [Signalsを記入] | [Placementを記入] | [Sourceを記入] | [Destinationを記入] |

<!-- 記載範囲: Collectorを配置するCluster / Namespace自体の構造はCompute and Container Platform Architectureを正とする。本項目ではObservability Componentとしての配置・役割を具体化する。 -->

### 15.6 Telemetry Flow

<!-- Application / InfrastructureからCollector等を経て各Backendへ至るTelemetry経路。環境間共有があればBoundaryと識別方式 -->

<!-- 図の記載: 必要に応じてMermaid flowchartでApplication / Infrastructure→Collector等→Metrics / Logs / Traces Backendを表す。共有時は環境Boundaryと識別方法を明示する。 -->

[構成・関係図をここに記載]

<!-- 記載範囲: 一般的なApplication Request FlowやInfrastructure Traffic Flowを表現しない。本図はTelemetry Flowを正本とする。 -->

### 15.7 Alerting Architecture

<!-- 記載条件: Alertingが必要な場合。 -->

<!-- Alert対象・Signal、Ruleと管理元、Severity、通知基盤・宛先、Grouping / Suppression、環境差異、Application / Infrastructureの責務 -->

| Alert Target | Signal | Condition / Rule Source | Notification |
| --- | --- | --- | --- |
| [Alert Targetを記入] | [Signalを記入] | [Condition / Rule Sourceを記入] | [Notificationを記入] |

<!-- 記載範囲: 障害時の具体的なOperator対応手順やRunbookそのものは定義しない。また、Infrastructureが自動的にFailoverするためのHealth判定は13章を正とする。 -->

### 15.8 Dashboard and Visualization

<!-- 記載条件: Dashboard / Visualizationを用意する場合。 -->

<!-- Dashboardの対象Scope、Signal、Tool、目的、定義の管理元。Panel / Query全量はCodeを正とする -->

| Dashboard | Scope | Signals | Purpose |
| --- | --- | --- | --- |
| [Dashboardを記入] | [Scopeを記入] | [Signalsを記入] | [Purposeを記入] |

<!-- 記載範囲: すべてのPanel / Query等を設計書へ網羅的に転記しない。Dashboard定義をCode等で管理する場合は、その定義を正本とする。 -->

### 15.9 Telemetry Storage and Retention

<!-- Telemetryの保存先、環境、Retention、Capacity・制約。上位方針があれば従い、Business Dataの保持は対象外 -->

| Signal | Storage | Environment | Retention | Capacity / Constraint |
| --- | --- | --- | --- | --- |
| [Signalを記入] | [Storageを記入] | [Environmentを記入] | [Retentionを記入] | [Capacity / Constraintを記入] |

<!-- 記載範囲: Business DataのRetention / Archivingは扱わない。本項目はObservability Dataに限定する。 -->

### 15.10 Environment-specific Observability

<!-- 環境ごとの配置、Signal収集、Retention、Alerting等の差異と根拠。休眠時のResource維持は17章 -->

| Concern | [環境1] | [環境2] | [環境3] |
| --- | --- | --- | --- |
| [Concernを記入] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] |

<!-- 記載範囲: Environment自体の休眠・削除時にObservability Resourceを維持するかどうかはEnvironment Lifecycle and Dormancy Strategyで定義する。 -->

## 16. Infrastructure Provisioning and Delivery

<!-- 本章では、本Infrastructure Architectureで定義されたInfrastructure ResourceをCodeとして管理し、依存関係に従ってProvisioning / Configurationし、各Environmentへ安全かつ再現可能に適用するためのInfrastructure Delivery Architectureを定義する。 -->

### 16.1 Infrastructure Code Structure

<!-- Infrastructure CodeのDirectory構成、IaC / Platform設定 / 環境設定 / 補助Toolの責務と管理・適用単位。実装本文は複製しない -->

```text
[Infrastructure Code Root]/
├── [IaCの管理単位]/
├── [Platform設定の管理単位]/
└── [環境設定・補助Tool等の管理単位]/
```

<!-- 記載範囲: 個々のResource DefinitionやManifest本文を設計書へ転記しない。実際のInfrastructure Codeを具体設定の正本とする。 -->

### 16.2 Terraform and IaC Architecture

<!-- 記載条件: IaCを採用する場合。 -->

<!-- 採用IaCのRoot / Shared / 環境Module、Resource単位、Dependency、Variable / Output、Provider、環境差分。補助Toolを使う場合の責務 -->

| IaC Unit | Responsibility | Dependency | Environment |
| --- | --- | --- | --- |
| [IaC Unitを記入] | [Responsibilityを記入] | [Dependencyを記入] | [Environmentを記入] |

<!-- 記載範囲: Terraform Resourceの全Parameterを設計書へ複製しない。Resource固有仕様は対応するInfrastructure SectionおよびInfrastructure Codeを正とする。 -->

### 16.3 IaC Module Dependencies

<!-- 記載条件: IaCを採用する場合。External Moduleの採用要否を検討し、採用する場合は以下を記載する。 -->

<!-- 採用するExternal IaC Module、そのSource、適用Scope、Versionおよび用途。 -->

| Module | Source | Scope / Used For | Version | Purpose |
| --- | --- | --- | --- | --- |
| [Moduleを記入] | [Registry / Repositoryを記入] | [Scopeを記入] | [Versionを記入] | [Purposeを記入] |

<!-- 記載範囲: Module内部のResource Definitionや実装、個々のVariable / Parameterを設計書へ複製しない。具体的なModule利用設定はInfrastructure Codeを正とする。 -->

### 16.4 Infrastructure State Management

<!-- 記載条件: IaC Stateの管理が必要な場合。 -->

<!-- Stateの単位・Scope・環境分離、Remote Backend、Lock、Access、機密性、Backup / Recovery、State間Output参照 -->

| State | Scope | Environment | Backend | Access |
| --- | --- | --- | --- | --- |
| [Stateを記入] | [Scopeを記入] | [Environmentを記入] | [Backendを記入] | [Accessを記入] |

<!-- 記載範囲: StateへのIAM PermissionそのものはInfrastructure Security and Identityと整合させる。 -->

### 16.5 Kubernetes Configuration Architecture

<!-- 記載条件: Kubernetesを採用する場合。 -->

<!-- Kubernetes採用時のManifest / Chart / Base / Overlay等の管理単位、環境差分、Namespace対応、Application / Platform / 共通Resourceの分担 -->

| Resource Scope | Management | Environment Variation |
| --- | --- | --- |
| [Resource Scopeを記入] | [Managementを記入] | [Environment Variationを記入] |

<!-- 記載範囲: 個々のManifest Parameterを設計書へ網羅的に転記しない。また、Application / Workloadの配置そのものはApplication and Workload Placementを正とする。 -->

### 16.6 Infrastructure Dependencies and Provisioning Order

<!-- ResourceおよびTechnology境界を跨ぐDependencyと適用順序。並列化可能な構築と前提成立が必要な構築を区別 -->

<!-- 図の記載: 必要に応じてMermaid flowchartで構築単位をNode、前提Dependencyを矢印として表す。Network、Compute / Data、Platform設定、Configuration等の実際の依存を反映する。 -->

[構成・関係図をここに記載]

```text
[最初に成立させる構築単位]
  ↓ [必要なOutput・前提]
[依存する構築・設定単位]
  ↓ [必要なOutput・前提]
[Application-readyの成立]
```

<!-- 実際の依存に応じて分岐・並列・段数を調整する。 -->

<!-- 記載範囲: Application機能間のDependencyやApplication Detail Designの設計順序は扱わない。 -->

### 16.7 Environment Provisioning Strategy

<!-- 環境ごとのManual / Pipeline、Trigger、Approval、実行主体、Create / Update / Destroy / Rebuild方式と理由 -->

| Environment | Provisioning Method | Execution | Purpose / Rationale |
| --- | --- | --- | --- |
| [Environmentを記入] | [Provisioning Methodを記入] | [Executionを記入] | [Purpose / Rationaleを記入] |

<!-- 記載範囲: Environmentをいつ休眠・削除するかというLifecycle PolicyはEnvironment Lifecycle and Dormancy Strategyで定義する。 -->

### 16.8 Infrastructure Delivery Pipeline

<!-- 記載条件: Infrastructure CI/CDを採用する場合。採用するLayerのみを対象とする。 -->

[CI/CD採用時のLayer別Pipeline構造と環境への適用方式。Terraform層とKubernetes層を使用する場合は独立したPipelineとし、独立実行・失敗・再実行が可能な構造にする]

#### Pipeline Separation

<!-- 記載条件: Infrastructure CI/CDを採用する場合。Terraform層とKubernetes層の両方があれば、二つの独立Pipelineを定義する。 -->

<!-- Layerごとの責務・変更単位、Target、Dependency。Terraformの適用・検証完了後にKubernetesを実行可能とし、常に一つのPipelineの連続Stageとして一括実行しない -->

Pipelineの責務と依存:

| Pipeline | Responsibility | Primary Target | Dependency |
| --- | --- | --- | --- |
| [Pipelineを記入] | [Responsibilityを記入] | [Primary Targetを記入] | [Dependencyを記入] |

Pipeline別Stage定義:

| Pipeline | Stage | Tool / Action | Output | Failure Behavior |
| --- | --- | --- | --- | --- |
| [Pipelineを記入] | [Stageを記入] | [Tool / Actionを記入] | [Outputを記入] | [Failure Behaviorを記入] |

Terraform Pipeline（採用時）:

```text
[検証Stage]
  ↓
[Plan作成・確認Stage]
  ↓
[Review / Approval Stage]
  ↓
[Apply Stage]
  ↓
[適用後検証Stage]
```

Kubernetes Pipeline（採用時）:

```text
[検証Stage]
  ↓
[Diff確認Stage]
  ↓
[Review / Approval Stage]
  ↓
[Apply Stage]
  ↓
[適用後検証Stage]
```

<!-- 記載範囲: Application Build / Unit Test等のApplication Delivery Pipeline自体はSystem Architectureを正とする。 -->

### 16.9 Infrastructure Validation and Testing

<!-- Layerごとの適用前後Validation / Testと実施時点・Tool・対象。Format / Lint、Plan / Diff、Policy / Security、Health / Connectivity、Drift等の必要検証を独立定義 -->

| Layer | Validation | Timing | Target | Tool / Method |
| --- | --- | --- | --- | --- |
| [Layerを記入] | [Validationを記入] | [Timingを記入] | [Targetを記入] | [Tool / Methodを記入] |

#### Verification Workload Strategy

<!-- 記載条件: Workloadを利用したInfrastructure検証が必要な場合。Applicationの完成待ちが不要な検証と、Actual Applicationによる統合検証を区別する。 -->

<!-- 検証対象とApplication完成時期からTemporary / Actual Workloadを選定。Temporaryは最小構成としBusiness Logicを模倣せず、検証後に不要Resourceを削除 -->

| Verification Target | Verification Workload | Timing | Verification |
| --- | --- | --- | --- |
| [Verification Targetを記入] | [Verification Workloadを記入] | [Timingを記入] | [Verificationを記入] |

<!-- 記載範囲: Application機能のTest CaseはTest Designを正とする。また、Infrastructure Healthの定義そのものはAvailability, Recovery and Infrastructure Healthを正とする。 -->

### 16.10 Application Delivery Integration

<!-- Infrastructure Ready条件、Application PipelineへのTarget / Registry / Identity / Configuration提供、前提Resource、実行順序・Trigger関係 -->

<!-- 図の記載: Mermaid flowchartで独立したInfrastructure Pipeline→Infrastructure Ready / Output・Configuration→Application Pipeline→Deployment Targetの接続とTrigger / 参照関係を表す。 -->

[構成・関係図をここに記載]

<!-- 記載範囲: Application PipelineのBuild / Test / Artifact生成等の内部構造を再定義しない。 -->

### 16.11 Infrastructure Change and Delivery Rules

[Code経由変更、Console変更の許可・禁止、Emergency Change、Drift修正、Apply前Review / Approval、環境Promotion、Codeと実Resourceの整合、Application変更との順序]

<!-- 記載範囲: 個々のTrainにおける具体的な変更手順やRelease Scheduleは定義しない。 -->

## 17. Environment Lifecycle and Dormancy Strategy

<!-- 本章では、各EnvironmentおよびInfrastructure Resourceについて、Provisioning後にどのようなLifecycleで維持・停止・削除・再生成するかを定義する。 -->

### 17.1 Lifecycle Requirements

<!-- 環境ごとの利用目的・頻度、常時利用要否、停止許容期間、復元時間、State保持・再生成可能性、外部接続維持、Cost・Availability要件 -->

| Environment | Usage Pattern | Suspension Allowed | State Preservation | Restore Requirement | Cost Priority |
| --- | --- | --- | --- | --- | --- |
| [Environmentを記入] | [Usage Patternを記入] | [Suspension Allowedを記入] | [State Preservationを記入] | [Restore Requirementを記入] | [Cost Priorityを記入] |

<!-- 記載範囲: dev / stg / prod等のEnvironment名だけを根拠としてLifecycle Strategyを決定しない。また、具体的な停止・削除方式は本項目ではまだ決定しない。 -->

### 17.2 Lifecycle Model

<!-- 採用するLifecycle Stateと意味、適用対象・遷移条件。不要なStateを導入せず、全Resourceに同一遷移を強制しない -->

<!-- 図の記載: 必要に応じてMermaid stateDiagram-v2で採用したStateと計画的な遷移を表す。保持・削除対象や遷移条件を17.4〜17.7へ対応付け、障害復旧は混在させない。 -->

[Lifecycle状態遷移図をここに記載]

<!-- 記載範囲: すべてのEnvironment / Resourceが同一のLifecycle Stateを経由することを要求しない。また、Infrastructure障害によるRecovery Flowは本Lifecycle Modelへ混在させない。 -->

### 17.3 Lifecycle Strategy by Environment

<!-- 17.1の要求から環境別のActive / Inactive、Preservation / Restoration方式と根拠。prodも環境名だけで常時維持と決めない -->

| Environment | Active Strategy | Inactive Strategy | Preservation Strategy | Restoration Strategy | Rationale |
| --- | --- | --- | --- | --- | --- |
| [Environmentを記入] | [Active Strategyを記入] | [Inactive Strategyを記入] | [Preservation Strategyを記入] | [Restoration Strategyを記入] | [Rationaleを記入] |

<!-- 記載範囲: Environment種別に対する一般的な慣習のみを理由としてStrategyを決定しない。 -->

### 17.4 Resource Lifecycle Classification

<!-- ResourceごとのKeep / Stop / Scale Down / Scale to Zero / Preserve / Destroy / Recreate等の採用Action、保持対象、再現元、理由 -->

| Resource | Lifecycle Action | Preserve | Recreate From | Reason |
| --- | --- | --- | --- | --- |
| [Resourceを記入] | [Lifecycle Actionを記入] | [Preserveを記入] | [Recreate Fromを記入] | [Reasonを記入] |

<!-- 記載範囲: Resource自体の通常時構成は対応するInfrastructure Sectionを正とする。本項目ではLifecycle Actionのみを定義する。 -->

### 17.5 Preservation Strategy

<!-- Data、Snapshot、IaC State、Artifact、Configuration / Secret / Certificate、DNS、Code等の保持判断、正本、復元必須性。再生成可能なものと失えないものを区別 -->

| Preservation Target | Preserve | Source of Truth | Required for Restore |
| --- | --- | --- | --- |
| [Preservation Targetを記入] | [Preserveを記入] | [Source of Truthを記入] | [Required for Restoreを記入] |

<!-- 記載範囲: Backup / Retention等について別途Data Strategyが存在する場合、その方針を再定義しない。本章ではEnvironment Lifecycle上、何をPreserveする必要があるかを扱う。 -->

### 17.6 Destroy and Suspension Procedure

<!-- Traffic・Workload停止、必要State / Data保持、依存順の停止・削除、保持物検証までの順序とDependency。緊急障害復旧は13章 -->

```text
[Traffic / Workload停止]
  ↓ [停止完了条件]
[必要State / Dataの保持]
  ↓ [保持確認・依存条件]
[再生成可能なResourceの停止・削除]
  ↓
[保持Asset・残存Resourceの検証]
```

<!-- 実際のResource Dependencyに基づく順序と対象へ置き換える。 -->

<!-- 記載範囲: 障害発生時の緊急Recovery Procedureは本項目では扱わない。 -->

### 17.7 Restoration Architecture

<!-- 保持Code / State / Backup等から基盤、Data、設定、Workload、Applicationを再構成し、検証後Trafficを再開する順序。16章の適用単位を参照 -->

```text
[保持Code / State / Backup等の復元元]
  ↓
[依存順のInfrastructure構築・Data復元]
  ↓
[Configuration / Secret供給・Platform設定]
  ↓
[Application配置]
  ↓
[復元検証]
  ↓ [再開判定]
[Traffic再開]
```

<!-- Resourceごとの復元元と適用単位を明示し、必要な分岐・並列・順序へ調整する。Pipeline内部は16章を参照する。 -->

<!-- 記載範囲: 各Terraform / Kubernetes Pipelineの内部Stageを再定義しない。 -->

### 17.8 Restoration Verification

<!-- 必要Resource・Health・通信・Configuration / Secret・Data・Application・外部接続・観測の確認とSuccess Condition、Traffic再開可否 -->

| Verification | Target | Success Condition |
| --- | --- | --- |
| [Verificationを記入] | [Targetを記入] | [Success Conditionを記入] |

### 17.9 Cost and Restoration Trade-offs

<!-- 維持Costと復元Cost / Time、作業負担、Data Loss / Restore失敗Risk、外部依存、利用頻度・Availabilityを比較した採用理由。推測を確定値にしない -->

| Resource / Environment | Keep Cost | Restore Cost / Time | Selected Strategy | Reason |
| --- | --- | --- | --- | --- |
| [Resource / Environmentを記入] | [Keep Costを記入] | [Restore Cost / Timeを記入] | [Selected Strategyを記入] | [Reasonを記入] |

<!-- 記載範囲: Costだけを基準としてLifecycle Strategyを決定しない。 -->

## 18. Application and Deployment Handoff

<!-- 本章では、Infrastructure ArchitectureおよびInfrastructure構築の結果として、Applicationの実装・実行およびDeploymentに必要となるInfrastructure由来の情報を整理し、Application / Deployment担当へ引き渡すContractを定義する。 -->

### 18.1 Handoff Scope and Consumers

<!-- 境界を越えた情報が必要なApplication / Service / Workload / Deployment PipelineとHandoff範囲。基盤内部情報を網羅しない -->

| Consumer | Type | Required Handoff |
| --- | --- | --- |
| [Consumerを記入] | [Typeを記入] | [Required Handoffを記入] |

<!-- 記載範囲: Application内部だけで完結するConfigurationや実装仕様を本章で定義しない。また、Infrastructure担当内部だけで利用するResource情報を網羅的に引き渡さない。 -->

### 18.2 Application Configuration Contract

<!-- Consumerが使用するConfiguration Key、その意味、Source、環境Scope、機密性。動的なEndpoint等の実値を固定Contractにしない -->

| Configuration Key | Consumer | Purpose | Source | Environment | Sensitive |
| --- | --- | --- | --- | --- | --- |
| [Configuration Keyを記入] | [Consumerを記入] | [Purposeを記入] | [Sourceを記入] | [Environmentを記入] | [Sensitiveを記入] |

<!-- 記載範囲: Endpoint、Host、Resource Name等のEnvironment固有の実値をpersistentなContractとして固定しない。実値のSource of TruthはInfrastructure / Configuration Storeとする。 -->

### 18.3 Configuration Reference Contract

<!-- 記載条件: Parameter Store等のConfiguration Sourceを参照する場合。 -->

<!-- Keyと安定したReferenceの対応、Consumer、Value Producer、Naming / 環境識別、Outputからの登録・更新・Applicationへの反映方式 -->

| Configuration | Reference | Consumer | Value Producer |
| --- | --- | --- | --- |
| [Configurationを記入] | [Referenceを記入] | [Consumerを記入] | [Value Producerを記入] |

<!-- 記載範囲: Parameterへ格納されるEnvironment固有値そのものを本章へ転記しない。 -->

### 18.4 Secret and Credential Reference Contract

<!-- 記載条件: ApplicationがSecret / Credentialを利用する場合。 -->

<!-- Secret Reference、Consumer、用途、環境、Application Configuration Key、Runtime / Injection供給、Rotation時の対応。機密値は書かない -->

| Secret / Credential | Consumer | Secret Reference | Usage | Environment |
| --- | --- | --- | --- | --- |
| [Secret / Credentialを記入] | [Consumerを記入] | [Secret Referenceを記入] | [Usageを記入] | [Environmentを記入] |

<!-- 記載範囲: Password、API Key、Token、Private Key等のSecret値そのものを記載しない。また、Secret StoreおよびInjection ArchitectureそのものはConfiguration, Secrets and Certificatesを正とする。 -->

### 18.5 Infrastructure Endpoint and Resource Contract

<!-- Resource利用に必要なHost / Port / URL / Name等の情報種別とSource。可能なものは18.2〜18.4のReferenceを介し、実値を複製しない -->

| Resource | Consumer | Required Information | Configuration Source |
| --- | --- | --- | --- |
| [Resourceを記入] | [Consumerを記入] | [Required Informationを記入] | [Configuration Sourceを記入] |

<!-- 記載範囲: Infrastructure Resource自体の構成・設定を再定義しない。 -->

### 18.6 Certificate and Trust Handoff

<!-- 記載条件: Application / DeploymentがCertificate / CA / Trust情報を利用する場合。 -->

<!-- Application / Deploymentが必要とするCertificate / CA / Trust StoreのReference・Source、Consumer、用途。Private Key等の実体は埋め込まない -->

| Certificate / Trust Asset | Consumer | Reference / Source | Purpose |
| --- | --- | --- | --- |
| [Certificate / Trust Assetを記入] | [Consumerを記入] | [Reference / Sourceを記入] | [Purposeを記入] |

<!-- 記載範囲: Certificateの発行、配置、更新方式はConfiguration, Secrets and Certificatesを正とする。 -->

### 18.7 Application Deployment Target Contract

<!-- 上位Deployment Unitと環境別Platform / Cluster、Namespace / Target、Deployment Resourceの対応。7章と一致させる -->

| Deployment Unit | Environment | Platform / Cluster | Namespace / Target | Deployment Resource |
| --- | --- | --- | --- | --- |
| [Deployment Unitを記入] | [Environmentを記入] | [Platform / Clusterを記入] | [Namespace / Targetを記入] | [Deployment Resourceを記入] |

<!-- 記載範囲: Application Deployment StrategyやPipeline内部のBuild / Test / Artifact生成処理はSystem Architectureを正とする。 -->

### 18.8 Application Pipeline Infrastructure Contract

<!-- Application Pipelineの環境別Target、Registry、Identity / Access参照、Configuration / Secret Reference、前提Resource、Infrastructure Ready条件 -->

| Pipeline | Environment | Target | Identity | Required Infrastructure |
| --- | --- | --- | --- | --- |
| [Pipelineを記入] | [Environmentを記入] | [Targetを記入] | [Identityを記入] | [Required Infrastructureを記入] |

<!-- 記載範囲: PipelineのBuild / Unit Test / Artifact生成等のApplication Delivery処理は再定義しない。また、IAM / Kubernetes RBAC等の権限そのものはInfrastructure Security and Identityを正とする。 -->

### 18.9 Environment-specific Handoff Matrix

<!-- Consumerごとの環境別Handoff差異とSource。実値一覧ではなくReference・TargetのContractを示し、可能な範囲でKey / 構造を共通化 -->

| Handoff Item | Consumer | [環境1] | [環境2] | [環境3] | Source |
| --- | --- | --- | --- | --- | --- |
| [Handoff Itemを記入] | [Consumerを記入] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] | [配置・設定・方針または参照先] | [Sourceを記入] |

<!-- 記載範囲: Environment固有値を一覧として複製することを目的としない。Environment差異をApplication / Deployment担当が認識するために必要なContractのみを記載する。 -->

### 18.10 Handoff Completeness and Change Rules

[全Consumerの必要設定・参照・Output対応・Deployment先・権限前提の充足確認、再構築後のReference維持、Contract変更時の影響Consumer特定と変更Rule]

<!-- 記載範囲: 個々のTrainにおける具体的なHandoff作業手順や担当者間の連絡方法は定義しない。 -->

## 19. Infrastructure Architecture Diagrams

<!-- 本章では、各Sectionで定義されたInfrastructure Architectureを統合し、Environment、Network、Traffic Entry、Compute / Container Platform、Application / Workload、Data Infrastructure、External Connectivity等の主要な構造と関係を可視化する。 -->

### 19.1 Infrastructure Architecture Overview

<!-- Environment / Network Boundaryと主要Resource・Workload配置、Traffic / Data / 外部接続を統合。Security、Certificate、Configuration、Observability、Management等の独立した役割を持つ主要Resourceも原則網羅 -->

<!-- 図の記載: Mermaid flowchartで各節の決定を統合する。主要なNetwork / Traffic / Compute / Workload / Data / 外部接続に加え、採用したSecurity・Certificate・Configuration・Observability・Management Resourceも表し、通常Trafficと管理・制御の関係を区別する。環境・Workload種別で大きく異なる場合は図を分ける。 -->

[構成・関係図をここに記載]

<!-- 記載範囲: 各Sectionですでに定義されたCIDR、Route、Security Group Rule、IAM Policy、Resource Size、Scaling値等の詳細仕様を図へ重複して記載しない。また、Architecture上独立した構成要素ではない補助的・内部的なResourceまで網羅することで、図の視認性を損なわない -->

### 19.2 Multi-AZ Infrastructure Topology

<!-- 記載条件: Multi-AZ構成を採用する場合。 -->

<!-- Multi-AZ採用時のNetwork / VPC、AZ、Public / Private Subnet、Gateway等の配置と主要接続。個別Applicationは抽象化し、環境差異は必要に応じ図を分ける -->

<!-- 図の記載: Mermaid flowchartでNetwork内にAZとPublic / Private Subnetを配置し、Gateway / NAT等との接続を示す。Trafficの方向と配置関係を区別し、5章・13章の正本から描く。 -->

[構成・関係図をここに記載]

<!-- 記載範囲: 個別Resourceの詳細構成や設定値を再定義しない。本項目では、Multi-AZ構成におけるAvailability Zone、Subnetおよび主要なNetwork Componentの配置・接続関係の可視化に限定する。 -->
