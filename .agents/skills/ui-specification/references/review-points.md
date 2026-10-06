# review points

以下のすべてのファイルを一つずつ順にレビューし、全体で一つのレビュー結果およびレポートを生成する。

- `docs/persistent/details/view/*.md`
- `docs/persistent/details/error-codes.md`

レビューは次の方法で行う。

- 開始時に対象ファイルを列挙する。まず`error-codes.md`を全文確認し、その後、画面仕様をパス順に一つずつ全文確認する。一部の画面だけを代表としてレビューしない。
- 画面仕様には章ごとの観点と「各ファイル内の妥当性と一貫性」を適用する。`error-codes.md`にはError Presentation内のエラーコード定義に関する観点と、同文書に適合するファイル内一貫性の観点を適用し、画面仕様の章構成を要求しない。
- 全ファイルの確認後、最後に「ファイル間を横断した一貫性」を確認する。エラーコード関連の仕様と`error-codes.md`の照合はError Presentationを主担当とし、横断確認でも参照して同じ問題を重複指摘しない。
- 改善点・指摘には、対象ファイルのProjectルートからの相対パスを必ず明記する。Section、Screen、Component、Interaction / Step、Error Code等の該当箇所も特定する。
- ファイル間の不整合には、関係するすべてのファイルのパス、各該当箇所、何が食い違うかを記載する。画面仕様と`error-codes.md`の不一致なら両方を示す。
- 個別確認と横断確認を一つのレポートに統合し、ファイルごとに別レポートを生成しない。対象一覧と確認状況を記載し、全件を確認できたか分かるようにする。
- 画面仕様が0件、`error-codes.md`が存在しない、または読み取れないファイルがある場合は、その事実と未確認範囲を明示する。確認できない範囲を「問題なし」と扱わない。

## Review Report Path

全対象ファイルのレビュー結果は以下の一つのファイルに出力する。パスはProjectルートからの相対パスとする。

```text
docs/reviews/ui-specification-review-report.md
```

## レビューの前提と適用範囲

- UI仕様の内容の正本は当skillの`references/guide.md`とし、既存の`assets/template.md`を構造・記載形式の確認に使用する。
- 1 Screenにつき1 Artifactとして、所属Frontend ApplicationのScreen Compositionと、User OperationからScreen UpdateまでのScreen Behaviorが実装可能な粒度で定義されているかを評価する。
- Function Design / System Architectureで確定した目的、画面間関係、User Interaction、Business Rule、Application Boundaryを前提とする。UI仕様でそれらを再定義していないか確認する。
- Color、Typography、Icon、共通Component、Framework、State Management、Logging等の横断的なRuleは対応するGuidelineを正とする。画面固有の仕様と適用条件を確認し、共通RuleやPixel単位のLayout値を各画面へ複製することは要求しない。
- Backend API等のContract・内部処理は対応するSpecificationを正とする。UIからの利用、Request / View ModelへのMapping、画面への反映を確認し、API内部のApplication Service・Database処理まで展開させない。
- `error-codes.md`も参照資料だけでなくレビュー対象とする。既存の定義形式に従ってCodeと意味・関連仕様を確認し、このレビューのために新たな列構成を要求しない。APIのError Contractと矛盾がある場合は推測で解決せず、関係箇所を明示する。
- Formがない画面のForm Definition、単体の定義で十分なComponentの個別詳細、表で十分に把握できるStateの遷移図等を一律に必須化しない。適用有無は上位設計と対象Screenの特性から判断し、必要な事項の省略と区別する。
- 同一仕様は担当Sectionを正とし、他Sectionでは参照・適用関係を確認する。参考例の画面・Component・State・Error Codeや未記入枠を決定済みの仕様として残していないかも確認する。

## 特有のレビュー観点

- Change History
- Summary
- Screen Structure
- Component Definition
- Screen State
- Form Definition（Formがある場合）
- Validation / Display Rules
- Interaction Flow
- Sequence
- Processing Details
- Error Presentation（エラーコード定義と整合性を含む）
- 各ファイル内の妥当性と一貫性
- ファイル間を横断した一貫性

### 0. Change History

