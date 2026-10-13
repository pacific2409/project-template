# Database Domain Guide

## Specification Sources

### **Overall Design Specifications**
- `docs/persistent/function-design.md`
- `docs/persistent/system-architecture.md`
- `docs/change-requirements/function-design.md`
- `docs/change-requirements/system-architecture.md`

### **Detailed Design Specifications**
- `docs/persistent/details/database-definition.md`
- `docs/persistent/details/table/*.md`
- `docs/change-requirements/details/database-definition.md`
- `docs/change-requirements/details/table/*.md`


## **Work Skill for Implementation Loop**
Work Skill: $other-constituent-implementation

## **Module Handover Policy**
- **Handover**: `Required`

### **Outgoing Handover Information**
担当Moduleが構築・管理するDatabaseおよびDatabase Objectについて、後続のApplicationがDataの参照・登録・更新・削除を行うために必要となる情報を整理する。

- **Database Identification**: 接続対象となるDatabase名、Schema名その他の識別情報。
- **Application Connectivity**: ApplicationからDatabaseへ接続するためのHost、Port、Database名、接続方式その他の接続情報。
- **Authentication / Authorization**: ApplicationがDatabaseを利用する際の認証方式、User、必要な権限およびCredentialの取得・参照方法。
- **Database Objects**: Applicationから利用するTable、Viewその他のDatabase Objectについて、参照すべきSpecificationや利用上の前提・制約。

## **Post-Release Actions**
- **Post-Release Actions** : `Not Required`