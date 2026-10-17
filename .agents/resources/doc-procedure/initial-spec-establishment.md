# Initial Spec Establishment

## Inputs
本Flowを利用する場合は、Flowの開始前に以下のInputを定義する。
明示的にOptionalと規定があるもの以外は全て必須項目とする。

### **Sources**
Artifactの作成において前提情報として使用する文書のパス。
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
本Principleは、各Module内におけるPhase間の進行およびPromotion順序を規定するものであり、Module間のExecution OrderやPhaseの同期を要求するものではない。あるModuleをIntegrationへPromotionするための条件として、他Moduleが同一Phaseまで完了していることを要求しない。(例えば、Frontend ModuleのDevelopmentの完了は、Backend ModuleのIntegrationへのPromotionの前提条件とはならない) 

ただし、Releaseへの進行については本Principleとは別の全体進行上の条件として、全ModuleのIntegrationが完了していることを前提とする。

Current Trainにおける各Module(定義についてはプロジェクトルールの用語定義を参照)のDevelopmentからReleaseまでの進行は、原則として以下の順序とする。

`Development` → `Integration` → `Release`

- **Development**: 作業ブランチまたは修正ブランチにて、Current Trainで当該Moduleに必要となるすべての要件または機能の構築・開発・改修を完了する。
- **Integration**: Development完了後、作業・修正ブランチを統合ブランチへ統合し、検証環境（stg等）へ反映した上でIntegration Testを実施する。
- **Release**: Integration完了後、Release開始が可能な状態になったら、統合ブランチをリリース用ブランチへ統合し、本番環境へReleaseを実施する。

各Moduleについて前段階が完了する前に後続段階へ進まず、Development中の変更を直接検証環境または本番環境へPromotionせず、Integration Testが完了していない変更を本番環境へPromotionしない。

各Phaseは、**Current Train**で当該Moduleに必要となる一連の変更をまとめて完了させた上で次のPhaseへ進行し、個々のTaskや構成要素ごとに `Development → Integration → Release` を繰り返さない。

例えばInfrastructureでは、VPC、S3その他の個々のResourceごとにIntegrationおよびReleaseまで進めるのではなく、**Current Train**で対象Moduleに割り当てられたInfrastructure ResourceのDevelopmentを完了した後、それらを一体としてIntegration、Releaseの順に進行する。

## Discussion Policy
### **Discussion Principles**
- Skillに確認・議論方法について固有の規定がある場合は、その規定を本項の共通Policyより優先する。
- Discussionにおける確認や議論は常に**Guide**と**Sources**を参照しながら進める。
- 確認や議論は、**Guide**が**Artifacts**に対して求めている内容を十分に意識して行う。
- **Phase Progression Principle** に矛盾しない設計を行うことを意識する。
- 確認は、それまでの内容を踏まえた複数の選択肢のサジェストとセットで行う。
- ただし、**Guide**の内容について、**Subsection**単位で設計事項を分割せず、**Section**単位の記載例および特記事項を中心とする形式で構成されている場合は、まずその**Section**で定義すべき内容の全体像を**Sources**から導出し、ユーザーに提示する。その上で、判断が必要となった細部の事項についてユーザーに対して議論や選択を求める。
- ユーザーに確認を行う際、回答を受けたら、記録前に内容を精査する。その結果、要求や設計として十分に整理され、ユーザーとの合意が得られたと判断できた場合、回答内容を整理して**Draft**に記録する。そうでない場合は、そう判断できるようになるまで、ユーザーと議論を繰り返す。

### **Scope and Applicability**
- 任意のセクションは、まずその項目を定義するかを確認する。
- **Sources**、それまでに確認・決定した内容、および指定されている場合は**Scope**を踏まえ、対象のSectionまたはその配下の項目がProjectに適用されない、または定義する必要がない可能性がある場合は、無理に具体的な内容を生成せず、対象外または定義しないことも選択肢として提示し、ユーザーに確認する。

### **Sources and Draft Management**
- **Draft**にはあくまで、**Guide**に沿って定義する要求や設計の内容のみを記録し、参照元や、記録方針、検討状況などは記録しない。ただし、**Scope**の指定がある場合は、同内容をDraft冒頭に記録する。
- **Sources**に十分な情報が記載されている項目については、内容の再確認を行わない。
- 各**Section**の確認を行う際は、まず、**Sources**にてどの情報が充足・不足しているのか、また不足要素の有無を示す。
- 各**Section**について**Sources**にすでに十分に記録されている内容についてはDraftへ重複して記録せず、**Guide**に対して不足している部分のみを確認および記録によって補う。

## List of Step
- Validate Inputs
- Understand Sources and Guide
- Discuss and Draft
- Refine Draft and Check Consistency
- Generate or Modify Artifacts
- Check Artifacts Consistency
- Select the Evaluation Mode for the following Artifacts Review
- Request Artifacts Review
- Move **Draft** and Review Report to Steering for the Current Train

## Procedure Steps

### Step 0: Validate Inputs
- **Inputs**における必須項目が全て情報として揃っていることを確認する。


