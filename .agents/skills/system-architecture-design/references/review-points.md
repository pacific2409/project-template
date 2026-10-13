# review points

`docs/persistent/system-architecture.md` を以下の観点でレビューする。

## Review Report Path

レビュー結果は以下に出力する。パスはProjectルートからの相対パスとする。

```text
docs/reviews/system-architecture-design-review-report.md
```

## レビューの前提と適用範囲

- 内容の正本は当skillの`references/guide.md`とする。承認済みの`assets/template.md`は成果物の構造・記載形式の確認に使用する。
- System Architecture OutlineとFunction Designを入力とし、確定済みの機能、責務、設計対象間の関係を、正式なSystem / Application Architectureへ具体化できているかを評価する。機能仕様・Business Ruleを再設計していないか確認する。
- 各Section / Subsectionの適用有無は、要求・先行設計・本書の決定から判断する。該当Concernがない項目の省略を欠落とせず、一般論・推測・将来の可能性だけを理由に記載を要求しない。該当Concernが存在するのに省略されている場合は不足として確認する。
- System / Application Architectureとして判断可能な事項は、必要な粒度まで確定しているか確認する。「詳細だから」という理由だけで技術選定や共通Ruleを後続へ先送りしていないかを評価する。
- 個別API・Data・UI・Batchの内部仕様、Infrastructureの物理構成・固有方式、Data Migration・Replication・Backup / Restore・Retention等の戦略、具体的なTest Scenario / Caseは必須要件として要求しない。Application側の構造・要求・制約と、後続設計が決定する実現構成を区別する。
- guideがArchitecture上必要な場合の具体化を認める事項は、一律に詳細すぎると判断しない。例えば共通Ruleとして固定する必要がある設定値や主要Package構成は、必要性と適用範囲を確認する。
- Decisionの主担当Sectionを正とし、関連Sectionの本文・表・図・参照が一致しているか確認する。プレースホルダーや参考例の技術・構造が、未判断の決定事項として残っていないかも確認する。

## 特有のレビュー観点

- Change History
- Architecture Overview
- System Boundary and Context
- Application and Service Structure
- Responsibility, Ownership and Architecture Evolution
- Technology Stack
- Application Architecture
- Dependency Management
- Integration Architecture
- External Service Integration
- Data Persistence Architecture
- Security Architecture
- Performance and Scalability Architecture
- Deployment Architecture and Strategy
- Test Architecture
- Technical Constraints and Architecture Decisions
- システムアーキテクチャ設計書全体の妥当性と一貫性

各章の観点では適用条件を満たす項目を確認し、最後の横断的な観点では文書全体を一つのArchitectureとして評価する。

### 0. Change History

- 初回履歴はレビュー・再レビューを含む設計工程が完了し、文書が確定した時点の1件として扱われているか。確定前のレビュー時に確定済み履歴を要求していないか。
- 確定前のレビュー対応・記載修正・表現改善・誤記修正を個別履歴にしていないか。
- 確定後の正式変更・後続Trainによる変更がある場合、Change、Date、Train、Summaryから変更を追跡できるか。

### 1. Architecture Overview

- 1.1：機能仕様を成立させるSystem / Application構造と技術方式、および後続設計の基準・制約を確定する文書として、目的が明確か。
- 1.2：主要Application / Service、基本構造、主要関係・Pattern、Persistence、外部依存、Deployment Unitのうち該当する事項から全体像を理解できるか。要約が後続章の決定と一致しているか。
- 1.3：重要な特徴が本システムの具体的な構造や後続設計への影響と結び付いているか。一般的な品質特性の列挙になっていないか。
- 1.4：Mermaidの全体構成図からSystem・Application / Service境界、主要Data Store、外部System / Serviceとの関係が分かり、本文・各章の図と整合しているか。個別Flow・Interface仕様やInfrastructure配置を混在させていないか。

### 2. System Boundary and Context

- 2.1：OutlineのSystem Boundaryを前提に、業務・機能領域の対象内・一部・対象外と責務が明確か。一部を担う領域では担当範囲を判別できるか。
- 2.2：外部Systemと分担する領域がある場合、内外の責務の区切りが明確で、連携に必要な責任の欠落・重複がないか。
- 2.3：既存Systemが関係する場合、取込み・併存・置換等の位置づけが明確か。段階的な変更では現在と目標が区別されているか。
- 2.4：MermaidのSystem Contextが本システムを一つの単位として示し、主要Actor・直接関係する外部Systemとの目的・責務を意味的に表しているか。
- この章でApplication内部構造、通信方式、個別Interface、移行・Cutover手順、Network構成を先取りしていないか。

