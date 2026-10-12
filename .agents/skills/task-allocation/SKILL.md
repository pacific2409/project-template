---
name: task-allocation
description: >
  特定の具体的な作業を実施するWork型 Skill。
  仕様定義からCurrent Trainで必要となる構築・開発・変更対象を特定し、Domain・Module・Functional Unit・Logic Unitの階層で各ExecutorへTaskを割り当て、依存関係および実施順序を整理する。
  Use when: Development Specification完了後、構築・開発工程に向けたTask Allocationを実施するとき。
  Do not use for: 要件定義、設計、各Executorによる具体的な構築・開発・変更作業。
---

# Work Skill: task-allocation

## Summary
Development SpecificationからCurrent Trainで必要となる構築・開発・変更対象を特定し、Domain・Module・Functional Unit・Logic Unitの階層で各Executorへ割り当てる。

各対象の依存関係および実施順序と、Module単位で必要となる付随対応を整理し、構築・開発工程で各Executorへ作業を移譲するための **Development Allocation Map** を作成する。

## Input
- **Requirement Mode**: 本Skillにおける仕様定義の起点となった要求の性質によって、`INITIAL` または `CR` のいずれかに分かれる。


## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- 各Stepは**Execution Steps**に記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。

## Domain Allocation Definition
Task Allocationの対象となるDomainについてその処理順等を定義する。各DomainのTask Allocationは、下表の定義を前提として実施する。

| No. | Domain | Primary Resources | Supporting Resources | Required Logic Units |
|---:|---|---|---|:---:|
| 1 | Infrastructure | `infrastructure-design.md` | — | No |
| 2 | Database | `table-definitions/*.md` <br> `data-strategy.md` | — | No |
| 3 | Backend | `api-specifications/*.md` <br> `batch-specifications/*.md` | `system-architecture-design.md` | Yes |
| 4 | Frontend | `ui-specifications/*.md` | `system-architecture-design.md` | Yes |

## Draft
各Domainにおける構築・開発・変更対象の抽出、Moduleへの割当、依存関係および実施順序など、Task Allocationの過程で確定した内容を以下にて、段階的に整理・記録する。
```
docs/drafts/development-allocation-map.md
```

## Guide for the Skill (`references/guide.md`)
このガイドの内容を踏まえながら、全てのStepを実行する。

## Template for the Artifact (`assets/template.md`)
**Artifact**を作成する際に、テンプレートとして利用する。

## Example for the Artifact (`references/example.md`)
**Artifact**を作成する際、実際の作成イメージの参考にする。


## Artifact
Current Trainにおける構築・開発・変更対象をDomain・Module・Functional Unit・Logic Unitの階層で整理し、各Executorの担当範囲、依存関係および実施順序を定義する成果物は以下に出力する。
```
docs/.steering/<current-train>/shared/information/development-allocation-map.md
```

## Goal
- ExecutionStepsに定義されたすべてのStepが完了していること。
- **Artifact** の作成が完了し、内容が承認されていること。


## List of Step
── Pre Steps ──
- Understand Task Allocation
- Determine Resource Root
- Prepare Draft and Artifact
── Task Allocation Execution Steps ──
- Extract Allocation Targets
- Allocate Targets to L2 Modules
- Determine L2 Dependencies and Execution Order
- Organize L3 Functional Units
- Decompose into L4 Logic Units
- Determine Module-level Required Items
- Update Development Allocation Map

── Post Steps ──
- Generate Map Overview
- Move **Draft**  to Steering for the Current Train

## Execution Steps

### Pre Step 1: Understand Task Allocation

**Guide**、**Template**、**Example** を読み込み、Task Allocationの方針、構造、および **Development Allocation Map** の完成イメージを確認する。

※**Example**は構造・粒度・表現方法の参考としてのみ使用し、その内容をCurrent TrainのTask Allocationへ引き継がない。

### Pre Step 2: Determine Resource Root

**Requirement Mode**に応じて、**Domain Allocation Definition**に定義されたResourcesの参照元を決定する。

- **Requirement Mode = `INITIAL`**
  - `docs/persistent/` をResource Rootとする。

- **Requirement Mode = `CR`**
  - `docs/change-requirements/` をResource Rootとする。
  - 必要に応じて、`docs/persistent/` に存在する対応する同名の既存文書も、変更前の仕様・設計や前提情報を確認するために参照する。
  - Task Allocationの対象は `docs/change-requirements/` に定義された変更内容を基準として特定し、`docs/persistent/` の内容のみを根拠として変更対象を追加しない。


### Pre Step 3: Prepare Draft and Artifact
- **Draft**および**Artifact**のファイルを作成する。

### Task Allocation Execution - Step 1: Extract Allocation Targets
**Domain Allocation Definition** の順序に従って、次に処理するDomainを対象とする。

対象Domainの **Primary Resources** を確認し、Current Trainで構築・開発・変更が必要となる対象をすべて抽出する。

抽出した各対象について、対応種別を `[Create / Update]` のいずれかとして特定する。

- 対象が1件以上存在する場合、当該Domainを **Required: Yes** とする。また、抽出した対象および各対象の対応種別 `[Create / Update]` と、当該Domainの **Required** の判定結果を **Draft** に記録した上で、次項 へ進む。
- 対象が存在しない場合、当該Domainを **Required: No** として **Draft** に記録し、`Task Allocation Execution - Step 1` に戻って次のDomainを処理する。

### Task Allocation Execution - Step 2: Allocate Targets to L2 Modules
Step 1で抽出したすべての対象について、対象Domainの **Primary Resources** および **Guide** に定義されたL2 Moduleの分類に従って、対応するModuleへAllocationする。

