# Change Requirement Definition

## Inputs
本Flowを利用する場合は、Flowの開始前に以下のInputを定義する。
明示的にOptionalと規定があるもの以外は全て必須項目とする。

### **Sources**
Artifactの作成において前提情報として使用する文書のパス。
複数指定可。
- 実際の工程においては、指定パスのうちファイルが存在するもののみを扱う。

### **Affected Modules**
本Flowによる仕様の定義または更新によって、影響を受ける可能性のあるModuleのパス。
複数指定可。

### **Draft**
ユーザーとの確認・議論によって具体化・合意した内容を記録する作業文書のパス。

### **Artifacts**
本Flowによって作成または更新する成果物のパス。
複数指定可。

### **Guide**
Artifactsに定義する内容、その検討観点および記述内容の指針を定めるContent Guideのパス。

### **Template**
各Artifactの作成に使用するTemplateのパス。

### **Specific Review Points Sheet**
`document-reviewer`によるArtifact Reviewで使用する、Artifact固有のレビュー観点表のパス。

### **Scope**
Optional項目。指定は任意とする。本Flowにおける作業対象および変更対象の範囲。

## Return
下記を呼び出し元に返却する。

- **Flow Required**(Optional): `True` / `False`
  - 本Flowの実行が、使用時の目的に照らして必要かどうかを示す。
  - `False`と判断された場合は、明示的に返却する。

## Derived Resources

### **CR Sources**

以下を **CR Sources** として使用する。

- `docs/ideas/development-concept-planning.md`
- `docs/change-requirements/` 配下に、**Sources** と同名のファイルが存在する場合、そのファイル(これについては**Sources**側のファイルの存在の有無は問わない)

### **Change Requirements**
**Change Scope Identification** によって対応対象となった各 **Artifact** について、`docs/persistent/` からの相対パスを維持したまま、配置先を `docs/change-requirements/` に置き換えたパスに **Change Requirements** を作成する。

**Example:**
- `docs/persistent/function-design.md`
  → `docs/change-requirements/function-design.md`
- `docs/persistent/details/table/user-table-spec.md`
  → `docs/change-requirements/details/table/user-table-spec.md`

## Glossary
### **Change Requirement Type**
- **NEW**: 新たなArtifactを成立させるためのChange Requirement。
- **UPDATE**: 既存Artifactに対して追加・修正を行うためのChange Requirement。

## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- 各StepはProcedure Stepsに記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。ただし、承認不要と明記のあるStepはその内容を優先する。
- Procedure Stepsの開始時、既存の**Artifacts**が存在する場合は、既存の構造と内容を維持しながら更新を行う。
- 本FlowによるArtifactの新規作成または変更は、本Flowの全工程が完了した時点で確定したものとして扱う。ArtifactにChange Historyが存在する場合は、この単位を1件の履歴として記録する。
- **Phase Progression Principle** に沿って設計を行う。またこれに矛盾しないよう、各Phaseの進行順序を遵守した内容になるように注意する。

## **Phase Progression Principle**
Current Trainにおける各ModuleのDevelopmentからReleaseまでの進行は、原則として以下の順序とする。

※Module: Infrastructureのawsやgcp、Frontendのwebやios、Backendの特定のマイクロサービスなど。詳しくはプロジェクトルールのGlossaryを参照

`Development` → `Integration` → `Release`

本Principleは、各Module内におけるPhase間の進行およびPromotion順序を規定するものであり、Module間のExecution OrderやPhaseの同期を要求するものではない。あるModuleのDevelopment、Integrationへの進行条件として、他Moduleが同一Phaseまで完了していることを要求しない。ただし、Releaseへの進行については本Principleとは別の全体進行上の条件として、全ModuleのIntegrationが完了していることを前提とする。

- **Development**: 作業ブランチまたは修正ブランチにて、Current Trainで当該Moduleに必要となるすべての要件または機能の構築・開発・改修を完了する。
- **Integration**: Development完了後、作業・修正ブランチを統合ブランチへ統合し、検証環境（stg等）へ反映した上でIntegration Testを実施する。
- **Release**: Integration完了後、Release開始が可能な状態になったら、統合ブランチをリリース用ブランチへ統合し、本番環境へReleaseを実施する。

各Moduleについて前段階が完了する前に後続段階へ進まず、Development中の変更を直接検証環境または本番環境へPromotionせず、Integration Testが完了していない変更を本番環境へPromotionしない。

