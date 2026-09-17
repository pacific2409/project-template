---
name: write-prd
description: >
  特定の具体的な作業を実施するWork型 Skill。
  開発アイデアをもとにプロダクト要求を具体化・定義し、その内容をもとに要求定義書(PRD)の作成または追記を行う。
  Use when: プロダクト要求定義時にのみ使用。
---

# Work Skill: write-product-requirement-definition

## Summary
開発アイデアをもとにプロダクト要求を具体化・定義し、その内容をもとに要求定義書(PRD)の作成または追記を行う。

## Source
このファイルの内容をもとにPRDを作成する。
```
docs/ideas/product-concept-planning.md
```

## 前提条件
- **Source** のファイルが作成されている。
- また**Source**に、プロダクトの基本的なアイデアが含まれている。

## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- 各StepはExecutionStepsに記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。ただし、承認不要と明記のあるStepはその内容を優先する。
- Execution Stepsの開始時、`docs/persistent/product-requirements.md`に既存のファイルが存在する場合は、既存PRDの構造と内容を維持しながら更新を行う


## Content Guide for the Skill (`references/guide.md`)
PRDに定義する内容、その検討観点および記述内容の指針を定める。このガイドを参照しながら要求定義を進める。

## Draft
要求内容の検討過程において、ユーザーと議論した内容を以下に記録する。
```
docs/drafts/product-requirements-draft.md
```

## Artifact
PRDは以下に保存する:
```
docs/persistent/product-requirements.md
```

## Sections of PRD
PRDは以下の **Section** によって構成する。
- プロジェクト方針
- プロダクト概要
- ターゲットユーザー(ペルソナ)
- 目標・完了条件(Goals)
- 成功指標(KPI) ※任意項目
- 機能要件
- 非機能要件
- スコープ外 ※任意項目

## Goal
- ExecutionStepsに定義されたすべてのStepが完了していること。
- **Artifact** の作成およびレビューが完了し、内容が承認されていること。

## Execution Steps
### Step 0: Input Source and Guide
**Source**と**Guide**の存在と、その内容を一通り読み込む。
なおこの作業に承認は不要。完了したら、

### Step 1: Discuss Requirements and Draft
1. まず、本項の**Discussion Policy**の内容を把握する。
2. **Draft**のファイルを作成する。
3. 次に、**Section**ごとに、**Guide**が示す定義方針・内容に対して、**Source**の内容だけでは不足する観点についてユーザーと確認・議論し、その内容について合意が取れたら都度**Draft**に記録する。確認は、各**Section**について、Guideに定義された記載内容を十分に満たせる情報が揃うまで行い、揃い次第、次セクションの確認へ進む。

#### **Discussion Policy**
- このStepは常に**Guide**と**Source**を参照しながら進める。
- 確認や議論は、**Guide**がPRDに対して求めている内容を十分に意識して行う。
- 確認は、それまでの内容を踏まえた複数の選択肢のサジェストとセットで行う。
- 任意のセクションは、まずその項目を定義するかを確認する。
- **Draft**にはあくまで、**Guide**に沿って定義する要求の内容のみを記録し、参照元や、記録方針、検討状況などは記録しない。
- **Source** に十分な情報が記載されている項目については、内容の再確認を行わない。
- 各**Section**の確認を行う際は、まず、**Source**にてどの情報が充足・不足しているのか、また不足要素の有無を示す。
- 各**Section**についてSourceにすでに十分に記録されている内容についてはDraftへ重複して記録せず、**Guide**に対して不足している部分のみを確認および記録によって補う。
- ユーザーに確認を行う際、回答を受けたら、記録前に内容を精査する。その結果、要求として十分に整理され、ユーザーとの合意が得られたと判断できた場合、回答内容を整理して**Draft**に記録する。そうでない場合は、そう判断できるようになるまで、ユーザーと議論を繰り返す。

