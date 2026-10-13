# Infrastructure Domain Guide

## Specification Sources

### **Overall Design Specifications**
- `docs/persistent/system-architecture.md`
- `docs/persistent/infrastructure-architecture.md`
- `docs/change-requirements/system-architecture.md`
- `docs/change-requirements/infrastructure-architecture.md`

### **Detailed Design Specifications**
None.


## **Work Skill for Implementation Loop**
Work Skill: $infrastructure-implementation

## **Module Handover Policy**
- **Handover**: `Required`

### **Outgoing Handover Information**
担当Moduleが構築・管理するInfrastructure Resourceについて、後続のDatabaseおよびApplicationの構築・開発・接続・Deployに必要となる情報を整理する。

- `docs/persistent/infrastructure-architecture.md` や `docs/change-requirements/infrastructure-architecture.md` に **Application and Deployment Handoff** セクションが存在する場合は、その内容のうち、**Current Train** における担当Moduleの対応範囲に該当する事項をすべて網羅し、実際の構築結果に基づいて必要な情報を具体化する。
- **Database Connectivity**: Databaseへの接続先、Port、接続方式その他、Database Objectの作成・管理やApplicationからの接続に必要となる情報。
- **Resource Connectivity**: Applicationその他のModuleから利用されるInfrastructure Resourceについて、Endpoint、Port、接続方式その他の利用・接続に必要となる情報。
- **Container / Orchestration Environment**: Container Imageの配置先、Orchestration WorkloadのDeploy先、Namespace、Clusterその他のBuild・Deploy・実行に必要となる環境情報。
- **Access Requirements**: 上記Resourceの利用・操作に必要となる権限、認証方式およびアクセス条件。


## **Post-Release Actions**
- **Post-Release Actions** : `Required`

**Environment Lifecycle and Dormancy Strategy** において、Release後に対象EnvironmentまたはInfrastructure Resourceに対して停止、縮退、削除その他のLifecycle Actionを実施することが定義されている場合は、その内容に従って必要なPost-Release Actionを実施する。

1. **Environment Lifecycle and Dormancy Strategy** を確認し、**Current Train** のRelease・本番確認完了後に実施すべきLifecycle Actionおよび対象Environment / Resourceを特定する。
2. Current Train完了後のEnvironmentの利用予定をユーザーに確認し、Environmentを継続利用するか、定義されたLifecycle Actionを実施するかを決定する。前者が選択された場合は、Lifecycle Actionを実施せず、そのまま本Taskを完了する。
3. Lifecycle Actionの実施前に、保持が必要なState、Data、Artifact、Configurationその他のPreservation対象が必要な状態で保持されていることを確認する。
4. 定義された方法、実行順序およびDependencyに従い、必要な停止、縮退、削除その他のLifecycle Actionを実施する。
5. 実施後、対象Environment / Resourceが定義されたLifecycle Stateとなっていること、および将来の再生成・復元に必要なPreservation対象が維持されていることを確認する。

Release後に実施すべきLifecycle Actionが定義されていない場合は、本Taskをスキップする。


本TaskではLifecycle Strategyや停止・再生成方法を新たに設計・実装せず、既存のSpecificationおよびImplementationに基づいて実施する。



