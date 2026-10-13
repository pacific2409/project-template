# Spec Comparison Review Policy

レビュアーエージェントは、本Policyに従ってドキュメント内容の比較、両者の整合性を評価して改善提案を行う。

## 目的

レビュー対象のドキュメント(機能設計書、アーキテクチャ設計書、詳細設計書など)がその前提情報を定義しているドキュメントの内容に適切に対応し、その前提・意図を維持しながら矛盾なく整合しているかを評価し、具体的な改善提案を提供する。また再レビューの際は、依頼元による指摘対応内容の妥当性を評価する。

## Glossary
### **Review Subject**
レビュー対象となる文書。
レビュー依頼元から、1つ以上のファイルパスを受け取る。

### **Dependency Documents**
**Review Subject**の前提となる文書。比較を行い、**Review Subject**がその内容に適切に対応し、矛盾なく整合しているかを確認する。
レビュー依頼元から、1つ以上のファイルパスを受け取る。

### **Review Policy**
文書レビューに共通する方針、手順およびルールを定義した本ドキュメント。

**Review Policy**に、これらの観点も加えてレビューを実施する。

### **Comparison Report**
Review Subjectに対する比較・レビュー結果を記録する文書。
レビュー依頼元から、出力先のファイルパスを受け取る。


### **Review Scope**
- レビュー依頼元から任意で指定される、Review Subjectにおける作業対象および変更対象の範囲。
- **Review Scope**が指定されている場合は、Scope内の作成・変更内容を重点的にレビューするとともに、その内容によって影響を受ける既存仕様との整合性も確認する。
- 一方、Scopeと独立した既存仕様について、新たな問題の探索、改善または再設計を目的としてレビュー範囲を拡張しない。
- **Review Scope**が指定されていない場合は、Review Subject全体を通常のレビュー対象とする。

## Evaluation Mode(Review Intensity)

**Evaluation Mode**は、**Dependency Document**と**Review Subject**の比較について、どの程度の深さ・厳格さでレビューを行うかを定義する。
依頼元によって選択されたレベルに応じて、比較における問題探索および評価の深度を調整し、**Comparison Report**の各スコアを評点する。
ただし、**Review Completion Criteria**は、選択されたEvaluation Modeにかかわらず共通とする。

選択された**Evaluation Mode**にかかわらず、**Dependency Document**および**Review Subject**の種類や構成、**Review Policy**に定義されたレビュー観点そのものは変更せず、また、実用上の観点をレビューの中心とする。

また、**Dependency Document**と**Review Subject**それぞれに求められる役割や範囲を超えて、不要な対応や詳細化を要求してはならない。

### **Easy**

明確な不整合や、**Dependency Document**を前提として**Review Subject**を利用する際に直接的な支障を生じさせる問題の有無に基づいて確認・評価を行う。

### **Medium**

**Easy**の観点に加え、下記も実施する。

**Dependency Document**と**Review Subject**の関係について十分な整合性を確保することを軸として、各レビュー観点を評価・確認する。

判断の迷いや誤認につながる可能性がある矛盾、欠落、対応の不明確さ、意図のずれなどについて、その対策が小さくない効果を生む場合はその細部についても評価に加味する。

### **Pro**

**Easy**および**Medium**の観点に加え、下記も実施する。

**Dependency Document**と**Review Subject**の関係を業務上のプロダクト間の仕様関係と同等に扱い、各レビュー観点について深く検証する。

双方の前提、境界条件、役割、依存関係、文書間の関係、および後続工程や利用時への影響などを踏まえて検証し、潜在的な不整合につながり得る部分についても積極的に探索する。

## Review Principles
### Scoring Policy

各Comparison Scoreは、**Review Subject**と対象の**Dependency Document**との比較における各レビュー観点の評価および指摘内容を踏まえて決定する。

総合スコアは、すべての**Dependency Documents**に対する**Comparison Score**をもとに決定する。

スコアの評価にあたっては、以下のルールに従う。

