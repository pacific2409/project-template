# review points

`docs/persistent/infrastructure-architecture.md` を以下の観点でレビューする。

## Review Report Path

レビュー結果は以下に出力する。パスはProjectルートからの相対パスとする。

```text
docs/reviews/infrastructure-design-review-report.md
```

## レビューの前提と適用範囲

- 内容の正本は当skillの`references/guide.md`とする。承認済みの`assets/template.md`は成果物の構造・記載形式の確認に使用する。
- Function Design / System ArchitectureのApplication、Service、Integration、Data、Security、Performance、Deployment等の要求を、実行・接続・保護・観測・運用可能なInfrastructureへ具体化できているかを評価する。Applicationの機能・内部構造・Business Ruleを再設計するレビューにはしない。
- 各Section / Subsectionの適用有無は、要求・先行設計・本書の決定から判断する。該当Concernがない項目の省略を欠落とせず、該当するのに省略された事項は不足として確認する。特定Cloud、Kubernetes、Multi-AZ、Bastion、Auto Scaling等を一律に必須化しない。
- 基本設計と詳細設計を分割しない成果物として、Infrastructure側で判断可能な事項が構築可能な具体仕様まで確定しているかを確認する。「詳細だから」という理由だけで後続へ先送りしていないかを評価する。
- 実測が必要な値は、確定値、初期値、Constraint、後続の確認対象が区別されているかを確認する。設計時点で未実施の負荷試験や復元試験を、実施済みの根拠として扱わない。一方、具体的な設計値が必要な項目を、理由なく未定のままにしない。
- 個別API / Batch / Data / UI仕様、ApplicationのBuild / Test / Release戦略、Data Migration / Schema Evolution / Business DataのRetention・Archiving戦略、Application機能のTest Case、Operator向けRunbook本文は必須要件として要求しない。基盤に必要なBackup・Recovery、計画的な停止・再生成の依存順序と検証は本書の対象とする。
- IaC / Manifest / Pipeline実装本文の複製は要求しない。本書で確定した仕様を実体へ反映した後は、Code / Configurationを具体設定の正本として参照できるかを確認する。
- Decisionの主担当Sectionを正とし、本文・表・図・参照の名称、境界、数値、接続関係が一致しているか確認する。例示の技術・構造・値や未記入のプレースホルダーを、決定済みの内容として残していないかも確認する。

## 特有のレビュー観点

- Change History
- Infrastructure Overview
- Environment Separation Architecture
- Infrastructure Technology Stack and Tooling
- Cloud and Infrastructure Resource Architecture
- Network Architecture
- Compute and Container Platform Architecture
- Application and Workload Placement
- Data and Messaging Infrastructure
- Traffic Management and External Connectivity
- Infrastructure Security and Identity
- Configuration, Secrets and Certificates
- Resource, Performance and Scaling Architecture
- Availability, Recovery and Infrastructure Health
- Environment Access and Management Architecture
- Observability Architecture
- Infrastructure Provisioning and Delivery
- Environment Lifecycle and Dormancy Strategy
- Application and Deployment Handoff
- Infrastructure Architecture Diagrams
- インフラ設計書全体の妥当性と一貫性

各章の観点では適用条件を満たす項目を確認し、最後の横断的な観点では構築・利用・運用・再生成・引渡しまでを一つのInfrastructure Architectureとして評価する。

### 0. Change History

- 初回履歴はレビュー・再レビューを含む設計工程の完了時点の1件として扱われているか。確定前のレビューで確定済みの履歴を要求していないか。
- 同一設計工程内のレビュー対応、記載修正、表現改善、誤記修正を個別履歴にしていないか。
- 確定後の正式な設計変更・後続Trainによる変更がある場合、Change、Date、Train、Summaryから変更を追跡できるか。

### 1. Infrastructure Overview

- 1.1：対象とするInfrastructure形態、Provider、Environment、提供する基盤領域、System Architectureとの責務境界が明確か。上位設計の何を実現する文書か分かるか。
- 1.2：環境分離、Network、実行基盤、Data / Messaging、外部接続、Security、Availability / Scaling、Provisioning、Lifecycleの主要方針から全体像を理解でき、後続章の決定と一致しているか。
- 1.3：主要Application / Service / Workloadと必要な基盤機能の対応を追跡できるか。機能責務やDeployment Unitを変更せず、具体的な配置先は7章と区別しているか。
- 1.4：全体構成図または正式図への参照から、外部・Environment・Networkの境界、実行基盤、Workload、Data / Messaging、外部接続の論理関係が分かるか。詳細ResourceやApplication内部処理を網羅する図になっていないか。

### 2. Environment Separation Architecture

