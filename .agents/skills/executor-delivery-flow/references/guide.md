# Common Guide

## Default Inputs For Work Skill
以下は、Executor FlowからWork Skillへ共通して連携するInputの標準セットである。各Work Skillへの連携は、Task内で明示的に指定された場合に限る。

- **Domain**: 担当Domain
- **Module**: 担当Module
- **Requirement Mode**: **Workflow Initialization**で識別した**Requirement Mode**
- **Specification Sources**: **Domain Guide** の **Specification Sources** に指定されたパスのうち、実際に存在し、かつ `relevant-specifications.md` において`Non-Relevant`に分類されていないSpecificationのパス


## How to start the Implementation Loop
1. `tasklist.md` のTask、DependenciesおよびExecution Orderを確認し、今回実施するTaskとその順序を整理する。
2. 実施するTaskと順序、またその要約・概要をユーザーに提示する。
3. **Domain Guide** に指定された **Work Skill for Implementation Loop** を特定し、**Default Inputs for Work Skills** をInputとして連携して**Implementation Loop**を実行する。
4. `tasklist.md` の表から、対象Taskの**Implementation Loop**がすべて完了したことを確認する。



## Handling Issues After Verification
Integration Test、ReleaseまたはProduction Verificationの結果について、問題、不具合、期待結果との不一致その他後続工程への進行を妨げる事項が確認された場合は、以下の手順に従って対応する。

1. 検知された問題および未解決事項について、関連するVerification結果、Evidenceおよび残存リスクを確認し、対応要否をユーザーと協議・決定する。
   - 対応不要と判断された事項については、その理由およびユーザーの判断を担当モジュールの**Current Train**における**Steering**に任意のファイルを作成し、記録する。
   - 対応が必要な問題については、次以降の手順へ進む。

2. 対応が必要な問題について、共通Procedure **System Issue Triage** (`.agents/resources/dev-procedure/system-issue-triage.md`) を実施する。実施する際は、**Default Inputs For Work Skill**および**Detected Issue**をInputとして連携する。

**Detected Issue**
- 問題が検知された工程
- 発生状況
- 期待結果
- 実際の結果
- 確認済みの事実
- 関連するDraft／Evidence

3. **Triage Conclusion** を確認し、担当外Moduleの対応結果、担当Module内の修正要否・修正計画および残存するBlockerを把握する。

4. **Triage Conclusion** の **Outstanding Blockers** を確認する。
   - Blockerが存在する場合は、その内容および影響範囲を `blockers.md` に反映し、解消に必要な対応をユーザーと確認する。
   - Blockerによって実施できないTaskについては、解消されるまで再実施を保留・待機する。
   - Blockerが解消された場合は、その結果を確認し、`blockers.md` を更新する。

5. **Internal Corrections Required** が `Yes` の場合は、以下を実施する。
   - 決定した修正計画を `tasklist.md` の **Task Table** に追加する。
   - **Development Guidelines** に従い、現在作業中のブランチ（統合ブランチやリリース用ブランチ）からFix Branchを準備し、チェックアウトする。
   - **How to start the Implementation Loop** に従い、必要なImplementationおよびVerificationを実施する。

6. **Triage Conclusion**、Blockerの解消状況および修正内容・影響範囲を踏まえ、必要なTaskからExecutor Delivery Flowを再実施する。
   - **Internal Corrections Required** が `Yes` の場合は、修正内容の統合に必要なPR/MR関連Taskから再実施する。必要に応じて、それ以前の仕様整合確認も再実施する。
   - **Internal Corrections Required** が `No` の場合は、原則として問題が発生したVerificationを再実施する。ただし、担当外Moduleの対応結果や影響範囲によって必要な場合は、それ以前のTaskから再実施する。
   - いずれの場合も、再実施するTaskおよびVerificationは、修正内容と影響範囲に応じて必要な範囲を選定し、不要な工程を無条件に繰り返さない。
   - ただし、ReleaseまたはProduction Verificationで検知された問題に対してImplementationの修正を行った場合は、修正内容を統合ブランチへ反映し、必要なVerificationを実施した上で、必ず**Merge for Release Branch** を経由して **Execute Release and Production Verification** を再実施する。

