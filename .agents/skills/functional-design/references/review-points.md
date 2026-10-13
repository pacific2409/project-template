# review points

`docs/persistent/function-design.md` を以下の観点でレビューする。

## Review Report Path

レビュー結果は以下に出力する。パスはProjectルートからの相対パスとする。

```text
docs/reviews/functional-design-review-report.md
```

## レビューの前提と適用範囲

- 内容の正本は、当skillの`references/guide.md`とする。`assets/template.md`は成果物の構造を確認するために参照する。
- 要求定義および先行するSystem Architectureの基本方針と照合し、要求や決定済みの境界を本書で再定義していないか確認する。
- 各Section / Subsectionの適用有無は、要求、先行設計、本書で確定した内容から判断する。該当事項がない項目の省略を欠落として扱わず、一般論や将来の可能性だけを理由に記載を要求しない。一方、該当する設計対象や関係があるのに省略されていないか確認する。
- 複数の設計対象の関係を成立させる仕様は、詳細度にかかわらず本書で確定している必要がある。後続設計者が、対象間の責務・関係・制約・振る舞いを推測せずに個別設計へ進めるかを評価する。
- 単一対象の内部仕様、具体的な技術・実装方式、Application内部のLayer、Infrastructure、Deployment / Delivery、個別Test Caseを必須要件として要求しない。これらを本書で決定していないかも確認する。
- 仕様の主担当Sectionを正とし、他Sectionの記述・表・図・参照との整合性を確認する。後段で特定された対象が前段の機能構造や一覧から漏れていないか、同一仕様の重複定義や矛盾がないかも確認する。
- templateのプレースホルダーや図の記入例が、実際の設計判断を経ずに決定事項として残っていないか確認する。

## 特有のレビュー観点

- Change History
- Functional Overview and Scope
- Functional Decomposition
- Logical System Structure
- Use Cases
- Components and Responsibilities
- Business Rules
- Functional Flows
- Data Overview
- Interface Overview
- UI and User Interaction Overview
- Error and Exception Behavior
- Non-Functional Requirements per Function
- Functional Verification Strategy
- Detailed Design Handoff
- 機能設計書全体の妥当性と一貫性

以下の各観点では、対応するSectionの適用条件を満たす項目についてチェックポイントを確認する。最後の横断的な観点では、該当するSectionを通して文書全体を評価する。

### 0. Change History

- 初回履歴は、レビュー・再レビューを含む機能設計工程が完了し、文書が確定した時点の1件として扱われているか。確定前のレビュー段階で、確定済み履歴の存在を要求していないか。
- 確定までのレビュー対応・表現改善・誤記修正を個別履歴にしていないか。
- 確定後の正式変更や後続Trainによる変更がある場合、Change、Date、Train、Summaryから変更の時点・所属Train・概要を追跡できるか。

### 1. Functional Overview and Scope

- 1.1：対象システム・機能群が実現すること、ユーザーや他システムへの価値・役割、対象機能領域が明確か。個別機能への分解と混同していないか。
- 1.2：業務・機能領域、ユーザー操作、システム処理、外部連携のうち該当する範囲が、要求と整合しているか。API等の個別設計対象を列挙する節になっていないか。
- 1.3・1.4：今回の対象、将来対応予定・候補、システムの責務として扱わない領域が区別され、要求で合意した位置づけを維持しているか。未決定事項を対象外とみなしていないか。
- 1.5：利用・起動・関与するActorと概要レベルの役割が明確か。詳細な操作・権限・Interface・Flowをここで定義していないか。
- 1.6：前提・仮定は機能設計全体に影響するものか。個別機能の事前条件、要求・仕様、Architecture上の決定、未解決事項の暫定仮定を混在させていないか。

### 2. Functional Decomposition

- 2.1：対象要求から必要な機能が導かれ、機能領域・機能・必要なサブ機能の親子関係を階層リストで把握できるか。後続設計で独立した責務として扱える粒度か。
- 2.2：各機能の所属領域、目的・責務、実現することが簡潔かつ一意に理解できるか。階層にある機能と説明が対応しているか。
- 2.3：要求と機能の対応を、一対多・多対一も含めて追跡できるか。設計対象要求の漏れや、要求または要求を成立させる設計上の必要性に根拠を持たない機能追加がないか。
- Application / Service / Componentへの割当、API・Batch等の設計対象、処理順序、Business Rule、入出力項目、技術的なModule構造をこの節へ混在させていないか。

### 3. Logical System Structure