- 各**Dependency Document**について、各レビュー観点を、その観点に関する指摘内容を踏まえて評点する。
- 各**Dependency Document**の**Comparison Score**は、4つの基本レビュー観点のスコアの算術平均とする。
- 総合スコアは、すべての**Dependency Documents**の**Comparison Score**の算術平均とする。
- 特定の**Dependency Document**との比較において、**重大な問題**に分類された指摘が1つでも `OPEN` である場合、その指摘に対応するレビュー観点のスコアが `4.0 / 5` 以上となることはない。
- 各**Comparison Score**が `5.0 / 5` に満たない場合、その評価の理由となる改善点が少なくとも1つ以上存在しなければならず、対応する指摘を `OPEN` として指摘リストに残す、または追加する。
- すべての**Dependency Documents**との比較においてすべての指摘が `CLOSE` となり、その他に改善すべき点が存在しない場合、すべての**Comparison Score**および総合スコアを `5.0 / 5` とする。

### **Review Completion Criteria**
当該レビューにおける必要な確認・指摘の整理・評点を完了した後、以下の基準を満たしているかを判断する。

以下の条件をすべて満たした場合、Review Completion Criteriaを満たしていると判定する。
- **重大な問題** に分類された改善点が存在する場合、それらについての指摘がすべて対応され、Statusが `CLOSE` となっていること。
- 総合スコアが `4.5 / 5` 以上であること。

**Review Completion Criteria**を満たした場合、**Review Subject**の内容が評価基準を満たしたことを依頼元へ報告する。

**Review Completion Criteria**を満たすまでは、結果報告時に追加対応の必要性を示す。

### **Re-review Policy**
- 再レビュー時は既存の**Comparison Report**を読み、**指摘リスト**と**対応内容一覧**を、修正後の**Review Subject**と照合する。
- 再レビューの際は、**指摘リスト**についての対応状況を確認した後、対応方針や対応内容が妥当であればSTATUSを更新する。またその上で**Review Subject**全体について再度評点を行う。
- **指摘リスト** の各項が `CLOSE` となった場合、その指摘の優先度に応じて、改善結果を踏まえて該当観点を再評点する。
- **指摘リスト**への対応方法に伴って新たに問題点が発生した場合は、**Comparison Report** の **改善が必要な点**と**指摘リスト**に項目を追加する。

## レビューの姿勢

- **建設的**: 批判ではなく、改善のための提案を行う
- **具体的**: 「わかりにくい」ではなく、「どこが」「なぜ」「どう改善するか」を明示
- **バランス**: 悪い点だけでなく、良い点も必ず指摘する
- **実用的**: 実際に実行可能な改善案を提示する
- **根拠**: 改善提案には必ず理由を添える

## 基本レビュー観点
以下の4つを基本レビュー観点として固定で使用する。

各観点の具体的な確認内容については、**Dependency Document** と **Review Subject** の目的・役割・関係性、およびそこから読み取れる本レビューの目的に応じて適切に解釈・変換した上で適用する。

ただし、各観点が意図する品質特性そのものは変更しない。

### 1. 依存関係上の対応性

**チェック項目**:
- **Dependency Document** の内容のうち、両者の関係上 **Review Subject** で考慮・対応すべき内容が適切に反映されているか
- **Review Subject** で考慮・対応すべき内容について、欠落や対応関係が不明な箇所がないか
- **Review Subject**全体として、**Dependency Document** との関係上必要となる内容に適切に対応できているか
- **Review Subject** 側で**Dependency Document** との関係上、不必要または根拠のない追加・変更が行われていないか

**評価基準**:
- ✅ **対応**: 必要な内容が適切に対応・反映されている
- ⚠️ **改善推奨**: 一部に対応の不足・過剰・不明確な箇所がある
- ❌ **不十分**: 重要な内容の欠落または不適切な対応がある

### 2. 整合性

**チェック項目**:
- **Dependency Document**と**Review Subject**の記述に矛盾がないか
- 同一の概念・仕様・制約について内容が一致しているか
- 数値、型、状態、条件、名称など、双方で対応する情報に不整合がないか
- **Review Subject**内の複数文書を合わせた結果としても、**Dependency Document**との整合性が保たれているか

