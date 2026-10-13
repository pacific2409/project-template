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

## Prepare Repository Structure Guideline
### **Database State Management**
Database / Schema自体の作成・定義、Database内部の構造変更（DDL）、管理対象Dataの変更（DML）を責務ごとに分離する。ただし、Technology StackおよびMigration Toolによって発生する要件がある場合は、それぞれの性質に合わせてDirectory Structureを柔軟に調整する。

- Database State Management Moduleでは、Database自体の作成・初期構成、DDL、DMLをそれぞれ異なる責務として扱い、Repository Structure上も領域を分離する。
- 例えば、これらすべてを扱う場合は以下のように構成する。

```text
<module-root>/
├── database-schema/
├── ddl/
└── dml/
```

- 対応内容に含まれない領域は作成しない。


### **Separation by Database State Management Responsibility**
- DDLおよびDMLについて複数のDatabaseを管理する場合は、対象Databaseごとにサブディレクトリを分離する。
- 例えば、複数DatabaseについてDDL、DMLを管理する場合は、以下のように構成する。

```text
<module-root>/
├── ddl/
│   ├── database-a/
│   └── database-b/
└── dml/
    ├── database-a/
    └── database-b/
```

## **Work Skill for Implementation Loop**
Work Skill: $other-constituent-implementation