
## **Design Policy**

- Function DesignおよびSystem Architectureで確定したApplication / Service構造、Environment Requirement、Integration、Persistence、Security、Performance、Deployment等を前提としてInfrastructureを設計し、それらのApplication Architecture上のDecisionを本設計で再定義しない。
- Infrastructure Architectureについて基本設計と詳細設計を別Artifactに分割せず、Infrastructureとして判断可能な事項は、詳細度を理由に後続工程へ先送りせず、本設計で実装可能な仕様まで決定する。
- Environment SeparationをInfrastructure全体の基本Boundaryとして先に確定し、Network、Compute、Data、Security、Configuration等の各Architectureへ一貫して反映する。
- Infrastructure Resourceについて、TechnologyやResourceの採用だけでなく、その責務、配置、接続、Security、Capacity、AvailabilityおよびEnvironmentごとの差異まで明確にする。
- Application / WorkloadをInfrastructureへ配置する際は、System Architecture上のApplication / Service / Deployment Boundaryを維持し、Infrastructure都合によってその責務境界を崩さない。
- Infrastructure Resource間のDependencyを明確にし、Provisioning、ConfigurationおよびDeliveryを再現可能な順序として設計する。
- Terraform等によるCloud Infrastructure層とKubernetes Resource層は独立した変更・適用単位として扱い、それぞれを独立して実行・失敗・再実行可能なDelivery Pipelineとして設計する。
- Infrastructureは常時維持することを前提とせず、Environmentの用途、利用頻度、State保持要件、再生成可能性、復元時間およびCost等からLifecycle Strategyを導出する。
- Environmentを停止・縮退・削除する場合は、Infrastructure Code、State、Configuration、Artifact、Backup等の必要なPreserved Assetから利用可能な状態へ再生成できることを前提として設計する。
- InfrastructureからApplicationへEnvironment固有の実値を直接固定的に引き渡すことを避け、可能な限りConfiguration Store / Secret Store等の安定したReferenceをContractとして利用する。
- Secret / Credential等の機密値を設計書やHandoff Artifactへ記載せず、管理元、Referenceおよび供給方式を定義する。
- Infrastructure構築後に生成されるEndpoint等の実値は適切なSource of Truthで管理し、Infrastructure再生成によって実値が変化してもApplication側のConfiguration Contractを可能な限り維持する。
- Application Detail Designで、本設計の前提では要求を満たせない新たなInfrastructure Requirementが判明した場合は、Infrastructure ArchitectureへのFeedbackとして再設計し、必要な関連Sectionへ変更を反映する。
- 各Section / Subsectionは対象Projectに該当するInfrastructure Concernが存在する場合のみ記載し、該当事項がない内容を一般論や推測によって埋めない。


## **Key Points for Design**

- Infrastructure全体を、Environment → Resource → Network → Compute → Workload Placement → Data / Messaging → Traffic → Security → Configurationという依存関係を意識して設計し、各Section間のDecisionを整合させる。
- dev / stg / prod等について、Environment名だけを理由に構成を決めず、目的・Isolation Requirement・Security・Availability・Cost等から共有 / 分離Boundaryを導出する。
- Cloud Resourceを単に列挙せず、System Architecture上のどのApplication / Service / Workload / Architecture Requirementを成立させるためのResourceなのかを追跡可能にする。
- Network Architectureでは必要なConnectivityを確定し、Infrastructure SecurityではそのConnectivityおよびResource Accessを必要最小限のControlとしてEnforceする。
- Compute / Container Platformでは実行基盤となる器を定義し、Application and Workload PlacementでSystem Architecture上のApplication / Service / Batch等を具体的な実行基盤へMappingする。
- System ArchitectureのData Persistence / IntegrationをDatabase、Cache、Object Storage、Queue / Broker等の具体的なInfrastructureへ落とし込み、Data OwnershipおよびEnvironment Boundaryと整合させる。
- Application Trafficについて、Network ReachabilityとTraffic Routing / Distributionを区別し、Load Balancer、Ingress、API Gateway、CDN、DNSおよびExternal Connectivityを責務に応じて設計する。
- CPU / Memory、Replica、Node、Instance、CapacityおよびScalingについて、要求・初期Sizing・実測による調整を区別し、設定値には可能な限り根拠を残す。
- Availabilityでは冗長化、Failure Domain、Failover、HealthおよびRecoveryを一貫して設計し、意図的なEnvironment休眠・削除とは区別する。
- ObservabilityではMetrics / Logs / Tracesの生成元からCollector、Backend、Visualization、AlertingまでのTelemetry Flowを明確にし、Infrastructure Healthとの責務を区別する。
- Infrastructure Code、State、Kubernetes ConfigurationおよびInfrastructure Pipelineについて、Environmentごとの差異とDependencyを明確にし、同一構成を再現可能にする。
- Terraform層とKubernetes層を独立したDelivery Pipelineとして扱いつつ、Terraformによって必要なPlatformが成立した後にKubernetesを適用するDependencyを維持する。
- Environment Lifecycleでは、Keep / Stop / Scale Down / Destroy / Preserve / Recreate等をResourceごとに判断し、Costだけでなく復元時間、State、再生成Cost、Risk等とのTrade-offからStrategyを決定する。
- Environmentを破棄可能とする場合は、「Codeがあるから復元できる」と仮定せず、Preserved AssetからInfrastructure・Applicationを再生成し、利用可能な状態まで戻せることをVerification対象とする。
- Application / Deployment Handoffでは実値の受け渡しではなくConfiguration / Deployment Contractを中心とし、Parameter Store等の安定したReferenceを介してInfrastructureとApplicationを疎結合にする。
- 全Sectionを一度設計した後に横断的な整合性を再確認し、後続Sectionで判明したConstraintやDependencyを関連Sectionへ反映してInfrastructure Architecture全体を収束させる。