### 3. Application and Service Structure

- 3.1：システムを構成するApplicationの種類、利用者・用途、役割が明確か。同種Applicationを分ける場合、その単位が判別できるか。
- 3.2：同一Applicationに置く責務と独立させる責務が明確で、該当するFrontend / Backendの一体・分離方針が確定しているか。Outline・Function Designと整合しているか。
- 3.3：Backendがある場合、基本構造と適用範囲が明確か。複数Backendで異なる構造を採用する場合、それぞれ定義されているか。
- 3.4：Service / Moduleが特定され、所属Application、構造上の境界、大まかな役割が基本構造と一致しているか。
- 3.5：Mermaidの構成図がApplication・Service / Moduleの包含関係と境界を正しく表し、一覧と一致しているか。
- 内部Layer・依存Rule、責務の詳細・Data Ownership、Integration方式、Infrastructure上のDeployment配置をこの章で重複定義していないか。

### 4. Responsibility, Ownership and Architecture Evolution

- 4.1：Function Designの機能領域が3章の構造単位へ割り当てられ、担当範囲と必要な非担当範囲が明確か。
- 4.2：複数単位が関係する領域について、集約先または分担する役割が明確で、責務の重複・曖昧さがないか。
- 4.3：主要Data領域の生成・変更・整合性に責任を持つOwnerが明確か。他の利用主体とOwnerを区別し、物理Data Store配置と混同していないか。
- 4.4：現在の独立構造と同一構造内の論理分離が区別され、3章の構造と一致しているか。
- 4.5：将来の分割・統合・維持の方向性が現在の構造と区別されているか。変更を見込む場合、対象単位・意図が明確で、根拠のない将来機能や実施計画を追加していないか。
- 4.6：将来変更に備えて維持する責務・Ownership境界が必要な場合、その境界と理由が4.5に対応しているか。現在の配置によって境界が失われないことを後続章からも確認できるか。

### 5. Technology Stack

- 5.1：各Application / ServiceのPlatform、実装言語、Application実行Runtimeが明確で、対象間の違いが判別できるか。
- 5.2：主要Framework・Application Server / Runtimeと用途が確定しているか。Architecture全体に影響する選定理由がある場合、それが明示されているか。
- 5.3：必要なMiddleware・Data Technologyの採用対象、利用主体、用途が明確か。Databaseの場合、種類・Engineが確定しているか。
- 5.4：Application基盤として横断利用する主要Technologyが特定されているか。標準搭載技術でも選択の明示が必要なものを曖昧にせず、局所的Utilityの網羅一覧にもしていないか。
- 5.5：該当するPackaging、Build、SCM、Repository管理、CI/CD、Artifact Build等のTechnology / Platformと適用対象が確定し、13章の利用方式と対応しているか。
- 採用技術・必要なVersion方針が相互に両立し、7章のDependency制約と矛盾していないか。Infrastructure実行基盤・Managed Service構成や具体的なBuild Command・Pipeline YAMLを要求していないか。

### 6. Application Architecture

- 6.1：Pattern名だけでなく、本システムでの解釈・適用範囲・目的が明確か。組み合わせる場合、各Patternの役割が区別されているか。
- 6.2：Application / Serviceごとの主要Layer / Module、役割、含める要素が採用Patternに対応しているか。構造の理解に有効な場合のMermaid図が本文と一致しているか。
- 6.3：各Layer / Moduleが担う責務・担わない責務と、またがる責務の正本が明確か。Function Designの機能やBusiness Ruleを再定義していないか。
- 6.4：構造上許可・禁止する依存方向と、必要なTechnologyへの直接依存Ruleが明確か。Dependency Matrixを用いる場合、本文・図と一致しているか。
- 6.5：該当する共通処理の配置・責務が明確で、Transaction、認証認可、外部Client、Persistence等の専門章の決定と整合しているか。
- 6.6：Package / Module構成と境界を越える参照Ruleが、論理境界をSource Code上でも維持できるものか。Architecture上重要な場合、主要Directory / Packageまで確定しているか。
- Class・Method・全Source Fileの配置を必須化していないか。構造上のDependencyとSoftware Dependency管理を混同していないか。

### 7. Dependency Management

