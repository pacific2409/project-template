# Discussion Guide

## 目的と観点

- 目的：Function Designに必要な、最小限のSystem Architectureの骨子を決める。
- 利用場面：後のFunction Designで、画面・API・Batch・Data・Event・外部IF・機能フローを配置する「箱」を定める。
- 対象範囲：System Boundary、Application Structure、Backend / Service Structure、Architecture Evolution、Responsibility & Ownershipの5項目。
- 重視する観点：境界・構成・責務について、具体的な選択肢を提示して議論できる論点にする。個別機能や連携フロー、技術・実装の詳細には踏み込まない。
- 対象外：具体的な機能・画面・API・Batch・Data・Event・外部IFの設計、それらの連携・処理フロー、技術スタック、Application内部のレイヤーや依存ルール、具体的な通信方式、Infrastructure構成、Deployment方式、個別仕様、実装方式、テスト仕様。以下で扱うService / Module境界やData Ownershipは、機能領域単位の骨子に限定する。

## 選択肢の提示方法

- 各Topicを使う際は、プロダクトの前提とそれまでの決定を踏まえ、実際の領域名・Application名などを入れた具体案を提示する。括弧内は案を作るための観点や例であり、固定の選択肢ではない。
- 複数の領域・境界に適用するTopicは、対象を一つずつ取り上げる。各案は同じ対象・同じ判断軸で比較できるものにする。
- 選択肢は3案程度を目安とするが、二択が自然な場合や前提上成立する案が限られる場合は、水増ししない。選択肢の違いを示すために対象外の技術・個別仕様へ踏み込まない。

## **Overview**
- System Boundary
- Application Structure
- Backend / Service Structure
- Architecture Evolution
- Responsibility & Ownership

## Decision Topics by Perspective

### System Boundary

- 本システムの責務に含める業務・機能領域の範囲（候補となる領域ごとに、全体を含めるか、一部を含めるか、含めないか。一部の場合は含める範囲を明示した案で比較する）
- 外部システムと分担する領域の責務境界（該当する領域ごとに、本システムが担う範囲と外部に委ねる範囲の区切り方を比較する）
- 関係する既存システムの位置づけ（本システムに取り込むか、外部システムとして併存させるか、置き換えるか）

### Application Structure

- システムを構成するApplicationの種類の組合せ（プロダクトに必要なWeb・Mobile・Desktop・CLI・Backendなどの組合せを、構成案として比較する）
- 同じ種類のApplicationを分ける単位（利用者・用途が異なる場合に、一つにまとめるか、利用者別・用途別に分けるか）
- FrontendとBackendのApplication境界（同一Applicationとして扱うか、別Applicationとして扱うか。Frontendを持たない構成の場合は該当なし）

決定結果はApplication一覧として整理し、各Applicationの範囲と大まかな位置づけを記す。Frontend / Backend以外も含め、システム全体のApplication境界が読み取れる形にする。

### Backend / Service Structure

- Backendの基本構造（Monolith・Modular Monolith・Microservicesなど、Service / Moduleへの分割をどの形で持つか）
- Service / Moduleを分ける境界（関連する業務・機能領域を取り上げ、一つにまとめる案と、具体的な区切りで分ける案を比較する。各案には分けた単位の大まかな役割を示す）

### Architecture Evolution

- 想定した境界を今回どこまで構造として分けるか（境界ごとに、今回から別Application / Serviceに分けるか、同じApplication / Service内の論理的な区分に留めるか）
- 各領域の将来の構造変更の方向性（対象領域ごとに、現状維持・分割・統合の案を比較する。分割先や統合先を示して違いを明確にする）
- 将来の構造変更に備えて維持する責務の論理境界（同じApplication / Service内に置く領域について、将来の分割単位で責務を区別するか、現在の単位にまとめておくか）
- 将来の構造変更に備えて維持する論理境界（必要な領域について、管理責任を将来の分割単位で区別するか、現在の単位にまとめておくか。データの物理的な配置は扱わない）

### Responsibility & Ownership

- 各機能領域の担当先（領域ごとに、どのApplication / Service / Moduleに割り当てるか、担当先の候補を比較する。決定結果から各単位が担当する範囲・担当しない範囲を明確にする）
- 責務が重なる領域の分担方法（該当領域ごとに、一つの担当先に集約する案と、役割を区切って分担する案を比較する。集約先または分担の区切りを明示する）
- 各機能領域のData Ownership（Function Designの前提として必要な領域ごとに、どのApplication / Service / Moduleにデータの管理責任を置くか、所有先の候補を比較する）
