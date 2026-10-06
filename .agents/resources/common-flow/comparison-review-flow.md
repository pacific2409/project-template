# Comparison Review Flow

## Inputs
本Flowを利用する場合は、Flowの開始前に以下のInputを定義する。
明示的にOptionalと規定があるもの以外は全て必須項目とする。

### **Sources**
Artifactの作成において前提情報として使用する文書のパス。
複数指定可。

### **Artifacts**
本Flowによって作成または更新する成果物のパス。
複数指定可。

### **Guide**
Artifactsに定義する内容、その検討観点および記述内容の指針を定めるContent Guideのパス。

### **Template**
各Artifactの作成に使用するTemplateのパス。

### **Comparison Review Report**
`spec-comparator`が作成・更新する比較レビューレポートの出力先のパス。

### **Specific Review Points Sheet**
`document-reviewer`によるArtifact Reviewで使用する、Artifact固有のレビュー観点表のパス。

### **Scope**
Optional項目。指定は任意とする。本Flowにおける作業対象および変更対象の範囲。

## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- 各StepはExecutionStepsに記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。ただし、承認不要と明記のあるStepはその内容を優先する。
- Execution Stepsの開始時、既存の**Artifacts**が存在する場合は、既存の構造と内容を維持しながら更新を行う。
- 本FlowによるArtifactの新規作成または変更は、本Flowの全工程が完了した時点で確定したものとして扱う。ArtifactにChange Historyが存在する場合は、この単位を1件の履歴として記録する。

## List of Step
- Request Specification Comparison Review
- Request Artifacts Review
- Move **Draft** and Review Report to Steering for the Current Train

## Execution Steps
### Step 1: Request Specification Comparison Review
Agent `spec-comparator` に **Sources**と**Artifacts** の比較レビューを依頼する。

依頼時には、以下の情報を明示する。
 - レビュー対象となる **Artifacts** のパス
 - 比較対象として、 **Sources** のパス
 - 比較レビューレポートの出力先 **Comparison Review Report**のパス
 - 前項で選択された**Evaluation Mode**
 - **Review Scope** *(Optional)*: **Input**で指定された**Scope**がある場合、その内容

レビュー結果を受領した後の対応については、後述の**Action after Review** に従う。

### Step 2: Request Artifacts Review
Agent `document-reviewer` に **Artifacts** のレビューを依頼する。

依頼時には、以下の情報を明示する。
 - レビュー対象となる **Artifacts** のパス
 - 比較対象として、 **Sources** のパス
 - **Specific Review Points Sheet**のパス
 - 前項で選択された**Evaluation Mode**
 - **Review Scope** *(Optional)*: **Input**で指定された**Scope**がある場合、その内容を連携する。

レビュー結果を受領した後の対応については、後述の**Action after Review** に従う。

レビューレポートの出力先については**Specific Review Points Sheet**から確認すること。

### Step 3: Move **Draft** and Review Report to Steering for the Current Train
前項までの全ての工程が完了したとき、今回の工程にて作成または受け取った **Draft** およびReview Reportsを、Current TrainのSteering領域にあるManagerディレクトリ下のそれぞれ対応する場所に移動する。

- **Scope**が指定されている場合は、移動対象の各ファイルについて、Scopeの対象を簡潔に識別できるkebab-caseの名称を導出し、ファイル名の拡張子直前に`-scope-<scope-name>`を付与してから移動する。


## Action after Review

Reviewerによるレビュー結果を受領した後は、Reviewの種類にかかわらず以下に従う。

### **1. Review Resultの共有**

Reviewerからレビュー結果の報告とReview Reportが返却されたら、その内容を確認する。

Reviewerからの口頭での報告内容は、Reviewerの回答形式のままユーザーへ漏れなく共有する。
その際、Review Reportについてユーザーへ共有するのは格納パスのみとし、Review Reportを確認するよう促すまでに止める。その内容自体は出力しない。

### **2. Review Completionの確認**

Reviewerから「レビュー完了基準を満たしている」という旨の報告を受け、かつ次のいずれかに該当する場合、当該Reviewを完了する。

- 新たに追加された指摘がなく、すべての指摘が `CLOSE` となっている。
- 残る指摘への対応を続行するか終了するかユーザーに確認し、終了する旨の回答を得た。

### **3. 指摘への対応**

上記の完了条件を満たさない場合、まだ `CLOSE` となっていない指摘について、一つずつユーザーと確認・議論し、必要な改善を行う。

各指摘について、以下をReview Reportの依頼元記述欄に記録する。

- 対応可否
- 対応する場合は、対応内容および修正箇所
- 対応しない場合は、その理由

一通りの指摘に対して必要な対応を行った後は、当該Reviewを依頼したStepへ戻り、同じReviewerへ再レビューを依頼する。その際、実施した対応内容もReviewerへ連携する。

当該Reviewが本項の完了条件を満たすまで、レビュー依頼と本項の対応を繰り返す。

### **Re-Review Guideline**

- **Artifacts**の改善、Review Reportへの記載、および再レビュー依頼を行う際は、都度その前にユーザーへ確認し、承認を得る。