- 初回履歴を、レビュー・再レビューを含む作成・確認が完了し、UI仕様書が確定した時点の1件として扱っているか。確定前のレビューで確定済み履歴を要求していないか。
- 初回確定前のレビュー対応、記載修正、表現改善、誤記修正を個別履歴として記録していないか。
- 初回確定後の正式変更・後続Trainによる変更がある場合、Change、Date、Train、Summaryから対象Screenの変更を追跡できるか。

### 1. Summary

- Physical Name、Logical Name、Application、Screen Type、Route / Path、Descriptionから対象Screenと所属Frontend Application・目的を識別できるか。
- Screen TypeがPage / Modal / Dialog等の画面の性質を示し、上位で確定したScreenとApplication Boundaryに一致しているか。
- 独立したRoute / Pathがある場合は具体的で、ない場合は`-`としているか。Modal等へ無条件に独立Routeを要求していないか。
- 一つのファイルで一つのScreenを扱い、後続のComposition・BehaviorがそのScreenの目的に対応しているか。

### 2. Screen Structure

- ScreenをRootとするTreeから、領域とComponentの包含関係、基本的な表示順序を理解できるか。
- Treeだけでは不明な重要な位置関係には必要なAnnotationがあり、Pixel / Margin / Padding等の具体値やComponent内部仕様を混在させていないか。
- 繰り返しComponentを構造として表現し、表示件数分を列挙していないか。
- 条件付きで表示するComponentも構造に含まれ、表示条件・状態差異はScreen StateまたはValidation / Display Rulesへ対応しているか。
- Screen Structure上の実際のUI ComponentについてComponent Definitionとの対応を確認する。構造理解のためだけに置かれた論理的な領域・Groupingについて、Componentとしての個別定義を機械的に要求しない。

### 3. Component Definition

- 構造上の各Componentについて識別名、UI上のType、Label / Text、Model / Value、Required、Editable、役割が明確か。特定FrameworkのClass名だけで役割を表していないか。
- 固定表示と動的な入力・表示値が区別され、参照するView Model / Form Model等を特定できるか。
- Required / Editableの`●`・`-`が入力・操作特性に対応し、表示専用ComponentやFormの定義と矛盾しないか。
- 状態・条件によるVisible / Hidden、Enabled / Disabledを本節で重複定義せず、4・6章へ対応付けているか。User Actionから始まる処理は7・9章に接続しているか。
- List / Table / Composite Component等の内部仕様を1行では表せない場合、必要な個別Definitionがあり、内部の項目、Label、Value、役割を判断できるか。不要な個別詳細や親定義の重複を要求していないか。

### 4. Screen State

- 対象Screenに必要なStateと成立条件・契機が明確で、状態によって変化するComponentを特定できるか。例示のStateを無条件に追加していないか。
- Visibility、Enabled、Display / Behaviorが具体的で、操作対象ではないComponentを操作可能とする等の矛盾がないか。
- Stateによって変わらない基本仕様を重複させず、Component Definitionとの役割分担が明確か。
- Stateの成立条件が上位のBusiness Ruleと整合し、Interaction Flow / Sequence / Processing Detailsで遷移するStateが定義されているか。
- 遷移が複雑な場合、必要な状態遷移図から遷移条件を理解でき、表・処理と一致しているか。単純なStateに図の追加を機械的に要求していないか。

### 5. Form Definition

- Formがある場合、Fieldと入力Component、Type、Required、必要なSize / Min / Max / Patternが対応し、入力仕様を具体的に判断できるか。
- 単一Fieldの制約と複数Field間のValidationが明確で、上位のBusiness Ruleを変更せず実現しているか。
- Validation Error時のMessageが定義され、該当条件と対応しているか。Component Definitionの必須・編集特性とも一致しているか。
- Validation条件・Messageの正本を本節とし、6・9・10章で異なる定義を行っていないか。
- Formが存在しない場合は本節の省略を認め、一般的な入力項目やValidationを追加していないか。

### 6. Validation / Display Rules