未解消のBlockerが存在する場合は、その影響範囲に応じて実施可能なTaskのみを進める。Blockerの解消、または残存リスクを踏まえたユーザーによる進行承認が得られるまで、対応する結果確認・進行判定Taskを完了しない。

### Reference for **Triage Conclusion**
**Triage Conclusion** は、`docs/.steering/<current-train>/<module-name>/working/issues/issue-triage-<no>-plan.md` のうち、今回の **System Issue Triage** で作成・更新したファイルを参照する。

対象ファイルを特定できない場合は、同命名規則に該当するファイルのうち `<no>` が最大のものを確認し、今回の問題に対応することを確認した上で参照する。

対応関係を確認できない場合は、推測によって選択せず、ユーザーに確認する。


## Handling Requests During Await
Workflowの待機中に、Current Trainにおける担当ModuleのImplementation、Configuration、Verificationその他の関連事項について、ユーザーから相談または対応依頼があった場合は、以下の手順に従って対応する。

なお、下記`1.` ~ `4.`で整理・協議した内容は、**Current Train** における担当Moduleの **Steering** の `working/`下に依頼を受けるごとに任意のファイルを作成し、記録する。

1. ユーザーから受けた相談・対応依頼の内容を確認し、通常の相談・調査・確認と、問題・不具合・修正に関する対応依頼を区別する。
   - 通常の相談・調査・確認については、担当Moduleの責務範囲および **Executor Rules** に従って対応し、元のAwait Taskへ戻る。
   - 問題・不具合・修正に関する対応依頼については、次の手順へ進む。

2. **Current Train** における **Steering** の `shared/work-requests/` 配下にあるファイル群の各内容(**Correction Requests**) を確認し、自身の担当Moduleが対応先として指定されているもの、または担当Moduleが問題の原因・対応に関係する可能性があるものを特定する。

3. 特定した **Correction Requests** について、記載された問題、調査結果および依頼内容を確認し、担当Moduleの責務範囲と照合して対応要否をユーザーと協議・決定する。
   - 担当Moduleの対応範囲に該当しない場合は、その判断と根拠を整理する。

4. 担当Moduleで対応する事項について、関連するSpecification、Implementation、Configurationおよび既存の調査結果を確認し、必要な対応方針をユーザーと協議・決定する。

5. Correction Requestへの対応において、Taskの再実施が不要な場合は、本guideの**Finalize Correction Request Responses** に従い、対象のCorrection Requestへの回答・対応結果を記録する。
   - 対応完了後は、以降のStepを実施せず、元のAwait Taskでの待機を継続する。

6. Taskの再実施が必要な場合は、Current Trainにおける担当Moduleの**Steering** の `adhoc-workflow-context.md` の **Active Context** に以下を記録する。
   - **Title**：臨時対応の概要
   - **Origin Task**：依頼を受けたAwait Task
   - **Request Reference**：対象のCorrection Requestを一つ以上列挙
   - **Re-entry Task**：再実施を開始するTask
   - **Re-execution Scope**：再実施するTaskおよび対象範囲

   記録先のファイルが存在しない場合は、所定のテンプレート(`assets/adhoc-workflow-template.md`) を用いて`docs/.steering/<current-train>/<module-name>/adhoc-workflow-context.md` を新規作成する。

7. Implementationの変更が必要な場合は、以下を実施する。
   - **Development Guidelines** に従い、現在のWorkflowの進行状態に応じて適切なBranch(統合ブランチやリリース用ブランチ)からFix Branchを準備する。
   - 決定した対応内容を `tasklist.md` の **Task Table** に追加する。
   - **How to start the Implementation Loop** に従い、必要なImplementationおよびVerificationを実施する。

8. Taskの再実施が必要な場合は、対応内容および影響範囲を踏まえ、必要なTaskから本Workflow(Executor Delivery Flow)を再実施する。
   - Implementationの変更がある場合は、原則としてPR/MR関連Taskから再実施する。
   - Implementationの変更がない場合は、必要な確認・Verificationを実施する。
   - 再実施するTaskおよびVerificationは、変更内容と影響範囲に応じて選定し、不要な工程を無条件に繰り返さない。
   - 再実施したVerificationに対応する結果確認・進行判定Taskは省略しない。


Active Context に基づいてWorkflowを再実施する場合は、指定された Re-execution Scope の完了後、通常のWorkflow進行を継続せず、Origin Task へ復帰する。

