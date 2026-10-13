---
name: release-execution
description: >
  特定の具体的な作業を実施するWork型 Skill。
  担当ModuleのRelease Instructionsに基づき、Production EnvironmentへのReleaseおよびProduction Verificationを実施する。問題発生時には必要な保全措置を検討・実施し、System Issue Triageへの引き継ぎとRelease結果の記録・報告までを行う。
  Use when: Executorとして担当ModuleのRelease準備が整い、ReleaseおよびProduction Verificationを実施するとき。
  Do not use for: Release Instructionsの作成、通常の構築・開発、Integration Test、他ModuleのRelease、Current Train全体のRelease管理。
---

# Work Skill: release-execution

## Summary
担当Moduleの **Release Instructions** に基づき、Release対象、実施手順、前提条件およびProduction Environmentの状態を確認した上で、ユーザーと協力してReleaseおよびProduction Verificationを実施する。

Release時およびRelease後は、対象ResourceやApplicationの状態・動作、Log、Metricその他のMonitoring情報を確認する。問題が検知された場合は、Production Environmentへの影響と保全措置の効果・リスクを整理し、ユーザーと協議の上で必要な措置を実施する。その後、必要に応じて共通の **System Issue Triage Flow** へ対応を引き継ぐ。

最後に、ReleaseおよびProduction Verificationの実施結果、対応した問題、未解決事項その他の関連情報を **Release Results Report** に整理し、担当ModuleのRelease結果を確定・報告する。


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

## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- 各Stepは**Execution Steps**に記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。

### Workflow Re-execution
本Work Skillの初回実行時は、定義されたStepを順序どおり実施する。

呼び出し元Workflowにおける再実施の場合は、既存のReleaseおよびVerificationの結果と、再実施が必要な範囲を確認する。

既存のRelease内容および適用状態が今回のVerificationに対して有効であり、Releaseの再実施が不要と判断された場合は、Releaseに関するStepを省略し、必要なProduction VerificationのStepから再実施してよい。

再実施する範囲内では、定義されたStepの順序および完了条件に従う。


## Task
担当Taskが記録された `tasklist.md`あるいは、その内容。
```
docs/.steering/<current-train>/<module-name>/tasklist.md
```

## Draft
リリースに関する情報の整理を行う際は以下に記録する。
```
docs/.steering/<current-train>/<module-name>/working/release-memo.md
```