- Validation Presentation Rulesから、Error対象の入力ComponentとMessageの対応、表示場所・方法、必要なSubmit制御を判断できるか。Validation条件・Message自体は5章を参照しているか。
- Display / Interaction Rulesが対象Component、条件、表示Format・Visible / Hidden・Enabled / Disabled等の結果を具体的に示しているか。
- Screen全体のStateによる変化は4章、個別の値・条件によるRuleは本節と役割が分かれ、同時に適用して矛盾しないか。
- 上位のBusiness RuleをUI表示・操作制御に反映する範囲にとどまり、Ruleそのものや共通Styleを再設計していないか。

### 7. Interaction Flow

- 主要User OperationからValidation、必要なFrontend処理・API連携・Mappingを経てScreen Updateまで辿れるか。正常・異常・取消等、対象Interactionに必要な分岐が表現されているか。
- FormやBackend APIを使う場合、それぞれのValidation・呼出し結果に応じた処理が、対応する仕様を参照しているか。
- View ModelへのMappingが必要な場合、その処理がFlowに含まれ、具体的なMappingは9章に定義されているか。
- State変更が4章のStateに対応し、Validation・表示Rule・個別LogicをFlow内で別定義していないか。
- 独立した主要Interactionが複数ある場合、Interaction単位でFlowを分割し、一つの巨大な処理へ混在させていないか。Mermaidの接続・分岐を解釈できるか。

### 8. Sequence

- Interaction Flowと原則同じ単位で、User、This View、必要な連携先のやり取りを時系列に追跡できるか。
- This Viewが対象Frontend ApplicationのScreenを表し、Frontend内のValidation・Mapping・State変更が必要に応じてSelf Messageとして表されているか。
- APIを使う場合、Target APIへのRequestとResponseまでを扱い、連携先内部のService・Database等へ展開していないか。API Contractは対応するSpecificationを参照しているか。
- 必要な分岐が`alt` / `else`等で表現され、成功・Error・取消等の結果が7・9章と一致しているか。
- 複数の独立Interactionが分割され、Mermaidの参加者・境界・Message・順序が実際の連携を表しているか。

### 9. Processing Details

- Interaction単位・Step単位で、操作から画面反映まで追加の設計判断なく実装できる粒度に具体化されているか。例示のStep数・種類を機械的に踏襲していないか。
- `Step N`と`N.1`等の番号、分岐・繰返し、遷移先Step、終了条件が明確で、存在しないStepへの遷移や処理の欠落がないか。
- FormからRequestへのMappingが必要な場合、送信先APIとFieldごとのSourceが明確で、API SpecificationのContractに一致しているか。Endpoint / HTTP Method等を独自に再定義していないか。
- Backend Dataを画面表示へ使用する場合、画面固有の変換・構造差・表示用Dataが必要であればView Model Mappingが具体的か。単純な参照で十分な場合まで形式的なView Modelの追加を要求しない。一方、Backend ContractとUI Componentが不必要に密結合となる構造は避けられているか。
- Backend Dataを画面表示へ使う場合、Responseの参照元からView Modelまたは表示用のTarget FieldまでのMappingを追跡できるか。変換・名称変更・構造変更がある場合、その対応関係が実装可能な粒度で明確か。
- View ModelとComponentの対応が3章のModel / Valueに一致し、Mapping・更新処理に必要な関係だけを記載しているか。
- Validation、State変更、表示Rule、Error表示が各担当Sectionの定義に従い、Flow・Sequenceの正常系・異常系を実現しているか。
- Screen UpdateまたはError処理後の状態・終了を判断でき、補足は必要なStepのNoteとして整理されているか。

### 10. Error Presentation

#### 画面でのError表現とエラーコードの照合