- 2.1：Environmentごとの目的・利用範囲・Production Dataの扱いが明確で、不要な環境を参考例に合わせて追加していないか。
- 2.2：採用するAccount / Network / Cluster / Namespace等のBoundaryごとに、どのEnvironmentを共有・分離するかが明確か。表と、図を用いる場合の包含関係が一致しているか。
- 2.3：共有・独立させるInfrastructureと対象Environmentを特定でき、共有時の干渉、Security、Capacity、障害影響に対する根拠・制約があるか。
- 2.4：Environment間の接続方針が必要な場合、通信可否、方向、目的、条件が分かるか。Network経路とSecurity制御の具体化へ引き継げるか。
- 2.5：跨環境のData利用が関係する場合、共有・複製・持ち込みの可否、本番Dataの非本番利用条件、匿名化等の要否が明確か。Data Strategyの処理方式を再設計していないか。
- 2.6：管理者・WorkloadのIdentity / Credential、権限、共有基盤Accessの環境境界が明確で、跨環境Accessの例外が分離方針を崩していないか。
- 2.7：External Serviceがある場合、上位設計での実Service / Stub利用に従い、環境ごとの接続先・外部Resourceの分離または共有を判断できるか。

### 3. Infrastructure Technology Stack and Tooling

- 3.1：採用Platformと対象領域・用途が明確か。複数Cloud / On-premise等を利用する場合、責務の使い分けが分かるか。
- 3.2：Workload種別ごとのOrchestration / Platform、Compute、必要なContainer Runtimeが実行要求に対応しているか。
- 3.3：OS / Infrastructure Runtimeを選定・管理する場合、対象と用途が明確か。Application Runtimeの選定を混在させていないか。
- 3.4：IaCを採用する場合、技術ごとの適用範囲・責務が明確で、複数Tool間の重複・空白がないか。
- 3.5：Configuration / Deployment / 管理Toolの役割と範囲が分かり、16章の管理・適用方式へ接続しているか。
- 3.6：設計上重要なTool・Component間の依存、接続、互換性上の制約が明確か。図を用いる場合も同じ関係を表し、Resourceの構築順序と混同していないか。
- 3.7：Versionまたは許容範囲、Provider / Plugin等との互換性、Support期間、Upgrade・廃止時の制約が必要な範囲で定義され、各ResourceのVersionと整合しているか。
- 3.8：InfrastructureのSource管理、Repository、CI/CD等の技術と用途が明確か。Application側と同じ技術・基盤を使うことを無条件に前提としていないか。

### 4. Cloud and Infrastructure Resource Architecture

- 4.1：主要Resourceの種別、役割、利用者が明確で、上位要求との対応から存在理由を説明できるか。実行・Data基盤だけでなく、採用するTraffic、Registry、管理、観測等の主要Resourceにも漏れがないか。
- 4.2：Resourceの環境別配置有無、共有・分離が2章と一致しているか。非配置と記載漏れを区別できるか。
- 4.3：Resourceの責務、主要Consumer / Concern、担わない責務が分かり、Application責務やData Ownershipを再定義していないか。
- 4.4：主要Resource間の利用・依存・接続関係が明確で、後続の通信・権限・供給設計へ対応付けられるか。
- 4.5：論理構成図または正式図への参照がInventory・環境別配置・関係と一致しているか。補助的な詳細Resourceや設定値を網羅することが目的になっていないか。

### 5. Network Architecture

- 5.1：Environment、Network / VPC、Region、Network間の共有・分離・接続方式が明確で、2章の境界を実現しているか。
- 5.2：Network全体とSubnetのCIDR、種別、AZ、用途が具体化され、接続先を含むAddress Spaceの重複や収容上の不整合がないか。必要な拡張余地を考慮しているか。
- 5.3：Route Table、関連Subnet、宛先、Targetから必要経路が成立するか。経路の存在を通信許可と混同していないか。
- 5.4：外部・内部・管理TrafficのIngress / Egress、公開・非公開、入口・出口から宛先までの経路を追跡できるか。
- 5.5：Private接続が必要な場合、対象、方式、Endpoint / Connection、経路と目的が具体化され、9章の接続と10章のAccess前提に矛盾しないか。
- 5.6：採用するPublic / Private DNS Zone、Domain、内部・外部の名前解決、必要なResolver / Forwardingが明確で、環境差異と9.5のTraffic Recordを支えられるか。
- 5.7：公開・非公開、Application・Data・管理等のNetwork区画と必要・不要な通信関係が明確で、10.6の制御へ反映できるか。
- 5.8：必要な通信のSource、Destination、Protocol / Port、方向、目的が具体的か。Applicationだけでなく基盤・管理・外部接続で必要な経路も、対象範囲に応じて含まれているか。
- 5.9：採用するAZ / Subnet、NAT / Gateway、DNS、外部接続の単一障害点・障害影響が整理され、13章のAvailability / Recoveryと整合しているか。

### 6. Compute and Container Platform Architecture