- 3.1：先行Architectureで決定済みのApplication / Service / Module等を前提に、今回必要な論理構成要素と機能設計上の役割が整理されているか。境界・責務を独自に変更していないか。
- 3.2：2章の各機能領域について、主担当の論理構成要素と関連要素を把握できるか。領域を横断する関係が抜けていないか。
- 3.3：Mermaidの論理構成図が一覧・機能配置と整合し、システム内部と外部、利用・機能連携の関係を読み取れるか。
- 図や本文へ、具体的な通信方式、Request / Response、Data内容、内部Layer、Infrastructure上の配置を混在させていないか。

### 4. Use Cases

- 4.1：対象機能について、Actorがシステムを利用して達成する目的、開始条件、正常終了時の結果が明確か。
- Actorは1.5、実現する機能は2章と対応し、目的と結果が一致しているか。
- Use Caseが処理手順やComponent間のSequenceに置き換わっていないか。具体的な画面操作・入出力・単一設計対象の内部仕様へ踏み込んでいないか。

### 5. Components and Responsibilities

- 5.1：機能を成立させる主要Componentと独立処理単位が特定され、種類、所属Application / Service、責務が明確か。2章の機能と3章の論理構造から配置・必要性を理解できるか。
- 5.2：各Componentの責務と関連Componentとの関係が明確で、責務の重複・欠落や曖昧なOwnershipがないか。
- 5.3：Batchが存在する場合、目的・責務、起動契機、意味的な入出力、主要処理、Online処理・Data・他Batchとの関係が把握できるか。5.1の一覧や後続Sectionと対応しているか。
- API・Screen・Tableの専用一覧を重複して定義していないか。Component内部のClass / Method / Layerや、単一BatchのJob / Step・Cron式・Retry回数・排他制御等を必須化していないか。

### 6. Business Rules

- 6.1：判断・許可・禁止を決める条件と結果が明確か。複数条件が組み合わさる場合、必要に応じたDecision Table等で、該当条件から結果を一意に判断できるか。
- 6.2：全体として一貫性を保証すべき計算・分類・集約・導出について、適用条件、使用情報、業務上の計算・導出方法、結果の意味が明確か。
- 6.3：複数対象にまたがる業務・機能制約が定義され、Data・UI・API等が共通の制約を参照できるか。
- 6.4：状態を持つEntity・機能がある場合、取り得る状態、契機・条件、遷移先、許可・禁止が明確か。複数の状態・遷移がある場合、Mermaidの`stateDiagram-v2`と遷移表が整合しているか。
- 複数SectionでRuleを再定義していないか。Field単体の形式Validation、内部Algorithm、Database制約の実装、Enum・状態更新API、UI内部状態等を混在させていないか。

### 7. Functional Flows

- 7.1：各Use Caseの目的を達成する正常系のStepが、Actor・Componentを横断して追跡できるか。結果を左右する主要分岐・代替Flowがある場合、それらが明示されているか。
- 7.1：主要な条件分岐を図示する必要がある場合、Mermaidの`flowchart`が本文と6章のRuleに整合しているか。
- 7.2：MermaidのSequence Diagramから、関与するActor / Component、相互作用の順序、要求・応答の意味、主要Data、必要な分岐を理解できるか。7.1のFlowと一致しているか。
- 7.3：複数Componentや後続処理へ影響する代替・例外Flowがある場合、発生条件、処理の変化、最終結果が明確か。共通の異常時振る舞いは11章の定義と一致しているか。
- 単一Component内部の処理、Method呼出し、Endpoint・HTTP Method・Schema・Status、通信方式を機能Flowとして定義していないか。

### 8. Data Overview

- 8.1：機能・Use Caseで扱う主要Domain Object / Entity / 永続データが特定され、表す情報と役割を共通理解できるか。
- 8.2：Data間の依存・関連、Cardinality、必須・任意、所有関係、関係成立に必要な制約が明確か。6章のBusiness Rulesと矛盾していないか。
- 8.3：Mermaidの`erDiagram`が8.2の関係・多重度を正しく表し、主要Entity間の関係を俯瞰できるか。
- 8.4：必要なMaster Dataがある場合、その目的、利用領域、他Data・機能との関係が明確か。
- 関係を成立させるために必要な仕様を曖昧にしたまま詳細設計へ送っていないか。一方、Column一覧、物理型、Index、内部実装のPK / FK、Masterの個別Code・値等を要求していないか。

### 9. Interface Overview

- 9.1：Component / Systemの境界を越えて必要となるInterfaceが特定され、種類、Provider / Producer、Consumer、機能上の目的が明確か。5章・7章の関係や相互作用と対応しているか。
- 9.2：APIが必要な場合、提供元・利用元・目的と、意味的なInput / Outputが、Component間の関係を判断できる粒度で記述されているか。
- 9.3：Event / Messageが必要な場合、Producer、Consumer、発生・送信目的、受渡し情報の意味が明確か。Consumerが複数の場合、それぞれの利用目的を追跡できるか。
- 9.4：外部連携がある場合、外部System、Interface、方向、内部担当Component、目的、情報の意味、内外の責務境界が明確か。
- 概観と種別ごとの記述が一致し、同一仕様を重複して再定義していないか。Endpoint、Protocol、Schema、Payload、配信保証、Retry、Broker、Network経路等を本書の必須仕様として扱っていないか。