- 既知Codeを受信したAPI Error、Responseを正常取得できないCommunication Error、Responseは受信したがCodeをMappingできないUnmapped Errorを区別しているか。
- API ErrorのError / Conditionに対象Codeが明記され、`docs/persistent/details/error-codes.md`に対応する定義があるか。Codeの意味・発生条件と画面での扱いが一致しているか。
- `error-codes.md`にMessage、分類、HTTP Status、利用条件等の関連仕様が定義されている場合、画面が参照・利用する内容と対応するAPI SpecificationのError Contractに矛盾がないか。UI側でCodeやContractを再定義していないか。
- TargetがComponent Definitionに存在し、Presentation Type、Display Content、User Actionから、どこへ何を表示し、その後何ができるかを判断できるか。
- APIのMessageをそのまま使用する場合は参照元が明確か。Frontend固有の表示内容を使う場合はその内容が明確で、Codeの意味・公開方針に適合しているか。画面用の表現とAPI Messageを区別し、許容された言い換えまで文字列不一致だけで問題にしていないか。
- Communication Errorは検知条件が明確か。Responseを受信しない事象に、存在しないBackend Codeの登録・返却を要求していないか。
- Unmapped Errorでは画面として定義したFallbackを使い、未知Codeや内部Error情報を直接表示しないか。未知Codeを既知Codeへ推測で割り当てていないか。
- Retry、入力修正、画面遷移、Dialog Close等のUser ActionがState・操作可否・Processing Detailsと両立するか。必要なState変更も定義済みStateに対応しているか。
- Form Validationの条件・Messageは5章、表示方法は6章を正とし、本節で重複定義していないか。FormでCodeを利用する仕様がある場合は、そのCodeも`error-codes.md`と照合するが、すべてのValidation MessageへCodeを新設することは要求しない。
- 共通のColor / Icon / Typographyを再定義せず、Backend内部のException・Stack Trace・非公開Detail等をユーザー表示仕様に含めていないか。

#### error-codes.md自体の定義

- 全文を確認し、Codeを識別でき、その意味と記載された関連仕様が明確か。同一の識別範囲で一つのCodeに異なる意味を割り当てる等の衝突・重複がないか。
- 同文書内でCode、意味、条件、Message等の定義が矛盾せず、記載された参照先を特定できるか。定義形式にない項目を一般論だけで追加要求していないか。
- 画面で既知Codeとして利用するものに定義漏れがなく、複数画面で参照するCodeの意味を一貫して判断できるか。
- 共通の定義と個別APIのError Contractに食い違いがある場合、関連するファイル・Code・項目を特定して指摘できるか。根拠なく片方を優先し、矛盾を見逃していないか。
- このレビュー対象の画面で利用しないCodeがあることだけを問題にせず、全画面に全Codeの表示定義を要求していないか。通信失敗・未知CodeのFallbackも、登録済みCodeの欠落と混同していないか。
- `error-codes.md`自体の確認は、UI SpecificationからError Codeを一意かつ矛盾なく参照・利用できることを確認する範囲とする。UIから利用されないCodeについて、他領域固有の利用方法や網羅性まで本レビューで新たに要求しない。

### 11. 各ファイル内の妥当性と一貫性

- 各画面仕様が、上位で確定したScreenの目的を、CompositionとUser OperationからScreen UpdateまでのBehaviorとして実装可能な粒度で具体化できているか。
- Structure、Component、State、Form、Validation / Display Rulesの識別名・Model・条件が一致し、必要な入力・表示・操作が同時に成立するか。
- Interaction Flow、Sequence、Processing Detailsが同じInteractionと分岐・連携・Mapping・State変更を表し、独立した操作が混在していないか。
- Error発生から画面表示・次の操作までが10章と整合し、例えばRetry可能としながら操作を無効化したままにする等の矛盾がないか。Code定義との照合結果は10章を参照する。
- 同一仕様の正本がSectionごとに明確で、重複記載による矛盾、未記入枠、参考例の残存、Backendや共通Guidelineの再定義がないか。
- `error-codes.md`はScreenの構成ではなく共通エラーコード定義として、Codeを一意に解釈し、意味・条件・関連仕様を矛盾なく参照できる文書になっているか。具体的な確認は10章の結果を使用する。

### 12. ファイル間を横断した一貫性

