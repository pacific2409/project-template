---
name: other-constituent-implementation
description: >
  専用のImplementation Skillが存在しないDomainやModuleあるいはその構成要素について、定義・実装を担うWork Skill for Implementation Loop。
  SQL、Script、DAGその他の構成要素について、汎用的な工程によりImplementationとその適用・実行を反復して実施する。
  Use when: 担当Moduleに割り当てられたTaskのImplementation対象について、適用可能な専用のImplementation Skillが存在しないとき。
  Do not use for: InfrastructureまたはApplicationなど、対象に適用可能な専用のImplementation Skillが存在する場合。設計、Repository Structureの準備、Test Specificationの作成、CI/CD PipelineやRuntime Environmentの初期構成、正式なTest Execution。
---

# Work Skill: other-constituent-implementation
## Summary
専用のImplementation Skillが存在しないDomain、Moduleまたはその構成要素について、`tasklist.md` に割り当てられたTaskを単位として **Implementation Loop** を実施し、Specificationに定義された内容を実装する。

各Taskでは、Specificationを正として既存・参考実装を確認した上でImplementationを行い、利用可能なStatic ValidationおよびSpecificationとの整合性確認を実施する。

Implementation後は、必要なEnvironmentへの適用・実行方法およびその結果の確認方法を整理し、一連の作業として実施する。Taskが完了したら `tasklist.md` を更新し、未完了のTaskが存在する場合は次のTaskの **Implementation Loop** へ進む。

## Input
### **Domain**
担当するModuleの所属するDomain

### **Module**
担当するModule。

### **Requirement Mode**
Current TrainのRequirement Mode。
`INITIAL` / `CR` のいずれか。

### **Specification Sources**
担当Moduleの構築において参照するSpecificationのパス。
複数指定可。


## Executor Rules

**Executor Rules** : Executorが作業全体を通して遵守する共通ルールを以下にて管理する。

```
.agents/resources/executor-rules.md
```


## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- 各Stepは**Execution Steps**に記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。
- **Development Guidelines** を作業全体の前提とし、内容を常に確認しながら作業を進める。
- 複数Environmentへの定義・実行・変更が必要な場合は、EnvironmentごとにImplementation Loopを分離せず、必要な全Environmentの定義・変更を同一Task内でまとめて実施する。


## Draft
```
docs/.steering/<current-train>/<module-name>/working/implementation/task-<task-no>.md
```
- 各Implementation Loopでは、対象Taskに対応する **Draft**  を作業上の補助情報として使用する。
- 各工程の中で調査・把握・整理した内容のうち、後続Stepで参照する必要がある要点やメモを適宜記録する。
- 詳細な情報を複製するのではなく、後続作業に必要な要点と必要に応じて参照元を記録する。
- 本ファイルはTaskのSpecificationや正式なDecisionの代替とはしない。重要な判断は `decisions.md`、Blockerは `blockers.md` など、**Executor Rules** で定められた正規の管理先へ記録する。


## Task Table
以下にてTask Tableとその進捗が管理されている。
```
docs/.steering/<current-train>/<module-name>/tasklist.md
```

## External Information
他の担当またはユーザーから共有された、当該TaskのImplementationに関連する情報が含まれる可能性がある。
```
docs/.steering/<current-train>/shared/handover/*
```

## Pending Information
いずれかの工程の中で、未確定または未解決になった情報・項目を以下にて管理する。
```
docs/.steering/<current-train>/<module-name>/working/pending-information.md
```

- いずれかの工程の中で未確定または未解決の情報・項目が判明した場合は、ユーザーに報告の上、その時点で Pending Information に記録する。後続の作業によって解決・確定した場合は、その結果を反映して更新する。

## Test Specification
担当ModuleにおけるIntegration Testの内容および実施方法が定義されている。
```
docs/.steering/<current-train>/<module-name>/test/test-specification.md
```

## Outgoing Handover Information
自身の担当Moduleから他Domain / Moduleへ引き継ぐ必要がある情報を整理・管理する。
```
docs/.steering/<current-train>/<module-name>/handover-from-<module-name>.md
```

- 更新の際にはテンプレートを(`.agents/resources/steering-assets/handover-from-some-module-template.md`)を使用する。

## Goal
- **Execution Steps**に定義されたすべてのStepが完了していること。

## List of Step
- Confirm Inputs

── Part A: Preparation ──
- Select Task
- Understand Specifications
- Understand Existing Implementation
- Plan Implementation

── Part B: Implementation & Pre-Apply Verification ──
- Implement
- Static Validation
- Check Specification Consistency

── Part C: Apply/Execution ──
- Plan Apply/Execution
- Resolve Pending Information
- Apply/Execute
- Handle Issues if Detected

── Part D: Completion ──
- Update Outgoing Handover Information
- Confirm Completion

