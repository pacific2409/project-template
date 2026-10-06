# review points

以下のすべてのファイルを一つずつ順にレビューし、全体で一つのレビュー結果およびレポートを生成する。

- `docs/persistent/details/batch/*.md`
- `docs/persistent/details/error-codes.md`

レビューは次の方法で行う。

- 開始時に対象ファイルを列挙する。まず`error-codes.md`を全文確認し、その後、Batch仕様をパス順に一つずつ全文確認する。一部のBatchだけを代表としてレビューしない。
- Batch仕様には章ごとの観点と「各ファイル内の妥当性と一貫性」を適用する。`error-codes.md`にはError Definition内のエラーコード定義に関する観点と、同文書に適合するファイル内一貫性の観点を適用し、Batch仕様の章構成を要求しない。
- 全ファイルの確認後、最後に「ファイル間を横断した一貫性」を確認する。エラーコード関連の仕様と`error-codes.md`の照合はError Definitionを主担当とし、横断確認でも結果を参照して同じ問題を重複指摘しない。
- 改善点・指摘には、対象ファイルのProjectルートからの相対パスを必ず明記する。Section、Batch、Job / Step、Processing Step、Transaction、Error Code等の該当箇所も特定する。
- ファイル間の不整合には、関係するすべてのファイルのパス、各該当箇所、何が食い違うかを記載する。Batch仕様と`error-codes.md`の不一致なら両方を示す。
- 個別確認と横断確認を一つのレポートに統合し、ファイルごとに別レポートを生成しない。対象一覧と確認状況を記載し、全件を確認できたか分かるようにする。
- Batch仕様が0件、`error-codes.md`が存在しない、または読み取れないファイルがある場合は、その事実と未確認範囲を明示する。確認できない範囲を「問題なし」と扱わない。

## Review Report Path

全対象ファイルのレビュー結果は以下の一つのファイルに出力する。パスはProjectルートからの相対パスとする。

```text
docs/reviews/batch-specification-review-report.md
```

## レビューの前提と適用範囲

- Batch仕様の内容の正本は当skillの`references/guide.md`とし、既存の`assets/template.md`を構造・記載形式の確認に使用する。
- 1 Batchにつき1 Artifactとして、実行開始から正常終了・異常終了までの内部仕様が実装可能な粒度で定義されているかを評価する。
- Function Design / System Architecture等で確定した目的、Service Boundary、Interface Relationship、Business Rule、Architecture Decisionを前提とし、個別Batch仕様で再定義していないか確認する。
- Input / Output、Data Access、Execution Control、Transaction Boundary、処理Logic、Error等は本仕様で具体化する。一方、Tableや連携先Service自体の内部仕様、System全体のFlow、Logging等の横断的な実装Ruleを複製させない。
- `error-codes.md`も参照資料だけでなくレビュー対象とする。既存の定義形式に従ってCodeの意味と関連仕様を確認し、このレビューのために新たな列構成を要求しない。共通定義と個別Batchの仕様に矛盾がある場合は推測で解決せず、関係箇所を明示する。
- 共通化された処理は専用のCommon Logic Specificationを正とし、呼出元には参照、引数、結果の扱い等の必要仕様があるかを確認する。参照先が対象パターン外でも、呼出Contractの照合に必要な範囲で確認し、対象一覧とは区別する。参照先の全面レビューへ無断で範囲を広げない。
- 対象にCommon Logic Specificationが含まれる場合は、InputをArgument、OutputをReturn Valueへ読み替え、章番号ではなくSectionの役割に対応させて評価する。Trigger、Execution Mode、Execution Control、Job / Step Structure、前後続Batch等の呼出元Batchに属する項目は要求しない。
- 実際のBatchに適用されるInput / Output、Dependency、Data Access、連携等を確認し、参考例の技術や処理を一律に必須化しない。ただしTransactionを使用しない場合も、その旨の明示を確認する。HTTP StatusやClient Response等のAPI固有項目をBatch共通の必須項目としない。
- 仕様の正本となるSectionを明確にし、他Sectionは同じ定義を参照しているかを確認する。未記入枠、参考例、推測を決定済みの仕様として扱わない。

## 特有のレビュー観点

- Change History
- Summary
- Dependencies
- Input Definition
- Output Definition
- Data Access
- Logic Flow
- Sequence
- Execution Control
- Transaction Overview
- Processing Details
- Error Definition（エラーコード定義と整合性を含む）
- 各ファイル内の妥当性と一貫性
- ファイル間を横断した一貫性

