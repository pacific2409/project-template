## **Design Policy**

- System Architecture Outlineで事前に確定したSystem Boundary、Application / Service境界、Responsibility / OwnershipおよびArchitecture Evolutionの方針を正式なSystem Architectureへ統合する。
- Function Designで確定した機能仕様および設計対象間の関係を前提とし、それらを成立させる技術Architectureを設計する。
- System / Application Architectureとして判断可能な事項は、詳細度を理由に後続工程へ先送りせず、本設計で決定する。
- 各Architecture Concernについて、その構造、責務、Boundary、Rule、Technologyおよび後続設計を拘束するConstraintを必要な粒度まで確定する。
- 同一のArchitecture Decisionを複数Sectionで重複して定義せず、そのDecisionを主として扱うSectionを正とし、関連Sectionでは必要に応じて参照する。
- Technologyの選定だけでなく、そのTechnologyをどのBoundary・責務・Ruleのもとで利用するかまでArchitectureとして明確にする。
- Application / Service内部のArchitectureとInfrastructure Architectureを区別し、Application側で要求する構造・特性を本設計で定義したうえで、そのInfrastructure上の実現を後続設計へ引き継ぐ。
- 現在のArchitectureだけでなく、将来の分割・統合等を想定して維持すべき論理境界を明確にする。ただし、根拠のない将来拡張を推測して過剰設計しない。
- 各Section / Subsectionは対象Projectに該当するArchitecture Concernが存在する場合のみ記載し、該当事項がない内容を一般論や推測によって補完しない。


## **Key Points for Design**

- System BoundaryからApplication / Service、Application内部構造まで、Architecture上のBoundaryとResponsibilityを一貫させる。
- Responsibility / Ownership、Integration、Persistence、Security、Deployment等の各Architecture Concernで、Application / Service境界を崩すDecisionが生じていないことを確認する。
- Technology Stack、Library / Dependency、Integration Technology等について、採用Technologyだけでなく、用途、適用範囲、CompatibilityおよびLifecycle上の制約を明確にする。
- Application ArchitectureではArchitecture Patternの名称だけを決定せず、Layer / Moduleの責務、Dependency DirectionおよびDependency Ruleまで具体化する。
- Integration ArchitectureではFunction Designで特定されたInterfaceを技術的な連携方式へ具体化し、同期 / 非同期、API / Event / Message、Version Compatibility等の共通Ruleを確立する。
- External Serviceへの依存は明確なBoundaryで隔離し、障害、Environment差異、Test Doubleへの切替等を含めてApplication内部への影響を制御する。
- Data Persistence、Security、Performance / Scalability等の横断Architectureは、個別機能だけでなくSystem全体のBoundaryおよび他のArchitecture Concernとの整合性を考慮して設計する。
- Application / ServiceごとのBuild、Artifact、Release、Deployment、Compatibility、RollbackおよびApplication Delivery Pipelineを、独立Deployabilityを考慮して設計する。
- Test Architectureでは各Architecture Boundaryを検証可能にし、Unit / Integration / Contract / E2E等の責務分担とTestabilityをArchitectureとして確保する。
- Technical Constraintsおよび重要なArchitecture Decisionを明確にし、後続設計や将来のArchitecture変更時に維持すべきGuardrailを残す。
- 各Architecture Concernを一度設計しただけで完了とせず、全Sectionを設計した後に横断的な整合性を再確認し、後続Sectionで判明した制約やDecisionを関連Sectionへ反映してArchitecture全体を収束させる。
