# Comparison Review

## Inputs
本Flowを利用する場合は、Flowの開始前に以下のInputを定義する。
明示的にOptionalと規定があるもの以外は全て必須項目とする。

### **Review Sources**
Artifactの作成において前提情報として使用する文書のパス。
複数指定可。

### **Artifacts**
本Flowによって作成または更新する成果物のパス。
複数指定可。

### **Comparison Review Report**
`spec-comparator`が作成・更新する比較レビューレポートの出力先のパス。

### **Specific Review Points Sheet**
Optional項目。ただし、**Required Artifact Review** の指定がない、もしくはその値が `true` の場合は必須。
`document-reviewer`によるArtifact Reviewで使用する、Artifact固有のレビュー観点表のパス。

Required Artifact Review true　の場合必ず受け取る

### **Required Artifact Review**
Optional項目。指定は任意とする。比較レビュー後にArtifact自体の詳細レビューを依頼するか。

### **Scope**
Optional項目。指定は任意とする。本Flowにおける作業対象および変更対象の範囲。

## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- 各StepはProcedure Stepsに記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。ただし、承認不要と明記のあるStepはその内容を優先する。
- Procedure Stepsの開始時、既存の**Artifacts**が存在する場合は、既存の構造と内容を維持しながら更新を行う。
- 本FlowによるArtifactの新規作成または変更は、本Flowの全工程が完了した時点で確定したものとして扱う。ArtifactにChange Historyが存在する場合は、この単位を1件の履歴として記録する。

## Action after Review
Request Reviewを行う工程で結果を受け取った後の対応については、以下に規定する。
```
.agents/resources/actions-after-review.md
```

## List of Step
- Request Specification Comparison Review
- Request Artifacts Review
- Move **Draft** and Review Report to Steering for the Current Train

## Procedure Steps
### Step 1: Request Specification Comparison Review
Agent `spec-comparator` に **Sources**と**Artifacts** の比較レビューを依頼する。

依頼時には、以下の情報を明示する。
 - レビュー対象となる **Artifacts** のパス
 - 比較対象として、 **Sources** のパス
 - 比較レビューレポートの出力先 **Comparison Review Report**のパス
 - 前項で選択された**Evaluation Mode**
 - **Review Scope** *(Optional)*: **Input**で指定された**Scope**がある場合、その内容

レビュー結果を受領した後の対応については、後述の**Action after Review** の規定に従う。

### Step 2: Request Artifacts Review
Input で **Required Artifact Review** の指定が連携されており、かつその値が `false` の場合は、本Stepは行わずskipし、次のStepへ進む。

Agent `document-reviewer` に **Artifacts** のレビューを依頼する。

依頼時には、以下の情報を明示する。
 - レビュー対象となる **Artifacts** のパス
 - 比較対象として、 **Sources** のパス
 - **Specific Review Points Sheet**のパス
 - 前項で選択された**Evaluation Mode**
 - **Review Scope** *(Optional)*: **Input**で指定された**Scope**がある場合、その内容を連携する。

レビュー結果を受領した後の対応については、**Action after Review** の規定に従う。

レビューレポートの出力先については**Specific Review Points Sheet**から確認すること。

### Step 3: Move **Draft** and Review Report to Steering for the Current Train
前項までの全ての工程が完了したとき、今回の工程にて作成または受け取った **Draft** およびReview Reportsを、Current TrainのSteering領域にあるManagerディレクトリ下のそれぞれ対応する場所に移動する。

- **Scope**が指定されている場合は、移動対象の各ファイルについて、Scopeの対象を簡潔に識別できるkebab-caseの名称を導出し、ファイル名の拡張子直前に`-scope-<scope-name>`を付与してから移動する。
