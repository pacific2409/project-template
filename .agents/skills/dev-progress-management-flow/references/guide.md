# Development Progress Management Guide

## Confirm Module Development and Integration Completion

ユーザーから対象Moduleの完了報告を受けた場合は、以下を確認して当該ModuleにおけるDevelopmentおよびIntegrationを完了として扱えることを確認する。

1. 以下の成果物から対応内容確認する。
   - **Development Report**(`docs/.steering/<current-train>/shared/executor-reports/<module-name>-development-report.md`)
   - 当該ModuleのWorkspaceにある `README.md`

2. **Development Report** について、以下を確認する。
   - **Requirement Verification Matrix** における担当項目のVerification結果
   - Integration Test結果
   - 残存リスクおよび未解決事項
   - その他、Development完了の判断に必要となる報告内容

3. 確認した成果物および報告内容から、当該ModuleをDevelopment完了として扱えることを確認する。


## Prepare Release Procedure
以下を確認し、Current Train全体のRelease Procedureを整理する。

- `docs/.steering/<current-train>/shared/release-info/<module-name>-release-instructions.md`
- **Development Allocation Map**
- 関連するSpecification
- 必要に応じて各ModuleのDevelopment ReportおよびHandover

各Moduleの **Release Instructions** に定義されたRelease対象、前提条件、実施手順、Verificationおよび依存するResource / Moduleを確認する。

その上で、以下を整理する。

1. Current TrainでReleaseするModuleを特定する。
2. Module間の依存関係およびReleaseの前提条件を確認する。
3. 先行してReleaseする必要があるModuleと、後続Moduleとの関係を特定する。
4. 各ModuleのReleaseおよびProduction Verificationの実施順序を決定する。
5. Module間で連続して実施する必要がある操作、待機条件その他の全体調整事項を整理する。
6. 各Module固有の詳細なRelease手順については **Release Instructions** を正とし、Release Procedureへ過度に複製しない。

整理した内容を `.steering/<current-train>/manager/release-procedure.md` に記録する。


## Confirm Module Release Completion
ユーザーから対象ModuleのReleaseおよびProduction Verificationの完了報告を受けた場合は、`docs/.steering/<current-train>/shared/executor-reports/<module-name>-release-result-report.md` を確認する。

Release Result Reportについて、以下を確認する。

- Release Instructionsに定義された必要なRelease操作が完了していること。
- Production Verificationが完了し、期待する結果が確認されていること。
- Release中またはProduction Verification中に発生した問題と、その対応結果。
- 未解決事項および残存リスク。
- その他、当該ModuleをRelease完了として扱うために必要となる報告内容。

必要に応じて、Release Instructions、Evidence、Monitoring結果その他の関連成果物を確認する。

確認した成果物および報告内容から、当該ModuleをRelease完了として扱えることを確認する。


## Release Phase Completion

### **Review Release Results**
すべてのRelease対象Moduleについて、以下を横断して確認する。

- `docs/.steering/<current-train>/shared/executor-reports/<module-name>-release-result-report.md`
- **Release Procedure**
- 必要に応じて各Moduleの **Release Instructions**、Evidence、Monitoring結果その他の関連成果物

各ModuleのRelease Result Reportをもとに、以下を確認する。
- Release Procedureに定義されたすべてのModuleのReleaseが完了していること。
- 各ModuleのProduction Verificationが完了していること。
- Release中またはProduction Verification中に発生した問題と、その対応結果が把握されていること。
- 未解決事項および残存リスクが把握されていること。
- Module間のRelease結果に不整合がないこと。

### **Confirm Release Phase Completion**
横断確認の結果から、Current TrainにおけるModule単位のReleaseおよびProduction Verificationがすべて完了し、Release Phaseを完了として扱える状態であることを確認する。

Release Phaseの完了を妨げる未完了事項、不整合または未解決事項が存在する場合は、その内容と必要な対応を整理し、解消後に本確認を再実施する。