### 0. Change History

- 初回履歴を、レビュー・再レビューを含む作成・確認が完了し、仕様書が確定した時点の1件として扱っているか。確定前のレビューで確定済み履歴を要求していないか。
- 初回確定前のレビュー対応、記載修正、表現改善、誤記修正を個別履歴として記録していないか。
- 初回確定後の正式変更・後続Trainによる変更がある場合、Change、Date、Train、Summaryから対象Batchの変更を追跡できるか。

### 1. Summary

- Physical Name、Logical Name、Service、Trigger Type、Execution Schedule、Descriptionから対象Batch、所属Service、起動方法、目的を識別できるか。
- Serviceが所属Application / MicroServiceの物理名に対応し、責務と連携範囲が上位のService Boundary・Interface Relationshipと一致しているか。
- Schedule、Manual、Event等のTrigger Typeが実態に合い、定期実行では時刻・周期、非定期実行ではExecution Scheduleの`-`等から適用有無を判断できるか。
- 一つのファイルで一つのBatchを扱い、目的・責務が上位で確定した範囲から拡張・変更されていないか。

### 2. Dependencies

- 実行に必要なConfiguration、接続先、Credential、Database、Storage、File、Messaging等が、Property、用途、必須・任意と対応しているか。処理で使う依存に漏れがないか。
- Typeがデータ型や製品名ではなく、Base URL、Path、Database、Secret等の用途・性質を表す同程度の粒度の分類か。
- Base URLとPathを使う場合、その役割と組合せが明確で、Processing Detailsの接続先定義と一致しているか。
- Property Value / Referenceから固定値か外部参照かを判断できるか。Environmentによって変化するEndpoint・Resource NameやSecret等、外部管理すべき値は原則として安定したReferenceで定義されているか。一方、仕様として固定される値まで機械的に外部Reference化することを要求しない。
- Secret、Credential、Token、Password等の機密値を記載せず、取得に使う参照先を定義しているか。上位のConfiguration / Secret Contractとも整合しているか。

### 3. Input Definition

- 実行開始時または処理中に外部から受け取るParameter、File、Object、Message等が識別され、Input Type、Source、必須・任意、Format / Definition、用途を判断できるか。
- SourceがDependenciesのPropertyや参照先と対応し、どこから何を受け取るかが曖昧でないか。
- 単純なInputは型・形式、構造を持つInputは項目定義または定義への参照から、Processing Detailsで必要な値とその解釈を特定できるか。
- 必須Inputの欠落や不正な形式に対する処理がProcessing Detailsにあり、任意Inputの省略時の扱いが実装上曖昧でないか。
- DBから読み取る業務DataをInputとして重複定義せず、Data AccessとProcessing Detailsへ整理しているか。外部Inputがない場合は不要な定義を要求しない。

### 4. Output Definition

- 外部へ生成・送信するFile、Object、Message等が識別され、Output Type、Destination、Format / Definition、用途を判断できるか。
- DestinationがDependenciesのPropertyや参照先と対応し、どこへ何を出すかが曖昧でないか。
- Outputの構造・形式と各値の取得元・生成方法が、定義への参照およびProcessing Detailsを通じて追跡できるか。
- 正常時、対象Dataがない場合、途中失敗時等、実際に存在する分岐でOutputを生成・送信する条件と結果の扱いが明確か。
- DBへの登録・更新・削除をOutputとして重複定義せず、Data AccessとProcessing Detailsへ整理しているか。外部Outputがない場合は不要な定義を要求しない。

### 5. Data Access

- 利用TableとC / R / U / Dの対応、PurposeがProcessing Detailsの実際の操作と一致しているか。操作の漏れや使われない操作がないか。
- 条件付きで行う操作がある場合、その条件をNoteや処理への参照から判断できるか。
- Data AccessはBatchとTableの利用関係を示し、具体的な抽出・更新条件はProcessing Detailsに集約されているか。
- Column、Key、Index、Constraint等のTable自体の定義を複製・再定義せず、必要なTable Definitionを参照しているか。
- Data Accessでは対象TableとC / R / U / Dの利用関係を確認し、具体的なTable / Column、抽出・更新条件、値の供給元および取得結果の扱いはProcessing Detailsから実装可能な粒度で判断できるかを確認する。SQL全文、Repository / ORMの具体的なClass・Method等、採用実装方式そのものを一律に要求しない。