### 10. UI and User Interaction Overview

- 10.1：画面を持つ場合、必要な画面、対象Actor、目的、利用可能にする機能が特定され、Use Caseと対応しているか。
- 10.2：画面間遷移がある場合、遷移元・先、契機・条件、遷移結果が明確か。画面数や遷移が複数ある場合、Mermaidの`stateDiagram-v2`が遷移表と整合しているか。
- 10.3：画面間で引き継ぐ情報がある場合、その意味、引渡し元・先、目的が明確で、遷移先の機能を成立させられるか。
- 10.4：複数画面に影響する操作がある場合、影響先と必要な振る舞い・制約が明確か。6章のRuleを再定義せず、一貫して適用しているか。
- 単一画面のレイアウト、Field、UI Component、色・Typography、内部表示制御、Routingや情報保持の技術方式へ踏み込んでいないか。

### 11. Error and Exception Behavior

- 11.1：主要Error / Exceptionが、後続処理やユーザーへの結果を区別する意味的な単位で分類されているか。
- 11.2：分類・発生条件ごとに継続・中断・代替処理と結果が明確か。複数Componentにまたがる場合、各ComponentやDataが到達・維持すべき状態を判断できるか。
- 11.3：ComponentをまたぐErrorについて、発生元、検知・対処責任、伝達先、伝播する意味、最終結果を決めるComponentが明確か。
- 11.4：ユーザー操作に影響する場合、認識させる結果と利用可能にする操作、必要な画面間・処理間の振る舞いが明確か。
- 7章の例外Flow、10章のInteraction、12章の継続要求と矛盾していないか。Error Code、Exception Class、Retry回数、Transaction実装、Message文言・表示方式を必須化していないか。

### 12. Non-Functional Requirements per Function

- 12.1：該当するPerformance / Capacity要求が対象機能・処理と対応し、適用条件・範囲が明確か。可能な場合、Response Time・Throughput・同時利用数・処理件数等の測定可能な基準が示されているか。
- 12.2：該当するSecurity / Access要求が対象機能・Data・Component間関係と対応し、複数Screen・API・Dataで一貫した利用制限・保護を求めているか。
- 12.3：該当するAvailability / Continuity要求が、通常時・依存先障害時等の条件と対応しているか。必要なRecovery・Data Loss許容等が明確で、11章の振る舞いと一致しているか。
- 12.4：その他の品質要求がある場合、分類・対象・要求が明確か。機能との対応を必要としないProject全体の方針を混在させていないか。
- 要求定義との対応が保たれ、根拠のない目標値や新規要求を追加していないか。Cache・Scaling・認証方式・暗号方式・Backup構成等の実現手段をここで決定していないか。

### 13. Functional Verification Strategy

- 13.1：機能、Use Case、Rule、Flow、状態遷移等の検証対象と、何を確認できれば正しいと言えるかが対応しているか。
- 13.2：複数Component・Data・Interface・UIで成立する機能について、対象間の関係そのものを保証する観点が導かれているか。
- 13.3：定義済みの代替Flow、Rule違反、依存先障害、禁止遷移等のうち該当する振る舞いを検証対象に含めているか。
- 13.4：12章の要求のうち機能検証で確認すべきものが対応付けられ、確認すべき充足条件が理解できるか。
- 検証観点が本書の仕様に根拠を持ち、後続Test Designへ展開できるか。個別Test Case、入力値・Test Data・具体的な期待値、実行手順、負荷条件、Tool・Mock・環境を要求していないか。

### 14. Detailed Design Handoff

- この章で引き渡されるAPI / Batch / Screen / Table等が、対応する前段Sectionで特定・定義された設計対象から導出されており、この章で初めて新たな設計対象が出現していないか。
- 14.1：本書で特定した設計対象のうち、個別Detail Designを必要とするものが漏れなく引き渡されるか。対象、設計種別、機能上の役割、定義元Sectionが対応しているか。
- 14.2：各対象・種別で維持すべき確定済みの責務、関係、Rule、制約、振る舞いが明確で、正本を参照できるか。引継ぎ欄で仕様を変更・再定義していないか。
- 14.3：後続判断を要する事項がある場合、Function Designでは意図的に決定しないことが適切な事項に限られ、その理由とArchitecture / Detail Designの判断先が明確か。該当事項がない場合の省略は妥当か。
- 要求の不明点、本設計で決めるべき対象間仕様、設計矛盾が先送りされていないか。個別内部仕様や技術方式まで確定させることを引継ぎの完了条件にしていないか。

