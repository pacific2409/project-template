---
name: test-execution
description: >
  特定の具体的な作業を実施するWork型 Skill。
  担当ModuleのTask、SpecificationおよびRequirement Verification Matrixに基づき、構築・開発結果を検証するためのTest Specificationを作成する。
  Use when: Executorが担当Moduleの構築・開発に先立ってTest Specificationを作成するとき。
  Do not use for: Testの実行、構築・開発・実装そのもの、RequirementやSpecificationの定義・変更。
---
# Work Skill: test-execution

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
- ファイル作成の際、既存のファイルが存在する場合は、削除や内容の上書きは行わず、状況に応じて更新または規定のファイル名にナンバリングを加えて新規作成するなどして対応する。


## Task
担当Taskが記録された `tasklist.md`あるいは、その内容。
```
docs/.steering/<current-train>/<module-name>/tasklist.md
```

## Draft
```
docs/.steering/<current-train>/<module-name>/working/test-design.md
```

## Test Specification
担当ModuleにおけるTestの内容および実施方法が定義されている。
```
docs/.steering/<current-train>/<module-name>/test/test-specification.md
```

## Goal
- **Execution Steps**に定義されたすべてのStepが完了していること。

## List of Step
- Confirm Inputs
- Plan Test Execution
- Prepare Test Environment
- Execute Tests
- Verify Test Results
- Review Outstanding Tests and Issues
- Confirm Completion

## Execution Steps

### Step 0: Confirm Inputs
- **Inputs** によって引き継がれた情報を改めて確認する。

### Step 1: Plan Test Execution
**Test Specification** を確認し、担当ModuleのIntegration Testについて、実施対象、実行順序、必要な操作およびEvidence取得方法を整理する。

- 各TestのTest Method、Expected Result、Evidence MethodおよびEvidence to Retainを確認する。
- Test間の依存関係を確認し、実行順序を整理する。
- Testの実施に必要なEnvironment Information、Test Data、外部Dependencyその他の前提条件を特定する。
- 各Testおよび関連操作について、Agentまたはユーザーのいずれが実施するかを確認する。
- Test結果およびEvidenceの取得・保存方法を確認する。

整理したTest Executionの全体像と実施手順の概要をユーザーに提示・説明し、以降の作業について認識を合わせる。

本Stepでは新たなTest Caseの設計は行わず、既存の **Test Specification** に基づいて実行計画を具体化する。


### Step 2: Prepare Test Environment
前Stepで整理した内容をもとに、Integration Testの実施に必要なTest Environmentの状態、依存関係および適用・Deploy方法を確認し、必要な準備を行う。

1. Test Environmentについて、必要なInfrastructure、Database、Application、External Serviceその他のDependencyが利用可能な状態にあるか確認する。
2. 担当ModuleのImplementationが対象Environmentへ適用・Deployされているか確認し、必要な適用・Deploy内容を特定する。
3. 対象Environmentへの適用・Deployに利用可能なCI/CD Pipelineが存在する場合は、そのPipelineの構成および実行方法を確認する。
4. 利用可能なCI/CD Pipelineが存在しない場合は、`docs/.steering/<current-train>/<module-name>/working` 配下にて、既存のImplementation Draft、CI/CD Configuration、Runtime Environment Configurationその他の関連情報のうち記載のある内容を確認し、手動での適用・Deploy方法および手順を整理する。
5. 必要な操作について、Agentまたはユーザーの実施主体を確認し、ユーザーと協力して適用・DeployおよびEnvironmentの準備を行う。
6. Test Environmentおよび必要なDependencyが、後続のIntegration Testを実施可能な状態にあることを確認する。

本Stepでは、Integration Testの実施を目的とした新たなCI/CD Pipelineの構築は行わず、既存のPipelineまたは手動操作によって必要なEnvironmentを準備する。

担当外Moduleに関する準備・変更が必要な場合は、自身で変更せず、**Executor Rules** 等に従ってユーザーを介して対応を依頼する。