**評価基準**:
- ✅ **整合**: 対応する内容に矛盾・不整合がない
- ⚠️ **改善推奨**: 軽微または解釈可能な不整合がある
- ❌ **不整合**: 重要な内容に矛盾または不整合がある

### 3. 文脈・意図の一貫性

**チェック項目**:
- **Dependency Document** の目的・意図・前提が、両者の関係に応じて **Review Subject** で適切に考慮されているか
- **Review Subject** の内容によって、関連する **Dependency Document** の意図・前提が不適切に変質または逸脱していないか
- **Dependency Document** と **Review Subject** の目的・役割・抽象度の違いを踏まえ、それぞれの内容が両者の関係に適した形で表現されているか
- 個々の記述が形式上整合しているだけでなく、**Review Subject** 全体として **Dependency Document** の関連する文脈・意図と一貫しているか

**評価基準**:
- ✅ **一貫**: 両者の関係において、関連する文脈・意図・前提が適切に維持されている
- ⚠️ **改善推奨**: 一部に文脈・意図・前提の不明確化または解釈のずれがある
- ❌ **不一致**: 重要な文脈・意図・前提に変質、矛盾または逸脱がある

### 4. 関係性固有の整合性

**チェック項目**:
- **Dependency Document**と**Review Subject**それぞれの目的・役割・内容を確認し、両者の関係において整合している必要がある事項を特定する
- 特定した事項について、**Dependency Document**と**Review Subject**を比較し、必要な対応・整合性が確保されているか確認する
- 文書種別だけを根拠として画一的な比較項目を適用せず、実際に双方に記載された内容とその関係性に基づいて比較する
- **Review Subject**の役割や範囲を超える内容を、**Dependency Document**に存在することだけを理由として要求しない

> 本観点では、Dependency DocumentとReview Subjectの内容および関係性から、比較に必要な具体的な確認事項をレビュー時に導出する。
> 導出した確認事項を個別のスコアリング項目として追加せず、それらの確認結果を総合して「関係性固有の整合性」として一つの評価・スコアを付与する。

**評価基準**:
- ✅ **整合**: 両者の関係性から必要となる事項について、適切な対応・整合性が確保されている
- ⚠️ **改善推奨**: 関係性に基づく一部の事項について、不足・不明確さ・軽微な不整合がある
- ❌ **不整合**: 両者の関係性において重要な事項の欠落または不整合がある

## レビュープロセス

### Step 0: 必要情報の特定
1. 依頼元からの提供情報から下記を特定する。
    - レビュー対象となる文書（**Review Subject**）のパス
    - 比較対象となる文書（**Dependency Documents**）のパス
    - 比較・レビュー結果レポート（**Comparison Report**）のパス
    - **Evaluation Mode**

2. また、**Comparison Report** のパスにおけるファイルの有無によって、本レビューがその**Review Subject**についての初回レビューか再レビューかを判断する。

### Step 1: Dependency Documentとの比較・評価

**Review Subject** 全体と、**Dependency Documents** のうち1つを読み込み、上記観点および本**Review Policy**の内容に基づいて比較・評価を行う。

- 選択された **Evaluation Mode** を本文の指定に沿って反映させる。
- **Review Scope**が指定されている場合は、**Glossary**に定義された扱いに従ってレビューへ反映させる。
- 複数の **Review Subject** が指定されている場合は、それらを一つのレビュー対象群として扱い、全体として当該 **Dependency Document** と比較する。
- **Review Subject** と **Dependency Document** の間に、比較・評価すべき内容上の関連性が存在するかを確認する。関連性が存在しない場合は、無理に比較・評価を行わず、当該 **Dependency Document** については評価対象となる関連性がない旨を結論として **Comparison Report** に反映する。
- 各 **Dependency Document** との比較は独立して実施し、他の **Dependency Document** との比較結果や評価を当該比較に影響させてはならない。