各Phaseは、**Current Train**で当該Moduleに必要となる一連の変更をまとめて完了させた上で次のPhaseへ進行し、個々のTaskや構成要素ごとに `Development → Integration → Release` を繰り返さない。

例えばInfrastructureでは、VPC、S3その他の個々のResourceごとにIntegrationおよびReleaseまで進めるのではなく、**Current Train**で必要となるInfrastructure ResourceのDevelopmentを完了した後、それらを一体としてIntegration、Releaseの順に進行する。

## Discussion Policy
**Discuss and Draft**は、常に以下に従って実施する。

### **Discussion Principles**
- Skillに確認・議論方法について固有の規定がある場合は、その規定を本項の共通Policyより優先する。
- Discussionにおける確認や議論は常に**Guide**、**CR Sources**、**Sources**を参照しながら進める。
- 確認や議論は、**Guide**が**Artifacts**に対して求めている内容を十分に意識して行う。
- **Phase Progression Principle** に矛盾しない設計を行うことを意識する。
- 確認は、それまでの内容を踏まえた複数の選択肢のサジェストとセットで行う。
- ただし、**Guide**の内容について、**Subsection**単位で設計事項を分割せず、**Section**単位の記載例および特記事項を中心とする形式で構成されている場合は、まずその**Section**で定義すべき内容の全体像を**CR Sources**から導出し、ユーザーに提示する。その上で、判断が必要となった細部の事項についてユーザーに対して議論や選択を求める。
- ユーザーに確認を行う際、回答を受けたら、記録前に内容を精査する。その結果、要求や設計として十分に整理され、ユーザーとの合意が得られたと判断できた場合、回答内容を整理して**Draft**に記録する。そうでない場合は、そう判断できるようになるまで、ユーザーと議論を繰り返す。

### **Scope and Applicability**
- 任意のセクションは、まずその項目を定義するかを確認する。
- **CR Sources**、それまでに確認・決定した内容、および指定されている場合は**Scope**を踏まえ、対象のSectionまたはその配下の項目がProjectに適用されない、または定義する必要がない可能性がある場合は、無理に具体的な内容を生成せず、対象外または定義しないことも選択肢として提示し、ユーザーに確認する。
- **Scope** が指定されている場合は、**Scope** に含まれる作業対象および変更対象を踏まえて比較し、確認・議論の対象を **Scope** を満たすために必要な範囲に限定する。

### **Sources and Draft Management**
- **Draft**にはあくまで、**Guide**に沿って定義する要求や設計の内容のみを記録し、参照元や、記録方針、検討状況などは記録しない。ただし、**Scope**の指定がある場合は、同内容をDraft冒頭に記録する。
- **CR Sources**および**Sources**に十分な情報が記載されている項目については、内容の再確認を行わない。
- 各**Section**の確認を行う際は、まず、**CR Sources**および**Sources**にてどの情報が充足・不足しているのか、また不足要素の有無を示す。
- 各**Section**について**CR Sources**および**Sources**にすでに十分に記録されている内容についてはDraftへ重複して記録せず、**Guide**に対して不足している部分のみを確認および記録によって補う。

## List of Step
- Validate Inputs
- Prepare Draft

── Change Scope Identification ──

- Identify Specified Scope
- Identify New Specifications
- Identify Updates to Existing Specifications
- Determine Whether Change Requirements Are Needed

── Change Requirement Definition ──

- Understand Sources and Guide
- Discuss and Draft for CR Type `NEW`
- Discuss and Draft for CR Type `UPDATE`
- Refine Draft and Check Consistency
- Analyze Impact on Affected Modules
- Generate or Modify Change Requirements
- Validate Change Requirements
- Select the Evaluation Mode for the following Reviews
- Request Change Requirements Consistency Review
- Apply Change Requirements to Artifacts
- Request Artifacts Review
- Move **Draft** and Review Report to Steering for the Current Train


## Procedure Steps

### Step 0: Validate Inputs
- **Inputs**における必須項目が全て情報として揃っていることを確認する。

### Step 1: Prepare Draft
- **Draft**のファイルを作成する。

### Step 2: Identify Scope
- **Inputs**にて、**Scope** の指定を受け取っていない場合は、本Stepをスキップする。
- **Scope** の指定がある場合は、以下に従う。
  - その指定内容から、**Artfact**の追加が必要か、更新が必要か判断する。
  - 追加の場合は`Type: NEW`、更新の場合は`Type: UPDATE` の **Change Requirement** を `REQUIRED` として **Draft** に記録する。
  - **Scope** の指定の内容を**Draft**に記録する。
  - ※以降のStepでは、**Scope**の内容は**Draft**から確認する。
  - Change Scopeは既に特定されているものとしてStep 3からStep 5をスキップし、Step 6へ進む。

