# Application Implementation Guide

## Operational Verification Guideline
対象のImplementationについて、開発環境もしくはローカル環境へのDeployおよびDeploy後の動作・状態を確認するための方法と手順を整理し、**Draft** に整理の上、ユーザーに作業概要を提示する。その際はDeploy・検証手順で使用するコマンドも明示する。(Deploy先がローカル環境なのかクラウド上等の開発環境なのかについては仕様を確認する。)

### **Verification Plan**

以下の内容を整理する。

- **Operational Verification**で確認する内容
- Verificationに必要な起動・稼働・Deployその他の事前操作
- 開発環境もしくはローカル環境へのDeploy方法および手順
- Verificationの方法および手順
- 期待する状態・結果
- 実施に必要となるEnvironment Information
- 各操作をAgentまたはユーザーのどちらが実施するか
- 前項がユーザーの場合、結果をどこにどのような形式で保存させるか

### **Reuse of Test Specification**
**Test Specification** を確認し、選択したTaskの確認に利用可能なTest Method、Verification MethodまたはEvidence取得方法が定義されている場合は、必要に応じて**Operational Verification**にも流用する。

### **Dependency Readiness**
Implementation後の状態をもとに、計画したTest、Build、起動、Deployおよび**Operational Verification**を実施するために必要なDependencyが十分に揃っていることを改めて確認する。

不足するDependencyが確認された場合は、本Stepにおいて必要なDependencyを追加・調整し、後続のDeployおよびVerificationを実施可能な状態にする。

### **Execution Responsibility**
実行主体について、**Draft**、`working/` 配下の関連情報、`decisions.md` その他の既存情報から判断可能な場合は、その内容に従う。

既存情報から判断できない場合はユーザーに確認し、以降の作業でも前提となる重要な判断は `decisions.md` に、当該Taskの**Operational Verification**に限定される実施内容は対象Taskの **Draft** に記録する。

### **User Alignment**
整理した**Operational Verification**の方法と手順をユーザーに説明し、以降のStepで実施する内容について認識を合わせる。

## Module Handover Policy
### API Handover Policy
担当Moduleが提供するAPIおよび外部Interfaceについて、後続のFrontendその他のModuleが接続・利用するために必要となる情報を整理する。

- **API Endpoint**: APIのBase URL、Pathその他の呼び出し先を特定するための情報。
- **API Interface**: 利用可能なAPI、HTTP Method、Request / Responseその他のInterface Specificationへの参照情報。
- **Authentication / Authorization**: APIの利用に必要な認証・認可方式、Tokenその他のCredentialの取得・設定方法。
- **Connection Requirements**: APIの利用に必要となるNetwork、CORSその他の接続条件や制約。