### Step 2: Refine Draft and Check Consistency
1. ここまでの**Draft**の内容を踏まえて、同文書の冒頭に**Overview**の項を追加し、その上で、内容は維持したまま、重複や表現を整理し、文書全体を一貫した内容に整える。
2. 整理した**Draft**が**Source**と比較して一貫しているかを確認する。
3. 整理した**Source**と**Draft**を合わせた内容が**Guide**に沿ったものになっているかを確認する。

### Step 3: Generate or Modify Artifact
**Source**と**Draft**の内容を元に、**Guide**に沿って**Artifact**を新規の場合は作成、既存の場合は修正する。
**Artifact**(PRD)を作成する際は、`assets/template.md` をテンプレートとして利用する。

**Source** および **Draft** に含まれる内容を欠落させることなく、適切な **Section** に反映すること。特に機能要件については、この点に一層注意を払うこと。採用か本Train対象外かつ将来候補か永久的スコープアウトか、について、合意した位置づけを維持して反映する。

### Step 4: Check Artifact Consistency
1. 作成した**Artifact**が**Source**と比較して一貫しているかを確認する。
2. 作成した **Artifact** が **Draft** の内容を欠落なく反映しているかを確認する。
3. 作成した **Artifact** が **Guide** に沿った内容になっているかを確認する。
4. 作成した **Artifact** が利用したテンプレートに沿った内容になっているかを確認する。

### Step 5: Select the Evaluation Mode for the following Artifact Review
ユーザーに後述のArtifact Reviewにおけるレビュー強度(**Evaluation Mode**)をEasy/Medium/Proの中から選択させる。

### Step 6: Request Artifact Review from a Dedicated Agent
Agent `document-reviewer` に **Artifact** のレビューを依頼する。

依頼時には、以下の情報を明示する。
 - レビュー対象となる **Artifact** のパス
 - **Specific Review Points Sheet**(`.agents/skills/write-prd/references/review-points.md`)のパス
 - 前項で選択された**Evaluation Mode**

`document-reviewer` からレビューの結果の報告とレビューレポートのファイルが返却されたら、内容を確認し、レビュワーからの口頭での報告内容については、レビュワーの回答形式のままユーザーに漏れなく共有し、ユーザーにレポートを見るように促す。また、その際レビューレポートについてのユーザーへの共有は格納パスにとどめ、内容は出力しない。なお、レビューレポートの出力先については**Specific Review Points Sheet**から確認すること。

### Step 7: Action after Artifact Review
前項レビュワーから「レビュー完了基準を満たしている」という旨の報告を受ける。かつ、次のいずれかに当てはまった場合、このStepを完了する。
- 新たに追加された指摘がなく、すべての指摘がCLOSEになっている。
- 残る指摘への対応を続行するか終了するかユーザーに確認し、終了する旨の回答を得た。

上記の完了条件を満たさない場合、レビューで受けた指摘のうち、まだCLOSEになっていないものについて、一つずつユーザーと確認・議論および改善を行う。また、その際の対応可否、および対応する場合は対応内容と修正箇所、対応しない場合はその理由を、返却されたレビューレポートの依頼元記述欄に記録する。
- 一通りの指摘に対する必要な改善を行った後はStep 6へ戻り、再レビュー依頼を行う。その際対応内容もレビュワーに連携する。
- 本Stepの上記完了条件を満たすまで、Step 6とStep 7を繰り返す。

#### Re-Review Guideline
- *Artifact**の改善やレビューレポートへの記載を行う際、ならびに再レビュー依頼を行う際は、都度必ずその前にユーザーに確認し、承認を得る。

### Step 8: Move **Draft** and Review Report to Steering for the Current Train
**Step 7**までの全ての工程が完了したとき、今回のこれらの工程にて、作成もしくは受け取った**Draft**およびレビューレポートを、Current TrainのSteering領域にあるManagerディレクトリ下のそれぞれ対応する場所に移動する。