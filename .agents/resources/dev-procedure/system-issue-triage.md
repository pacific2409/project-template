# System Issue Triage Procedure

## Purpose
Implementation、Integration Test、ReleaseおよびProduction Verificationその他の工程で検知されたSystemの問題について、原因、影響範囲およびOwnershipを調査・特定し、必要な対応を整理する。

担当外Moduleの問題については対応依頼および結果の確認を行い、担当Module内の問題については修正方針・計画を整理する。

本Procedureでは担当ModuleのImplementationおよびVerificationは実施せず、その進行は呼び出し元に委ねる。

## Inputs
本Flowを利用する場合は、Flowの開始前に以下のInputを定義する。
明示的にOptionalと規定があるもの以外は全て必須項目とする。

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


## Development Allocation Map
下記にて、本フローで管理するModuleの担当範囲と本Trainにおける立ち位置が確認できる。
```
docs/.steering/<current-train>/shared/information/development-allocation-map.md
```


## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- 各StepはProcedure Stepsに記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。ただし、承認不要と明記のあるStepはその内容を優先する。


## Draft
各Triageでは、調査・判断・対応結果を記録するため、以下にDraftを作成する。

```
docs/.steering/<current-train>/<module-name>/working/issues/issue-triage-<no>-plan.md
```

- `<no>` は既存のDraftの最大番号に1を加えた3桁の連番とする。初回は `001` とする。
- 作成時は、同階層の既存のissue-triage-<no>-plan.mdの最大番号を確認し、`<no>` を決定する。
- DraftはTriage単位で作成し、各Stepで確認・整理した内容を継続的に記録する。
- 過去のDraftは履歴として保持し、削除・上書きしない。

## Correction Requests
担当外Moduleへの対応依頼に関する情報を整理し、配置する場所を示す。

```
docs/.steering/<current-train>/shared/work-requests/correction-request-<no>-from-<module-name>.md
```
- `<no>` は当該リクエストについて整理を行なった**Draft** の番号に合わせる。



## Procedure Steps
- Validate Inputs and Prepare Draft
- Identify Issues
- Identify Ownership
- Prepare External Correction Requests
- Request External Corrections
- Await External Correction Results
- Plan Internal Corrections
- Report Triage Results

### Step 0: Validate Inputs and Prepare Draft
- **Inputs**における必須項目が全て情報として揃っていることを確認する。
- **Draft** を作成する。

### Step 1: Identify Issues
呼び出し元から引き継いだ問題について、発生状況、期待結果と実際の結果、関連するImplementationおよびEnvironmentの状態を確認し、問題の内容、原因および影響範囲を調査・整理する。

1. 問題が検知された工程、対象Module、Environment、発生状況および確認済みの事実を整理する。
2. 関連するTask、Specification、Implementation、Configuration、Log、Test Resultその他の情報を確認し、期待する状態・動作と実際の結果の不一致を特定する。
3. 問題の原因を調査し、確認できた原因と、未確定の原因・可能性を区別する。
4. 問題によって影響を受けるModule、Resource、Environment、機能およびVerificationの範囲を特定する。
5. 調査結果を **Draft** に整理する。

確認できない事項は推測によって確定せず、未確定事項として記録する。


### Step 2: Identify Ownership
前項で整理した問題の原因および影響範囲について、**Development Allocation Map**、Specificationおよび各Moduleの責務を確認し、担当Module内外の対応範囲を特定する。

1. 特定した問題の原因について、担当Moduleの責務範囲に属するものと、担当Module外の責務範囲に属するものを区別する。
2. 担当外の問題については、担当外の対応事項として整理する。
3. 担当内外の双方に対応が必要となる場合は、それぞれの対応範囲および依存関係を整理する。
4. Ownershipが確定できない事項については、その理由および確認に必要な情報を整理する。
5. 特定したOwnershipおよび対応範囲を **Draft** に記録する。

担当内外の問題は排他的に扱わず、該当するものをそれぞれ後続Stepの対象とする。

### Step 3: Prepare External Correction Requests
担当Module外に対応が必要と考えられる問題が存在する場合は、その内容および必要な対応を整理し、**Correction Requests** を作成する。

1. 担当外の各問題について、発生状況、確認済みの原因、影響範囲および依頼する対応内容を **Draft** に整理する。
2. **Development Allocation Map** を参照し、各問題について対応先と考えられるDomain / Moduleを特定し、**Draft** に整理する。
   - 担当Moduleまで特定できる場合は、該当Moduleに分類する。
   - Moduleを特定できない場合は、該当Domainに分類する。
   - Domainも特定できない場合は、未分類として整理する。
   - 複数のDomain / Moduleが関係する可能性がある場合は、無理に単一の対応先へ分類せず、関連する候補を併記する。