## Execution Steps
### Step 0: Confirm Inputs
- **Inputs** によって引き継がれた情報を改めて確認する。

### Step 1: Select Task
**Task Table** から、次に実施する未完了のTaskを選択し、本Implementation Loopの対象とする。

選択したTaskについて、以下にTask単位の **Draft** を作成する。

**Task Table** にて選択したTaskのStatusを更新し、以降のStepでは当該Taskを対象として作業する。

### Step 2: Understand Specifications
選択したTaskについて、**Specification Sources**、`relevant-specifications.md` および `tasklist.md` を確認し、実装対象となる仕様、制約および関連する技術要素を理解する。

必要に応じて元のSpecificationを改めて確認し、抽出・整理された情報のみから推測によって仕様を補完しない。

### Step 3: Understand Existing Implementation
選択したTaskの実装に関係する既存実装が存在する場合は、その内容や`existing-implementation.md` を確認し、今回のImplementationにおいて維持・変更・追加する範囲を把握する。

既存実装や参考実装から把握できない内容を推測によって補完しない。

### Step 4: Plan Implementation
選択したTaskについて、Specificationを正として、前Stepまでで理解した既存・参考実装を踏まえ、今回実施するImplementationの内容と手順を整理し、作業概要イメージをユーザーに提示する。

- 新規作成・変更する対象
- 既存実装のうち維持する対象
- Implementationの実施順序
- 実装後に確認する内容

複数Environmentへの定義・実行・変更が必要な場合は、EnvironmentごとにImplementation Loopを分離せず、必要な全Environmentの定義・変更を同一Task内でまとめて実施する。

**External Information**に関連する情報が存在する場合は、これも整理内容に含める。

また、**Task Table**全体における本Taskの立ち位置や、本Work Skillの**List of Step** も確認し、作業全体の流れも含めて本TaskのImplementation Planを整理する。

Specificationに定義されていない設計を独自に追加せず、実装上の判断が必要な場合はProjectのルールに従って確認・決定する。


### Step 5: Implement
前Stepまでで確認・整理したSpecification、既存・参考実装、Implementation Planに基づき、選択したTaskを実装する。

- Specificationを正として実装する。
- 既存実装を変更する場合は、必要な変更範囲に限定する。
- 複数Environmentへの定義・実行・変更が必要な場合は、EnvironmentごとにImplementation Loopを分離せず、必要な全Environmentに対する実装・定義・変更を同一Task内でまとめて実施する。
- 実装中に新たな調査・確認が必要になった場合は、必要に応じて実際の実装やSpecificationへ戻って確認する。
- 実装上の重要な判断が発生した場合は、**Executor Rules** に従って記録する。
- 実装中に把握・整理した補助的な情報は、必要に応じて対象Taskの **Draft** に記録する。

### Step 6: Static Validation
担当ModuleについてStatic Analysis / Validationの方法が定義されており、現在の構成で実行可能な場合は、実装した内容に対してStatic Validationを実施する。

実施可能なStatic Validationが一部のみ存在する場合はその範囲で実施し、実施可能なものが存在しない場合は本Stepをスキップする。

1. 既存のStatic Analysis / Validationに関するConfigurationを確認する。
2. `decisions.md` にCurrent TrainでのStatic Analysis / Validationの追加・変更に関するDecisionが存在する場合は、その内容を確認する。
3. 確認した方法のうち、現在のImplementationに対して実行可能なStatic Validationについて実行方法をユーザーに連携の上、実施する。
4. 問題が確認された場合は必要な修正を行い、再度Static Validationを実施する。

### Step 7: Check Specification Consistency
実装した内容を、選択したTaskに関連する **Specification Sources** と照合し、要求された内容が欠落なく適切に反映されていることを確認する。

1. 前工程で確認したSpecificationおよび対象Taskの **Draft** をもとに、実装内容との対応を確認する。
2. 必要に応じて元の **Specification Sources** を改めて確認し、整理・要約した情報のみに依存して判定しない。
3. Specificationに定義された構造、Configuration、制約その他の内容について、実装との不整合や欠落がないことを確認する。
4. 不整合または欠落が確認された場合は必要なStepまで戻って、再度順にStepを実施する。


### Step 8: Plan Apply/Execution
**Guide** の **Apply/Execution Guideline** に従い、選択したTaskのImplementationについて、適用・実行方法と手順を整理する。


### Step 9: Resolve Pending Information
**Pending Information** を確認し、選択したTaskのImplementation、Environmentへの適用またはVerificationによって解決・確定できる可能性のある情報・項目を特定する。

- 現時点ですでに提供・確定できる情報がある場合は、その内容を反映して **Pending Information** を更新する。
- Environmentへの適用またはVerificationによって確定できる情報がある場合は、その内容と確認方法を把握し、後続Stepで確認対象とする。
- 選択したTaskとは関係せず、本Taskによって解決できない項目については変更しない。