- 6.1：環境別のPlatform、Compute Model、Cluster / Execution Unitと役割が、選定技術・環境分離方針に対応しているか。
- 6.2：Clusterを採用する場合、環境・用途・共有範囲、Version、Control Plane、Endpoint Access、必要なAdd-on・Upgrade制約が構築可能な粒度で確定しているか。
- 6.3：Node / Compute Groupを管理する場合、管理方式、Instance種別、OS / Image、CPU Architecture、Capacity種別、Label / Taint等の基盤条件が、Workload配置・Sizingと整合しているか。
- 6.4：Infrastructure Runtimeの管理が必要な場合、対象・Version・互換性・制約が3章の方針と一致し、Application Runtimeと区別されているか。
- 6.5：Namespaceを採用する場合、その名前・用途・分離Boundaryが明確か。環境単位かApplication単位か等の粒度を、Security、Resource、Ownership、Deployment、運用の要件から選んでいるか。
- 6.6：Kubernetesを採用する場合、使用するResource種別の役割が明確で、必要なWorkload・設定・Identity・制御を支えられるか。種別の一般的な一覧だけになっていないか。
- 6.7：常駐・Scheduled・On-demand等のWorkload種別とExecution Model、Platform Resource、Lifecycleが対応しているか。
- 6.8：共通のContainer構成、必要なSidecar / Init、Restart、Graceful Shutdown、Health、Temporary Storage、Identity単位のBaselineが明確で、個別Workload設定と矛盾しないか。
- 6.9：構成図からEnvironment、Platform / Cluster、Node / Compute、Namespaceの関係が分かるか。論理的な分離単位と物理的な配置単位を誤って包含関係にしていないか。

### 7. Application and Workload Placement

- 7.1：配置対象が上位設計のApplication / Service / Workload、Deployment Unit、実行要件に対応し、内部Module等を独立配置単位へ勝手に変更していないか。
- 7.2：各Workloadの環境別配置有無・基盤差異が明確で、対象Environmentの利用目的を満たしているか。
- 7.3：各WorkloadのPlatform、Execution Model、Platform Resourceが6章で定義した実行方式と一致しているか。
- 7.4：Cluster / Namespaceを採用する場合、環境別の具体的な配置先が確定し、存在しない・異なる境界のTargetを参照していないか。
- 7.5：Compute / Node配置制約がある場合、Label / Taint / Toleration / Affinity等の条件が対象Computeで成立し、CPU ArchitectureやCapacityの制約にも適合するか。
- 7.6：Workload間の同居・分離を判断する場合、Resource競合、Security、障害、運用上の根拠があり、実際の配置・権限・Resource制御がその判断を実現しているか。
- 7.7：配置図が環境別Mappingと一致し、主要な配置Boundary・制約を読み取れるか。Application内部FlowやNetwork全体図に置き換わっていないか。

### 8. Data and Messaging Infrastructure

- 8.1：Persistence Domain、Owner、Persistence ModelとInfrastructure Resource / Managed Serviceの対応が明確で、上位のOwnership・Persistence方針を維持しているか。
- 8.2：Databaseがある場合、Engine / Version、Instance / Cluster、Class、Storage、拡張設定、AZ / Network配置、Endpoint参照、必要なParameter / Option・接続制約が具体化されているか。
- 8.3：Cacheがある場合、Engine、Cluster / Node、Capacity、Availability、配置・接続、Scaling、永続化の扱いが具体化され、Application側のCache方針を再定義していないか。
- 8.4：Object Storageがある場合、管理単位、環境、利用者、Class、暗号化、公開・非公開、接続方式が明確か。Lifecycle設定が必要な場合、上位のData方針を実現しているか。
- 8.5：Messagingがある場合、Producer / ConsumerとQueue / Topic / Broker等の対応、環境、Capacity / Throughput、Ordering / Delivery、Retention、DLQ等の必要設定がIntegration要求を実現しているか。Message意味・Payloadを再設計していないか。
- 8.6：環境ごとのData / Messaging配置・共有・分離が2章の境界と一致し、Production Dataの扱いを別の方針へ変えていないか。
- 8.7：Data Strategy等のBackup / Replication / Recovery方針がある場合、要求とSchedule、Snapshot、保存先、Replica、復元Resource等を対応付けられるか。RPO / RTOやRetention戦略を本節で再決定していないか。
- 8.8：構成図からWorkloadとData / Messaging Resourceの関係・環境境界が分かり、本文のOwner、Producer / Consumer、利用者と一致しているか。
- 別途Data Strategyが存在しないことを理由に、必要な基盤のBackup・復元構成まで未定としていないか。13.8と併せて確認する。

### 9. Traffic Management and External Connectivity

- 9.1：TrafficのSource、利用Application、Public / Private、Entry Point、Environmentが明確で、上位の公開範囲と一致しているか。
- 9.2：Load Balancerを採用する場合、種別、共有、Listener / Port、Target / Target Group、Health Check、必要なCross-zone等の設定が配置・Networkと整合しているか。
- 9.3：Host / Path / Protocol等の条件、Default動作、Destinationから、必要Trafficが正しいService / Workloadへ届くと判断できるか。Application内部Routingと混同していないか。
- 9.4：API Gateway / CDN / Edgeを採用する場合、対象Traffic、Origin、用途、環境、必要設定が明確で、Application依存のCache方針を独自に変更していないか。
- 9.5：DNS RecordのType、Alias / Target、環境、Routing / Failover設定が具体化され、5.6のZone・名前解決と整合しているか。
- 9.6：External Systemと接続する場合、方向、環境、Endpoint参照、方式、Traffic経路・関連Resourceが明確で、上位のInterface Contractを実現できるか。
- 9.7：External Serviceを利用する場合、環境別接続、Endpoint / Resource、利用者が明確で、Stub環境から実Serviceへ接続する等の不一致がないか。
- 9.8：Deployment Traffic切替が必要な場合、上位のDeployment Strategyに従う新旧Target、配分・切替条件、切替方式、Rollback経路が成立するか。
- 9.9：Traffic図がDNS、採用する入口Resource、Workload、External System / Serviceとの関係を示し、通常経路と切替・外部接続の定義に一致しているか。

