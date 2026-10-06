# review points

以下のすべてのファイルを一つずつ順にレビューし、全体で一つのレビュー結果およびレポートを生成する。

- `docs/persistent/details/api/*.md`
- `docs/persistent/details/error-codes.md`

レビューは次の方法で行う。

- 開始時に対象ファイルを列挙する。まず`error-codes.md`を全文確認し、その後、API仕様をパス順に一つずつ全文確認する。一部のAPIだけを代表としてレビューしない。
- API仕様には章ごとの観点と「各ファイル内の妥当性と一貫性」を適用する。`error-codes.md`にはError Definition内のエラーコード定義に関する観点と、同文書に適合するファイル内一貫性の観点を適用し、API仕様の章構成を要求しない。
- 全ファイルの確認後、最後に「ファイル間を横断した一貫性」を確認する。エラーコード関連の仕様と`error-codes.md`の照合はError Definitionを主担当とし、横断確認でも結果を参照して同じ問題を重複指摘しない。
- 改善点・指摘には、対象ファイルのProjectルートからの相対パスを必ず明記する。Section、API、Processing Step、Field、Transaction、Error Code等の該当箇所も特定する。
- ファイル間の不整合には、関係するすべてのファイルのパス、各該当箇所、何が食い違うかを記載する。API仕様と`error-codes.md`の不一致なら両方を示す。
- 個別確認と横断確認を一つのレポートに統合し、ファイルごとに別レポートを生成しない。対象一覧と確認状況を記載し、全件を確認できたか分かるようにする。
- API仕様が0件、`error-codes.md`が存在しない、または読み取れないファイルがある場合は、その事実と未確認範囲を明示する。確認できない範囲を「問題なし」と扱わない。

## Review Report Path

全対象ファイルのレビュー結果は以下の一つのファイルに出力する。パスはProjectルートからの相対パスとする。

```text
docs/reviews/api-specification-review-report.md
```

## レビューの前提と適用範囲

- API仕様の内容の正本は当skillの`references/guide.md`とし、既存の`assets/template.md`を構造・記載形式の確認に使用する。
- 1 APIにつき1 Artifactとして、提供Serviceを基準にRequest受付からResponse返却までの内部仕様が実装可能な粒度で定義されているかを評価する。
- Function Design / System Architecture等で確定した目的、Service Boundary、Interface Relationship、Business Rule、Architecture Decisionを前提とし、個別API仕様で再定義していないか確認する。
- Field、Type、Validation、Data Access、Transaction Boundary、処理Logic、Error Contract等は本仕様で具体化する。一方、Table、Internal / External Service等の連携先自体の内部仕様、System全体のFlow、Logging等の横断的な実装Ruleを複製させない。
- `error-codes.md`も参照資料だけでなくレビュー対象とする。既存の定義形式に従ってCodeの意味と関連仕様を確認し、このレビューのために新たな列構成を要求しない。共通定義と個別APIのContractに矛盾がある場合は推測で解決せず、関係箇所を明示する。
- 共通化された処理は専用のCommon Logic Specificationを正とし、呼出元には参照、引数、結果の扱い等の必要仕様があるかを確認する。参照先が対象パターン外でも、呼出Contractの照合に必要な範囲で確認し、対象一覧とは区別する。参照先の全面レビューへ無断で範囲を広げない。
- 対象にCommon Logic Specificationが含まれる場合は、guideに従ってRequestをArgument、ResponseをReturn Value、SamplesをArgument / Return Value Samplesへ読み替える。HTTP Method、Endpoint、HTTP Status等のAPI固有項目は要求せず、対応するInterface・Error仕様として評価する。
- 実際のAPIに適用されるDependency、Data Access、連携等を確認し、参考例の技術や処理を一律に必須化しない。ただしTransactionを使用しない場合も、その旨の明示を確認する。
- 仕様の正本となるSectionを明確にし、他Sectionは同じ定義を参照しているかを確認する。未記入枠、参考例、推測を決定済みの仕様として扱わない。

## 特有のレビュー観点

- Change History
- Summary
- Dependencies
- Request Definition
- Response Definition
- Data Access
- Logic Flow
- Sequence
- Transaction Overview
- Processing Details
- Error Definition（エラーコード定義と整合性を含む）
- Request / Response Samples
- 各ファイル内の妥当性と一貫性
- ファイル間を横断した一貫性

