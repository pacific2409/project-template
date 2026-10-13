# Ad Hoc Workflow Context

## Summary

本ファイルは、通常のWorkflow進行中に臨時の対応が発生し、別のTaskへの移行および元のTaskへの復帰が必要となる場合に、その制御情報と対応履歴を管理する。

臨時対応を開始する際は、既存Contextの最大No.に1を加えた番号を採番し、**Active Context** に記録する。

必要なTaskの再実施が完了した後は、記録された **Origin Task** へ復帰し、当該Taskに定義された対応結果の確認・記録・返却処理を実施する。

臨時対応の完了後は、対応結果を記録した上で、該当Contextを **Active Context** から **Context History** へ移動する。

本ファイルはTaskの進捗やIssueの詳細を管理するものではなく、Workflowの一時的な制御・復帰情報および臨時対応の履歴を管理するために使用する。

Active ContextはWorkflowの再実施単位で作成する。複数のCorrection Requestについて、共通のTask再実施によって対応できる場合は、単一のContextにまとめて管理してよい。

Active Contextは原則として1件ずつ処理し、指定されたRe-execution Scopeの完了後、Origin Taskへ復帰する。復帰時には、当該Contextに関連付けられたすべてのCorrection Requestについて回答・対応結果を最終化する。

## Active Context

<!-- 進行中の臨時対応を記録する。存在しない場合は空欄とする。 -->

### No. 1

- **Title**: [臨時対応の概要]
- **Origin Task**: [Task No. / Task Name]
- **Request Reference**: [関連するCorrection Request / Issue / Other Referenceを列挙]
- **Re-entry Task**: [Task No. / Task Name]
- **Re-execution Scope**: [再実施が必要なTaskおよび対象範囲]

## Context History

<!-- 完了した臨時対応を記録する。 -->

### No. X

- **Title**: [臨時対応の概要]
- **Origin Task**: [Task No. / Task Name]
- **Request Reference**: [関連するCorrection Request / Issue / Other Referenceを列挙]
- **Re-entry Task**: [Task No. / Task Name]
- **Re-execution Scope**: [再実施したTaskおよび対象範囲]
- **Result**: [対応結果の概要]