3. 分類したDomain / Moduleごとに問題および対応依頼を整理し、単一の対応依頼ファイルとして **Correction Requests** に作成・配置する。
    - 作成する際は、テンプレート(`agents/resources/dev-procedure/correction-request-template.md`) の形式を踏襲し、リクエスト情報(Request Informationおよび各Request)を記載する。Response欄は依頼先の記述欄であるため、ここでは記載しない。

対応先の特定は **Development Allocation Map** および確認済みの情報に基づいて行い、他Domain / Moduleの内部仕様や責務を推測によって確定しない。

対応先のDomain / Moduleに分類された事項についても、実際の対応可否およびOwnershipは依頼を受けた側で確認・判断する。

担当外の問題が存在しない場合は、本StepおよびStep 4～5をスキップし、Step 6へ進む。

### Step 4: Request External Corrections
前Stepで作成した **Correction Requests** の内容および配置先をユーザーに提示し、対象Domain / Moduleへの取り次ぎを依頼する。

対応先が未確定の事項については、必要に応じてユーザーを介してManagerによるOwnershipの識別・調整を依頼する。

本Stepでは担当外ModuleのImplementationを直接変更しない。

### Step 5: Await External Correction Results
前Stepで依頼した事項について、対応先からの回答および対応結果を確認する。

1. **Correction Requests** への外部対応(回答・対応結果の記録も含め)が完了した旨の報告をユーザーから受けるまで待機する。
2. ユーザーから完了報告を受けたら、**Correction Requests** に各対応先からの回答および対応結果が記録されていることを確認する。
3. **Correction Requests** の更新内容を確認し、確定したOwnership、実施された変更、未対応事項および担当Moduleへの影響を **Draft** に反映する。
4. 対応先が未確定の事項や、追加の対応が必要となる事項が残っている場合は、必要に応じて **Correction Requests** を更新し、ユーザーを介して追加の確認・対応を依頼する。その場合は、手順1から再実施する。

対応結果によって問題の原因やOwnershipに関する認識が変わった場合は、必要に応じて前Stepまでの調査・整理内容を更新する。

必要な回答および対応結果が揃ったことを確認して、次のStepへ進む。

### Step 6: Plan Internal Corrections
担当Module内に対応が必要な問題が存在する場合は、これまでの調査結果および担当外Moduleの対応結果を踏まえ、必要な修正方針およびImplementation Planをユーザーと協議・決定する。

1. 担当Module内の各問題について、原因、影響範囲および必要な修正内容を確認する。
2. 関連するSpecification、Implementation、Configurationおよび担当外Moduleの対応結果を確認し、修正方法の選択肢を整理する。
3. 各選択肢について、期待される効果、影響範囲およびリスクを比較し、対応方針をユーザーと協議・決定する。
4. 決定した対応方針に基づき、修正対象、Implementationの内容、実施順序および必要なDependencyを整理する。
5. 修正方針およびImplementation Planを **Draft** に記録する。

担当Module内に修正が必要な問題が存在しない場合は、本Stepをスキップする。

本StepではImplementationを実施しない。

### Step 7: Finalize Triage Results
これまでの調査、担当外Moduleへの対応依頼および担当Module内の修正計画の結果を整理し、後続のImplementationおよびVerificationに必要な情報を確定する。

1. 検知された問題について、原因、影響範囲およびOwnershipの調査結果を確認する。
2. 担当外Moduleへの対応依頼について、依頼先、対応内容、確認した対応結果および残存する問題を整理する。
3. 担当Module内の修正要否および決定した修正方針・計画を確認する。
4. 修正・変更によって影響を受ける可能性のあるImplementationおよびVerificationの範囲を整理する。
5. 未解決事項、未確定情報およびBlockerが存在する場合は、その内容と後続作業への影響を明確にする。
6. これまでの結果を踏まえ、以下の結論を**Triage Conclusion**として下記Formatに従い **Draft** に明記する。
   - **External Corrections**: 担当外Moduleによる対応が発生したか、およびその対応結果。
   - **Internal Corrections Required**: 担当Module内でImplementation Loopによる修正が必要か。
7. **Draft** の内容を最終確認し、本Procedureを完了する。

本ProcedureではImplementation LoopおよびVerificationの実行、元のWorkflowへの復帰は行わず、後続工程の進行は呼び出し元に委ねる。

#### Format of Triage Conclusion
```
## **Triage Conclusion**

- **External Corrections Performed**: Yes / No
- **Internal Corrections Required**: Yes / No
- **Outstanding Blockers**: [内容 / None]
```