### 0. Change History

- 初回履歴を、レビュー・再レビューを含む作成・確認が完了し、仕様書が確定した時点の1件として扱っているか。確定前のレビューで確定済み履歴を要求していないか。
- 初回確定前のレビュー対応、記載修正、表現改善、誤記修正を個別履歴として記録していないか。
- 初回確定後の正式変更・後続Trainによる変更がある場合、Change、Date、Train、Summaryから対象APIの変更を追跡できるか。

### 1. Summary

- Physical Name、Logical Name、Service、API Type、HTTP Method / Endpoint、Descriptionから対象API、提供Service、公開・利用範囲、目的を識別できるか。
- Serviceが提供Application / MicroServiceの物理名に対応し、Internal / Externalの区分が上位のService Boundary・Interface Relationshipと一致しているか。
- HTTP Method / Endpointが`(METHOD) /path`として具体的で、後続のRequest・処理・Sampleと整合しているか。
- 一つのファイルで一つのAPIを扱い、目的・責務が上位で確定した範囲から拡張・変更されていないか。

### 2. Dependencies

- 実行に必要なConfiguration、接続先、Credential、Database、Storage、File、Messaging等が、Property、用途、必須・任意と対応しているか。処理で使う依存に漏れがないか。
- Typeがデータ型や製品名ではなく、Base URL、Path、Database、Secret等の用途・性質を表す同程度の粒度の分類か。
- Base URLとPathを使う場合、その役割と組合せが明確で、Processing Detailsの接続先定義と一致しているか。
- Property Value / Referenceから固定値か外部参照かを判断できるか。Environmentによって変化するEndpoint・Resource NameやSecret等、外部管理すべき値は原則として安定したReferenceで定義されているか。一方、API Path等の仕様として固定される値まで機械的に外部Reference化することを要求しない。
- Secret、Credential、Token、Password等の機密値を記載せず、取得に使う参照先を定義しているか。上位のConfiguration / Secret Contractとも整合しているか。

### 3. Request Definition

- 受け付けるFieldの名前、Contract上のType、Required、意味が具体的で、Processing Detailsから入力を一意に参照できるか。
- Nested Objectを`parent.child`、Array要素を`field[]`等で表現し、親子関係・要素型を判断できるか。
- Size、Min / Max、Pattern、その他のValidationが適切な対象に定義され、型や相互の制約に矛盾しないか。文字数・配列要素数と数値・日時の範囲を混同していないか。
- 必須・任意と、入力の有無による処理条件が整合しているか。任意Fieldを無条件に参照する等、定義された入力を処理できない箇所がないか。
- Field固有のValidationが上位のRuleを具体化しているか。複数FieldにまたがるBusiness Ruleそのものを独自に変更せず、処理での適用へ接続しているか。

### 4. Response Definition

- 正常時に返却するField、Type、Required、意味と階層・Array要素の構造が明確か。
- 常に含まれるFieldと条件によって含まれないFieldが区別され、`null`許容・空Array・値の変化等の必要な補足があるか。Fieldの省略と`null`を混同していないか。
- Processing DetailsのResponse Mappingから、各Fieldの値と返却条件を追跡できるか。必須Fieldの供給元が欠落していないか。
- Error Responseを正常Responseとして重複定義せず、Error DefinitionとそのMappingへ分離しているか。

### 5. Data Access

- 利用するTableとCRUD、機能上の目的、条件付き操作の補足が明確で、Processing Detailsの実際の操作と一致しているか。
- Create / Read / Update / Deleteの実行有無が`●`・`-`で区別され、記載のないTable更新等が処理に現れていないか。
- Table名とその利用がTable Definition・上位の責務に適合しているか。参照先を確認できない場合、推測で整合と扱っていないか。
- 本節はAPIとTableの利用関係を示し、SQL条件・更新Column・値は9章、Table内部のColumn・Key / Index・ConstraintはTable Definitionを正としているか。
- Data Accessは対象Table / Column、検索・更新条件、値の供給元および取得結果の扱いから実装内容を判断できるかを確認する。SQL全文、Repository / ORMの具体的なClass・Method等、採用実装方式そのものを一律に要求しない。

### 6. Logic Flow

