---
name: development-concept-planning
description: >
  特定の具体的な作業を実施するWork型 Skill。
  新たな開発・Trainの開始にあたり、開発のアイデアを考え、そのコンセプトを整理する。
  Use when: 新たなプロジェクトやトレインについての開発のアイデアを考え出すとき。
  Do not use for: 要件定義、設計、開発以降の工程。
---
# Work Skill: development-concept-planning

## Summary
新たな開発・Trainの開始にあたり、開発のアイデアを考え、そのコンセプトを整理する。

## Inputs
- **Train Type**: 本Skillを実行するTrainの種別。`LAUNCH` または `EVOLVE`。

## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- **Procedure** には、**Execution Steps** が記載されている。
- 各Stepは**Execution Steps**に記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。

## Discussion Guidelines
- 合意・承認状況については文書の末尾にて管理・更新する。
- 本文の規定に従って、議論の中で生じた、将来案は **Future Ideas** に記録する。
- **Artifacts** には、後続の工程・Phaseや次以降のStepの予定・実施内容を記載しない。
- 今回対象外と合意した内容は、専用の節にまとめる。未決定の事項を、対象外とみなさない。
- 確認は、それまでの内容を踏まえた複数の選択肢のサジェストとセットで行う。


## Artifacts
開発のコンセプトは以下に記録・整理する:
```
docs/ideas/development-concept-planning.md
```

## Future Ideas
Discussionの中で出てきた将来発展性や、今回は採用しないが将来的に検討したいアイデアを下記の出力先および形式で記録する。
```
docs/persistent/future-ideas.md
```

```
# Future Ideas

## **Index**

| No. | Title | Area | Recorded At |
|-----|------|-------|-------------|
|  |  |  | [YYYY-MM-DD] |

## **Details**

### **[将来案のタイトル]**

- **Area**: [プロダクト機能・体験 / 内部処理・振る舞い / システムアーキテクチャ / データ管理・運用 / インフラ / その他]
- **概要**: [将来検討したい内容]
- **背景・価値**: [なぜ検討する価値があるか]
- **今回見送る理由**: [今回の開発では採用しない理由]
- **記録日**: [YYYY-MM-DD]

### **[将来案のタイトル]**
```


## Goal
- ExecutionStepsに定義されたすべてのStepが完了していること。
- 開発するプロダクトの基本的なアイデアが決定し、そのコンセプトが整理されていること。
- **Artifacts** の作成が完了し、内容が承認されていること。


## Procedure
**Train Type** に応じて、以下から該当するProcedureを一つ選択し、その内容を実行する。

- `LAUNCH`: `references/procedure-on-launch.md`
- `EVOLVE`: `references/procedure-on-evolve.md`