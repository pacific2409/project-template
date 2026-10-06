# review points

`docs/persistent/details/table/*.md` に該当するすべてのファイルを、一つずつ順にレビューし、全体で一つのレビュー結果およびレポートを生成する。

- レビュー開始時に対象ファイルを列挙し、パス順に一つずつ全文を確認する。一部のファイルだけを代表としてレビューしない。
- 各ファイルのレビューでは、章ごとの観点と「各ファイル内の妥当性と一貫性」を確認する。すべてのファイルの確認後、最後に「ファイル間を横断した一貫性」を確認する。
- 改善点・指摘を追加するときは、どのファイルの問題か分かるよう、Projectルートからの相対パスを必ず明記する。該当Section、Table、Column、Key / Index、Constraint等も特定する。
- ファイル間の不整合を指摘する場合は、関係するファイルのパスと、それぞれの該当箇所・食い違いを明記する。問題の所在を「テーブル定義全体」だけで済ませない。
- 個別確認と横断確認の結果を一つのレポートへ統合し、ファイルごとに別レポートを生成しない。対象ファイル一覧と確認状況を記載し、全件を確認できたか分かるようにする。同じ問題を重複して指摘せず、関係ファイルをまとめて示す。
- 対象が0件の場合、または読み取れないファイルがある場合は、その事実と未確認範囲を明示する。未確認を「問題なし」と扱わない。

## Review Report Path

全対象ファイルのレビュー結果は以下の一つのファイルに出力する。パスはProjectルートからの相対パスとする。

```text
docs/reviews/table-definition-review-report.md
```

## レビューの前提と適用範囲

- 内容の正本は当skillの`references/guide.md`とし、既存の`assets/template.md`を成果物の構造・記載形式の確認に使用する。
- 1 Tableにつき1つのTable Detail Designとして、Function Designおよび関連する上位設計で確定したData Relationship、Constraint、Business Ruleを、対象Tableの物理仕様へ具体化できているかを評価する。上位の業務ルールそのものを新たに決めるレビューにはしない。
- 記載形式だけでなく、Column、Key / Index、Constraintの具体性、相互整合、上位設計との対応から、Tableの物理定義として実装可能かを確認する。DDL全文、Application内部処理、Migration手順、Infrastructure構成等を追加の必須項目として要求しない。
- `created_at`、`updated_at`、`operator`、`deleted_flag`、`timestamp`はguideで必須とされたCommon Columnとして全Tableで確認する。一方、guideの例示Table・業務Column・Data Type・Size等は、そのまま採用することを要求しない。
- `4. Constraints`は、Columns / Indexesだけでは十分に表せないTable固有のConstraintが存在する場合に確認する。該当事項がない場合の省略を欠落としない。
- 採用Databaseと上位で確定した規則に照らして仕様を確認する。未確定の前提や確認できない参照先を推測で補い、整合していると判断しない。

## 特有のレビュー観点

- Change History
- Table Summary
- Columns
- Indexes
- Constraints（該当する場合）
- 各ファイル内の妥当性と一貫性
- ファイル間を横断した一貫性

### 0. Change History

- 初回履歴は、レビュー・再レビューを含む作成・確認を終え、定義書が確定した時点の1件として扱われているか。確定前のレビューで確定済みの履歴を要求していないか。
- 初回確定前のレビュー対応、記載修正、表現改善、誤記修正を個別の変更履歴にしていないか。
- 初回確定後の正式な変更・後続Trainによる変更がある場合、Change、Date、Train、Summaryから対象Tableの変更を追跡できるか。

### 1. Table Summary

- Physical Name、Logical Name、Descriptionによって、対象Tableとその保持する情報・目的を識別できるか。
- 上位設計で定義したDataの役割に対応し、対象Tableの責務を不必要に拡張・変更していないか。
- 一つのファイルが一つのTableを対象としているか。Physical Nameと、後続のColumn・Key / Index・Constraintで扱うTableが一致しているか。

### 2. Columns