各L2 Moduleについて、割り当てられた対象の対応種別をもとに、Module自体の対応種別を `[Create / Update]` のいずれかとして特定する。

Allocationの結果を **Draft** に記録する。

### Task Allocation Execution - Step 3: Determine L2 Dependencies and Execution Order
前項で特定したL2 Module間の依存関係・対応順序を、対象Domainの **Primary Resources** をもとに確認する。

依存関係が存在する場合は、依存されるModuleから依存するModuleの順となるよう、各L2 Moduleの **Execution Order** を決定する。


各L2 Moduleについて、以下の内容を **Draft** に記録する。

- **Dependencies**
- **Execution Order**

すべてのL2 Moduleについて記録が完了したら、次項へ進む。

### Task Allocation Execution - Step 4: Organize L3 Functional Units
L2 Moduleごとに、前項でAllocationされた対象をL3 Functional Unitとしてその依存関係や・対応順序を整理する。

各Functional Unitについて、対象Domainの **Primary Resources** および **Guide** に定義されたAllocation Rulesに基づき、以下を特定する。

- 対応種別 `[Create / Update]`
- **Dependencies**
- **Execution Order**

Execution Orderは、Functional Unit間の依存関係をもとに、依存される側から依存する側の順となるよう決定する。

各Functional Unitについて特定した内容を、対応するL2 Moduleの配下へ **Draft** に記録する。

すべてのL2 ModuleについてL3 Functional Unitの整理が完了したら、次項へ進む。

### Task Allocation Execution - Step 5: Decompose into L4 Logic Units
対象Domainが **Domain Allocation Definition** において **Required Logic Units = Yes** と定義されている場合は、各L3 Functional UnitをL4 Logic Unitsへ分解する。**Required Logic Units = No** の場合は、本Stepをスキップする。

対象Domainの **Primary Resources** をもとに、各Functional Unitを構成する処理を、段階的に構築・動作確認できる単位へ整理する。

Logic Unitsへの分解では、以下に従う。

- Specification / Definitionに定義された内容の範囲内で分解し、未定義の実装内部構造や処理を新たに設計しない。
- 一度にFunctional Unit全体を実装するのではなく、構築と動作確認を段階的に繰り返せる、ある程度まとまりのある単位へ分解する。
- 過度に細かな処理単位への分割は避け、それぞれが実装上の意味を持つまとまりとなるようにする。
- Logic Unitsは、原則として実施する順序に並べる。
- 各Logic Unitについて、対応種別 `[Create / Update]` を特定する。

各Functional Unitについて特定したLogic Unitsとその対応種別を、対応するL3 Functional Unitの配下へ **Draft** に記録する。

すべての対象Functional UnitについてLogic Unitsへの分解が完了したら、次項へ進む。

### Task Allocation Execution - Step 6: Determine Module-level Required Items

各L2 Moduleについて、**Guide** に定義された当該Domainの **Module-level Required Items** を確認し、Current Trainにおける対応要否を判定する。

判定には、**Domain Allocation Definition** に **Supporting Resources** が指定されている場合はそれらを参照し、指定されていない場合は **Primary Resources** を参照する。

各Itemについて、Current Trainで必要となる対応に応じて、以下のいずれかを判定する。

- `Setup Required`: Current Trainで対象を新規に構築・設定する必要がある。
- `Change Required`: Current Trainで既存の対象を変更する必要がある。
- `No`: Current Trainでは対象の新規構築・設定および変更を必要としない。

判定は、そのModuleが対象の仕組みを利用するかどうかではなく、Current Trainにおいて実際にSetupまたはChangeの対応が発生するかを基準とする。

※参照Resourcesから当該ItemについてSetupまたはChangeが必要であると判断できる情報を確認できない場合は、推測による補完を行わず No とする。

各L2 Moduleについて判定した **Module-level Required Items** を **Draft** に記録する。

すべてのL2 Moduleについて判定が完了したら、次項へ進む。

### Task Allocation Execution - Step 7: Update Development Allocation Map
前項までに **Draft** へ記録した対象Domainの内容を確認し、**Guide**に従い、**Template** を使用して **Artifact** の当該Domainへ反映する。表現方法については、**Example**も参考にする(ただし、内容は引き継がないように注意する)。


反映後、対象Domainについて **Draft**、**Guide**、**Template** および参照したResourcesと照合し、内容の欠落・矛盾・誤ったAllocationや順序がないことを確認する。

確認の結果、問題がある場合は必要な修正を行い、再度確認する。

対象Domainの反映および確認が完了した後、**Domain Allocation Definition** に未処理のDomainが存在する場合は `Task Allocation Execution - Step 1` に戻り、次のDomainについて処理を開始する。

すべてのDomainの処理が完了した場合は、Development Allocation Mapの内容についてユーザーの承認を得た上で、Post Stepへ進む。

### Post Step 1: Generate Map Overview
すべてのDomainについてTask Allocationが完了した後、完成した **Artifact** の内容から全体の構造を抽出し、**Guide**や**Example**を参考に**Map Overview** を生成して**Artifact**の冒頭の該当箇所に追加する。

**Map Overview** は、各Domainに記録された確定内容を俯瞰して表現するものとし、新たなTask、Allocation、DependencyまたはExecution Orderを追加・変更してはならない。

生成後、**Map Overview** と各Domainの内容を照合し、構造および実施順序に矛盾や欠落がないことを確認する。

### Post Step 2: Move **Draft**  to Steering for the Current Train
前項までの全ての工程が完了したとき、今回の工程にて作成した **Draft**を、Current TrainのSteering領域にあるManagerディレクトリ下のそれぞれ対応する場所に移動する。