### 6. Logic Flow

- MermaidのFlowから、開始、実行条件・Inputの確認、対象Data取得、主要な分岐・反復、連携・更新、結果確定、正常終了・異常終了を実際の処理に応じて追えるか。
- 分岐条件と遷移先が明確で、主要な失敗経路や対象Dataがない場合の経路がProcessing Detailsと矛盾していないか。
- Execution Controlの実行・継続・中断方針と整合し、実行されないStepや到達できない終了状態を作っていないか。
- 対象Batchの内部Flowに範囲を絞り、別Batchの内部処理やSystem全体のUse Caseを混在させていないか。詳細条件の正本はProcessing Detailsになっているか。

### 7. Sequence

- Batchを中心に、必要な起動元、Internal Service / Component、Database、External Serviceとのやり取りが識別できるか。直接・間接の呼出関係を必要な範囲で追えるか。
- `Our System`と`External`等の区分が上位の境界と一致し、呼出順序、送受信するData・結果がProcessing Detailsと一致しているか。
- ScheduleやMessaging等を起動に使用する場合、Triggerとの関係がSummary・Execution Controlと一致しているか。
- 連携の意味を理解できる粒度であり、Payloadの全項目や内部Classの呼出一覧へ過度に詳細化していないか。対象Batchに関係しない連携を含めていないか。

### 8. Execution Control

#### Execution Properties

- Execution Modeの同期・非同期が、Batch内部の処理方式ではなく、起動元から見た実行方式として明確か。
- Execution Conditionが実行の前提条件を表し、Summaryを正とする起動時刻・周期と混同・重複していないか。条件未成立時の扱いを処理から追えるか。
- Expected Execution TimeとExpected Volumeが対応し、通常量・最大量や想定負荷の前提から、期待時間がどの条件に対するものか判断できるか。性能試験等が未実施の場合、実測による達成確認までは要求せず、設計上の前提・目標と実測結果を混同しない。
- Concurrent Executionの可否が明確で、共有Data・Outputに対する処理がその方針と両立するか。禁止する場合は重複起動時の扱い、許可する場合は処理競合の扱いが必要な範囲で具体化されているか。
- Restartの可否とRestart Pointが整合し、再開時にどこまで完了済みとして扱うかをProcessing Details・Transactionと対応づけられるか。再実行不可のBatchに再開方式を一律に要求しない。
- 再実行を許可する場合、確定済みのDB変更・外部送信・Outputをどう扱うかが明確で、再開位置によって意図しない二重処理や処理漏れが起きる仕様になっていないか。必要な処理について再実行時のIdempotencyを判断できるか。
- Predecessor Batch / Successor Batchが識別可能で、存在しない場合は`-`等により明確か。前後続との実行条件・引継ぎがProcessing Detailsと一致しているか。
- Predecessor Batch / Successor Batchには、本Batchと直接の実行依存関係を持つBatchを記載しているか。Batch Chain全体の依存関係を個々のSpecificationへ重複して展開することを要求しない。
- Retry / Skip / Continue / Abortを用いる場合、その条件、適用範囲、Retry上限等の必要な方針がExecution Controlにあり、個別Stepへの適用がProcessing Detailsに示されているか。

#### Job / Step Structure

- Job / Step、Type、Execution Condition、On Success、On Failureから、実行順序と各単位の役割を判断できるか。
- Job / StepとProcessing DetailsのStepの対応を追え、成功・失敗時の遷移先、終了・中断・再開可能な位置が矛盾していないか。
- 一部の対象・Stepが失敗しても継続する場合、最終的な正常終了・異常終了の判定が曖昧でないか。実行全体の制御と個別Step内部のLogicを混在させていないか。

### 9. Transaction Overview

- Transactionを使用するかが明確で、使用しない場合もその旨が明示されているか。
- 使用する各Transactionについて、Processing Scopeが実在するStepと対応し、Commit・Rollbackの契機、範囲、境界の目的と保証する整合性が具体的か。
- Processing DetailsのTransaction指定と一致し、開始前・Commit後の処理を同じTransaction内として扱う等の矛盾がないか。
- 複数Transactionや反復処理を用いる場合、処理単位ごとの確定範囲と途中失敗時に残る結果が、Restart Pointや継続方針と両立するか。
- 外部呼出やFile / Message出力等、Rollbackだけでは取り消せない処理を区別し、失敗・再実行時の扱いが必要な範囲でProcessing Detailsにあるか。すべての外部処理に同一の補償方式を要求しない。

