---
name: requirement-verification-allocation
description: >
  特定の具体的な作業を実施するWork型 Skill。
  Product Requirements Definitionから検証対象となる要件・条件を抽出し、Development Allocation Mapに定義された各Moduleへ検証責務を割り当て、その網羅性と妥当性を確認する。
  Use when: Task Allocation完了後、各Moduleの構築・開発に先立って、PRDの要件に対する検証責務の割当を行うとき。
  Do not use for: 要件定義、設計、構築・開発、具体的な検証方法やテストケースの定義、テストの実施。
---

# Work Skill: requirement-verification-allocation

## Summary
Product Requirements Definitionから、Goals、Functional RequirementsのAcceptance CriteriaおよびNon-functional Requirementsにおける検証対象を抽出する。

Development Allocation Mapに定義された各Moduleの担当範囲をもとに検証責務を割り当て、すべての検証対象が適切なModuleによって網羅されていることを確認する。

その結果を、検証対象と担当Moduleの対応関係を示す **Requirement Verification Matrix** として作成する。


## Input
- **Requirement Mode**: 本Skillにおける仕様定義の起点となった要求の性質によって、`INITIAL` または `CR` のいずれかに分かれる。

## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- 各Stepは**Execution Steps**に記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。

## Draft
検証対象の抽出および担当Moduleへの割当結果を、Artifactへ反映する前に以下に整理・記録する。
```
docs/drafts/requirement-verification-matrix.md
```

## Template for the Artifact (`assets/template.md`)
**Artifact**を作成する際に、テンプレートとして利用する。


## Development Allocation Map
Current Trainにおける各Moduleの担当範囲、依存関係および実施順序を定義した文書。検証担当Moduleの割当に使用する。本Work Skillでは、Read Onlyとして参照する。
```
docs/.steering/<current-train>/shared/information/development-allocation-map.md
```

## Product Requirements Definition
Projectの要求を定義した文書。本Work Skillでは、Goals、Functional RequirementsのAcceptance CriteriaおよびNon-functional Requirementsを検証対象の抽出元とする。本Work Skillでは、Read Onlyとして参照する。
```
docs/persistent/product-requirements.md
```

## PRD Change Requirements
Current TrainにおけるProduct Requirementsの変更内容を定義した文書。`CR`の場合に参照する。本Work Skillでは、Read Onlyとして参照する。
```
docs/change-requirements/product-requirements.md
```

## Artifact
PRDから抽出した検証対象と、その検証を担当するModuleの対応関係を記録する成果物は以下に出力する。
```
docs/.steering/<current-train>/shared/information/requirement-verification-matrix.md
```

## Goal
- ExecutionStepsに定義されたすべてのStepが完了していること。
- **Artifact** の作成が完了し、内容が承認されていること。


## List of Step

- Extract Verification Targets
- Allocate Verification to Modules
- Generate Requirement Verification Matrix
- Validate Verification Coverage
- Move **Draft** to Steering for the Current Train

## Execution Steps
### Step 1: Extract Verification Targets

**Requirement Mode** に応じて、以下の文書から検証対象となりうる要件・条件を抽出する。

- `INITIAL`: **Product Requirements Definition** 全体を対象とする。
- `CR`: **PRD Change Requirements** に定義された追加・変更内容を対象とする。必要に応じて **Product Requirements Definition** を参照し、変更後の要求・条件を確認する。


- 目標・完了条件（Goals）
- 機能要件（Functional Requirements）の各受け入れ条件
  - ただしP2を除く。
- 非機能要件（Non-functional Requirements）

抽出した各項目について、PRD内の該当箇所と内容を整理し、**Draft** に記録する。

### Step 2: Allocate Verification to Modules

前項で抽出した各項目について、**Development Allocation Map** に定義されたModuleから、検証を担当するModuleを特定する。

割当にあたっては、以下に従う。

- 各Moduleの担当範囲および関連するSpecificationを踏まえて割り当てる。
- 1つの検証対象に対して、複数のModuleを割り当ててもよい。
- 異なるDomainに属するModuleを組み合わせてもよい。
- 検証対象とModuleの関係について、根拠のない割当を行わない。

各項目に対する検証担当Moduleを **Draft** に記録する。

- 各検証対象の具体的な検証方法およびテストケースは、本Skillでは定義せず、担当Moduleの構築・開発工程で決定する。
- Goalsを含め、UI/UXに関する検証対象は、原則としてFrontend DomainのModuleへ割り当てる。

### Step 3: Generate Requirement Verification Matrix
**Draft** に記録された検証対象と担当Moduleの対応関係を整理し、**Artifact** を作成する。作成時は**Template** を使用する。

各検証対象について、PRDの該当箇所、検証対象の内容、および担当Moduleを追跡できる形式で記録する。

### Step 4: Validate Verification Coverage

作成した **Artifact** を Step 1で抽出対象とした文書および **Development Allocation Map** と照合し、以下を確認する。

1. Step 1で定めた抽出対象の文書に含まれるすべての検証対象が、欠落なくMapに記録されていること。
2. 各検証対象について、少なくとも1つのModuleが割り当てられていること。
3. 各Moduleへの割当が、**Development Allocation Map**における担当内容と整合していること。

未割当または不適切な割当が存在する場合は、ユーザーと対応方針を確認し、必要な修正を行う。

すべての検証対象について適切な担当Moduleが割り当てられていることを確認できた場合、本Skillを完了する。


### Step 5: Move **Draft**  to Steering for the Current Train
前項までの全ての工程が完了したとき、今回の工程にて作成した **Draft**を、Current TrainのSteering領域にあるManagerディレクトリ下のそれぞれ対応する場所に移動する。