- 7.1：Dependencyの追加・選定・管理・更新・廃止の基本方針と、管理主体・統一範囲が明確か。必要性と既存手段での代替可能性を判断できるか。
- 7.2：Function Design・各Architecture章から必要性が判明した主要Library / SDK / Extension等が洗い出され、用途・利用主体・選定理由と採用可否が確定しているか。可能性だけの依存や全Transitive Dependencyを列挙していないか。
- 7.3：Versionの選定・固定・更新方法が明確か。互換性が重要なDependencyはVersion / Range、Compatibility対象、制約が示され、5章と一致しているか。必要なBOM・Lock File等の統制方針があるか。
- 7.4：Direct Dependencyを明示し、Transitive Dependencyへの暗黙依存を避ける方針があるか。該当する競合・意図しない導入・Security Riskに対する統制と、継続して維持すべきConstraintが明確か。
- 7.5：共有Dependencyがある場合、責務・利用範囲・制限・Versioning・互換性・変更影響の扱いが明確か。共有によってService BoundaryやDomain Ownershipを崩していないか。
- 7.6：更新、脆弱性、EOL、Deprecated、長期未更新、削除等の該当Riskに対する方針が明確か。変更がArchitectureやInterfaceへ与える影響を確認できるか。
- 具体的なBuild設定、Scan基盤、Automation Tool・CI Job、Infrastructure用Dependencyの設計をここで要求していないか。

### 8. Integration Architecture

- 8.1：Function DesignのInterfaceから連携元・先、目的、同期／非同期、採用Styleへ追跡できるか。必要に応じたMermaid図が一覧と一致しているか。
- 8.2：同期／非同期の選択が即時結果・完了待ち・時間的分離・Consumer数・障害隔離・整合性等の該当条件に基づいているか。
- 8.3：API連携がある場合、通信方式と共通Ruleが明確か。Internal / Externalの区別、Ownershipを越える利用、必要なTimeout・Retry・Idempotency方針が整合しているか。
- 8.4：Event / Message連携がある場合、使い分け・Pattern・Coupling・Delivery Semantics・Ordering・重複・失敗・Versioningのうち必要な共通方針が確定しているか。
- 8.5：外部System連携がある場合、Inbound / Outbound方式、外部固有依存・変更・障害から内部を保護する境界方針が明確か。
- 8.6：独立変更・Deployに必要なCompatibility範囲、Breaking Change、Versioning、更新順序、旧Version併存の方針が明確か。
- 8.7：将来の境界変更に関係する場合、4章の方向性に基づいてInterface BoundaryとConsumerへの影響を扱うRuleが定義されているか。
- Function Designの意味的な契約を変更していないか。個別Endpoint・Schema・Payload・Topic / Queue名やInfrastructure接続構成を混在させていないか。

### 9. External Service Integration

- 9.1：Applicationが依存するExternal Service、分類、利用主体、目的が明確か。業務上関係するだけの外部Systemを網羅的に再掲していないか。
- 9.2：外部固有Technology・API・SDK・Data Modelへの依存を隔離する境界が明確で、6章のLayer / Dependency Ruleと整合しているか。
- 9.3：Client / Adapterが担う変換・Error表現・認証処理・変更隔離・切替境界等の責務が明確か。Business RuleやUse Case Logicを持たせていないか。
- 9.4：Serviceごとの障害影響、伝播境界、必要な縮退・Fallback・Retry・障害隔離方針が明確で、Function Designと8章の共通Ruleに一致しているか。具体値はArchitecture全体で固定する必要性があるものに限られているか。
- 9.5：Environmentごとの実Service・代替実装利用が、Cost・Rate Limit・副作用・利用可能性等の制約に対応しているか。Serviceごとの差異を判別できるか。
- 9.6：代替実装を使う場合、共通境界、切替単位・Environment、再現する振る舞い、実Service確認を必須とする範囲が明確か。Mermaid図と本文が同じ切替構造を示しているか。
- 9.7：External AIを利用する場合のみ、共通方針を適用したAI固有のDecision、必要なService / Modelの役割・利用主体・障害隔離等が明確か。AIを使わない場合に本項目を要求していないか。
- SDK Versionは7章と整合しているか。個別Client実装、Prompt・Model Parameter、Stub Response・Test Data、Infrastructure接続・Credential配置を必須化していないか。

### 10. Data Persistence Architecture