### Step 3: Identify New Specifications
**Artifacts** に指定された各パスにおいて、それぞれのファイルが存在するかを確認する。

- すべてのArtifactが既に存在する場合、`Type: NEW` の **Change Requirement** を`NOT REQUIRED`として **Draft** に記録する。

- 存在しないArtifactがある場合、そのうちのいずれかについて、そのArtifactの名前(ファイル名)が示す対象、あるいはそれに関する内容が、CR Sources の中で言及されているかを`Yes/No`で判断する。
  - `Yes`の場合、`Type: NEW` の **Change Requirement** を`REQUIRED`とし、言及があるものについては、そのArtifact名を全て **Draft** に記録する。
  - `No`の場合、`Type: NEW` の **Change Requirement** を`NOT REQUIRED`として **Draft** に記録する。

### Step 4: Identify Updates to Existing Specifications
**Artifacts** に指定された各パスにおいて、それぞれのファイルが存在するかを確認する。

- 存在する**Artifact**が1つもない場合、`Type: UPDATE` の **Change Requirement** を `NOT REQUIRED` として **Draft** に記録する。

- 存在する**Artifact**が1つ以上ある場合、Agent `explorer` に、存在する**Artifact**、**CR Sources**、**Guide** のパスを連携の上、以下の調査を依頼する。

``` text
**CR Sources** を、**Artifacts** および **Guide** と参照・比較し、本変更によって追加または更新が必要となる可能性のある**Artifact** および、その **Section・Subsection** があるか(`Yes / No`)を特定する。
  - `Yes`の場合、`Type: UPDATE` の **Change Requirement** = `REQUIRED` と判断する。また、対象となる **Artifact** を特定した上で、Artifactごとに追加・更新対象となる **Section・Subsection** を整理し、それぞれについて「追加 / 更新」の種別を区別・明示してリストアップする。
  - `No`の場合、`Type: UPDATE` の **Change Requirement** = `NOT REQUIRED` と判断する。
```

Agentに依頼する際は、以下の形式・内容で報告してもらい、その内容を **Draft** に記録する。
- **Change Requirement** `Type: UPDATE`: `REQUIRED` / `NOT REQUIRED`
- **Target Artifacts**: `REQUIRED`の場合、追加・更新対象となるArtifactのリスト
  - **Target Sections**: Artifactごとに「追加 / 更新」の種別を明示した、対象Section・Subsectionのリスト

### Step 5: Determine Whether Change Requirements Are Needed
前項までの結果として、**Draft** に記録されたすべての **Change Requirement** が `NOT REQUIRED` である場合、**Flow Required**=`False` を呼び出し元に返却し、以降のStepは実施せず、本Flowを終了する。

Otherwise、以降のStepへ進む。

### Step 6: Understand Sources and Guide
1. **CR Sources**と現状の**Draft**から今回の変更対応の内容を理解する。
2. **Guide**と**Sources**の内容を一通り読み、定義すべき内容とその前提となる情報を確認する。

※なおこの作業に承認は不要。

### Step 7: Discuss and Draft for CR Type `NEW`
**Draft** にて、`Type: NEW` の **Change Requirement** が `REQUIRED` の場合にのみ、本Stepを実行する。**Otherwise**、本Stepをスキップする。

1. まず、本項の **Discussion Policy** の内容を把握し、その規定に沿って議論を進める。
2.  **Draft** に記録された `Type: NEW` の対象**Artifact** ごとに、以下の確認・議論を実施する。
   - **Section** ごとに、さらにその配下に **Subsection** が存在する場合は **Subsection** ごとに、**Guide** が示す定義方針・内容を、 **CR Sources** および **Sources** の内容と照らして確認していく。
   - **CR Sources** や **Sources** の内容だけでは不足する観点についてユーザーと確認・議論し、その内容について合意が取れたら都度 **Draft** に記録する。
   - 各 **Section** および **Subsection** について、**Guide** に定義された記載内容を十分に満たせる情報が揃うまで確認を行い、揃い次第、次の **Subsection** または **Section** へ進む。
3. 本step対象の **Artifact** が複数である場合は、そのすべての **Artifact** について `2.` を繰り返す。


### Step 8: Discuss and Draft for CR Type `UPDATE`
`Type: UPDATE` の **Change Requirement** が `REQUIRED` の場合にのみ、本Stepを実行する。**Otherwise**、本Stepをスキップする。

