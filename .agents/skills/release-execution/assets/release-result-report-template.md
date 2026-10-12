# Release Results Report

## Overview

- **Project**: [Project Name]
- **Train**: [Current Train]
- **Domain**: [Domain Name]
- **Module**: [Module Name]
- **Release Date**: [Date / Time]
- **Target Environment**: [Environment]

## Release Attempts
<!--
Releaseの実施回ごとにAttempt No.を採番し、一覧に記録する。
各Attemptについて、対応する「Attempt No. X」Sectionを作成し、Release Target、実施結果、Production Verification、Monitoringおよび問題への対応結果を記録する。
再Release時は過去のAttemptを上書きせず、新しいAttemptを追加する。
-->
| Attempt No. | Date / Time | Commit / Artifact | Release Result |
|---|---|---|---|
| 1 | [Date / Time] | [Commit / Artifact] | NOT_COMPLETED |
| 2 | [Date / Time] | [Commit / Artifact] | PASS |

## Attempt No. 1
### Release Target

| Item | Value |
|---|---|
| Branch | [Branch Name] |
| Commit | [Commit SHA] |
| Artifact / Image | [Artifact Name / Version / Digest] |
| Release Instructions | [Reference] |


### Release Execution Results

| No. | Operation | Result | Evidence / Reference |
|---|---|---|---|
| 1 | [Operation] | [Result] | [Reference] |
| 2 | [Operation] | [Result] | [Reference] |

### Production Verification Results

| No. | Verification Item | Expected Result | Actual Result | Status | Evidence / Reference |
|---|---|---|---|---|---|
| 1 | [Verification] | [Expected] | [Actual] | [PASS / FAIL / SKIPPED] | [Reference] |

### Monitoring Results

| Target | Verification Method | Result | Remarks |
|---|---|---|---|
| [Log / Metric / Resource] | [Command / Query / Dashboard] | [Result] | [Remarks] |

### Issues and Recovery Actions

[Release中またはProduction Verification中に確認された問題、停止・Rollbackその他の保全措置、その実施結果]

## Attempt No. 2

...

## Outstanding Issues and Risks

[未解決事項、残存リスク、対応状況およびユーザーの判断。存在しない場合はNone]

## Overall Result

- **Release Status**: [SUCCESS / FAILED / PARTIAL]
- **Production Verification Status**: [PASS / FAIL / PARTIAL]
- **Summary**: [ReleaseおよびProduction Verificationの総合結果]