### 10. Infrastructure Security and Identity

- 10.1：上位Security要求とInfrastructureのTrust Boundaryを対応付け、Source / Targetと必要なControlを説明できるか。
- 10.2：Workload、管理者、Delivery / IaC等の実行主体が、用途・環境・Scopeに応じたInfrastructure Identityへ対応しているか。
- 10.3：IAMを利用する場合、Role、Principal、許可Resource / Action、Permission Scope、信頼・引受条件、環境、跨Accountの扱いを具体化し、必要以上の権限を与えていないか。
- 10.4：Workload Identityを利用する場合、配置先・実行主体・Cloud Identity・Access先Resourceの対応が成立しているか。Kubernetes採用時はNamespace / ServiceAccountとの対応も確認する。
- 10.5：Kubernetesを採用する場合、Subject、Namespace / Cluster Scope、Role・Binding等の権限と必要な隔離制御が明確で、Network制御との役割分担が成立するか。
- 10.6：5.8で必要とした通信が具体的なControl・Ruleで許可され、不要な通信が拒否されるか。Routeの到達性とSecurity上の許可をそれぞれ確認できるか。
- 10.7：入口保護が必要な場合、WAF / DDoS / Rate Limit / IP制限等のControl、適用先、設定、目的が明確か。ApplicationのBusiness上の制限を置き換えていないか。
- 10.8：要求された保存時・通信時暗号化が対象Resource / Trafficへ適用され、方式、Key管理元・環境分離・必要なRotationが明確か。Certificate管理と接続しているか。
- 10.9：Access Control MatrixがPrincipal、Resource、Access、Control、環境の正本として使え、IAM / RBAC / Network等の具体設定との過不足・矛盾がないか。

### 11. Configuration, Secrets and Certificates

- 11.1：Configuration / Secretの機密性、共通・環境固有、管理方針を区別し、分類と実際の管理・供給方式が一致しているか。
- 11.2：各ConfigurationのConsumer、Source of Truth、環境差異、生成・提供主体が分かるか。Secret実値や動的な生成値を永続的な固定値として文書管理していないか。
- 11.3：非機密Configurationの管理元から各Consumerへの配布・取得方式と更新反映が明確で、必要な時点で利用できるか。
- 11.4：Secret / Credentialを扱う場合、Store、Consumer、供給方式、環境分離が具体化され、Code・Repository・Imageへの機密値の埋込みを前提としていないか。Identity方式との使い分けが明確か。
- 11.5：Secret供給が必要な場合、Runtime取得・起動時取得・Injection等の採用方式、Source / Target、更新検知・反映・Restart要否が、Workloadの実行方式と整合しているか。
- 11.6：Configuration更新・Secret Rotationの契機、反映時点、新旧併存、Restart、失敗時、環境差異を判断できるか。具体的な周期はSecurity / 運用要求がある場合に確認し、一律に要求しない。
- 11.7：Certificate / TLS Assetがある場合、対象Domain / Endpoint、発行・管理主体、Private Key管理元、配置・供給、更新方法が実際のTLS利用先と一致しているか。
- 11.8：環境別のConfiguration / Secretの参照・管理・分離差異が2章と整合し、実値の複製ではなく正本を特定できるか。
- 11.9：供給図がInfrastructure OutputからSourceへの登録、Deployment / WorkloadへのInjectionまたはRuntime取得を区別し、本文・表と同じ経路を示しているか。

### 12. Resource, Performance and Scaling Architecture

- 12.1：上位のPerformance / Capacity要求からResource、Baseline、上限、単位、Sizing根拠を追跡できるか。初期値・制約・実測後の確認対象と確定値を区別しているか。
- 12.2：WorkloadのCPU / Memory等を割り当てる場合、Request / Limitや必要なStorage値が明確で、配置先・実行方式・Compute Capacityと整合するか。
- 12.3：Replica / 同時実行の最小・通常・最大と根拠が明確で、Application側の並列実行制約や環境差異を反映しているか。
- 12.4：Workload Auto Scalingを採用する場合、機構、Metric / 閾値、Scale-out / in条件、安定化、範囲が具体的で、必要Metricを15章の基盤から取得できるか。
- 12.5：Node / Compute Capacityを管理する場合、最小・通常・最大、Instance Type / Capacity、対象Workloadが明確で、System Resource分を含めて収容可能か。
- 12.6：Infrastructure Auto Scalingを採用する場合、Trigger、範囲、Scale-in時の影響・制約、Workload Scalingとの連動が成立するか。計画的休眠と区別しているか。
- 12.7：Data / Messagingがある場合、Storage、Connection、Throughput等の必要なCapacity、初期値、拡張条件・上限・QuotaがWorkload需要と整合しているか。
- 12.8：環境別Capacity差異の根拠が要求・検証目的・Costと結び付き、他節の具体値と矛盾していないか。
- 12.9：Quota、接続数、Throughput、外部依存等の制約・Bottleneckについて、影響Scope、限界、基盤側の対応が明確か。ApplicationのAlgorithmやFallbackの再設計へ広げていないか。

