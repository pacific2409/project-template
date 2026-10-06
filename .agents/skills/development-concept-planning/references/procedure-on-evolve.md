# Procedure on Evolve


## List of Step
- Prepare **Artifacts** and **Future Ideas**
- Understand the Project Overview
- Identify the Primary Change Area
- Understand the Current State of the Selected Area
- Get the Initial Change Idea
- Discuss the Intended Change
- Finalize Development Concept Planning

## Execution Steps

### Step 0: Prepare **Artifacts** and **Future Ideas**
**Artifacts** のファイルを作成する。存在しなければ、**Future Ideas** についても同様に作成する。

### Step 1: Understand the Project Overview

最初に `docs/Readme.md` を読み、既存プロジェクトの概要と文脈を理解する。

ここでは、文書から読み取れる範囲で次のような情報を押さえる。

- プロジェクトの目的
- プロダクトの概要
- システムの大まかな構成

## Step 2: Identify the Primary Change Area

今回どの領域を中心に変更したいか、ユーザーに確認する。

1. プロダクト機能・体験
2. 内部処理・振る舞い
3. システムアーキテクチャ
4. データ管理・運用
5. インフラ
6. その他

この段階では具体的な変更内容を聞き出す前に、まず確認対象となる文脈を絞る。

### Step 3: Understand the Current State of the Selected Area

選択された領域に対応する既存文書を確認し、対象部分の大枠を理解する。

| 選択領域 | 参照文書 |
|---|---|
| プロダクト機能・体験 | `docs/persistent/product-requirements.md` |
| 内部処理・振る舞い | `docs/persistent/functional-design.md` |
| システムアーキテクチャ | `docs/persistent/system-architecture.md` |
| データ管理・運用 | `docs/persistent/data-strategy.md` |
| インフラ | `docs/persistent/infrastructure-architecture.md` |

`その他`の場合も含めて、対応する文書が存在しない場合は、既存定義の変更ではなく、今回新たに定義する内容として理解する。

## Step 4: Get the Initial Change Idea

ここまでに理解したプロジェクトの文脈と**Future Ideas**の内容を踏まえ、何を変更したいか、または、プロジェクトにどう変更を加えたいかを大枠でユーザーに確認する。

変更種別は次の三つとして扱う。

- 追加
- 修正
- 廃止

確認するときは、既存文書から読み取った対象候補を複数提示し、最後に `その他` を含める。

回答された内容は、前項の「どの領域を中心に変更したいか」とあわせて、変更アイデアの初期状態として**Artifacts**へ記録する。

### Step 5: Discuss the Intended Change
このStepは、本Skillに規定の**Discussion Guidelines**に従って進める。

前項で確認・記録したアイデアについて、以下の観点について一つずつユーザーに確認する。
具体的に「何を、どのような状態へ変えたいか」を議論した上で、何がしたいのかが明確化できたら、その内容を **Artifacts** に追記した後、次の観点の確認へ進む。

#### **Perspective**
- 変更する対象・変更領域・変更種別
- 現在どのような状態か
- どのような状態に変えたいか
- 変更する目的
- 期待する結果や体験
- 維持したい既存の内容
- (存在する場合に限り)既存仕様を踏まえた変更内容の実現可能性に関する重大な懸念点
- 将来的な発展可能性
- その他エージェントが重要と判断した点
- 残っている未決事項
- 今回の対象外(今回対応しないだけなのか、永久に対応しないのかを明確に)

ここでは、実現手段、使用技術、内部構造などの「どうやって実現するか」は決めない。そこは後続の要求定義や設計工程へ渡す。

## Step 6: Finalize Development Concept Planning
前項までに記録された **Artifacts** の内容全体を確認し、合意された内容の意味を変更しない範囲で、重複や記述の整理を行う。

整理された内容からプロダクトの全体像を要約し、文書の冒頭にOverview(概要)として追加する。

最終的な **Artifacts** の内容をユーザーに提示し、承認を得る。