- 対象Tableに必要なすべてのColumnが、Common Columnも含めて定義されているか。物理Column名が重複せず、論理名称から意味を識別できるか。
- PK / UKは該当する場合に`●`、該当しない場合に`-`とし、所属するKeyをIndexesと対応付けられるか。複数Columnで構成するKeyでは、対象Columnすべての所属と組合せが分かるか。
- FKは該当する場合に`<table>.<column>`で参照先を特定し、該当しない場合に`-`としているか。複合参照がある場合、参照元・参照先のColumnの組合せと対応順が曖昧でないか。
- Type (Size)に採用Database上の物理Data Typeと必要なSize / Precision / Scaleが定義され、保持する値の意味・値域・精度を表現できるか。
- Not NullはNOT NULLの場合に`●`、NULL許容の場合に`-`とし、上位の必須・任意の関係、Key、Constraintと矛盾しないか。
- Defaultは値または式が明確で、存在しない場合は`-`か。Data Type、Not Null、値域、Constraintに適合し、「Defaultなし」と「NULLを設定」を混同していないか。
- 必要なCode値、値域、Column固有の意味・補足がRemarks等から分かるか。Remarksの説明と実際の型・Default・制約に食い違いがないか。
- `created_at`が作成日時を保持し、作成後の通常更新では変更しない仕様になっているか。
- `updated_at`が作成時・更新時の日時を保持し、`created_at`と役割を混同していないか。
- `operator`が作成・更新を実行したAPI / Batch等の実行元を識別可能な値を保持する仕様か。別の意味のColumnへ置き換えていないか。
- `deleted_flag`が`0`を未削除、`1`を削除済みとし、Defaultが`0`になっているか。
- `timestamp`が楽観的排他制御に使用するVersion Timestampとして定義され、Record更新に伴って更新する仕様か。単なる作成日時・最終更新日時と混同していないか。
- Common Columnについて、Table Definitionで規定された意味・設定・更新上のContractを確認する。JPA、Entity Listener、Database Trigger等の具体的な実現方式までは要求しない。
- Common Columnの物理仕様・補足がこれらの共通の意味と設定・更新規則に矛盾していないか。Default式の指定だけで更新時の動作まで定義したと誤認していないか。具体的なApplication CodeやTrigger実装本文は要求しない。

### 3. Indexes

- 対象TableのPrimary Key、Unique Key、および上位の利用・検索要求から必要となるIndexを特定できるか。Foreign Key Columnについても、既存Indexとの対応や採用Databaseの方式、利用方法を踏まえて必要性を判断できるか。ColumnsのKey定義と対応が取れているか。
- Index Name、Type、Columns、Unique、必要なRemarksが具体的で、存在しないColumnを参照していないか。採用Database上のIndexの実現方式と矛盾しないか。
- 複合Key / IndexのColumnsが構成Columnを漏れなく含み、Index順で記載されているか。組合せ全体の一意性と、各Column単独の一意性を混同していないか。
- TypeとUniqueの指定が一致し、上位で要求された一意性を過不足なく実現しているか。検索用Indexを理由なくUniqueにする等、別の業務制約を追加していないか。
- Primary Keyに`pk_`、Unique Key / Unique Indexに`uk_`、通常Indexに`idx_`、非UniqueのComposite Indexに`mul_`を使用しているか。UniqueなComposite Indexは役割を優先して`uk_`としているか。
- 命名が`<prefix><table>_<purpose / columns>`を基本とし、採用DatabaseのIdentifier Length等の制約を満たしているか。
- 検索・性能上必要なIndexは、対象Column・順序と利用目的を対応付けて妥当性を判断できるか。実行計画や性能試験が未実施の場合、性能を確認済みと扱っていないか。
- PK / UK等を実現するIndexと検索用Indexの重複を確認し、同等のIndexを理由なく追加する構成になっていないか。FKごとに独立した追加Indexが必須と決めつけず、既存Indexとの対応や採用Databaseの方式に照らして判断しているか。

### 4. Constraints

- Columns / Indexesだけでは十分に表現できないTable固有のConstraintがある場合、その内容が定義されているか。該当事項がない場合、章の省略を認めているか。
- Constraint Name、Type、Definition、必要なRemarksから、対象Columnと成立させる条件を具体的に判断できるか。採用Databaseで表現可能な物理仕様か。
- CHECK等の条件が上位のBusiness Ruleに対応し、その意味を変えたり、未決定の業務ルールを新たに導入したりしていないか。
- Constraintが参照するColumn、Data Type、NULL許容、Default、Code値・値域と整合しているか。想定した値の許可・拒否が成立するか。
- PK / UK / FK等、Columns / Indexesで表現済みの内容を重複列挙し、異なる定義や複数の正本を作っていないか。

### 5. 各ファイル内の妥当性と一貫性

- ファイル全体が、一つのTableの目的と上位で確定したData Relationship・Constraint・Business Ruleを、実装可能な物理仕様へ具体化する成果物として成立しているか。項目の記入だけでなく、必要なDataを表現・保持できるか。
- Table Summaryの目的、Columnの意味・型・NULL許容・Default、Key / Index、Constraintが一つの定義として両立しているか。節ごとには自然でも、組み合わせると必要なRecordを保持できない等の矛盾がないか。
- PK / UK / FKの所属、複合Key / IndexのColumn構成・順序、一意性、参照先が文書内で一致し、実装時に異なる解釈が生じないか。
- Common Columnが業務Columnと併せて定義され、その意味・更新規則がRemarksやConstraintによって否定されていないか。論理削除と一意性等が関係する場合も、上位のルールと物理仕様が整合しているか。
- 必要な補足は物理仕様の判断を明確にする内容に限られ、Application内部処理や上位の業務設計を再定義していないか。未記入枠・参考例・未確定事項を決定済みの仕様として扱っていないか。

### 6. ファイル間を横断した一貫性