### 13. Availability, Recovery and Infrastructure Health

- 13.1：対象・環境ごとのAvailability / Continuity要求が、Infrastructureで必要な構成・制約へ対応しているか。
- 13.2：ResourceのFailure Domainと冗長構成が明確で、必要な故障に耐えられる配置になっているか。Replica数だけでなく、Network・Compute・Dataの実際の障害境界と12章のCapacityを確認する。
- 13.3：Failoverが必要な場合、Failure、切替先、Trigger、Automatic / Manual、方式が具体化され、9章のTraffic制御と一致しているか。
- 13.4：Readiness、Liveness、Startup、Load Balancer / Resource Healthの役割と失敗時の影響が区別され、Infrastructure制御に直接使う判定と一般的な監視を混同していないか。
- 13.5：採用するHealth Checkの方式、Endpoint / Command、間隔、Timeout、失敗回数・猶予、Failure Actionが具体的で、起動・停止・Traffic制御と整合しているか。Application内部のHealth実装まで要求していないか。
- 13.6：障害時の復旧対象、方法、Source、Dependency / 順序が明確で、Code・State・Configuration・Backup等から復旧可能か。計画的な再生成とは区別されているか。
- 13.7：Infrastructure変更にRollback等の判断が必要な場合、設定の巻戻し・再生成可否、Stateful Resourceの制約、必要なRoll-forward、Application互換性が明確か。
- 13.8：Dataの保持・復元が必要な場合、Backup / Snapshot、保存先、復元対象・環境・依存Resourceが具体化されているか。Data Strategyがあれば従い、存在しない場合も基盤側で必要な復旧設計を欠落させていないか。
- 13.9：主要故障についてImpact、Detection、Failover / Recovery、Service影響を一貫して追跡できるか。表だけに本文と異なる復旧方式が追加されていないか。

### 14. Environment Access and Management Architecture

- 14.1：管理目的・対象・頻度・Security要求から、環境別Access Model、入口、Public / Private、直接接続可否が決定されているか。環境名だけを理由にしていないか。
- 14.2：Bastion / Management Hostの要否が判断され、採用する場合は配置・共有、Access方式、Public IP / SSHの可否、用途、稼働方式が明確か。管理Serviceで足りる構成へBastionを強制していないか。
- 14.3：管理・調査・検証対象、環境、目的、Access元、必要Capabilityが分かり、管理経路を通常Application経路の代替としていないか。
- 14.4：管理Toolと実行環境、対象、用途が対応し、3章のVersionと5・10章の接続・権限で実行可能か。個々のCommand / SQL本文を必須としていないか。
- 14.5：主要Management Flowを追跡でき、図を用いる場合は管理主体から入口・管理Resourceを経て対象へ至る経路を正しく表しているか。Application通常Trafficと混在していないか。
- 14.6：環境別のAccess、管理Resource、検証目的、制約の差異に要求上の根拠があり、2章のEnvironment Boundaryと一致しているか。
- 14.7：管理主体ごとの必要権限・Scope、必要なTemporary / Session Access、特権制限・追跡要件が明確で、10章の実際のControlへ対応しているか。
- 14.8：誰が・いつ・どのEnvironmentへAccessしたかを追跡するAudit Sourceと連携先が明確で、15章の収集・保存基盤へ接続しているか。
- 14.9：管理専用Resourceがある場合、停止・削除・再生成とTool / Configurationの再現元が17章に整合し、管理Resource自体が休眠や復元を妨げないか。

### 15. Observability Architecture

- 15.1：収集するMetrics / Logs / Traces / Events等のSignal、対象、目的、環境が明確で、Application・Platform・Managed Serviceの必要な観測を支えられるか。
- 15.2：Metricsを扱う場合、Source、収集方式、Backend・保存構成、環境分離が具体的か。Scalingで使うMetricの提供とScaling条件の決定を区別しているか。
- 15.3：Logsを扱う場合、必要なApplication / Platform / Access / Audit Logの収集・転送・保存・検索構成と、連携に必要な出力要件が明確か。
- 15.4：Tracingを採用する場合、Source、標準、Export / Collector / Backend、Sampling、Context伝播や外部境界の前提が明確か。Application内のInstrumentation / Span設計を要求していないか。
- 15.5：Collector等が必要な場合、Signal、配置方式・環境、Source / Destination、必要な集約・Filter・Buffering等と障害時の影響が具体化されているか。
- 15.6：TelemetryがSourceからBackendへ届く経路を追跡でき、図を用いる場合も本文と一致しているか。環境間でBackendを共有する場合、Boundaryと環境識別方式が明確か。
- 15.7：Alertingが必要な場合、対象、Signal、Condition / Ruleの管理元、Severity、通知先、必要なGrouping / Suppression、環境差異と責務分担が明確か。自動Failover判定と混同していないか。
- 15.8：Dashboardを用意する場合、対象Scope、Signal、Tool、目的、定義の管理元が分かるか。Panel / Queryの全量転記を要求していないか。
- 15.9：Telemetryの保存先、環境、Retention、Capacity / Constraintが必要な観測・Audit要求に適合するか。Business Dataの保持戦略へ範囲を広げていないか。
- 15.10：環境別の配置、収集範囲、Retention、Alerting等の差異が明確で、Cost削減によって必要な検証・運用が成立しなくなっていないか。休眠時の扱いは17章に整合しているか。