- Request受付から正常ResponseまたはError処理まで、対象APIの主要処理と結果に影響する条件分岐を縦方向に追跡できるか。
- Validation、Data取得・更新、連携等の必要な処理が9章と対応し、主要な分岐・終了経路に欠落がないか。
- 個別SQLやMappingの詳細を別定義せず、System全体のUse Caseや他APIの処理へ範囲を広げていないか。
- MermaidのNode・矢印・分岐条件が記法と意味の両面で成立し、Processing Detailsと同じ流れを示しているか。

### 7. Sequence

- 本APIが処理を完了するために利用する主要Service / Component、Database、External System / ServiceとのInteractionを、提供Serviceから見た順序として理解できるか。
- 自システム内と外部のParticipantが`Our System`・`External`等の境界で区別され、SummaryのServiceとDependenciesの連携先に対応しているか。
- Messageが処理要求・取得Data・処理結果等の意味を表し、具体Payloadや内部Class / Method Callまで過剰に展開していないか。
- Interactionの順序・連携先・結果の扱いがLogic FlowとProcessing Detailsに一致し、本APIの処理範囲外の継続Flowを混在させていないか。
- Mermaidの参加者・Message・境界が解釈可能で、連携先自体の内部仕様を本APIの正本として再定義していないか。

### 8. Transaction Overview

- Transactionの使用有無が明確か。使用しない場合も、その旨が明示されているか。
- 使用する場合、TransactionごとのProcessing Scopeが実在するStep範囲へ一意に対応し、Commit・Rollbackの条件と対象Scopeを判断できるか。
- Boundaryの目的と整合性を保証する対象が明確で、処理順序・更新内容・Error経路と両立しているか。
- 複数Transactionや外部処理がある場合、確定済みの範囲とRollback可能な範囲を区別し、外部処理まで同一Transactionで戻せるかのように曖昧に扱っていないか。
- Boundaryの正本を本節とし、各StepのTransaction表記はその参照になっているか。Transaction外で実行することが重要な処理は9章で明示され、両節が一致しているか。
- 複数のData更新を一体として成立させる必要がある場合、必要な処理が同一Transaction Scopeに含まれているか。逆に、独立して確定可能な処理やExternal Serviceとの通信まで理由なくTransactionを拡大していないか。

### 9. Processing Details

- `Step N`と`N.1`等の番号が一意で、他Stepへの遷移先、分岐、繰返し、終了条件が具体的か。Transaction・Error等から同じStepを参照できるか。
- Request Validationから正常・異常のResponse返却まで、追加の設計判断なく実装できる粒度に具体化されているか。例示のStep構成を機械的に採用していないか。
- Data Accessがある場合、Table・Column、検索条件、値の供給元、必要な更新内容、取得結果の扱いが明確で、5章とTable Definitionに整合しているか。例示の検索条件を並べるだけで実際の条件を曖昧にしていないか。
- Internal / External Serviceを利用する場合、採用Interfaceに応じた呼出先・Method等、Request Mapping、利用するResponse情報、結果による分岐が具体的か。DependenciesのProperty参照と連携先Contractに一致しているか。
- 共通化された処理はCommon Logic Specificationを参照し、引数・戻り値・Errorの扱い等、呼出元として必要な仕様が明確か。切出し済みのLogicを重複定義していないか。
- 複数APIに類似する処理が存在することだけを理由にCommon Logicへの切出しを要求しない。共通化することが上位方針・既存設計・明確な再利用関係から判断できる場合に、専用Specificationとの分離・参照が適切かを確認する。
- Response Mappingが4章のFieldへ対応し、Source / Valueと必要な条件を追跡できるか。Error Response MappingもCode・Message・Validation Message等の返却仕様に一致しているか。
- Errorが発生する条件・判定Logic・遷移先が定義され、Step末尾のErrorが10章へ対応するか。記載するHTTP Statusは外部から受信した値ではなく、本APIがClientへ返却する値か。
- Transactionと関係するStepが8章のTransactionまたはOutsideへ対応し、Commit / Rollback前後の処理が矛盾しないか。
- 条件・Mapping等に適した表や疑似Codeを用い、必要な補足はNoteで明確にしているか。Loggingの具体的な実装・個々のLog内容を本仕様で必須定義させていないか。

### 10. Error Definition

#### APIのError Contractとエラーコードの照合

