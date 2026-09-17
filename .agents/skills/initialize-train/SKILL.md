---
name: initialize-train
description: >
  特定の具体的な作業を実施するWork型 Skill。
  新規開発Trainの開始にあたり、ヒアリングした開発アイデアから、Projectや本Trainのタイトルを導き出し、それを用いてSteering領域のセットアップを行う。
  Use when: Train Initialization を実施するとき。
  Do not use for: 要件定義、設計、開発以降の工程。
---
# Work Skill: initialize-train

## Summary
開発アイデアのヒアリングおよび内容整理、その結果に基づくProjectや本Trainのタイトルの決定・定義を行う。また、対応するSteering領域のセットアップを行う。

## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- 各StepはExecutionStepsに記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。

## Goal
- ExecutionStepsに定義されたすべてのStepが完了していること。
- 開発するプロダクトの基本的なアイデアが決定し、プロダクトコンセプト整理されていること。
- `docs/ideas/product-concept-planning.md` の作成が完了し、内容が承認されていること。
- 合意されたProject名およびTrain名が、`docs/train-status.md` に記録されていること。
- `.steering/` 以下に、Current Trainと同名のディレクトリがExecutionStepsに定められた内容とともに作成されていること。

## Execution Steps
### Step 1: Get Initial Idea
ユーザーにどのようなプロダクトを作りたいかを確認し、
回答内容を整理し、開発アイデアの初期状態として `docs/ideas/product-concept-planning.md` を作成して記録する。
※内容の詳細化や要件定義までは行わない。

### Step 2: Discuss the Product Concept
`Step 1: Get Initial Idea`で確認・記録したアイデアについて、以下の観点(**Check Point**)について一つずつユーザーに確認する。議論の上で方向性が一定具体化できたら、その内容を `docs/ideas/product-concept-planning.md` に追記した後、次の観点の確認へ進む。

#### **Guideline**
- 合意・承認状況については文書の末尾にて管理・更新する。
- `docs/ideas/product-concept-planning.md` には、後続の工程・Phaseや次以降のStepの予定・実施内容を記載しない。
- 今回対象外と合意した内容は、専用の節にまとめる。未決定の事項を、対象外とみなさない。
- 確認は、それまでの内容を踏まえた複数の選択肢のサジェストとセットで行う。

#### **Check Point**
- プロダクトの規模感(開発期間や速度・難易度・完成度)
- アプリケーションタイプ(Web・モバイル・デスクトップ・CLIなど)
- 利用シーン(いつ・どんな状況で使うのか)
- プロダクトの中心となる体験(プロダクトを主に特徴づける点)
- 利用・入出力イメージ
- 取り入れたい技術・仕組み(ここでは構成の方向性まで、具体的な技術選定については触れない)
- 取り入れる仕組みを活かせる機能についてのアイデア
- UXをより良くするためのアイデア
- プロダクトに独自性・面白さを加えるアイデア
- 将来的な発展可能性
- その他当プロダクトのコンセプトを決める上で重要とエージェントが判断した点
- ここまでの内容について、プロダクトコンセプトの範囲内で残っている未決定事項の確認・確定
- ここまでの内容について、今回対象外にする内容の確認(今回対応しないだけなのか、永久に対応しないのかを明確に)

### Step 3: Finalize Product Concept Planning
Step 2までに記録された `docs/ideas/product-concept-planning.md` の内容全体を確認し、合意された内容の意味を変更しない範囲で、重複や記述の整理を行う。

整理された内容からプロダクトの全体像を要約し、文書の冒頭にOverview(概要)として追加する。

最終的な `docs/ideas/product-concept-planning.md` の内容をユーザーに提示し、承認を得る。

### Step 4: Name the Project and the Current Train
整理したProduct Conceptをもとに、Projectおよび本Trainを識別する名称を考え、ユーザーに提示し、決定する。

いずれの名前も特徴を表しつつ簡潔な名前にする。

Trainの名称は、以下の命名規則に従う。

`[YYYYMMDD]-[開発タイトル]`

例：
- `20250115-initial-implementation`
- `20250115-add-tag-feature`


### Step 5: Train Status Initialization
`Step 4: Name the Project and the Current Train` で決定した内容をもとに、`docs/train-status.md` を作成する。

作成にあたっては、`assets/train-status-template.md` をテンプレートとして利用する。

### Step 6: Steering Setup
`.steering/` 配下に、決定したCurrent Trainと同名のディレクトリおよびそのサブディレクトリを、以下の構成で作成する。
- `.steering/<current-train>/`
- `.steering/<current-train>/manager/`
- `.steering/<current-train>/manager/ideas/`
- `.steering/<current-train>/manager/drafts/`
- `.steering/<current-train>/manager/reviews/`
- `.steering/<current-train>/shared/`
- `.steering/<current-train>/shared/information/`

また、末端の各ディレクトリには、.gitkeep ファイルを作成する。