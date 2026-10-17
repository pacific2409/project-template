# CI/CD Pipeline Configuration Guide

## Common Guideline
- - `.gitlab-ci.yml` はPipeline全体の構成を担うものとし、複数Jobから `extends` して利用する共通処理は、`variables`、`include`、`default`、`stages` 等の全体定義を除き、`gitlab/.gitlab-common-ci.yml` に分離する。

### **Environment Trigger**
- EnvironmentごとのJobには、対象Environmentに対応するブランチのprefixをTrigger条件として含める。
- 各ブランチの具体的なprefixおよび運用については、**Development Guidelines** に従う。

## Domain-specific Guideline

### **Infrastructure**
Domain Infrastructureに属するModuleにおいては下記のGuidelineに従う。

#### **Separation by Provisioning / Application Method**

- Infrastructureでは、構築・適用方式が異なる領域について、CI/CD Pipeline上もそれぞれの責務を分離する。それぞれ独立したPipeline Definitionおよび実行単位として扱うことを基本とする。
- 分離した各Pipelineについては、Repository内で対応する構築・適用方式のDirectory配下に変更があった場合に、そのPipelineが実行対象となるよう変更PathをTrigger条件の設定に含めることを基本とする。
- 例えば、TerraformによるInfrastructureの構築と、`kubectl`によるKubernetes Resourceの適用が存在する場合は、それぞれのPipelineを分離する。
- Terraformに対するTerragruntや、Kubernetes Manifestに対するKustomizeなど、各構築・適用方式を補助・拡張するToolやEcosystemについては、それ自体を理由としてPipelineを分離せず、対応する構築・適用方式のPipelineに含めることを基本とする。

#### **Environment Lifecycle**
`docs/persistent/infrastructure-architecture.md` および `docs/change-requirements/infrastructure-architecture.md` に **Environment Lifecycle and Dormancy Strategy** のセクションが存在する場合は、その内容を一通り確認し、CI/CD PipelineまたはInfrastructure Operationによって実現する必要があるLifecycle Actionを特定する。

- Environment / Resourceの停止、縮退、削除に必要な操作
- State / Data / Artifactその他のPreservation
- Environmentの再開、再生成、復元に必要な操作
- Lifecycle Action間の実行順序およびDependency
- Lifecycle Action実行後のVerification
- Environmentごとの実行方式、Triggerおよび実行主体

Lifecycle Strategyの実現にPipelineの追加・変更が必要な場合は、Pipeline Configurationへ反映する。