- 本APIがClientへ公開するError Code、HTTP Status、Error Message、必要なValidation Message、意味を具体的に判断できるか。
- 本APIで公開するCodeに`docs/persistent/details/error-codes.md`の対応する定義があり、Codeの意味・関連仕様が一致しているか。共通定義に発生条件等がある場合は、9章の実際の判定とも整合するか。
- `error-codes.md`にHTTP Status、Error Message、Validation Message、分類、公開範囲等が定義されている場合、APIの返却Contractと一致しているか。差異を許す規則がある場合はその適用条件を確認し、根拠なく片方を優先しない。
- HTTP Statusが、Error発生元のStatusではなく、本APIがClientへ返却する値として定義されているか。External ServiceのErrorから本APIのCode・Statusへの変換を9章と対応付けられるか。
- Error Messageが`errorMessage`、該当するValidation Messageが`validationMessage`へ設定され、非該当のValidation Messageは`-`として区別されているか。
- 9章で発生・返却するErrorに定義漏れがなく、定義されたErrorの意味と利用箇所が対応しているか。発生条件・判定Logic・遷移先を本節で別定義していないか。
- Error Response MappingとSamplesにも同じCode・Status・Messageの仕様が反映され、Sampleだけに未知のContractが現れていないか。
- 外部ServiceのCodeをそのまま本APIの公開Codeとみなしていないか。外部のCodeを内部判定にのみ使う場合まで、共通の公開Codeとして登録することを要求しない。

#### error-codes.md自体の定義

- 全文を確認し、Codeを識別でき、その意味と記載された関連仕様が明確か。同じ識別範囲の一つのCodeに異なる意味を割り当てる等の衝突・重複がないか。
- 同文書内のCode、意味、Message、Status等が矛盾せず、記載された参照先を特定できるか。既存の定義形式にない列や項目を一般論だけで要求していないか。
- 対象APIが公開するCodeに定義漏れがなく、複数APIが同じCodeを利用する場合、その意味と共通Contractを一貫して判断できるか。
- 個別API仕様との不一致がある場合、関係するファイル、Code、項目を特定して指摘できるか。共通定義を無条件に正しいとみなして問題の所在を隠していないか。
- 今回の対象APIで利用しないCodeがあることだけを問題にせず、全APIに全Codeの返却定義や個別Sampleを要求していないか。

### 11. Request / Response Samples

- Request、正常Response、代表的なError ResponseのPayload例が、各DefinitionのField、Type、階層、Required、Validation、返却条件に一致しているか。
- JSON等の採用形式として解釈でき、Sampleだけに新しいFieldや制約を追加していないか。Optional Fieldは理解に有用な範囲で扱われているか。
- `null`、空Array、省略等を使う例がある場合、その扱いがDefinitionに根拠を持つか。
- Error Sampleが10章と`error-codes.md`の定義に整合しているか。すべてのError Codeの個別Sampleを必須としていないか。
- Secret、Credential、個人情報等の実データを使用せず、説明用の値になっているか。

### 12. 各ファイル内の妥当性と一貫性

- 各API仕様が、上位で確定した目的・Service Boundary・Business Ruleを、Request受付からResponse返却までの実装可能な仕様として具体化できているか。
- Requestの制約、Dependencies、Data Access、処理、Response Mappingが一続きに追跡でき、定義された入力から必要な結果を生成できるか。
- Logic Flow、Sequence、Processing Detailsが同じ処理順序・分岐・連携を表し、TransactionのScope・Commit・RollbackとError経路も同時に成立するか。
- Field・Property・Table・Step・Transaction・Code等の識別と意味が全Sectionで一致し、存在しない値・Stepや供給されない結果を参照していないか。
- Error発生から公開Contract・Response Mapping・Sampleまでが整合し、外部Errorと本APIのErrorを混同していないか。共通Codeの照合結果は10章を参照する。
- 仕様の正本がSectionごとに明確で、Sampleや共通処理の重複定義、未記入枠、例示の残存、連携先内部仕様の再定義がないか。
- `error-codes.md`はAPIの内部構成ではなく共通エラーコード定義として、Codeの意味と関連仕様を矛盾なく参照できる文書になっているか。具体的な確認は10章の結果を使用する。

### 13. ファイル間を横断した一貫性