### 16. Infrastructure Provisioning and Delivery

- 16.1：Infrastructure Codeの構造とIaC・Platform設定・環境設定・補助Toolの責務が分かり、管理・適用単位に影響するDirectory構成が確定しているか。
- 16.2：IaCを採用する場合、Root / Shared / 環境Module、Resource管理単位、Dependency、Variable / Output、Provider、環境差分が再現可能な構造か。補助Toolを使う場合の責務分担も明確か。
- 16.3：IaCを採用する場合、External / Reusable Moduleの採用要否を検討し、Project内部Moduleとの比較・組合せを踏まえて判断しているか。採用する場合は、Module、Source、Version、用途・適用範囲、主要DependencyおよびCompatibility上の制約が明確で、再現可能な形で管理されているか。
- 16.4：Stateを管理する場合、単位・環境分離、Backend、Lock、Access、機密情報、Backup / Recovery、State間参照が明確で、変更・復旧に必要なStateを利用できるか。
- 16.5：Kubernetesを採用する場合、Manifest / Chart / Base / Overlay等の管理方式、環境差分、Namespace対応、Application / Platform / 共通Resourceの管理単位が配置設計に一致しているか。
- 16.6：Resource・Technology境界を跨ぐ依存と適用順序が明確で、前提Resource / Outputが成立してから次の構築・設定へ進めるか。図や順序表にも同じ依存が表れているか。
- 16.7：環境別のManual / Pipeline、Trigger、Approval、実行主体、Create / Update / Destroy / Rebuild方式と根拠が明確か。
- 16.8・Pipeline Separation：Infrastructure CI/CDを使う場合、責務・Target・Dependency・Stage・Output・失敗時動作が具体的か。Terraform層とKubernetes層の両方を使う場合、独立して実行・失敗・再実行できるPipelineとし、Terraformの適用・検証完了後にKubernetesを実行可能にしているか。常に一つのPipelineで一括適用する構造になっていないか。
- 16.9：採用Layerごとの適用前後Validation / Testが独立して定義され、対象・時点・Tool / Methodが具体的か。必要なFormat / Lint、Plan / Diff、Policy / Security、Health / Connectivity、Drift検出を確認できるか。
- 16.9・Verification Workload Strategy：Workloadを使う検証が必要な場合、対象とApplication完成時期に応じてTemporary / Actual Workloadを選んでいるか。Infrastructure単独検証を不必要にApplication完成待ちとせず、Temporary Resourceは最小限・Business Logic非模倣・検証後削除としているか。Workloadを用いない場合も、対象Infrastructureの成立性を何によって確認するかが明確か。
- 16.10：Application PipelineへTarget、Registry、Identity、Configuration等を提供する接続とInfrastructure Ready条件が明確か。前提Resource、順序、Trigger関係が18章のContractと一致しているか。
- 16.11：Code経由変更、直接変更の可否、Emergency Change、Drift、Review / Approval、環境Promotion、Codeと実Resourceの整合、Applicationとの同時変更順序を判断できるか。Application Pipeline内部を再設計していないか。

### 17. Environment Lifecycle and Dormancy Strategy

- 17.1：利用目的・頻度、停止許容期間、復元時間、保持すべきData / State、再生成可能性、外部接続、Cost・Availabilityから、環境別Lifecycleの判断根拠を得られるか。
- 17.2：採用Stateの意味・対象・遷移が明確か。不要なStateや全Resource共通の遷移を強制せず、計画的な休眠・再生成と障害復旧を区別しているか。状態図を用いる場合も一致しているか。
- 17.3：環境別のActive / Inactive、Preservation、Restoration方針が17.1の要求に基づくか。prodは常時維持、非本番は削除等を環境名や慣習だけで決めていないか。
- 17.4：ResourceごとのKeep / Stop / Scale Down / Preserve / Destroy / Recreate等のAction、保持対象、再現元、理由が明確で、対象Resourceの実際の制約と両立するか。
- 17.5：Data、Snapshot、State、Artifact、Configuration / Secret / Certificate、DNS、Code等の必要な資産について、保持判断、Source of Truth、復元必須性が明確か。再生成可能なものと失うと復元できないものを区別し、削除対象と保持対象が衝突していないか。
- 17.6：Traffic・Workload停止、State / Data保持、Resource停止・削除、保持物の検証までの順序が実際のDependencyに合っているか。必要な資産を保持する前に破棄する流れになっていないか。
- 17.7：復元元からInfrastructure、Data、Configuration / Secret、Platform設定、Application配置、検証、Traffic再開まで辿れるか。16章の適用単位・Pipelineを利用でき、削除済みのResourceだけに復元元や実行手段を依存していないか。
- 17.8：必要Resource、Health、通信、設定供給、Data、Application、外部接続、観測について、休眠前と同等の利用可能状態へ戻ったことを判断するSuccess Conditionがあるか。Traffic再開前の判断に使えるか。
- 17.9：維持Costと復元Cost / Timeに加え、作業負担、Data Loss・復元失敗Risk、外部依存、利用頻度、Availabilityを踏まえてStrategyを選んでいるか。費用だけで決めず、推定と確認済みの値を区別しているか。

