# Task Allocation Guide

## Common Rules
- L2 ~ L4で定義する各要素の対応種別[Create / Update]については、**Requirement Mode** = `INITIAL`の場合は、全体を通して全て[Create]とする。

## Glossary

### **Module-level Required Items**

各L2 Moduleについて、Current Trainで必要となる付随対応を **Module-level Required Item** として定義する。

対象となるItemはDomainによって以下のとおりとする。

| Domain | CI/CD Pipeline | Container Image | Orchestration Workload |
|---|:---:|:---:|:---:|
| Infrastructure | ✓ | - | - |
| Database | ✓ | - | - |
| Backend | ✓ | ✓ | ✓ |
| Frontend | ✓ | ✓ | ✓ |

各Itemについて、Current Trainで対応が必要かを判定し、必要な場合は対応内容に応じて `Setup Required` または `Change Required`、不要な場合は `No` とする。

- **Setup Required**: 対象が存在せず、Current Trainで新規に構築・設定する必要がある場合。
- **Change Required**: 既存の対象に対して、Current Trainで変更する必要がある場合。
- **No**: Current Trainにおいて、対象の新規構築・設定および変更が不要な場合。

## Task Allocationの階層

Task Allocationでは、構築・開発対象を以下の階層に整理する。

### L1: Domain

構築・開発を行う大分類。

以下の順序を基本の実施順序とする。

1. Infrastructure
2. Database
3. Backend
4. Frontend

各Domainについて、Current Trainでの対応要否を判定する。
対応不要なDomainについては、後続のTask Allocationを行わない。

### L2: Module

各Domainにおける独立した担当・構築・開発単位。

Domainごとに以下の単位で整理する。

- Infrastructure: Cloud Provider等のInfrastructure担当単位
- Database: Data Migration / Database State Management / Data Replication
- Backend: Service
  - APIとBatchはそれぞれ独立したServiceとして扱い、同一Serviceに含めない。
- Frontend: Platform

複数のModuleが存在する場合は、設計上の依存関係をもとにModule間の実施順序を整理する。

#### **Database Module Definitions**

- **Data Migration**：旧System / 旧Data Modelから新System / 新Data ModelへDataを移行する。
- **Database State Management**：Databaseの構造および管理対象Dataについて、定義された状態を構築・変更し、各環境へ順次適用する。RDBでは、`CREATE TABLE`、`ALTER TABLE`等のDDLや、初期Master Dataの`INSERT`等のDMLを含む。
- **Data Replication**：Database間 / System間でDataを継続的に同期・複製する。


### L3: Functional Unit

各Moduleが構築・開発・変更する機能単位。

Specification / Definitionに定義された内容をもとに、下記のような単位で各Moduleが担当する機能を特定する。

- Infrastructure: Cloud Resource等
- Database: Table / Data等に対するDDL / DML
  - Databaseでは、DDLとDMLの双方が必要な場合、すべてのDDLを先行して実施し、その完了後にDMLを実施する。
- Backend: API、Batch等
- Frontend: Screen等

#### **Allocation Rules**

- 複数のFunctional Unitが存在する場合は、それらの依存関係をもとに実施順序を整理する。
- 複数のFunctional Unitには、依存される側から依存する側の順にExecution Orderを設定する。
- Infrastructureにおいて、検証環境や踏み台環境の構築が対応内容に含まれる場合は、他のFunctional Unitより先に実施するよう最優先のExecution Orderを設定する。
- Infrastructureにおいて、Resourceの構築・適用手段が異なる場合はFunctional Unitを分離する。例えば、Terraformによる構築と `kubectl apply` による構築が存在する場合、それぞれを別のFunctional Unitとして扱う。
- Databaseでは、DDLとDMLの双方が必要な場合、すべてのDDLを先行して実施し、その完了後にDMLを実施する。

### L4: Logic Unit

Functional Unitを構成する処理・ロジック単位。

Specification / Definitionに処理・ロジック単位およびその関係が定義されている場合、それらをTask Allocationへ反映する。

Task Allocationにおいて、Specification / Definitionに定義されていない実装内部の構造や処理単位を独自に設計・追加しない。

## Task Allocation Structure

Task Allocationでは、対象となる構築・開発作業をDomainの性質に応じてL1からL3、またはL4までの階層に整理する。

また、実際に、**Map Overview**を定義する場合は、下記の形式に従って整理する。

```text
L1: Domain X
│
├── L2: Module X
│   ├── L3: Functional Unit X
│   └── L3: Functional Unit Y
│
└── L2: Module Y
    └── L3: Functional Unit Z


L1: Domain Y
│
├── L2: Module X
│   │
│   ├── L3: Functional Unit X
│   │   ├── L4: Logic Unit X
│   │   └── L4: Logic Unit Y
│   │
│   └── L3: Functional Unit Y
│       ├── L4: Logic Unit X
│       └── L4: Logic Unit Y
│
└── L2: Module Y
    │
    └── L3: Functional Unit Z
        ├── L4: Logic Unit X
        └── L4: Logic Unit Y
```

## Abstract Model Template
### **L1: [Domain]**

- **Required**: [Yes / No]

#### **L2: [Module]**

- **Action**: [Create / Update]
- **Dependencies**:
  - [L2 Module]
- **Execution Order**: [順序]
- **[Module-level Required Item]**  *(Optional)*: [Setup Required / Change Required / No]

##### **L3: [Functional Unit]**

- **Action**: [Create / Update]
- **Dependencies**:
  - [L3 Functional Unit]
- **Execution Order**: [順序]

##### **L4: Logic Units**  *(Optional)*
<!-- L4はDomainに応じて使用し、Backend / Frontendでは使用し、Infrastructure / Databaseでは使用しない。 -->

1. [Create / Update] [Logic Unit]
2. [Create / Update] [Logic Unit]
3. [Create / Update] [Logic Unit]