### Step 10: Apply/Execution
前工程で整理した方法と手順に従い、選択したTaskのImplementationを対象Environmentへ適用・実行する。

- Agentが実施主体となる操作はProjectの実行ルールに従って実施する。
- ユーザーが実施主体となる操作については、必要な操作内容、対象、手順および完了条件を提示し、ユーザーからの完了報告を受けて結果を確認する。
- 適用・実行後は、その結果および対象がSpecificationに基づく期待する状態となっていることを確認する。

Environmentへの適用・実行の結果によって **Pending Information** の情報・項目を解決または確定できた場合は、その内容を反映して更新する。

適用・実行結果を **Draft** に記録する。問題または期待結果との不一致が確認された場合は、その現象および確認できた事実を記録し、本Step内では原因調査・修正を行わず、次のStep にて対応を実施する。

### Step 11: Handle Issues if Detected
本 **Implementation Loop** における適用・実行および結果確認で、問題、不具合または期待結果との不一致が検知された場合は、共通Procedure **System Issue Triage** (`.agents/resources/dev-procedure/system-issue-triage.md`) に従い、問題の調査、Ownershipの識別および必要な対応の整理を行う。

Procedure実施の際は、**Domain**、**Module**、**Requirement Mode**、**Specification Sources**および**Detected Issue**をInputとして連携する。

**Detected Issue**
- 問題が検知された工程
- 発生状況
- 期待結果
- 実際の結果
- 確認済みの事実
- 関連するDraft／Evidence

問題が検知されていない場合は、本Stepをスキップして次のStepへ進む。

1. 検知した問題、その発生状況、期待結果と実際の結果、および確認済みの関連情報を整理する。
2. **System Issue Triage** を実施し、担当外Moduleの対応結果および担当Module内の修正要否・修正計画を確認する。
3. **Triage Conclusion** の **Outstanding Blockers** を確認する。
   - Blockerが存在する場合は、その内容および影響範囲を `blockers.md` に反映し、解消に必要な対応をユーザーと確認する。
   - Blockerによって実施できないStepについては、解消されるまで再実施を保留・待機する。
   - Blockerが解消された場合は、その結果を確認し、`blockers.md` を更新する。
4. **Triage Conclusion** の **Internal Corrections Required** およびBlockerの解消状況に基づき、以下のように対応する。
   - `Yes` の場合は、決定した修正計画および影響範囲を踏まえ、必要なStepまで戻って再度順にStepを実施する。
   - `No` の場合は、担当外Moduleの対応結果および問題の影響範囲を踏まえ、必要なStepから再実施する。原則として問題が発生したDeployまたはVerificationから再実施するが、それ以前の工程に影響する場合は該当Stepまで戻る。

5. 再実施したStepの結果を確認し、問題が解消されたことを確認する。

未解消のBlockerが存在する場合は、本Implementation Loopを完了しない。

再実施によって新たな問題または期待結果との不一致が検知された場合は、再び本Stepに従って対応する。

#### Reference for **Triage Conclusion**
**Triage Conclusion** は、`docs/.steering/<current-train>/<module-name>/working/issues/issue-triage-<no>-plan.md` のうち、今回の **System Issue Triage** で作成・更新したファイルを参照する。

対象ファイルを特定できない場合は、同命名規則に該当するファイルのうち `<no>` が最大のものを確認し、今回の問題に対応することを確認した上で参照する。

対応関係を確認できない場合は、推測によって選択せず、ユーザーに確認する。


### Step 12: Update Outgoing Handover Information
選択したTaskのImplementation、Environmentへの適用・実行および結果確認を通じて確定した情報のうち、後続Moduleへの引き継ぎに必要となる内容を **Outgoing Handover Information** に記録・更新する。

- **Guide** の **Module Handover Policy** に定義された項目のうち、選択したTaskの対応内容に該当するものを確認する。
- Environmentごとに情報が異なる場合は、その対応関係を明確にする。
- 既存の記録がある場合は、その内容を維持しながら必要な追加・更新を行う。
- 引き継ぎ対象となる情報が存在しない場合は、本Stepをスキップする。

### Step 13: Confirm Completion
選択したTaskについて、本**Implementation Loop**で必要となるImplementation、Validation、Environmentへの適用およびVerificationが完了していることを確認する。

1. 選択したTaskについて、本Work Skillの各Stepが必要な範囲で完了していることを確認する。
2. `tasklist.md` の対象Taskを完了状態へ更新し、必要に応じてProgressを更新する。
3. ここまでの作業内容をコミット・プッシュする。
4. `tasklist.md` に未完了のTaskが存在する場合は、次のTaskを対象として **Step 1** からImplementation Loopを継続する。
5. すべてのTaskが完了している場合は、本Work SkillおよびImplementation Loopを終了する。