### 18. Application and Deployment Handoff

- 18.1：情報を受け取るApplication / Service / Workload / Pipelineと必要Handoffが特定され、境界を越えて共有すべき情報に限定されているか。
- 18.2：Application Configuration Key、意味、Consumer、Source、環境、機密性がContractとして明確か。Environment固有のEndpoint等の実値を永続的なContractへ固定していないか。
- 18.3：Configuration Sourceを参照する場合、KeyとReference、Naming・環境識別、Consumer、Value Producer、Output登録・更新・反映が対応しているか。再生成後も参照名を可能な限り維持できるか。
- 18.4：Secret / Credentialを利用する場合、Reference、Consumer、用途、環境、Application側Key、供給方式、Rotation時の対応が明確か。Password、Token、API Key、Private Key等の実値を含めていないか。
- 18.5：Resourceごとに必要なHost / Port / URL / Name等の情報種別とSourceが分かり、可能なものは18.2〜18.4のReferenceを通じて利用できるか。
- 18.6：Certificate / CA / Trust情報が必要な場合、Consumer、Reference / Source、用途が明確で、11章の管理・供給方式と整合しているか。実体を文書へ埋め込んでいないか。
- 18.7：上位Deployment Unitごとに環境別Platform / Cluster、Namespace / Target、Deployment Resourceが確定し、7章の配置先と一致しているか。
- 18.8：Application Pipelineに必要なTarget、Registry、Identity / Access、Configuration / Secret Reference、前提Resource、Infrastructure Ready条件を具体的に引き渡せるか。10・11・16章で定義したものと一致しているか。
- 18.9：Consumerに必要な環境差異を一箇所で把握でき、可能な範囲で同一Contractを維持しReference先を分離できるか。実値の複製一覧になっていないか。
- 18.10：全Consumerの必要設定・Output対応・参照・配置先・権限前提が揃っているか。Resource再生成による実値変更と、Key / Reference / Target等のContract変更を区別し、後者では影響Consumerを特定して設計変更として扱えるか。

### 19. Infrastructure Architecture Diagrams

- 19.1：統合図が各章の確定内容を反映し、Environment / Network Boundary、主要Resource、Workload配置、Traffic・Data・外部接続を俯瞰できるか。図だけで新たなDecisionを行っていないか。
- 19.1：Architecture上独立した役割を持つ主要Resourceを原則として網羅し、採用するSecurity、Certificate、Configuration、Observability、Management等も、全体の成立に必要な構成要素として読み取れるか。
- 19.2：Multi-AZを採用する場合、Network、AZ、Public / Private Subnet、Gateway等の配置・接続が5・13章と一致しているか。個別Applicationを抽象化し、配置関係とTraffic方向を混同していないか。
- 環境・Workload種別で構成が大きく異なる場合、必要に応じて図を分け、本文・各章の図との名称、Boundary、接続を一貫させているか。CIDR、IAM、Scaling等の詳細設定を過剰に展開せず、正本へ辿れるか。
- Mermaidを使う図は記法として成立し、矢印・包含・ラベルの意味を読み取れるか。正式な別形式の図を参照する場合は参照先を特定でき、単なる未記入枠になっていないか。

### 20. インフラ設計書全体の妥当性と一貫性