待機中の対応によって、当該Await Taskの完了条件が満たされたものとは扱わない。

ユーザーから待機解除に必要な完了報告および進行指示を受けるまで、次のTaskへ進まない。


## Finalize Correction Request Responses
Correction Requestへの対応結果を確認し、対象の**Correction Requests** への回答・対応結果を最終化する。

1. 対象となる **Correction Request** および対応内容を特定する。
   - **Ad Hoc Workflow Context** の **Active Context** に基づくTask再実施後の対応である場合は、**Origin Task**、**Request Reference**、**Re-entry Task** および**Re-execution Scope** を確認する。
   - Taskの再実施を伴わない場合は、**Handling Requests During Await** で特定した**Correction Request** および対応結果を確認する。

2. Taskの再実施を伴う場合は、再実施したTaskについて、必要なImplementation、Verificationおよび関連する対応が完了していることを確認する。

3. 対象の **Correction Requests** のResponse欄に以下の情報を記録する。
   - 担当ModuleによるOwnershipおよび対応可否の判断
   - 実施した対応・変更内容
   - Verificationの実施結果
   - 未対応事項および残存リスク
   - 関連するCommit、PR/MR、Evidenceその他の参照情報

   対象となるCorrection Requestが複数存在する場合は、それぞれのResponseを個別に記録する。

4. Responseの記録が完了したことをユーザーに報告し、依頼元Moduleへの取り次ぎを依頼する。

5. **Active Context** に基づく対応の場合は、対象Contextへ対応結果の概要を追加し、**Context History** へ移動する。

本Procedureでは、Correction Requestに対する新たなImplementationやVerificationは実施しない。


## Process for each Task
### Verify Overall Specification Consistency
Agent `explorer` に担当Moduleの **Workspace**、`tasklist.md`、および **Specification Sources** のパスを連携し、**Current Train**のImplementation全体についてSpecificationとの重大な不整合がないかを確認してもらう。

依頼時には、以下を確認結果の出力先として連携する。 (変数<>となっている部分は適切に置き換えた上で連携する)

`docs/.steering/<current-train>/shared/information/implementation-consistency-review-<module-name>.md`

#### 依頼内容
※後続Taskの対応後に発生する再実施の場合は、その対応箇所・対応内容に応じて、依頼する内容や確認範囲を調整する。

```
担当ModuleのWorkspaceにあるImplementationを確認し、
tasklist.mdに定義されたCurrent Trainの担当Taskおよび
Specification Sourcesと照合して、仕様との不整合や実装の欠落を抽出する。

以下の観点で確認すること。

- 担当Taskに要求されたImplementationが欠落なく実現されているか。
- ImplementationがSpecificationに定義された構造、振る舞い、制約を満たしているか。
- `docs/change-requirements/` 配下に.gitkeep以外のファイルが存在する場合、Change Requirementsに定義された変更内容が反映されているか。
- また、Change Requirementsについて、実装の変更内容については、担当ModuleのWorkspaceにて現在チェックアウトされているブランチと、masterブランチとのgit diffを確認すること。

不整合または欠落が確認された場合は、
対象Task、Specificationの該当箇所、
Implementationの該当箇所、
問題の内容および根拠を整理する。

Specificationに明示されていない内容を独自に要求せず、
確認できない事項は推測で補完せずに区別して記録する。

本調査ではImplementationの変更・修正は行わない。
```

#### 完了報告受領後

完了報告を受けたら出力結果を確認し、以下のパスへ移動する。

`docs/.steering/<current-train>/<module-name>/working/implementation-consistency-review.md`


### Address Specification Review Findings
`implementation-consistency-review.md` に記録された指摘事項を確認し、対応要否および対応方針を整理する。

1. 各指摘について、関連するSpecificationおよびImplementationを確認し、指摘の妥当性と対応の必要性をユーザーと判断する。
2. 対応が必要な指摘について、具体的な対応方針を整理し、ユーザーと確認・決定する。
3. 対応する内容を `tasklist.md` の **Task Table** に追加し、本Guide の **How to start the Implementation Loop** の手順に従って **Implementation Loop** を実行する。(**Development Allocation**は変更しない)
4. 対応完了後、修正箇所および修正内容を中心に仕様突合を再依頼し、指摘事項が解消されていることを確認する。

