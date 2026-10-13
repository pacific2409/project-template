# Backend Domain Guide

## Specification Sources

### **Overall Design Specifications**
- `docs/persistent/function-design.md`
- `docs/persistent/system-architecture.md`
- `docs/change-requirements/function-design.md`
- `docs/change-requirements/system-architecture.md`

### **Detailed Design Specifications**
- `docs/persistent/details/error-codes.md`
- `docs/persistent/details/database-definition.md`
- `docs/persistent/details/table/*.md`
- `docs/persistent/details/api/*.md`
- `docs/persistent/details/batch/*.md`
- `docs/change-requirements/details/database-definition.md`
- `docs/change-requirements/details/table/*.md`
- `docs/change-requirements/details/api/*.md`
- `docs/change-requirements/details/batch/*.md`


## **Work Skill for Implementation Loop**
Work Skill: $application-implementation

## **Module Handover Policy**
- **Handover**: `Required`

### **Outgoing Handover Information**
担当Moduleが提供するAPIおよび外部Interfaceについて、後続のFrontendその他のModuleが接続・利用するために必要となる情報を整理する。

- **API Endpoint**: APIのBase URL、Pathその他の呼び出し先を特定するための情報。
- **API Interface**: 利用可能なAPI、HTTP Method、Request / Responseその他のInterface Specificationへの参照情報。
- **Authentication / Authorization**: APIの利用に必要な認証・認可方式、Tokenその他のCredentialの取得・設定方法。
- **Connection Requirements**: APIの利用に必要となるNetwork、CORSその他の接続条件や制約。

## **Post-Release Actions**
- **Post-Release Actions** : `Not Required`
