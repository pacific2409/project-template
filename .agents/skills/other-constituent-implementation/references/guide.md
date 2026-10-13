# Other Constituent Implementation Guide

## Apply/Execution Guideline
対象TaskのImplementationについて適用・実行およびその結果の確認方法・手順を整理し、**Draft** に記録した上で、ユーザーに作業概要を提示する。

### **Apply/Execution and Verification Policy**

- 検証環境および開発環境またはローカル環境への適用・実行は、同じタイミングで実施する。(適用・実行先がローカル環境なのかクラウド上等の開発環境なのかについては仕様を確認する。)

### **Apply/Execution Plan**

以下の内容を整理する。

- 適用・実行方法および手順
- 結果確認の方法および手順
- 期待する状態・結果
- 実施に必要となるEnvironment Information
- 各操作をAgentまたはユーザーのどちらが実施するか
- 前項がユーザーの場合、結果をどこにどのような形式で保存させるか


### **Execution Responsibility**
実行主体について、**Draft**、`working/` 配下の関連情報、`decisions.md` その他の既存情報から判断可能な場合は、その内容に従う。

既存情報から判断できない場合はユーザーに確認し、以降の作業でも前提となる重要な判断は `decisions.md` に、当該Taskの**Apply/Execution**に限定される実施内容は対象Taskの **Draft** に記録する。

### **User Alignment**
整理した**Apply/Execution**およびその結果確認の方法・手順をユーザーに説明し、以降のStepで実施する内容について認識を合わせる。


## Module Handover Policy
### Database Handover Policy
担当Moduleが構築・管理するDatabaseおよびDatabase Objectについて、後続のApplicationがDataの参照・登録・更新・削除を行うために必要となる情報を整理する。

- **Database Identification**: 接続対象となるDatabase名、Schema名その他の識別情報。
- **Application Connectivity**: ApplicationからDatabaseへ接続するためのHost、Port、Database名、接続方式その他の接続情報。
- **Authentication / Authorization**: ApplicationがDatabaseを利用する際の認証方式、User、必要な権限およびCredentialの取得・参照方法。
- **Database Objects**: Applicationから利用するTable、Viewその他のDatabase Objectについて、参照すべきSpecificationや利用上の前提・制約。