### 10. Processing Details

- Stepを一意に識別でき、実行条件・Inputの確認から結果確定・終了まで、順序、分岐条件、反復対象・終了条件、遷移先が実装可能な粒度か。
- Inputや取得Dataから判定・計算に必要な値を追え、抽出・更新のTable、Column、Condition、Value等が具体的か。Batchの入力元を曖昧なRequest等で代用していないか。
- 対象Dataがない場合や任意Inputがない場合等、定義された入力・取得結果の範囲に対応した処理があり、後続Stepが未取得の値を使用していないか。
- 外部連携を行う場合、採用方式に応じた接続先・操作、送信値のMapping、必要な返却値、結果判定と後続処理が明確か。RESTやgRPC等の参考例を一律に必須化しない。
- Common Logicを呼ぶ場合、参照先、Argument、Return Value、失敗時の扱いが明確で、共通処理の内部仕様を呼出元に複製していないか。
- Job / Stepの実行単位と内部の処理Stepが対応し、Retry / Skip / Continue / Abortの適用点・遷移先がExecution Controlの方針に従っているか。Retryの上限到達後も処理を追えるか。
- 結果の集約、Outputの生成・送信、必要な後続Batchへの引継ぎ、正常・異常終了の判定がOutput DefinitionとExecution Controlに従っているか。
- Errorが起こり得るStepでは発生条件とError Codeへの対応が明確で、共通のError Handlingへ渡す場合も発生元のCodeや必要な情報が失われていないか。
- 各StepのTransactionまたはOutsideの扱いを追え、重要なTransaction外の処理が明示されているか。Noteには補足を置き、実装を左右する条件を曖昧な注記だけに残していないか。


### 11. Error Definition

#### BatchのError仕様とエラーコードの照合

- Error Code、Error Message、Descriptionから、各Errorの意味を一意に理解できるか。発生条件の正本はProcessing Details、Retry / Skip / Continue / Abortの方針の正本はExecution Controlとなっているか。
- Processing Detailsで参照するError Codeに定義漏れがなく、Error Definitionだけに存在するCodeには当該Batchでの用途を確認できるか。同じCodeを複数Stepで使用すること自体を不備としない。
- 当該Batchで使用する共通Error Codeが`docs/persistent/details/error-codes.md`に定義され、Code、意味、Error Messageその他共通定義に存在する関連仕様と一致しているか。
- Messageの可変部分や個別補足を許容する場合、共通定義の規則に沿い、同じCodeを異なる意味に流用していないか。不一致は双方のパスと該当Codeを示す。
- 連携先が返すError CodeとBatch自身が扱うError Codeを区別し、変換・引継ぎがある場合はProcessing Detailsから対応を追えるか。連携先だけで使うCodeまで無条件にBatchの共通Codeとして登録・定義させない。
- 共通一覧のすべてのCodeを各Batchに記載することや、Batchに適用されないHTTP Status等の仕様を要求していないか。

#### error-codes.md自体の定義

- 定義されたCodeの識別範囲が明確で、その範囲内で同一Codeが矛盾する意味・Messageを持っていないか。説明から類似Codeを使い分けられるか。
- Code、意味、Message等、同文書が管理する項目が相互に整合し、参照や適用条件に未解決の矛盾がないか。
- 個別Batchの使用実態と照合して、共通定義としての意味が崩れていないか。他のAPI・UI等だけで使うCodeがBatchで未使用であることを理由に不要と判定しない。
- 未定義・重複・不一致を見つけた場合は、根拠となるファイルと箇所を明記し、個別仕様と共通定義のどちらを変えるかを推測だけで決定していないか。

### 12. 各ファイル内の妥当性と一貫性