- 10.1：Dataの性質・利用方法からPersistence Model / Technologyの適用先と目的が明確で、5章の採用技術と一致しているか。
- 10.2：4章の論理OwnershipがPersistence境界に反映され、他ServiceのAccess範囲が明確か。必要な場合、Database / Schema等の論理分離単位まで確定しているか。
- 10.3：各Application / ServiceのRead / Writeと責務が判別できるか。共有・他Ownerへの直接Accessを許可する場合、その範囲とRuleが明示され、必要に応じたMermaid図とも一致しているか。
- 10.4：Transaction管理単位とUse Case等の対応、複数Persistence・Service境界での扱い、失敗時に維持するAtomicityが明確か。
- 10.5：横断的整合性が必要な場合、Strong / Eventual等の保証範囲、Ownershipとの対応、一時的不整合の許容状態が明確で、8章の連携方式と両立するか。
- 個別Query・個別EntityのORM Mapping・Column等、物理配置・接続構成、Replication・Backup等のData戦略を先取りしていないか。Architecture共通Ruleとして必要な具体設定と、局所的実装設定を区別しているか。

### 11. Security Architecture

- 11.1：System内外のTrust Boundary、信頼前提、必要なSecurity Controlが明確か。必要に応じたMermaid図が既定の構造と一致し、論理的Trust ZoneとNetwork構成を混同していないか。
- 11.2：認証主体・要否・方式・Provider・Boundary、Identity Contextの伝達・Session / Tokenの扱い、該当するAnonymous範囲が明確か。
- 11.3：Authorization Model、Decision Point、Role / Permissionの扱い、必要な情報共有・多層確認が一貫しているか。個別機能の利用可否を再定義していないか。
- 11.4：Service間連携がある場合、Service Identityの認証・認可、User Contextの伝播とIdentityの区別、信頼しない内部境界が8章の方式に整合しているか。
- 11.5：保護対象Data、境界・状態、暗号化・Masking、Log出力・外部送信等の該当方針が、Function Designの保護要求を成立させるか。
- 11.6：Validationを行うBoundary、構文・構造とBusiness Validationの責務、必要な再確認・外部受信Dataの扱いが明確か。
- 11.7：Credentialの利用主体、取得・利用境界、保持・伝播、Environment分離、Rotation対応等の必要なApplication Ruleが明確か。
- Firewall・IAM Policy・Certificate配置・KMS・Secret Store / Injection基盤等のInfrastructure構成を要求せず、Application側の必要条件を引き渡せるか。

### 12. Performance and Scalability Architecture

- 12.1：Function DesignのPerformance要求から重要な対象と実現方針へ追跡できるか。要求値を独自に変更していないか。
- 12.2：Cacheを使う場合、対象・境界・Owner・正本・Hit / Miss・Invalidation・Stale許容範囲が明確で、Ownership・Consistencyと一致しているか。
- 12.3：並列・非同期処理を使う場合、処理単位、完了待ち、独立性、共有Resourceへの負荷、整合性の方針が8章・10章と両立するか。
- 12.4：主要処理特性に応じ、Memory・Connection等の有限Resource、大量Data・長時間占有、依存先負荷に対するApplication側の方針が明確か。
- 12.5：Scale単位とState Model、独立Scaling、Session / Local State、共有Resourceの制約が整合しているか。
- 12.6：Data増加の影響と、必要な取得・処理方式・Batch分割・Access Pattern方針が明確か。
- 12.7：必要な機能拡張基準・分離基準・Extension Pointが既存責務と4章のEvolutionに整合し、未定の将来機能を推測していないか。
- 12.8：想定されるBottleneckに根拠があり、影響範囲と局所化・回避方針が外部依存・Persistence等の決定と一致しているか。
- CPU / Memory割当、Thread / Worker数、Replica数、Autoscaling閾値、Storage Capacity、Retention等を本章の必須決定として扱っていないか。

### 13. Deployment Architecture and Strategy

- 13.1：Build・Release・Deploymentの単位と独立Deploy可否が明確か。独立Deployを求める場合、同時Releaseを不要にする条件があるか。
- 13.2：Artifactの種類・単位・Ownership・Versioning、必要なImmutable性・Promotion方針、Source / Artifact / ReleaseのVersion対応が一貫しているか。
- 13.3：対象別のStage・Trigger・Deploy範囲とBuild / Package方式・Toolが明確か。Artifact形式と生成手段を区別し、複雑な場合のMermaid図やPipeline共有・分離方針が表と整合しているか。
- 13.4：各EnvironmentでのApplication Deploy方式、実行主体・Triggerと理由が明確か。Application / Serviceごとの差異を把握できるか。
- 13.5：Promotion順序、Artifactの同一性・再Build、実行条件、手動／自動、承認境界、Environment固有Configurationの分離が定義されているか。
- 13.6：複数対象の変更に依存がある場合、Service・Frontend / Backend・Schema・Producer / Consumer・外部IF等の適用順序と制約が明確か。
- 13.7：新旧Version共存、Backward / Forward、Schema・API / Event互換性と更新順序の扱いが、8章の互換性方針に一致しているか。
- 13.8：要求するDeploy戦略、停止許容、新旧共存、必要なTraffic切替条件がApplicationごとに明確で、選定理由が要求に対応しているか。
- 13.9：Rollback / Roll-forwardの判断方針と可否、Schema・外部IF変更による制約、復旧後のData整合性、Rollback不能な変更の扱いが明確か。
- 13.10：Deploy後の起動・Readiness・疎通・Smoke・External Service接続等の該当検証範囲がPipelineに対応し、Rollback等の判断に利用できるか。
- Cluster・Registry等のResource、Infrastructure Pipeline、接続認証設定、Data復旧方式、個別Test Caseを先取りしていないか。