対応が必要な指摘事項が存在しない場合、または必要な対応および再確認がすべて完了した場合は、本Taskを完了して次のTaskへ進む。


### Create Pull Requests
**Development Guidelines** に従い作成する。

- 下記形式の統合ブランチが存在しない場合は、まず、Masterブランチを起点として作成して、リモートにPush・適用する。
  - ブランチ名は、`<prefix>/<current-train-name>` の形式とする。prefixの命名規則については**Development Guidelines** に従う。
- **Development Guidelines** の PR/MR Templateの確認と必要に応じた準備・整理
- GitHub / GitLabのRemoteおよびBranchの確認
- Remoteが複数ある場合、複数Remote間のHEAD Commit SHAの一致確認
- PR/MRのタイトル・本文の作成
- PR/MR作成後のURL・状態の確認

### Organize Module README
担当ModuleのImplementation、ConfigurationおよびIntegration Testの結果を確認し、Templateに基づいて `README.md` を作成または更新する。

作成・更新形式はReadmeのテンプレート(`assets/module-Readme-template.md`)に従う。

以下の方針に従って内容を整理する。

1. Templateの全Sectionを必ず設ける必要はなく、担当Moduleに該当する内容、または記載すべき情報が存在するSectionのみを設ける。
2. **Reference Specifications** には、`docs/persistent/` 配下のSpecificationのうち、担当Moduleの構築・開発において特に重要となるものを選定して記載する。すべてのSpecificationを網羅する必要はない。
3. `docs/change-requirements/` 配下のChange RequirementsはCurrent Train固有の情報であるため、原則として主要なReference Specificationsには含めず、必要に応じて変更履歴や関連資料として参照する。
4. **Configuration** には、Password、API Key、Tokenその他のSecretの実値を記載せず、必要な設定項目およびその設定・取得方法を記載する。
5. READMEには実装・設定ファイルの内容を過度に複製せず、概要、構造、利用方法および必要に応じた参照先を記載する。具体的な実装・設定内容は、それぞれの正本となるファイルを参照する。
6. 既存の `README.md` が存在する場合は、その内容を確認し、現在のImplementationおよびConfigurationと整合するよう必要な追加・変更を行う。

作成・更新の際は、チェックアウト中のブランチから、README作成・更新用の作業ブランチを作成し、その内容についてユーザーの承認を得た上で派生元のブランチにマージする。


### Prepare Release Instructions
担当ModuleのImplementation、CI/CD Pipeline、Runtime Environmentおよび関連するSpecificationを確認し、Release時に必要となる操作と確認事項をRelease Instructionsに整理する。

#### **Release Instructions Policy**
- Releaseの対象、前提条件、実施手順、期待結果、Release後のVerificationおよび問題発生時の対応方法を明確にする。
- 操作手順は、可能な限り再実行可能なCommand / Script等を用いて具体的に記述する。
- 各操作について、必要に応じて実施主体を明確にする。
- Release時およびRelease後に確認すべきLog、Metricその他のMonitoring情報について、確認対象、確認方法および異常と判断する条件を整理する。
- DomainやRelease内容に応じてSectionの追加・変更・省略を認める。ただし、Releaseを安全に実施するために必要な情報は省略しない。
- 同Domainの別Moduleや、過去Trainの同一Moduleについて、**Release Instructions** が存在する場合は、その内容を確認し、**Executor Rules** の **Reference to Historical/Relevant Steering** に基づき、現在のReleaseにおいて参考となる手順、実施順序、Verification方法および注意事項を把握する。
- 本TaskではRelease Instructionsの作成までを行い、実際のReleaseは実施しない。

#### **Reuse of Test Specification**
Verificationについては、**Test Specification** に定義されたTest Method、Verification MethodおよびEvidence取得方法を参照し、利用可能なものは、必要に応じてOperational Verificationに適用する。

#### **Output**
Release Instructionsは**Current Train**における担当Moduleの **Steering** の `working/<module-name>-release-instructions.md` に作成・更新し、記録する。

作成・更新形式はRelease Instructionsのテンプレート(`assets/release-instructions-template.md`)に従う。

作成・更新が完了したら、**Current Train**における**Steering** の `shared/release-info/` 配下にコピーする。