- 全対象ファイルを確認したうえで、同じ物理Tableを矛盾する内容で複数定義していないか。Tableの識別・責務・上位Dataとの対応がファイル間で一貫しているか。
- FK等で参照するTable・Columnが参照先の定義と一致するか。対象外のTableを参照する場合は既存の正本を確認できるか。定義を確認できない場合は、確認不足と定義上の誤りを区別して示しているか。
- 参照元・参照先のData Type、必要なSize / Precision / Scale等が採用Database上で互換か。複合参照ではColumn数・組合せ・対応順が一致し、参照先のPK / UK等と参照関係が成立するか。
- 上位で定義されたData Relationshipに対し、各Tableの参照、一意性、NULL許容、Constraintを組み合わせても関係の必須・任意や多重度が矛盾しないか。存在しない関係を推測で追加していないか。
- 全Tableに5つのCommon Columnが定義され、その意味、作成・更新時の扱い、`deleted_flag`の値とDefault、`timestamp`の排他制御用途が統一されているか。
- 共通の意味を持つColumn・識別子・Code値について、名称、型、Size、値域、NULL許容、Default等に説明できない食い違いがないか。Table固有の要件による差異は認め、単に別Tableであることや同名であることだけを理由に機械的な統一を要求しない。
- Key / Indexの命名規則・役割・複合Columnの記載方法が一貫しているか。名称の衝突は採用Databaseの名前空間に照らして確認し、異なるTableの同名要素を無条件に問題としない。
- 関連Tableの参照、論理削除、Code値、Constraint等が組み合わさったとき、上位で確定したルールを満たすDataを保持できるか。一方のファイルの定義変更が他方の参照・制約へ反映されていない等の不整合がないか。
- 横断的な指摘について、関係ファイルと該当Table / Column / Key / Constraint、および何が一致していないかを具体的に示せるか。根拠なく片方を正本と決めず、上位設計や共通規則に基づいて整合させる方向を提示しているか。
- 同一の業務情報を複数Tableで保持する場合、その重複が上位設計または明示されたData設計上の意図に基づくものか。根拠のない重複保持によって、更新時に値の不整合が生じる構造になっていないか。意図的な非正規化を機械的に問題としない。

## 特有のレビュー観点についてのレビュー例

以下のファイル名・Table・Columnは説明用の仮例であり、採用を要求するものではない。実際の指摘では対象ファイルのパスと該当箇所へ置き換える。

### 良い点の例

- `docs/persistent/details/table/orders.md`で、Tableの目的、業務Column、Common Column、Key / Index、Constraintが整合し、上位の注文Dataを物理仕様へ具体化できている。
- `docs/persistent/details/table/order_items.md`の複合Unique Keyについて、対象Columnすべての所属と組合せ・順序が分かり、各Column単独の一意性とは区別されている。
- `docs/persistent/details/table/orders.md`と`docs/persistent/details/table/order_items.md`の参照先Column、型、Key定義が一致し、上位で定めた親子関係を実現できている。

### 改善点の例

複合Keyの所属が不明確:

- 対象ファイル：`docs/persistent/details/table/order_items.md`
- 該当箇所：Columnsの`order_id`・`line_no`、Indexesの`uk_order_items_order_line`
- 問題：Indexesでは2つのColumnの組合せをUniqueとする一方、Columnsでは片方しかUKに所属しておらず、定義が一致しない。
- 推奨：両Columnの所属と複合Keyの構成を一致させ、組合せ全体の一意性であることを明確にする。

共通Columnの不足:

- 対象ファイル：`docs/persistent/details/table/orders.md`
- 該当箇所：Columns
- 問題：`timestamp`がなく、guideが要求する楽観的排他制御用のVersion Timestampが物理定義に含まれていない。
- 推奨：Common Columnとして追加し、物理Data Typeと更新時の扱いが共通規則に適合するように定義する。

ファイル内のDefaultとConstraintの矛盾:

- 対象ファイル：`docs/persistent/details/table/orders.md`
- 該当箇所：Columnsの`status`、Constraintsの`chk_orders_status`
- 問題：DefaultのCode値がCHECKで許可されず、定義どおりの初期値を保持できない。
- 推奨：上位で確定したCode値・初期状態に従い、Default、Remarks、Constraintを整合させる。

参照元と参照先の不一致:

- 対象ファイル：`docs/persistent/details/table/order_items.md`、`docs/persistent/details/table/orders.md`
- 該当箇所：前者のColumnsにある`order_id`のFK、後者のColumns・Indexes
- 問題：前者は`orders.order_id`を参照しているが、後者では参照されるKey Columnを`id`として定義しており、指定された参照先が存在しない。
- 推奨：上位のData Relationshipと識別子の定義を確認し、参照元・参照先のColumn名、型、Keyの対応を一致させる。

共通規則のファイル間不一致:

- 対象ファイル：`docs/persistent/details/table/orders.md`、`docs/persistent/details/table/order_items.md`
- 該当箇所：両ファイルのColumnsにある`deleted_flag`
- 問題：前者は`0`を未削除とするが、後者は`1`を未削除としており、guideの共通規則とファイル間の意味が一致しない。
- 推奨：両ファイルで`0`を未削除、`1`を削除済み、Defaultを`0`に揃え、関連するRemarks・Constraintも整合させる。