- 全画面仕様と`error-codes.md`を確認したうえで、同じScreenを矛盾する内容で重複定義していないか。Screen名、所属Application、Route / Pathの識別は実際のApplication境界に照らして成立するか。
- 画面遷移・Modal等の呼出しがある場合、遷移先Screenと起動条件、受け渡す値が関連画面の仕様と一致するか。対象外のScreenを参照する場合は正本を確認し、未確認と誤りを区別する。
- 同じ意味を持つ入力・表示値、共通Component、操作、Validation等が関連画面と上位設計・Guidelineに整合しているか。Screen固有の要件に基づく差異は認め、同名だけで一律に統一しない。
- 同じAPIを利用する画面間で、そのContractを異なる意味に解釈していないか。各画面固有のView Modelや表示Mappingの違いと、共通Contractの不整合を区別しているか。
- 10章で行ったエラーコード照合の結果が全画面に及び、同じCodeの意味・公開範囲が画面ごとに食い違っていないか。Presentation TypeやUser Actionの差異はScreenの目的・状態に基づき判断し、無条件に同一表示を要求しない。
- ある画面または共通Codeの仕様変更によって、関連画面の参照・遷移・Error処理が古いまま残っていないか。横断的な指摘は関係するファイルと該当箇所をすべて明示し、上位設計・Contract等の根拠から整合させる方向を示せるか。
- 複数画面で類似するComponentやInteractionが存在することだけを理由に、新たな共通Componentや共通Specificationへの切り出しを要求しない。既存の共通Component / Guidelineがある場合はその適用整合を確認し、共通化自体は別途の設計判断とする。

## 特有のレビュー観点についてのレビュー例

以下の画面名・Component・Codeは説明用の仮例であり、採用を要求しない。実際の指摘では確認したファイルと該当箇所に置き換える。

### 良い点の例

- `docs/persistent/details/view/search.md`で、入力、API利用、View Model Mapping、結果・空結果・Errorの画面反映をInteraction単位で追跡でき、各Sectionの定義が一致している。
- `docs/persistent/details/view/search.md`の既知Error Codeが`docs/persistent/details/error-codes.md`と一致し、画面での表示先・Message参照元・再操作も具体的である。
- `docs/persistent/details/view/search.md`で、通信失敗と未知Codeを区別したFallbackが定義され、内部Errorを表示せずにユーザーが次の操作を判断できる。

### 改善点の例

画面内の状態と操作の矛盾:

- 対象ファイル：`docs/persistent/details/view/search.md`
- 該当箇所：Screen State、Processing Details、Error Presentation
- 問題：Error表示後はRetry可能としているが、Retryを開始するComponentが操作不可のままで、再操作へ戻る経路がない。
- 推奨：Error後のState、Componentの操作可否、RetryのInteractionを対応付けて整合させる。

エラーコードの意味の不一致:

- 対象ファイル：`docs/persistent/details/view/search.md`、`docs/persistent/details/error-codes.md`
- 該当箇所：画面のError Presentationと共通定義の`E_SAMPLE_01`
- 問題：共通定義では入力条件の不備を示すCodeだが、画面では権限不足として表示し、入力修正へ進めない。
- 推奨：Codeの意味と対応APIのContractを確認し、画面の表示内容・User Actionを整合させる。共通定義とAPIにも不一致があれば、その関係箇所を併せて指摘する。

共通エラーコード定義内の衝突:

- 対象ファイル：`docs/persistent/details/error-codes.md`
- 該当箇所：同一識別範囲の`E_SAMPLE_02`に関する二つの定義
- 問題：一つのCodeに異なる意味が記載され、画面側がどちらの条件・表示として扱うべきか判断できない。
- 推奨：確定済みのError Contractに照らして意味と識別を整理し、関連する画面のCode参照も確認する。

未知Codeの直接表示:

- 対象ファイル：`docs/persistent/details/view/search.md`
- 該当箇所：Error PresentationのUnmapped Error
- 問題：認識できないCodeでもResponseのError情報をそのまま表示する仕様で、画面としてのFallbackがない。
- 推奨：未知Codeに対するFallbackの表示内容・Target・User Actionを定義し、非公開の内部情報を直接表示しない。

画面間の遷移先の不一致:

- 対象ファイル：`docs/persistent/details/view/search.md`、`docs/persistent/details/view/detail.md`
- 該当箇所：前者の詳細表示Interaction、後者のSummaryと対象識別値を利用するProcessing Details
- 問題：遷移元が渡す識別値と遷移先が必要とする識別値が異なり、選択した対象を表示できない。
- 推奨：上位の画面間関係を前提に遷移・受渡し仕様を整合させ、両画面の処理とMappingへ反映する。