### Finalize Module Handover
担当ModuleのImplementationおよびIntegration Testを通じて確定した情報を確認し、担当Moduleから後続Domain / Moduleへ引き継ぐ必要がある情報を整理・最終化する。

- 引き継ぎ内容には、**Domain Guide** の **Module Handover Policy** に指定された項目のうち、担当Moduleの対応内容に該当するものは全て含める。
- Environmentによって情報が異なる場合は、Environmentごとの対応関係を明確にする。
- Password、Token、API Keyその他のSecretの実値は記載せず、必要なCredentialの取得・参照方法を記載する。
- 既存のSpecificationやImplementationに定義された内容を過度に複製せず、後続Moduleが必要な情報およびその参照先を整理する。
- Handoverの対象となる情報が存在しない場合は、無理に項目を作成しない。
- 同Domainの別Moduleや、過去Trainの同一Moduleについて、**Outgoing Handover Information**が存在する場合は、その内容を確認し、**Executor Rules**の**Reference to Historical/Relevant Steering**に基づき、整理を行う上での参考にする。

**Outgoing Handover Information** を更新し、必要な情報が欠落していないことを確認する。

必要な情報を漏れなく記録・更新できたら、**Steering** の`shared/handover/`下にコピーする。


### Report Development Results
担当ModuleのImplementation、Integration Testおよび関連する対応結果を確認し、Template(`assets/development-report-template.md`)に基づいて **Development Report** を**Current Train**における担当Moduleの **Steering** の `working/<module-name>-development-report.md` に作成・更新する。

- **Test Specification** が存在する場合、**Requirement Verification Matrix** において担当Moduleへ割り当てられたVerificationを漏れなく抽出し、各項目の実施結果を記録する。
- **Test Specification** が存在する場合、Integration Testの結果は **Test Specification** およびEvidenceをもとに整理する。
- 使用したBranch、Commit、PR/MRは、実際のGit履歴およびRepositoryの状態に基づいて記録する。
- 未解決事項や残存リスクがある場合は、その内容、対応状況および後続工程への影響を明確にする。
- 既存のSpecificationやImplementationの内容を過度に複製せず、必要に応じて参照先を記載する。

作成・更新したDevelopment Resultsは、 **Current Train**における**Steering** の`shared/executor-reports/`下にコピーする。

### Merge for Release Branch
**Development Guidelines** に従い、担当Moduleの統合ブランチからリリース用ブランチへのMergeのための以下の工程を実施する。

1. Merge元およびMerge先のBranchを確認し、Release対象となる変更、Commitおよび未反映の変更を確認する。
2. 対象となるPull Request / Merge Requestを作成する。既存のPR/MRが存在する場合は、それを特定する。
3. PR/MRのReview完了状況、Required Checkの結果、Merge Conflictの有無およびMerge可能状態を確認する。
4. ユーザーにPR/MRのMergeを依頼し、完了報告を待つ。
5. Remote上でMergeが正常に完了し、対象のPR/MRがMerged状態になっていることを確認する。
6. ローカルでリリースブランチへCheckoutし、Remoteの最新状態へ同期する。

Merge完了後、リリースブランチにRelease対象の変更が適切に反映されていることを確認し、次の工程へ進む。


### Merge for Master Branch
**Development Guidelines** に従い、担当Moduleのリリース用ブランチからMasterブランチへのMergeのための以下の工程を実施する。
1. リリース用Branchに残っている変更がある場合は、ユーザーに報告し、対応方法を確認する。
2. Merge元およびMerge先のBranchを確認し、Masterへ反映する変更およびCommitを確認する。
3. 対象となるPull Request / Merge Requestを作成する。既存のPR/MRが存在する場合は、それを特定する。
4. PR/MRのReview完了状況、Required Checkの結果、Merge Conflictの有無およびMerge可能状態を確認する。
5. ユーザーにPR/MRのMergeを依頼し、完了報告を待つ。
6. Remote上でMergeが正常に完了し、対象のPR/MRがMerged状態になっていることを確認する。
7. ローカルでmasterブランチへCheckoutし、Remoteの最新状態へ同期する。

Merge完了後、MasterブランチへCurrent Trainの変更が反映されていることを確認し、次の工程へ進む。