- Batchの目的・性質に照らし、起動から正常終了・異常終了までの責務が一つの文書として実装可能か。章単位では記載があっても、処理のつながりや判断の根拠が欠けていないか。
- Summaryの目的・起動条件、Input / Output、Data Access、Flow・Sequence、Execution Control、Transaction、Processing Details、Errorが同じBatchの振る舞いを表しているか。
- 同時実行、途中失敗、Retry、再実行、部分的なCommit・外部送信を組み合わせたときも、定義した実行方針と結果が両立するか。単独の項目では見えない二重処理・処理漏れ・終了判定の矛盾がないか。
- 用語・識別子・Property・Table・Step・Transactionの参照が一致し、正本Sectionと補足・図の間に重複定義や食い違いがないか。
- 上位設計や連携先の責務を侵食せず、未決事項・適用外・参照先を区別できるか。必須判断が未記入や参考例のまま残り、実装者に新たな設計判断を委ねていないか。
- Common Logic Specificationや`error-codes.md`には、それぞれの成果物の目的・性質に沿って全体の妥当性と一貫性を確認し、Batch固有の章や実行制御を要求しない。

### 13. ファイル間を横断した一貫性

- 全対象の個別レビュー後、BatchのPhysical Name、所属Service、責務、参照関係に識別不能な重複や矛盾がないか。複数Batchの内部実装を一律に統一させる観点にしない。
- 前後続関係があるBatch同士で、起動条件・完了条件・引継ぎ先が一致しているか。片方の異常終了や部分成功をもう片方が正常完了として扱う等の食い違いがないか。
- 受け渡すFile / Object / Message等がある場合、出力側の形式・生成条件・出力先と入力側の形式・必須条件・取得元が対応し、処理対象や必要なDataを引き継げるか。
- 同じTableや出力先を扱い実行が重なり得るBatch同士で、対象範囲、更新の役割、Concurrent Execution・Restart等の前提が衝突していないか。関連のないBatchに同一制御方式を要求しない。
- 共通Dependency、共通Logic等を参照する複数ファイルで、同じ識別子が異なる意味を持たず、呼出Contract・結果の解釈が一致しているか。意図した差異は適用条件から説明できるか。
- Error Definitionで行った共通Codeとの照合結果を踏まえ、複数Batchが同じCodeを相反する意味で使用していないか。共通Codeでも、明示された個別事情に基づくRetry等の差異まで不整合としない。
- 不整合は関係するすべてのファイルのパスと該当箇所を示し、個別確認の指摘と統合する。関係先を確認できない場合は未確認範囲を明記し、推測で整合済みとしない。
- 複数Batchに類似する処理が存在することだけを理由にCommon Logicへの切出しを要求しない。共通化することが上位方針・既存設計・明確な再利用関係から判断できる場合に、専用Specificationとの分離・参照が適切かを確認する。

## 特有のレビュー観点についてのレビュー例

以下のパス・Batch名・Codeは説明用の仮例であり、必須の仕様や命名規則ではない。

### 良い点の例

- `docs/persistent/details/batch/daily-export.md`のExecution Control、Transaction Overview、Processing Detailsで、再開位置と確定済み対象の扱いが対応している。途中失敗後も、出力済みの対象を重複送信せず残りを処理する仕様を追跡できる。
- `docs/persistent/details/batch/daily-export.md`のError Definitionにある`BATCH_SOURCE_UNAVAILABLE`が、`docs/persistent/details/error-codes.md`の同Codeと意味・Messageで一致し、Processing Detailsから発生条件、Execution ControlからRetry上限後の異常終了を確認できる。

### 改善点の例

- `docs/persistent/details/batch/daily-export.md`のExecution Controlは先頭からの再実行を許可しているが、Processing DetailsのStep 4では送信済み対象を判別せず再送信する。再実行時の重複送信が許容されるか不明なため、確定済み結果の扱いと再開方式を整合させる必要がある。
- `docs/persistent/details/batch/daily-export.md`のJob / Step StructureはStep 2失敗時にAbortとしている一方、Processing Detailsの対応Stepは失敗対象をSkipして処理を継続する。適用条件の区別がなく、Batchの最終結果も変わるため、実行方針と遷移を一致させる必要がある。
- `docs/persistent/details/batch/daily-export.md`のError Definitionは`BATCH_SOURCE_UNAVAILABLE`を「出力形式不正」としているが、`docs/persistent/details/error-codes.md`の同Codeは「入力元に接続できない」を表す。発生条件を含めて確認し、Codeと意味の対応を揃える必要がある。
- `docs/persistent/details/batch/daily-export.md`のOutput DefinitionはCSV出力を定義しているが、後続の`docs/persistent/details/batch/daily-import.md`のInput Definitionは同じFileをJSONとして読み込む仕様になっている。変換処理の定義もないため、受渡し形式と両者のProcessing Detailsを整合させる必要がある。