### 14. Test Architecture

- 14.1：採用Test Levelごとに保証範囲、実物として組み合わせるComponent、代替するDependency、責務が明確か。不要なLevelを形式的に採用していないか。
- 14.2：既定のArchitecture Boundaryを前提に、独立したTest Boundaryと検証責務が明確で、単一Testへ過度に責務を集中させていないか。
- 14.3：該当するService・Data Store・同期／非同期・Transaction / Consistency・認証認可のIntegrationを、どの実Componentの組合せと方式で検証するか明確か。
- 14.4：Contract Testが必要な場合、対象BoundaryとProvider / Consumerの互換性・Breaking Change検出方針が、8章・13章の独立変更・Deploy方針を支えているか。
- 14.5：外部依存がある場合、Test Level / Environmentごとの実物・代替利用、実Service確認の必須範囲、Cost・Rate Limit・副作用、固有Failure検証が9章と一致しているか。
- 14.6：Test Doubleを使う場合、種類・目的・適用先・共通Interfaceが明確で、Production LogicへTest専用実装が侵入しない構造か。必要な実Dependencyとの確認が失われていないか。
- 14.7：判断可能な主要Framework / Toolが用途・適用先とともに選定され、Software Dependencyとして導入するものが7章へ反映されているか。
- 14.8：依存差替え、非決定性の分離、独立起動、Data初期化、結果・状態の観測等の必要なTestabilityが確保され、構造変更が6章・9章等へ反映されているか。
- Test Levelと13章のPipelineが対応しているか。具体的なScenario / Case、Data・Fixture、Mock応答値、操作手順、Infrastructure Test基盤を必須化していないか。

### 15. Technical Constraints and Architecture Decisions

- 15.1：外部・既存Systemからの技術制約について、根拠、影響Concern、遵守事項が明確か。Interface本文や移行手順の再定義になっていないか。
- 15.2：Platform・Runtime・Support Version・Environment等から生じる制約とArchitectureへの影響が明確か。5章の技術一覧を再掲するだけになっていないか。
- 15.3：採用技術の互換性・利用方式・License・Support等が選択可能な方式を制限する場合、制約と影響範囲が明示されているか。
- 15.4：横断的に重要なDecision、理由、影響範囲、後続設計で維持する条件が明確か。単一Concern内の決定を網羅的に再掲していないか。
- 15.5：全体への影響・再検討可能性が大きい判断について必要な場合、採用案・主要不採用案・不採用理由から判断Contextを理解できるか。別章に十分記録済みの場合に重複記載を要求していないか。
- 15.6：後続のApplication Detail Design・Infrastructure Architecture・Data Strategy・Test Design等へ渡す横断的制約が、適用先と遵守事項に対応しているか。各章参照で十分なRuleを再掲したり、後続で決める事項を先取りしたりしていないか。

### 16. システムアーキテクチャ設計書全体の妥当性と一貫性

機能設計を実現可能な技術構造へ具体化し、後続設計が共通して従う基準を確立する文書として、各Concernを組み合わせたArchitecture全体が成立するかを確認する。

