---
name: test-design
description: >
  特定の具体的な作業を実施するWork型 Skill。
  担当ModuleのTask、SpecificationおよびRequirement Verification Matrixに基づき、構築・開発結果を検証するためのTest Specificationを作成する。
  Use when: Executorが担当Moduleの構築・開発に先立ってTest Specificationを作成するとき。
  Do not use for: Testの実行、構築・開発・実装そのもの、RequirementやSpecificationの定義・変更。
---
# Work Skill: test-design

## Summary
担当ModuleのTask、SpecificationおよびRequirement Verification Matrixから必要な検証事項を特定し、それらを網羅するTestを設計する。

各Testについて、検証内容、Expected Result、Test Method、Evidence Methodおよび保持するEvidenceを定義し、後続のTest実行に使用するTest Specificationを作成する。Evidenceは可能な限り再実行可能かつ機械的に取得・判定できる方法を採用し、Testの自動化およびCI/CD Pipelineへの組み込みを考慮する。

## Input
### **Domain**
担当するModuleの所属するDomain

### **Module**
担当するModule

### **Requirement Mode**
Current TrainのRequirement Mode
`INITIAL` / `CR` のいずれか。

### **Specification Sources**
担当Moduleの構築において参照するSpecificationのパス
複数指定可。


## Executor Rules

**Executor Rules** : Executorが作業全体を通して遵守する共通ルールを以下にて管理する。

```
.agents/resources/executor-rules.md
```

## 前提条件
- 
## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- 各Stepは**Execution Steps**に記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。


## Task
担当Taskが記録された `tasklist.md`あるいは、その内容。
```
docs/.steering/<current-train>/<module-name>/tasklist.md
```

## Draft
```
docs/.steering/<current-train>/<module-name>/working/test-design.md
```

## Template for the Artifact (`assets/template.md`)
**Artifact**を作成する際に、テンプレートとして利用する。

## Artifact
```
docs/.steering/<current-train>/<module-name>/test/test-specification.md
```

## Goal
- **Execution Steps**に定義されたすべてのStepが完了していること。

## List of Step
- Confirm Inputs
- Extract Verification Points
- Understand Existing and Reference Tests
- Draft Test Specification
- Refine Draft and Check Coverage
- Generate Test Specification
- Validate Test Specification
- Request Coverage Review
- Move Review Report to Archive

## Execution Steps

### Step 0: Confirm Inputs
- **Inputs** によって引き継がれた情報を改めて確認する。

### Step 1: Extract Verification Points
Agent `explorer` に**Task**、**Specification Sources**、**Requirement Verification Matrix**についてそれぞれのパスを連携し、担当Moduleについて検証で確認すべき事項とその根拠を抽出させる。

依頼時には、以下を抽出結果の出力先として連携する。 (変数<>となっている部分は適切に置き換えた上で連携する)

`docs/.steering/<current-train>/shared/information/verification-points-<module-name>.md`


#### 依頼内容

```text
Task、Specification Sources、およびRequirement Verification Matrixを参照し、
担当Moduleの構築・開発結果を検証する上で確認が必要となる事項を抽出して結果を所定の場所に出力する。

以下を区別して整理すること。

- Taskから要求される検証事項
- Specificationから要求される検証事項
- Requirement Verification Matrixにおいて担当Moduleへ割り当てられた検証事項
- 各事項の根拠となるTask / SpecificationのFile・Section・Subsection / Requirement Verification Matrix上の項目

Requirement Verification Matrixにおいて担当Moduleへ割り当てられた検証事項は、漏れなく抽出すること。

具体的なTest Case、Expected Result、Evidence Methodは設計しない。
```

#### 完了報告受領後

完了報告を受けたら、出力結果を、`.steering/<current-train>/<module-name>/test/`に移動させる。

### Step 2: Understand Existing and Reference Tests

前項のExplorerによる抽出結果を確認した上で、担当Moduleの既存実装および同Domainの参考実装を確認し、Test Designにおいて前提となる既存のTestや検証方法、および今回の対応範囲を把握する。把握した内容は、`docs/.steering/<current-train>/<module-name>/working/existing-analysis-for-test.md` に整理する。

1. `existing-implementation.md` が存在する場合は、その内容を確認し、必要に応じて実際の実装を参照する。
2. 担当Moduleに既存のTestが存在する場合は、その構成、検証内容および実行方法を確認する。
3. 同Domainの他Moduleに参考となるTestが存在する場合は、Read-Onlyで確認し、参考となる検証方法や構成を把握する。
4. **Requirement Mode** が `CR` の場合は、既存Testと今回のTaskおよびExplorerの抽出結果を照合し、維持・追加・変更が必要となる検証範囲を整理する。変更対象だけでなく、その変更によって影響を受ける可能性のある既存機能についても、必要なRegression Testの範囲を確認する。

把握した内容のうち、後続のTest Designにおいて必要となる事項を整理し、次のDraft作成に反映する。

### Step 3: Draft Test Specification
前項までのExplorerの調査結果や、既存および参考実装の把握結果をもとに、以下を定義して**Draft**を作成する。

- Test No.
- Source / Traceability
- Verification
- Expected Result
- Evidence Method
- Evidence to Retain

Requirement Verification Matrixで担当Moduleに割り当てられたVerificationはすべて網羅する。

Evidence Methodは可能な限りCommand / Script等による再実行可能かつ機械的に結果を取得・判定可能な方法を優先し、後続の自動化およびCI/CD Pipelineへの組み込みを考慮する。

同Domainの別Moduleや、過去Trainの同一Moduleについて、**Test Specification**が存在する場合は、その内容を確認し、**Executor Rules**の**Reference to Historical/Relevant Steering**に基づき、Testの構成、検証内容、実施方法およびEvidence取得方法などについて参考にする。

整理・作成が完了したら、概要をユーザーに説明する。


### Step 4: Refine Draft and Check Coverage
**Task**、**Specification Sources**、**Requirement Verification Matrix**と**Draft**を照合し、検証事項の欠落、重複、Traceabilityを確認する。

### Step 5: Generate Test Specification
確定した**Draft**から **Artifact** を作成する。作成する際は、**Template**を利用する。

### Step 6: Validate Test Specification
**Artifact**が**Draft**を欠落なく反映し、各TestについてExpected Result、Evidence Method、Evidence to RetainおよびTraceabilityが定義されていることを確認する。

### Step 7: Request Coverage Review
Agent `spec-comparator` に**Artifact**と**Specification Sources**の比較レビューを依頼する。

Procedure: Specification Comparison Review(`.agents/resources/doc-procedure/comparison-review.md`)の内容を実行する。
Procedureの実行にあたっては、以下を本Skillの定義から特定してInputとして使用する。

- **Review Sources** : **Specification Sources**
- **Artifacts** : 前項までに作成した**Test Specification**
- **Comparison Review Report** : `docs/.steering/<current-train>/shared/reviews/test-design-on-specification-<module-name>.md`
- **Destination for Reports after Review** : `docs/.steering/<current-train>/<module-name>/archive/`
- **Scope** : **Task**の内容およびその範囲がこのテストの責任範囲である旨を連携
- **Required Artifact Review** : `false`