### Step 1: Understand Sources and Guide
- **Sources**と**Guide**の内容を一通り読み、定義すべき内容とその前提となる情報を確認する。

※なおこの作業に承認は不要。

### Step 2: Discuss and Draft

1. まず、本項の **Discussion Policy** の内容を把握する。
2. **Draft** のファイルを作成する。
3. **Scope** の指定がある場合は、その内容を**Draft**の冒頭に記録する。以降のStepでは、**Scope**の内容は**Draft**から確認する。
4. **Artifact** ごとに、以下の確認・議論を実施する。
   - **Section** ごとに、さらにその配下に **Subsection** が存在する場合は **Subsection** ごとに、**Guide** が示す定義方針・内容と **Sources** の内容を比較する。
   - ただし、**Scope** が指定されている場合は、**Scope** に含まれる作業対象および変更対象を踏まえて比較し、確認・議論の対象を **Scope** を満たすために必要な範囲に限定する。
   - **Sources** の内容だけでは不足する観点についてユーザーと確認・議論し、その内容について合意が取れたら都度 **Draft** に記録する。
   - 各 **Section** および **Subsection** について、**Guide** に定義された記載内容を十分に満たせる情報が揃うまで確認を行い、揃い次第、次の **Subsection** または **Section** へ進む。
5. 複数の **Artifact** について指定がある場合は、すべての **Artifact** について `4.` を繰り返す。

### Step 3: Refine Draft and Check Consistency
1. ここまでの**Draft**の内容を維持したまま、重複や表現を整理し、文書全体を一貫した内容に整える。また、各SectionまたはSubsectionの内容が、それより前方に記述された内容に対する制約や前提となっている場合は、その関係を確認し、必要に応じて前方の関連箇所を整合するように修正する。
2. 整理した**Draft**が**Sources**と比較して一貫しているかを確認する。
3. 整理した**Sources**と**Draft**を合わせた内容が**Guide**に沿ったものになっているかを確認する。
4. **Draft**の内容が、**Phase Progression Principle** に矛盾しない設計になっているかを確認する。

### Step 4: Generate or Modify Artifacts
**Sources**と**Draft**の内容を元に、**Guide**に沿って**Artifacts**を新規の場合は作成、既存の場合は修正する。

#### Creation/Modification Guideline
- **Artifacts**を作成・修正する際は、**Template** をテンプレートとして利用する。
- 複数の **Artifact** について指定がある場合は、**Artifact**ごとに一つずつ作成・修正する。
- **Sources** および **Draft** に含まれる内容を欠落させることなく、適切な **Section** に反映すること。特に機能要件の項目を扱う際には、この点に一層注意を払うこと。
- **Draft** の各**Section** / **Subsection** に記録された内容について、**Template** にその内容を表現するための領域・項目が存在しない場合は、**Template** に示された**Section**の目的および形式に沿って、必要な記述・表・図等を追加し、内容を欠落なく反映する。ただし、**Template** にあらかじめ定義されている表については、そのColumnを追加・削除・変更しない。
- **Artifacts**を作成・修正する際、採用か本Train対象外かつ将来候補か永久的スコープアウトか、についての言及がこれまでの合意の中にある場合は、合意した位置づけを維持して反映する。

### Step 5: Check Artifacts Consistency
1. 作成した **Artifacts** が **Draft** の内容を欠落なく反映しているかを確認する。
2. 作成した **Artifacts** が **Guide** に沿った内容になっているかを確認する。
3. 作成した **Artifacts** が利用した**Template** に沿った内容になっているかを確認する。

内容が確定したら、ここまでの内容をコミットする。

### Step 6: Select the Evaluation Mode for the following Artifacts Review
ユーザーに後述のReview工程におけるレビュー強度(**Evaluation Mode**)をEasy/Medium/Proの中から選択させる。


### Step 7: Request Artifacts Review
Agent `document-reviewer` に **Artifacts** のレビューを依頼する。

依頼時には、以下の情報を明示する。
 - レビュー対象となる **Artifacts** のパス
 - 比較対象として、 **Sources** のパス
 - **Specific Review Points Sheet**のパス
 - 前項で選択された**Evaluation Mode**
 - **Review Scope** *(Optional)*: **Input**で指定された**Scope**がある場合、その内容を連携する。

レビュー結果を受領した後の対応については、後述の**Action after Review** の規定に従う。

レビューレポートの出力先については**Specific Review Points Sheet**から確認すること。

### Step 8: Move **Draft** and Review Report to Steering for the Current Train
前項までの全ての工程が完了したとき、今回の工程にて作成または受け取った **Draft** およびReview Reportsを、Current TrainのSteering領域にあるManagerディレクトリ下のそれぞれ対応する場所に移動する。

- **Scope**が指定されている場合は、移動対象の各ファイルについて、Scopeの対象を簡潔に識別できるkebab-caseの名称を導出し、ファイル名の拡張子直前に`-scope-<scope-name>`を付与してから移動する。


## Action after Review
Request Reviewを行う工程で結果を受け取った後の対応については、以下に規定する。
```
.agents/resources/action-after-review.md
```