### 15. 機能設計書全体の妥当性と一貫性

個々のSectionが整っていることに加え、要求をシステム全体の機能構造・機能仕様へ具体化し、後続設計の前提を確定する文書として成立しているかを確認する。

- **要求から実現する機能までのつながり**：対象要求が機能へ分解され、該当するUse Case、Component、Rule、Flow、Data、Interface、UIの関係を通して実現されることを文書全体から説明できるか。個別の一覧には漏れがなくても、それらを組み合わせると達成できない要求や、根拠のない設計対象が残っていないか。
- **機能としての成立性**：Use Caseの開始から結果に至るまで、必要な処理主体・情報・責務がそろい、定義済みの制約のもとで協調できるか。正常系だけでなく、該当する代替・異常系や状態変化も含め、要求する結果とDataの状態、ユーザーに認識させる結果が両立しているか。
- **複数の表現間の一貫性**：機能階層、配置、責務一覧、各種図、Flow、入出力の意味、状態・関係制約が、同じシステムを矛盾なく表しているか。同じ名称が異なる対象・責務を指していないか、異なる名称が同じ対象を重複定義していないか。後段で具体化された内容が前段にも反映されているか。
- **機能要求と品質要求の両立**：機能ごとの非機能要求が、利用条件、Access、依存先障害時の振る舞い等と整合しているか。例えば、継続を求める機能が同じ条件のFlowでは必ず中断するなど、複数Sectionを合わせると要求を満たせない構造になっていないか。
- **全体設計としての決定範囲**：要求と先行Architectureの基本方針を維持しつつ、設計対象間の関係を成立させる判断が確定しているか。詳細設計へ委ねるべき内部仕様との区別が文書全体で一貫し、対象間の未決定事項を個別設計者へ押し付けたり、内部仕様の先取りによって全体の関係を曖昧にしたりしていないか。
- **検証と後続設計への接続**：確定した機能仕様から検証観点・保証範囲とDetail Design対象が導かれ、System Architecture、Infrastructure Architecture、Dependency Planning、各Detail Design、Test Designで必要な機能上の前提を読み取れるか。後続工程で対象間の責務・依存・振る舞いを再発見・再決定しなければ進めない欠落がないか。

## 特有のレビュー観点についてのレビュー例

以下は表現例であり、対象文書に存在しない設計対象や要求を追加する根拠にはしない。

### 良い点の例

**✅ 強み**

- 要求と機能の一対多の対応が明示され、各機能の責務と後続のComponentへの割当を追跡できる。
- Data間の必須関係・多重度が表と概念ER図で一致し、個別Columnの設計へ進む前提が確定している。
- 外部依存先の失敗時に、処理を中断するComponent、維持するDataの状態、ユーザーが再実行できる範囲が一貫している。
- APIのProvider / Consumerと意味的な入出力が明確で、具体的なSchemaを決めずにAPI Detail Designへ引き渡せる。

### 改善点の例

**⚠️ 改善が必要な点**

要求と機能の対応漏れ：

- 問題：設計対象の要求に対応する機能がなく、その要求を実現する範囲を追跡できない。
- 推奨：要求に対応する機能と責務を確認し、Functional Hierarchy・Description・Traceabilityの対応を整える。

Data間の関係の曖昧さ：

- 問題：二つのEntityが関連するとだけ記載され、関係が必須か任意かを後続設計者が判断できない。
- 推奨：機能・Business Ruleに照らしてCardinalityと関係制約を確定し、表と概念ER図へ反映する。

異常時の振る舞いの不整合：

- 問題：Functional Flowでは外部処理失敗時に継続するとされる一方、Error Handling Behaviorでは同じ条件で中断するとされている。
- 推奨：適用条件と機能上の結果を確定し、共通の異常時振る舞いと各Flowの参照を一致させる。

対象外の詳細化：

- 問題：API Overviewに具体的なEndpoint・Schema・HTTP Statusが定義されている一方、利用元と受渡し情報の意味が不明確になっている。
- 推奨：本書ではProvider / Consumerと情報の意味を確定し、契約の内部仕様はAPI Detail Designで扱う内容として整理する。

本設計の責務の先送り：

- 問題：画面間で引き継ぐ情報が未確定のまま、すべてUI Detail Designで判断するとされている。
- 推奨：画面間関係の成立に必要な情報と目的を本書で確定し、その保持・引渡しの技術方式を詳細設計へ委ねる。