- **機能仕様から技術構造へのつながり**：OutlineとFunction Designの境界・責務・関係が、Technology、内部構造、Integration、Persistence、Security、Deployment、Testへ追跡可能に具体化されているか。採用構造のために機能上の意味や制約を暗黙に変更していないか。
- **境界とOwnershipの実効性**：SystemからApplication / Service、内部Layer、Persistence、外部依存まで、責務と依存方向が一貫しているか。共有Library・Data直接Access・Client配置など、別章の決定によって宣言した独立性やOwnershipが崩れていないか。
- **方式を組み合わせた成立性**：同期／非同期、Transaction / Consistency、Retry・重複対策、Cache、並列処理、障害隔離が組み合わさったときにも機能仕様と品質要求を満たせるか。各章単体では妥当でも、結果の即時性・Atomicity・Access制御等の前提が互いに矛盾していないか。
- **技術・依存・制約の両立**：採用Platform・Runtime・Framework・Middleware・Library / SDK・Toolと、外部制約・Version条件・Layer Ruleが両立しているか。ある章が必要とする技術・Dependencyが一覧や採用判断から抜けていないか。
- **変更・Deploy・復旧の一貫性**：独立Deploy、Interface互換性、Schema変更順序、新旧共存、Artifact Promotion、RollbackとData整合性が同時に成立するか。現在と将来の構造を区別し、維持するEvolution Boundaryが実際の依存・Interface構造に反映されているか。
- **Environment・検証方針の整合**：Environment別の外部Service利用、代替境界、Test Level、Pipeline、Deploy後検証が一致しているか。必要な実Service・互換性の確認がすべて代替実装へ置き換わるなど、Architecture上の保証に抜けがないか。
- **後続設計へ渡す前提の充足**：本設計で決定すべきTechnology・Structure・Ruleが確定し、本設計から後続工程へ引き継ぐべき構造・特性・Boundary・Constraintを推測せずに読み取り、それを前提としてApplication Detail Design・Infrastructure Architecture・Data Strategy・Test Designを具体化できるか。Application側の要求・制約と後続の実現方式の境界が一貫し、重要なArchitecture判断を先送りしていないか。
- **文書全体の収束**：要約・図・表・本文が同じArchitectureを表し、用語・構造単位・Ruleの参照先が一意か。後段で判明した制約・Testability・Delivery上の条件が前段にも反映され、相反するDecisionや例示の残存がないか。

## 特有のレビュー観点についてのレビュー例

以下は表現例であり、対象にない技術・構造・要求を追加する根拠にはしない。

### 良い点の例

**✅ 強み**

- ServiceのData OwnershipがPersistence境界と他ServiceのAccess Ruleへ反映され、論理責任と技術的な利用関係が一致している。
- 外部SDKがClient境界へ隔離され、実Service・代替実装が共通境界を使うため、内部Layer RuleとEnvironment別Test方針が両立している。
- Artifact形式とBuild方式が区別され、Environment間のPromotion、互換性条件、Rollback判断まで一貫している。
- 採用Test Levelが実物・代替の範囲を明示し、独立Deployを支えるInterface互換性確認がPipelineへ対応付けられている。

### 改善点の例

**⚠️ 改善が必要な点**

OwnershipとPersistence利用の矛盾：

- 問題：あるServiceがData変更の唯一のOwnerとされる一方、別Serviceが無制限に直接更新する構成になっている。
- 推奨：許可するAccess範囲と変更・整合性責任を確定し、Ownership、Integration、Persistenceの定義を一致させる。

外部依存とLayer Ruleの不整合：

- 問題：Domainから外部技術への直接依存を禁止しているが、外部SDKの利用主体がDomainとされている。
- 推奨：外部固有依存を担う境界と内部Interfaceを具体化し、Layer Rule、Client責務、Dependency Inventoryを整合させる。

独立Deployの成立条件不足：

- 問題：Serviceを独立Deploy可能としながら、Provider変更時にConsumerの同時更新が必須となっている。
- 推奨：必要な互換性・新旧共存と適用順序を確定し、独立Deploy可能な範囲およびContract Test方針を一致させる。

技術選定の先送り：

- 問題：必要性が明らかな主要Test Frameworkが「実装時に選定」とされ、Test方式とDependencyの前提が確定していない。
- 推奨：本設計でFrameworkを選定し、適用Test範囲、採用Runtime等との互換性、Dependency管理へ反映する。

実Service確認の欠落：

- 問題：実Serviceとの互換性確認を必須としているが、すべてのTest Level / EnvironmentがStub利用になっている。
- 推奨：Cost・副作用等の制約を踏まえて実Service確認を行う範囲を定め、Environment利用、Test方針、Pipelineの対応を整える。

後続設計との責務混在：

- 問題：ApplicationのScale特性が不明なまま、Replica数だけがArchitecture方針として記載されている。
- 推奨：Scale Unit、State Model、共有Resourceへの制約を本書で確定し、具体的なResource構成・Scaling設定はInfrastructure Architectureへ引き渡す。