1. 本項の **Discussion Policy** を把握し、その規定に沿って議論を進める。
2. **Draft** に記録された `Type: UPDATE` の対象ArtifactおよびTarget Sectionsごとに、以下を実施する。
   - 対象Section・Subsectionに対応する 既存の**Artifact** と **Guide** の内容を確認していく。
   - 対象Section・Subsectionが**追加対象**か**更新対象**かを改めて判断する。
   - AS-IS として、**更新対象**の場合は対象の現在の定義を、**追加対象**の場合は追加先およびその前後を含む周辺の現在の定義を把握する。
   - **CR Sources**、**Sources** および **Guide** を踏まえ、必要な `TO-BE` をユーザーと確認・議論し、合意が取れたら都度AS-IS、TO-BE および必要な変更内容を **Draft** に記録する。
   - 各 **Section** および **Subsection** について、`AS-IS` および **Guide** が示す定義内容を踏まえ、追加または更新によって実現する `TO-BE` と、そのために必要な変更内容が十分に具体化されるまで確認・議論を継続する。
   - 上記条件が満たされ次第、次の **Subsection** または **Section** へ進む。
3. 本step対象の **Artifact** が複数である場合は、そのすべての **Artifact** について `2.` を繰り返す。

### Step 9: Refine Draft and Check Consistency
1. ここまでの**Draft**の内容を維持したまま、重複や表現を整理し、文書全体を一貫した内容に整える。また、各SectionまたはSubsectionの内容が、それより前方に記述された内容に対する制約や前提となっている場合は、その関係を確認し、必要に応じて前方の関連箇所を整合するように修正する。
2. 整理した**Draft**が、**CR Sources**や**Sources**と比較して一貫しているかを確認する。
3. 整理した**CR Sources**や**Sources**と**Draft**を合わせた内容が**Guide**に沿ったものになっているかを確認する。
4. **Draft**について、`Type: UPDATE` の**Change Requirement**に関する内容については、`AS-IS` が既存の **Artifact** と整合していること、および `TO-BE` や必要な変更内容が変更対象外の既存定義と矛盾なく成立することを確認する。
5. **Draft**の内容が、**Phase Progression Principle** に矛盾しない設計になっているかを確認する。

### Step 10: Analyze Impact on Affected Modules
**Affected Modules** が指定されている場合にのみ、本Stepを実行する。**Otherwise**、本Stepをスキップする。

1. Agent `explorer` に、**Affected Modules**と**Draft**のパスを連携し、以下の調査を依頼する。

```text
**Affected Modules** の既存実装を調査し、**Draft** に記録された変更内容を適用することによって、既存実装への影響に関する懸念または不整合が生じる可能性がないかを確認する。

懸念または不整合がある場合は、その内容、該当箇所および理由を報告する。
該当するものがない場合は、その旨を報告する。
```

2. Agent `explorer` から懸念または不整合について報告があった場合は、その内容をユーザーに共有し、対応するかを確認する。いずれも対応しない場合は、その理由を **Draft** に記録し、本Stepを終了。次のStepに進む。
3. 対応する場合は、ユーザーと対応内容を確認・議論し、合意した内容を **Draft** に反映する。「対応しない」となった場合は、その理由を **Draft** に記録する。

4. **Draft** を修正した場合は、修正後の **Draft** と、前回報告された懸念または不整合に対する対応内容をAgent `explorer` に連携し、1. の調査を再度依頼する。

5. Agent `explorer` から新たに対応判断が必要な懸念または不整合が報告されなくなるまで、2. から 4. を繰り返す。


### Step 11: Generate or Modify Change Requirements
**CR Sources**、**Sources**、**Draft**の内容を元に、**Guide**に沿って**Change Requirements**を新規の場合は作成、既存の場合は修正する。パスおよびファイル名については、**Derived Resources** に従って決定する。

- `Type: NEW` の **Change Requirement** については、対象 **Artifact** に対応する **Template** 全体を使用し、**Guide** が示す定義内容を一通り満たす形で作成・修正する。

- `Type: UPDATE` の **Change Requirement** については、**Draft** に記録された対象 **Section**・**Subsection** の範囲に限定して作成・修正する。各対象について、対象 **Artifact** の現在の定義との対応を確認しながら、`AS-IS`、`TO-BE` およびその間に必要となる追加・更新内容を、**Template** の対応する構造に沿って明確に表現する。