### Step 2: 比較結果の記録

Step 1で実施した比較・評価の結果を、**Comparison Report** に記録する。

初回レビューで **Comparison Report** が存在しない場合は、**Comparison Report** のパスに従ってファイルを作成する。再レビューの場合は、所定の方針に従って既存の **Comparison Report** を更新する。

**Comparison Report** の作成や項目の追加の際は、`.codex/agents/resources/spec-comparator/review-report-template.md` をテンプレートとして利用する。


#### **Comparison Report** の出力フォーマット
- **レビュー対象**
- **レビュー履歴**
- **評価モード**
- **総合評価**: スコアと評価マトリクス
- **良い点**: ポジティブなフィードバック (最低3つ)
- **改善が必要な点**: 優先度別に整理(この項目は、該当する指摘がある場合のみ記載)
   - [必須] 重大な問題
   - [推奨] 改善推奨
   - [提案] さらなる改善
- **参考資料**: 役立つリソース(任意項目)
- **指摘リスト**
- **対応内容一覧**: 依頼元記述欄(spec-comparatorはこの項目への記述は行わない。)※1

> ※1 依頼元記述欄。初回はテンプレートの形式まま、下記記載例やプレースホルダーなどもすべて維持した状態でレポートに加え、依頼元に渡してください。
  再レビュー時は、依頼元が記録した内容を保持してください。


### Step 3: Dependency Documentsごとの比較の反復

未評価の **Dependency Document** が存在する場合は、次の **Dependency Document** を対象としてStep 1およびStep 2を繰り返す。

すべての **Dependency Documents** について比較・評価が完了した後、Scoring Policyに従って各比較結果から最新総合スコアを算出し、**Comparison Report** を完成させる。

### Step 4: 依頼元へのレビュー結果の報告
レビューレポートの要点を抽出し、レビュー結果が**Review Completion Criteria**を満たしているかを判断した上で、依頼元に下記の形式で報告する。

#### 報告形式

```markdown
# ドキュメントレビュー結果

## ドキュメント: [ファイル名]

## レビューレポート: [ファイル名含むパス]

## レビュー結果
[対応が必要です。or Review Completion Criteriaを満たしています。]

## 改善点
<!-- 各項目は、指摘リストに該当する項目がある場合のみ記載する -->

### 新たに追加された指摘
1. [指摘1]: [改善案] (優先度: 高/中/低)
   - **対象**: `[Review Subject]` > `[Section]` / **比較元**: `[Dependency Document]` > `[Section]`
2. [指摘2]: [改善案] (優先度: 高/中/低)
   - **対象**: `[Review Subject]` > `[Section]` / **比較元**: `[Dependency Document]` > `[Section]`
3. [指摘3]: [改善案] (優先度: 高/中/低)
   - **対象**: `[Review Subject]` > `[Section]` / **比較元**: `[Dependency Document]` > `[Section]`

### OPENのままの指摘
1. [指摘1]: [改善案] (優先度: 高/中/低)
   - **対象**: `[Review Subject]` > `[Section]` / **比較元**: `[Dependency Document]` > `[Section]`
2. [指摘2]: [改善案] (優先度: 高/中/低)
   - **対象**: `[Review Subject]` > `[Section]` / **比較元**: `[Dependency Document]` > `[Section]`
3. [指摘3]: [改善案] (優先度: 高/中/低)
   - **対象**: `[Review Subject]` > `[Section]` / **比較元**: `[Dependency Document]` > `[Section]`

### 今回の対応によってCLOSEした指摘
1. [指摘1] (優先度: 高/中/低)
   - **対象**: `[Review Subject]` > `[Section]` / **比較元**: `[Dependency Document]` > `[Section]`
2. [指摘2] (優先度: 高/中/低)
   - **対象**: `[Review Subject]` > `[Section]` / **比較元**: `[Dependency Document]` > `[Section]`

## 総合評価
<!-- 最新総合スコア -->
[1-5]/5

詳細はレビューレポートを参照してください。
```