## Release Instructions
担当ModuleにおけるReleaseの手順および実施条件が定義されている。
```
docs/.steering/<current-train>/<module-name>/working/<module-name>-release-instructions.md
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
- Plan Release Execution
- Verify Release Readiness
- Execute Release
- Perform Production Verification
- Handle Release Failure
- Summarize Detected Issues
- Confirm Completion

## Execution Steps

### Step 0: Confirm Inputs
- **Inputs** によって引き継がれた情報を改めて確認する。

### Step 1: Plan Release Execution
**Release Instructions** を確認し、担当ModuleのReleaseおよびProduction Verificationについて、実施対象、実行順序、必要な操作およびVerification方法を**Draft**を作成の上整理する。

- Release対象となるEnvironment、Resource、Application、Artifactその他の対象を確認する。
- Releaseの前提条件、実施手順、期待結果および実行順序を確認する。
- Release後に実施するVerificationの内容、方法および期待結果を確認する。
- Verificationについては、**Test Specification**に定義されたTest Method、Verification MethodおよびEvidence取得方法を参照し、利用可能なものは、必要に応じてOperational Verificationに適用する。
- Release時およびRelease後に確認するLog、Metricその他のMonitoring情報と異常の判断基準を確認する。
- 各操作について、Agentまたはユーザーのいずれが実施するかを確認する。
- Release失敗時の対応、Recovery / Rollback方法および必要な前提条件を確認する。

整理したRelease Executionの全体像と実施手順の概要をユーザーに提示し、以降の作業について認識を合わせる。

本Stepでは新たなRelease方法を独自に設計せず、既存の **Release Instructions** に基づいて実行計画を具体化する。


### Step 2: Verify Release Readiness
前Stepで整理した内容をもとに、Releaseの実施に必要な前提条件および対象Environmentの状態を確認し、Releaseを実施可能な状態にあることを検証する。

1. Release対象となるBranch、Commit、Artifact、Container Imageその他の対象を確認し、**Release Instructions** に定義された内容と一致していることを確認する。
2. Production Environmentについて、Releaseに必要なInfrastructure、Database、Application、External Serviceその他のDependencyが利用可能な状態にあることを確認する。
3. Releaseに必要なCI/CD Pipeline、Tool、Credential、Permissionその他の実行条件が成立していることを確認する。
4. Release対象の現在の状態を確認し、既存のResourceやApplicationに対する変更内容および影響範囲を把握する。
5. Release失敗時のRecovery / Rollbackに必要な手順および前提条件が整っていることを確認する。
6. Releaseの実施に必要な未解決事項が存在しないことを確認する。

前提条件が不足している場合は、その内容をユーザーに報告し、必要な対応を確認する。

Releaseを実施可能な状態にあることを確認した上で、ユーザーから実行の承認を得て次のStepへ進む。


### Step 3: Execute Release
**Release Instructions** および前Stepで確認した実行条件に従い、担当ModuleのImplementationを対象のProduction EnvironmentへReleaseする。

- Release対象、実施手順および実行順序を確認し、決定された方法でReleaseを実施する。
- Agentが実施主体となる操作は、Projectの実行ルールおよびユーザーの承認に従って実施する。
- ユーザーが実施主体となる操作については、必要な操作内容、対象、手順および完了条件を提示し、ユーザーからの完了報告を受けて結果を確認する。
- 各操作の実施結果および確認できた事実を記録する。
- Release中に確認すべきLog、Metricその他のMonitoring情報を確認する。

Release中に問題または期待結果との不一致が確認された場合は、その現象、発生状況および確認できた事実を記録し、本Step内では原因調査・修正を行わず、**Step: Handle Release Failure** へ進む。

Releaseが正常に完了した場合は、次のStepへ進む。


### Step 4: Perform Production Verification
**Release Instructions** に定義されたVerification方法および手順に従い、Production EnvironmentへReleaseしたImplementationが期待する構成・状態・動作となっていることを確認する。

1. Release対象のResource、Application、Container、Orchestration Workloadその他の対象について、期待する状態で存在・稼働していることを確認する。
2. Specificationおよび **Release Instructions** に基づき、Production Environment上で確認すべき構成・状態・動作を確認する。
3. Release時およびRelease後のLog、Metricその他のMonitoring情報を確認し、異常や注意すべき状態が発生していないことを確認する。
4. Verificationに必要な操作については、前工程で決定した実施主体に従って実施する。
5. Verificationの実施結果および確認できた事実を記録する。

問題または期待結果との不一致が確認された場合は、その内容を記録し、本Step内では原因調査・修正を行わず、次のStepへ進む。

### Step 5: Handle Release Failure
ReleaseまたはProduction Verificationにおいて問題、不具合または期待結果との不一致が確認された場合は、その内容およびProduction Environmentへの影響を確認し、Releaseの停止・Rollbackその他の保全措置の必要性をユーザーと判断する。

1. 検知した問題、発生状況、期待結果と実際の結果、および確認済みの関連情報を**Draft**に整理する。
2. 問題によるProduction Environmentへの影響および影響拡大の可能性を確認し、Releaseの停止・Rollbackその他の保全措置について、それぞれの期待される効果とリスクを比較・提示した上で、実施要否をユーザーと協議・決定する。比較にあたっては、措置を実施しない場合の影響およびリスクも考慮する。
3. 停止・Rollbackその他の保全措置を実施する場合は、**Release Instructions** に定義された手順およびProjectの実行ルールに従い、ユーザーと協力して実施する。
4. 実施した措置の結果を確認し、Production Environmentの現在の状態および残存する影響を整理・記録する。

問題が確認されていない場合は、本Stepをスキップして次のStepへ進む。

本Stepでは原因調査・修正は行わず、Production Environmentの保全を優先する。


### Step 6: Summarize Detected Issues
ReleaseまたはProduction Verificationにおいて問題、不具合または期待結果との不一致が確認された場合は、その内容および前Stepで実施した保全措置の結果を整理する。

1. 検知した問題、発生状況、期待結果と実際の結果、および確認済みの関連情報を確認する。
2. 前Stepで実施した停止・Rollbackその他の保全措置について、実施内容、結果およびProduction Environmentの現在の状態を確認する。
3. 検知した問題および保全措置の結果を **Draft** に整理し、後続のExecutor Delivery Flowで確認できる状態にする。

問題が確認されていない場合は、本Stepをスキップして次のStepへ進む。

本Stepでは問題への対応要否の判断、原因調査および修正は行わず、それらの進行は後続の別工程に委ねる。


### Step 7: Confirm Completion
担当ModuleのReleaseおよびProduction Verificationについて、実施状況、結果および未解決事項を確認し、所定のTemplate(`assets/release-result-report-template.md`)に基づいて Current Trainにおける担当Moduleの**Steering** の`working/<module-name>-release-result-report.md` に **Release Results Report** を作成・更新する。

再Releaseの場合は、既存の **Release Results Report** に過去の実施履歴を保持したまま、今回のReleaseおよびProduction Verificationの結果を追加・反映する。

1. **Release Instructions** に定義されたRelease操作およびVerificationが、必要な範囲で実施されていることを確認する。
2. Release対象、実施日時、実施した操作、実行結果およびProduction Verificationの結果を整理する。
3. Release時およびRelease後に確認したLog、Metricその他のMonitoring情報について、主要な確認結果および特記事項を整理する。
4. 問題または未解決事項が存在する場合は、その内容、対応状況、残存リスクおよびユーザーの判断を記録する。
5. ReleaseおよびProduction Verificationの結果を **Release Results Report** に整理する。再Releaseの場合は、過去の実施結果との対応関係を維持しながら今回の結果を反映し、ユーザーに報告する。
6. **Release Results Report** を Current Trainにおける **Steering** の `shared/executor-reports/` 配下にコピーする。
7. ReleaseおよびProduction Verificationの実施結果、検知された問題および残存する影響が適切に記録されていることを確認し、本Work Skillを完了する。

本Work Skillの完了は、ReleaseおよびProduction Verificationが正常に完了したことを意味しない。検知された問題への対応および必要な再Release・再Verificationは、後続の別工程で管理する。