### Step 3: Execute Tests
**Test Specification** に定義された各Testについて、前Stepまでに整理した実行方法および手順に従ってTestを実施し、結果とEvidenceを取得する。

- 各Testの実施順序および前提条件を確認しながら実行する。
- Agentが実施主体となる操作は、Projectの実行ルールに従って実施する。
- ユーザーが実施主体となる操作については、必要な操作内容、対象、手順および完了条件を提示し、ユーザーからの完了報告を受けて結果を確認する。
- 各Testの実行結果およびEvidenceを取得し、**Test Specification** に定義されたEvidence MethodおよびEvidence to Retainに従って保存する。
- Evidenceは `test/result/` 配下に保存し、Test No.との対応を追跡可能な状態にする。

Testの実行中に問題または期待結果との不一致が確認された場合は、その現象および確認できた事実を記録し、本Step内では原因調査・修正を行わず、後続の工程で対応する。


### Step 4: Verify Test Results
前Stepで取得したTest結果およびEvidenceを **Test Specification** のExpected Resultと照合し、各Testの結果を判定する。

1. 各Testについて、実行結果がExpected Resultを満たしているか確認する。
2. Test結果およびEvidenceが、**Test Specification** に定義された内容を確認するために十分であることを確認する。
3. 判定結果に基づき、**Test Specification** の **Test Checklist** にある各TestのStatusおよびEvidenceを更新する。
4. Expected Resultとの不一致、Evidenceの不足、実行不能その他の問題がある場合は、その内容および確認できた事実を整理する。

Test Statusは、原則として以下を使用する。

- `NOT_RUN`：未実施
- `PASS`：期待結果を満たし、必要なEvidenceが取得されている
- `FAIL`：期待結果を満たしていない
- `BLOCKED`：前提条件の不足その他の理由によって実施できない

必要なEvidenceが取得できていない場合は、Testを `PASS` と判定しない。

問題または期待結果との不一致が確認された場合は、その内容および確認できた事実を記録し、本Step内では原因調査・修正を行わず、後続のStepへ進む。

### Step 5: Review Outstanding Tests and Issues

Integration Testの実施結果を確認し、検知された問題および未実施・未再実施のTestについて、後続の対応に必要な情報を整理する。

1. Integration Testで検知された問題、不具合または期待結果との不一致について、発生状況、期待結果と実際の結果、および確認済みの関連情報を整理する。
2. 未実施または未再実施のTestが存在する場合は、その理由、影響および残存するリスクを整理し、実施・再実施の要否をユーザーと協議・決定する。
3. 実施・再実施を省略する場合は、その理由およびユーザーの承認内容を記録する。
4. 対応が必要な問題について、後続の工程で確認できるよう、関連するTest No.およびEvidenceとの対応を整理する。

本Stepでは問題の原因調査・修正およびTestの再実施は行わず、それらの進行は後続の別工程に委ねる。


### Step 6: Confirm Completion
担当ModuleのIntegration Testについて、**Test Specification** に定義されたTestの実施状況、結果判定およびEvidenceの記録を確認し、本Work Skillの実行結果を確定する。

1. **Test Specification** の **Test Checklist** を確認し、各Testの実施状況およびStatusが適切に更新されていることを確認する。
2. 実施した各Testについて、必要なEvidenceが `test/result/` 配下に保存され、Test No.との対応が追跡可能であることを確認する。
3. `FAIL` または `BLOCKED` のTestが存在する場合は、その内容および関連するEvidenceを確認する。
4. 未実施・未再実施のTestについて、実施要否の判断および必要な記録が完了していることを確認する。
5. Testの実施状況、結果および後続対応が必要な事項を整理し、本Work Skillを完了する。

本Work Skillの完了は、すべてのTestがPASSしたことを意味しない。問題への対応および必要な再Verificationは、後続の別工程で管理する。
