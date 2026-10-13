# Common Logic Specificationに関する記述の抜粋

API SpecificationおよびBatch SpecificationのContent Guideから、Common Logic Specificationに関する記述を抜粋したもの。

## API Specification

出典: `project-template/.agents/skills/api-specification/references/guide.md`

### Common Logic Separation

- 処理を共通化する場合、または同一の処理が複数の処理から参照されるようになった場合は、その処理を専用のCommon Logic Specificationとして切り出す。
- Common Logic Specificationへ切り出した処理については、元のSpecificationで処理内容を重複して定義せず、Common Logic Specificationへの参照を記載する。
- 元のSpecificationには、Common Logicを呼び出すこと、およびその結果を元の処理でどのように扱うかなど、呼出元として必要な仕様のみを残す。
- Common Logic Specificationは、本Guideの`Request Definition`を`Argument Definition`、`Response Definition`を`Return Value Definition`、`Request / Response Samples`を`Argument / Return Value Samples`として読み替え、本Guideの定義方針および記載方法に従って作成する。
- API固有のHTTP Method、Endpoint、HTTP Status等はCommon Logic Specificationには適用せず、Common Logicとして対応するInterface、Errorおよび処理仕様へ読み替える。

### Processing Details内の参照記載例

```markdown
<!-- 処理を共通化する場合、または処理が複数から参照されるようになった場合、下記のように該当Specificationへの参照を渡す。-->
**Reference**: `Common Logic: External Service Client`
```

## API Specification Review Points

出典: `project-template/.agents/skills/api-specification/references/review-points.md`

### レビューの前提と適用範囲

- 共通化された処理は専用のCommon Logic Specificationを正とし、呼出元には参照、引数、結果の扱い等の必要仕様があるかを確認する。参照先が対象パターン外でも、呼出Contractの照合に必要な範囲で確認し、対象一覧とは区別する。参照先の全面レビューへ無断で範囲を広げない。
- 対象にCommon Logic Specificationが含まれる場合は、guideに従ってRequestをArgument、ResponseをReturn Value、SamplesをArgument / Return Value Samplesへ読み替える。HTTP Method、Endpoint、HTTP Status等のAPI固有項目は要求せず、対応するInterface・Error仕様として評価する。

### Processing Details

- 共通化された処理はCommon Logic Specificationを参照し、引数・戻り値・Errorの扱い等、呼出元として必要な仕様が明確か。切出し済みのLogicを重複定義していないか。
- 複数APIに類似する処理が存在することだけを理由にCommon Logicへの切出しを要求しない。共通化することが上位方針・既存設計・明確な再利用関係から判断できる場合に、専用Specificationとの分離・参照が適切かを確認する。

### 各ファイル内の妥当性と一貫性

- 仕様の正本がSectionごとに明確で、Sampleや共通処理の重複定義、未記入枠、例示の残存、連携先内部仕様の再定義がないか。

### ファイル間を横断した一貫性

- 共通化された処理が専用Specificationへ分離され、複数の呼出元が同じ引数・戻り値・ErrorのContractを参照しているか。Common Logic内部の定義を呼出元へ複製し、差異を生じさせていないか。

### 良い点の例

- `docs/persistent/details/api/get-order.md`が共通処理の正本を参照し、呼出元に必要な引数・結果の扱いだけを定義している。

## Batch Specification Review Points

出典: `project-template/.agents/skills/batch-specification/references/review-points.md`

### レビューの前提と適用範囲

- 共通化された処理は専用のCommon Logic Specificationを正とし、呼出元には参照、引数、結果の扱い等の必要仕様があるかを確認する。参照先が対象パターン外でも、呼出Contractの照合に必要な範囲で確認し、対象一覧とは区別する。参照先の全面レビューへ無断で範囲を広げない。
- 対象にCommon Logic Specificationが含まれる場合は、InputをArgument、OutputをReturn Valueへ読み替え、章番号ではなくSectionの役割に対応させて評価する。Trigger、Execution Mode、Execution Control、Job / Step Structure、前後続Batch等の呼出元Batchに属する項目は要求しない。

### Processing Details

- Common Logicを呼ぶ場合、参照先、Argument、Return Value、失敗時の扱いが明確で、共通処理の内部仕様を呼出元に複製していないか。

### 各ファイル内の妥当性と一貫性

- Common Logic Specificationや`error-codes.md`には、それぞれの成果物の目的・性質に沿って全体の妥当性と一貫性を確認し、Batch固有の章や実行制御を要求しない。

### ファイル間を横断した一貫性

- 共通Dependency、共通Logic等を参照する複数ファイルで、同じ識別子が異なる意味を持たず、呼出Contract・結果の解釈が一致しているか。意図した差異は適用条件から説明できるか。
- 複数Batchに類似する処理が存在することだけを理由にCommon Logicへの切出しを要求しない。共通化することが上位方針・既存設計・明確な再利用関係から判断できる場合に、専用Specificationとの分離・参照が適切かを確認する。

## Batch Specification

出典: `project-template/.agents/skills/batch-specification/references/guide.md`

### Common Logic Separation

- 処理を共通化する場合、または同一の処理が複数の処理から参照されるようになった場合は、その処理を専用のCommon Logic Specificationとして切り出す。
- Common Logic Specificationへ切り出した処理については、元のSpecificationで処理内容を重複して定義せず、Common Logic Specificationへの参照を記載する。
- 元のSpecificationには、Common Logicを呼び出すこと、およびその結果を元の処理でどのように扱うかなど、呼出元として必要な仕様のみを残す。
- Common Logic Specificationは、本Guideの`Input Definition`を`Argument Definition`、`Output Definition`を`Return Value Definition`として読み替え、本Guideの定義方針および記載方法に従って作成する。
- `Execution Control`、Batchの起動条件・実行方式・Job / Step Structure・前後Batchとの関係等のBatch固有の実行制御はCommon Logic Specificationには適用せず、呼出元となるBatch Specificationで定義する。

### Processing Details内の参照記載例

```markdown
<!-- 処理を共通化する場合、または処理が複数から参照されるようになった場合、下記のように該当Specificationへの参照を渡す。-->
**Reference**: `Common Logic: External Service Client`
```