- 全API仕様と`error-codes.md`を確認し、同じAPIを矛盾する内容で重複定義していないか。提供Service、API Type、HTTP Method / Endpointの識別と公開範囲が上位のBoundaryに整合しているか。
- 対象API間の呼出しがある場合、呼出元のRequest Mapping・Response利用・Error変換が呼出先のContractに一致しているか。対象外の参照先は照合に必要な範囲で確認し、未確認と仕様上の誤りを区別しているか。
- 共通の識別子・Field・Code・Property等について意味・型・必須性・制約に説明できない不一致がないか。API固有の目的や契約に基づく差異は認め、同名という理由だけで機械的な統一を求めない。
- 同じTableを利用するAPIのData Access・検索条件・更新値が、Table Definitionと上位のBusiness Ruleに適合しているか。API単位のTransactionを、複数API全体の原子性を保証するものと誤認していないか。
- 共通化された処理が専用Specificationへ分離され、複数の呼出元が同じ引数・戻り値・ErrorのContractを参照しているか。Common Logic内部の定義を呼出元へ複製し、差異を生じさせていないか。
- 10章の照合が全対象APIに及び、同じ公開Codeの意味・Status・Message等が共通定義と整合しているか。外部Serviceから受け取るCode・Statusと、本API群が公開するものの違いを考慮しているか。
- あるAPIや共通定義の変更によって、他APIの呼出し・Mapping・Sample・Error Contractに古い仕様が残っていないか。指摘は関係ファイルと該当箇所をすべて明示し、上位設計やContractを根拠に整合させる方向を示せるか。

## 特有のレビュー観点についてのレビュー例

以下のAPI名・Step・Codeは説明用の仮例であり、採用を要求しない。実際の指摘では確認したファイルと該当箇所に置き換える。

### 良い点の例

- `docs/persistent/details/api/create-order.md`で、Request、Data Access、更新Step、Transaction、正常・異常Responseまで追跡でき、追加の設計判断なく処理を実装できる。
- `docs/persistent/details/api/create-order.md`の公開Errorが`docs/persistent/details/error-codes.md`に一致し、外部ServiceのErrorを本APIのCode・Statusへ変換する条件も明確である。
- `docs/persistent/details/api/get-order.md`が共通処理の正本を参照し、呼出元に必要な引数・結果の扱いだけを定義している。

### 改善点の例

TransactionとStepの不一致:

- 対象ファイル：`docs/persistent/details/api/create-order.md`
- 該当箇所：Transaction Overview、Processing DetailsのStep 3・Step 4
- 問題：OverviewではStep 3終了時にCommitするが、Step 4では同じTransaction内の更新として扱っている。
- 推奨：整合性を保証する更新範囲に基づいてBoundaryを確定し、Stepの参照とCommit / Rollback条件を一致させる。

公開Error Contractの不一致:

- 対象ファイル：`docs/persistent/details/api/create-order.md`、`docs/persistent/details/error-codes.md`
- 該当箇所：Error Definitionと共通定義の`E_SAMPLE_01`
- 問題：共通定義では入力不備を示すCodeだが、APIは外部処理の障害に同じCodeを使用している。
- 推奨：確定済みのErrorの意味と公開Contractを確認し、処理条件、返却Code・Status・Message、Sampleを整合させる。

外部Statusと公開Statusの混同:

- 対象ファイル：`docs/persistent/details/api/create-order.md`
- 該当箇所：External Service呼出StepのError表記、Error Definition
- 問題：本APIは外部の対象なしを内部処理失敗として返す定義だが、Step末尾に外部から受信するStatusをそのまま記載している。
- 推奨：受信Errorの判定と公開Contractへの変換を区別し、StepのError表記を本APIがClientへ返却するStatusへ合わせる。

共通エラーコード定義内の衝突:

- 対象ファイル：`docs/persistent/details/error-codes.md`
- 該当箇所：同一識別範囲の`E_SAMPLE_02`に関する二つの定義
- 問題：同じCodeに異なる意味とMessageが記載され、APIがどちらを返すべきか判断できない。
- 推奨：上位のError方針と確定済みContractに照らして定義を整理し、対象APIの参照・返却仕様も確認する。

呼出元と呼出先のMapping不一致:

- 対象ファイル：`docs/persistent/details/api/create-order.md`、`docs/persistent/details/api/get-product.md`
- 該当箇所：前者の内部API呼出Step、後者のRequest Definition
- 問題：呼出先が必須とする識別Fieldが、呼出元のRequest Mappingに存在しない。
- 推奨：呼出先Contractに対応する入力の供給元を確定し、Mappingと関連する処理・Sampleを整合させる。