#### Creation/Modification Guideline
- **Change Requirements**を作成・修正する際は、**Template** をテンプレートとして利用する。
- 対象の**Artifact** が複数ある場合は、**Artifact**ごとに**Change Requirement**を一つずつ作成・修正する。
- **CR Sources**、**Sources** および **Draft** に含まれる内容を欠落させることなく、適切な **Section** に反映すること。
- **Draft** の各**Section** / **Subsection** に記録された内容について、**Template** にその内容を表現するための領域・項目が存在しない場合は、**Template** に示された**Section**の目的および形式に沿って、必要な記述・表・図等を追加し、内容を欠落なく反映する。ただし、**Template** にあらかじめ定義されている表については、そのColumnを追加・削除・変更しない。
- **Change Requirements**を作成・修正する際、採用か本Train対象外かつ将来候補か永久的スコープアウトか、についての言及がこれまでの合意の中にある場合は、合意した位置づけを維持して反映する。

### Step 12: Validate Change Requirements
1. 作成した **Change Requirements** が **Draft** の内容を欠落なく反映しているかを確認する。
2. 作成した **Change Requirements** が **Guide** に沿った内容になっているかを確認する。
3. 作成した **Change Requirements** が利用した**Template** に沿った内容になっているかを確認する。

内容が確定したら、ここまでの内容をコミットする。

### Step 13: Select the Evaluation Mode for the following Reviews
ユーザーに後述のReview工程におけるレビュー強度(**Evaluation Mode**)をEasy/Medium/Proの中から選択させる。

### Step 14: Request Change Requirements Consistency Review
前項までに、 `Type: UPDATE` の **Change Requirements** を作成した場合、本Stepを実行する。Otherwise、本Stepをスキップする。

Agent `spec-comparator` に **Artifacts**と**Change Requirements** の比較レビューを依頼する。

依頼時には、以下の情報を明示する。
 - レビュー対象となる `Type: UPDATE` の**Change Requirements** のパス
 - 比較対象として、 `Type: UPDATE` の**Artifacts** のパス
 - 比較レビューレポートの出力先のパス(`docs/reviews/<artifacts-name>-cr-report.md`)
   - ※ `<artifacts-name>` は **Artifacts** のファイル名、複数ある場合はそれらを包括した名前
 - 前項で選択された**Evaluation Mode**
 - **Review Scope** *(Optional)*: **Input**で指定された**Scope**がある場合、その内容を連携する。

レビュー結果を受領した後の対応については、後述の**Action after Review** に従う。

### Step 15: Apply Change Requirements to Artifacts

前項までに確定した **Change Requirements** を、対応する **Artifacts** に反映する。

- `Type: UPDATE` の **Change Requirement** については、`AS-IS` と `TO-BE` および定義された追加・更新内容を踏まえ、対応する **Artifact** の対象 **Section**・**Subsection** に変更を反映する。
  - 変更対象として定義されていない内容は維持する。
- `Type: NEW` の **Change Requirement** については、その内容を対応する **Artifact** のパスへコピーし、新たな **Artifact** として作成する。

すべての **Change Requirements** の反映が完了したら、本Flowにおいて実施した変更内容の全容を整理し、**Draft** の末尾に総括として記録する。
  - 新規作成した **Artifacts**
  - 追加・更新した **Artifacts** および **Section**・**Subsection**
  - 各対象に対して実施した変更内容

内容が確定したら、ここまでの内容をコミットする。

### Step 16: Request Artifacts Review
Agent `document-reviewer` に **Artifacts** のレビューを依頼する。

依頼時には、以下の情報を明示する。
 - レビュー対象となる **Artifacts** のパス
- 比較対象として、 **Sources** のパス
 - **Specific Review Points Sheet**のパス
 - 前項で選択された**Evaluation Mode**
 - **Review Scope** : 前項で総括した内容。

レビュー結果を受領した後の対応については、後述の**Action after Review** の規定に従う。

レビューレポートの出力先については**Specific Review Points Sheet**から確認すること。

### Step 17: Move **Draft** and Review Report to Steering for the Current Train
前項までの全ての工程が完了したとき、今回の工程にて作成または受け取った **Draft** およびReview Reportsを、Current TrainのSteering領域にあるManagerディレクトリ下のそれぞれ対応する場所に移動する。

- **Scope**が指定されている場合は、移動対象の各ファイルについて、Scopeの対象を簡潔に識別できるkebab-caseの名称を導出し、ファイル名の拡張子直前に`-scope-<scope-name>`を付与してから移動する。


## Action after Review
Request Reviewを行う工程で結果を受け取った後の対応については、以下に規定する。
```
.agents/resources/action-after-review.md
```