- InfrastructureのProvisioning完了だけを設計上の完成とせず、必要なInfrastructure Validation / VerificationによってApplicationを受け入れ可能な状態であることを確認でき、そのInfrastructure Ready条件と必要なDeployment / Configuration ContractをApplication側へ引き渡せるか。
- 本書全体が、上位で確定したApplication / Service、Integration、Data、Security、Performance、Deploymentの要求を、実行・接続・保護・観測・運用可能なInfrastructureへ変換する成果物として成立しているか。Resourceの羅列や一般的な推奨構成だけになっていないか。
- 上位要求・Workloadから必要Resource、配置、接続、Access、Configuration、Capacity、Healthまでを一続きに追跡できるか。個々の章が妥当でも、同じWorkloadについて全条件を同時に満たす構成が存在しない状態になっていないか。
- Environment・Resource・Application・Data Owner・Deployment Unitの境界が全章で一貫しているか。共有Resource、管理経路、Telemetry、Secret供給等の経路によって、分離・Ownershipの方針が実質的に崩れていないか。
- 構築時だけでなく、通常利用、変更、故障時の復旧、計画的な停止・縮退・削除、再生成後の利用再開までを、必要なCode・State・Artifact・Configuration・Backupから成立させられるか。必要な復元元、権限、実行手段、観測手段に欠落・循環依存がないか。
- Availability、Capacity、Performance、Security、管理Access、Cost、Lifecycleの判断が同時に成立するか。例えば冗長化を表明しながら同一Failure Domainへ集中する、休眠で復元必須資産を失う等の章間矛盾がないか。後続章で分かった制約が関連章へ反映されているか。
- Infrastructureの実体変更・再生成の影響を、安定したConfiguration / Secret ReferenceとDeployment Contractの境界内へ可能な限り閉じ込められるか。Application / Deployment側が基盤内部の動的実値や秘密情報の転記に依存せず利用・配置できるか。
- Infrastructureとして判断可能な事項が実装可能な粒度で確定し、未確定・実測依存の事項は初期値・制約・後続確認として識別できるか。未検証の前提を確定扱いしたり、基盤詳細を別設計へ丸ごと先送りしたりしていないか。
- Applicationの内部仕様・Delivery戦略や別途Data Strategyを再定義せず、基盤側の責務と後続工程へのContractを必要十分に確定しているか。文書とCode / Configurationの正本関係も明確で、後続設計からのFeedbackやContract変更時に影響するSection・Consumerへ辿れるか。

## 特有のレビュー観点についてのレビュー例

以下は観点の適用例であり、特定技術・構成・数値の採用を要求するものではない。

### 良い点の例

- 上位のWorkload・環境別要求から、配置先、通信経路、Identity、必要Configuration、Capacityまで対応を辿れ、構築に必要な具体仕様が揃っている。
- Terraform層とKubernetes層を採用する構成で、独立したPipelineと適用前後の検証が定義され、前提成立後に次のLayerを実行できる。Application未完成時の一時Workload検証と削除も明確である。
- 環境の利用頻度・停止許容・復元時間からResource別の保持・削除を決め、State、Artifact、Secret参照等の復元元を失わずに再生成・再開できる設計になっている。
- 再生成で変化するEndpointの正本をConfiguration Sourceとし、安定したKey / Referenceと更新・反映方式をConsumerへ引き渡している。Secret実値は含めていない。
- Sizingの初期値と根拠、上限、実測後の確認対象が区別され、未検証の値を確定値として扱わずに後続の構築・検証へ接続できる。

### 改善点の例

構築に必要な具体仕様の不足:

- 問題：NetworkとClusterの採用は決まっているが、必要なCIDR、Routeの宛先・Target、Workload配置先が「詳細設計で決定」のままで、構築へ移れない。
- 推奨：上位要求と環境分離方針から本設計で判断できる具体仕様を確定する。実測が必要な値だけは初期値・制約・確認対象として区別する。

接続と権限の不一致:

- 問題：WorkloadからData Storeへの通信がNetwork Connectivity Matrixにある一方、必要な通信制御とResource Accessが定義されず、接続が成立しない。
- 推奨：同一のSource / Destination・Identityについて、5章の経路、10章の許可、11章の設定供給、18章のContractを対応付けて修正する。

Pipelineの責務分離不足:

- 問題：TerraformとKubernetesの変更が常に同一Pipelineで連続適用され、片方だけの変更・検証・再実行ができない。
- 推奨：Layer別の独立Pipelineと検証を定義し、Terraform側の適用・検証完了をKubernetes側の実行前提として接続する。

休眠後に復元できない構成:

- 問題：削除するEnvironment内に復元必須のState・Artifactの唯一の保存先があり、Codeを残しても利用可能な状態を再生成できない。
- 推奨：保持対象とその正本・保存先を削除範囲から区別し、復元元・実行手段・適用順序・成功条件まで確認する。維持Costだけで削除を選ばない。

Handoffの実値への依存:

- 問題：再生成で変わるDatabase EndpointやSecret実値を引渡し文書へ記載し、変更のたびにApplication側の設定修正を要求している。
- 推奨：実値は管理元を正とし、安定したConfiguration Key / Reference、Value Producer、供給・更新方法をContract化する。機密値を文書から除き、参照・取得条件で引き渡す。

章ごとには妥当でも全体が成立しない設計:

- 問題：Availability章では複数Failure Domainへの分散を前提とする一方、Workload配置とCompute Capacityは一つのDomainだけを対象としている。
- 推奨：上位Availability要求から、Network、Compute、配置、Capacity、Health / Failoverを横断して整合させる。本文・表・統合図のすべてへ同じ判断を反映する。

Infrastructure Readyの検証不足:

- 問題：EKS ClusterやNetwork Resourceの作成成功だけをInfrastructure完成としているが、Workload Scheduling、内部通信、Data Store接続等、Application配置に必要な基盤能力が成立することを確認できない。
- 推奨：Application完成状況と検証対象に応じてTemporary / Actual Workload等を利用し、必要なInfrastructure能力を検証する。Temporary Resourceを利用する場合は最小限とし、検証後に削除する。