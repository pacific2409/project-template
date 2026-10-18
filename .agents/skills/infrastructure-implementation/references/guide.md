# Infrastructure Implementation Guide

## Implementation Policy
- 対象Resourceについて複数Environmentの定義が必要な場合は、EnvironmentごとにImplementation Loopを分離せず、必要な全Environmentの定義・変更を同一Task内でまとめて実施する。
- 複数Environmentの定義が必要な場合は、各環境の構成は、Specificationに定義されたEnvironment差異を除き、可能な限りProduction Environmentと同等になるよう実装する。
- terraformのようなInfrastructure as Codeツールを利用する場合かつ仕様上可能な場合は、変数と出力はそれぞれ独立したファイル(`variables.tf` および `outputs.tf` など)に定義する。
- **Environment Lifecycle and Dormancy Strategy** の内容を確認し、停止、縮退、削除、再生成、復元その他の定義されたLifecycle Strategyに対応可能なImplementationとする。

## Operational Verification Guideline
対象のImplementationについて、Environmentへの適用および適用後の動作・状態を確認するための方法と手順を整理し、**Draft** に整理の上、ユーザーに作業概要を提示する。その際は適用・検証手順で使用するコマンドも明示する。

stgその他の後続検証環境や本番環境へのApplyおよびVerificationは、本Implementation Loopでは実施せず、後続の対応工程で行う。

### **Verification Plan**
以下の内容を整理する。

- **Operational Verification**で確認する内容
- Verificationに必要な起動・稼働・適用その他の事前操作
- 開発・構築環境(dev等)への適用方法および手順
- Verificationの方法および手順
- 期待する状態・結果
- 実施に必要となるEnvironment Information
- 各操作をAgentまたはユーザーのどちらが実施するか
- 前項がユーザーの場合、結果をどこにどのような形式で保存させるか

#### **Environment Lifecycle and Dormancy Strategy**
`docs/persistent/infrastructure-architecture.md` または `docs/change-requirements/infrastructure-architecture.md` に **Environment Lifecycle and Dormancy Strategy** が存在する場合は、下記内容も整理する。

- 本Trainの **Requirement Mode** が `CR` であり、かつ当該Taskで適用・検証するResourceの前提となるEnvironmentまたはその構成要素が停止・縮退・削除された状態にある場合は、定義されたLifecycle ActionまたはCI/CD Pipeline等を利用して、Resourceの適用前または適用に伴って必要なEnvironmentを復元する方法と手順を整理する。
- **Environment Lifecycle and Dormancy Strategy** において、今回のImplementation対象が停止、縮退、削除、再生成または復元の対象となる場合は、そのLifecycle Actionによって期待する状態へ遷移できることを **Operational Verification** の対象として考慮する。
- 再生成・復元を確認する場合は、必要なState / Data / Artifact / Configurationが保持され、定義された方法によって利用可能な状態へ戻せることを確認対象とする。


### **Reuse of Test Specification**
**Test Specification** を確認し、選択したTaskの確認に利用可能なTest Method、Verification MethodまたはEvidence取得方法が定義されている場合は、必要に応じて**Operational Verification**にも流用する。

### **Dependency Readiness**
Implementation後の状態をもとに、計画したTest、Build、起動、適用・Deployおよび**Operational Verification**を実施するために必要なDependencyが十分に揃っていることを改めて確認する。

不足するDependencyが確認された場合は、本Stepにおいて必要なDependencyを追加・調整し、後続の適用・DeployおよびVerificationを実施可能な状態にする。

### **Execution Responsibility**
実行主体について、**Draft**、`working/` 配下の関連情報、`decisions.md` その他の既存情報から判断可能な場合は、その内容に従う。

既存情報から判断できない場合はユーザーに確認し、以降の作業でも前提となる重要な判断は `decisions.md` に、当該Taskの**Operational Verification**に限定される実施内容は対象Taskの **Draft** に記録する。

### **User Alignment**
整理した**Operational Verification**の方法と手順をユーザーに説明し、以降のStepで実施する内容について認識を合わせる。


## Module Handover Policy
担当Moduleが構築・管理するInfrastructure Resourceについて、後続のDatabaseおよびApplicationの構築・開発・接続・Deployに必要となる情報を整理する。

- `docs/persistent/infrastructure-architecture.md` や `docs/change-requirements/infrastructure-architecture.md` に **Application and Deployment Handoff** セクションが存在する場合は、その内容のうち、進行中のTaskの中で対応した内容に関連する事項については、実際の構築結果に基づいて必要な情報を具体化して、整理する。
- **Database Connectivity**: Databaseへの接続先、Port、接続方式その他、Database Objectの作成・管理やApplicationからの接続に必要となる情報。
- **Resource Connectivity**: Applicationその他のModuleから利用されるInfrastructure Resourceについて、Endpoint、Port、接続方式その他の利用・接続に必要となる情報。
- **Container / Orchestration Environment**: Container Imageの配置先、Orchestration WorkloadのDeploy先、Namespace、Clusterその他のBuild・Deploy・実行に必要となる環境情報。
- **Access Requirements**: 上記Resourceの利用・操作に必要となる権限、認証方式およびアクセス条件。