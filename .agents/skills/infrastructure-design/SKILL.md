---
name: infrastructure-design
description: >
  特定の具体的な作業を実施するWork型 Skill。
  Function DesignおよびSystem Architectureに基づき、Infrastructure Architectureについての仕様書を作成する。
  Use when: インフラ・アーキテクチャ設計時
  Do not use for: システム・アーキテクチャ設計、機能設計
---

# Work Skill: infrastructure-design

## Summary
Function DesignおよびSystem Architectureに基づき、Infrastructure Architectureについての仕様書を作成する。

## Inputs
- **Requirement Mode**: 本Skillにおける仕様定義の起点となった要求の性質によって、`INITIAL` または `CR` のいずれかに分かれる。
- **Scope** *(Optional)*: 本Skillで扱う作業対象および変更対象の範囲

## Sources
このファイルの内容をもとにInfrastructure Architectureの仕様書を作成する。
```
docs/persistent/function-design.md
docs/persistent/system-architecture.md
```

## 前提条件
- **Sources** のファイルが作成されており、いずれの内容も空でないこと。


## Content Guide for the Skill (`references/guide.md`)
Infrastructure Architectureに定義する内容、その検討観点および記述内容の指針を定める。このガイドを参照しながら要求定義を進める。

## Affected Modules
```
modules/infrastructure/*/*
```

## Draft
要求内容の検討過程において、ユーザーと議論した内容を以下に記録する。
```
docs/drafts/infrastructure-architecture-draft.md
```

## Artifacts
Infrastructure Architectureは以下に保存する:
```
docs/persistent/infrastructure-architecture.md
```

## Template for the Artifacts (`assets/template.md`)
**Artifacts**を作成する際に、テンプレートとして利用する。

## Specific Review Points Sheet (`references/review-points.md`)
Artifactsレビューを依頼する際に、レビュアーに提供する本ドキュメント特有のレビュー観点を定めている。

## Change Requirements
**Requirement Mode** = `CR` の場合、仕様変更の定義は以下に保存される。
```
docs/change-requirements/infrastructure-architecture.md
```

## Cloud Architecture Diagram Source
Cloud Infrastructureの構成図のSourceとなるdraw.ioファイルは以下に保存される。
```
docs/persistent/infrastructure-architecture.drawio
```

## Cloud Architecture Image

Cloud Infrastructureの構成図イメージは以下に保存される。
```
docs/persistent/infrastructure-architecture.png
```

## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- 本Skillは、通常実行時(**On-Demand Execution**の実行シナリオに該当しない全てのケース)には **Default Execution Steps** を、呼び出し元から **On-Demand Execution** が明示的に指定された場合には指定された **On-Demand Execution** のみを実行する。
- **On-Demand Execution** を実行する場合、**Default Execution Steps** は実行しない。
- 各StepはExecutionStepsに記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。ただし、承認不要と明記のあるStepはその内容を優先する。
- Execution Stepsの開始時、既存の**Artifacts**が存在する場合は、既存の構造と内容を維持しながら更新を行う。

## Goal
- ExecutionStepsに定義されたすべてのStepが完了していること。
- **Artifacts** の作成およびレビューが完了し、内容が承認されていること。

### Overview
### **Default Execution**
- Procedure: Spec Definition

── Post Steps ──

- Determine Impact on Cloud Architecture Diagram
- Generate Cloud Architecture Diagram
- Request to Export Cloud Architecture Image
- Review Cloud Architecture Diagram
- Extract Infrastructure-to-Application Dependencies

### **On-Demand Execution**
- Procedure: Specification Comparison Review

## Default Execution Steps
本Skillの通常実行時は、以下のStepを実行する。
### Procedure: Spec Definition
**Requirement Mode** に応じて、以下から該当するProcedureを一つ選択し、その内容を実行する。それによって、Infrastructure Architectureを作成・更新する。

- `INITIAL`: **Initial Spec Establishment** (`.agents/resources/doc-procedure/initial-spec-establishment.md`)
- `CR`: **Change Requirement Definition** (`.agents/resources/doc-procedure/change-requirement-definition.md`)

Procedureの実行にあたっては、以下を本Skillの定義から特定してInputとして使用する。

- **Sources**
- **Draft**
- **Artifacts**
- **Guide**
- **Template**
- **Specific Review Points Sheet**
- **Affected Modules** *(`CR`の場合のみ使用される)*
- **Scope** *(Optional: Inputとして指定されている場合)*

該当する **Procedure** から **Flow Required**=`False` が返却された場合、本Skillにおける以降のStepが存在しても、それらは実施せず、本Work Skillを終了する。

### Post Step 1: Determine Impact on Cloud Architecture Diagram
**Requirement Mode**=`CR`の場合にのみ、以下の手順を実行する。Otherwise, this Step is skipped.

**Artifacts**に対する**Change Requirements**の内容から、**Cloud Architecture Image**およびそのSourceとなる**Cloud Architecture Diagram Source**に修正が必要かを確認し、`Yes/No`で判断する。
  - `No`の場合は、本Skillにおける以降のPost Step 2 ~ 3をskipし、Post Step 4に進む。

### Post Step 2: Generate Cloud Architecture Diagram
**Requirement Mode**に応じて、以下のいずれかに従い、draw.io形式のCloud Infrastructure構成図 **Cloud Architecture Diagram Source** を$drawio Skillを使用して生成・更新する。

- `INITIAL`：**Artifacts**に基づいて新規作成する。
- `CR`: **Change Requirements**に基づいて、既存修正する形で再作成	- `CR`：**Artifacts**および**Change Requirements**に基づき、**Cloud Architecture Diagram Source**を更新する。

AWS等で公式アイコンが存在する場合は、必ずそれを使用し、その中でカラー付きのアイコンがある場合は、やはりこれも必ず使用して構成図を作成する。

構成図は、利用するCloud Provider（AWS / Google Cloud / Azure等）に応じたCloud Architecture Diagramとして作成し、少なくとも **Artifacts** で定義された以下の内容を読み取れるものとする。

- Environment / Network Boundary
- Availability Zone等の主要な配置Boundary
- Architecture上独立した役割を持つ主要Infrastructure Resource
- Application / Workloadの主要な配置
- Resource間の主要なConnectivity / Traffic Flow
- External System / External Serviceとの主要な接続
- Security、Management、Observability等、Infrastructure全体の成立に重要なResource

CIDR、IAM Policy、Security Group Rule、Resource Size等の詳細設定を網羅することは要求しない。

構成図はdraw.ioで編集可能な形式とし、既存のArchitecture Decisionを変更・追加せず、**Artifacts**の内容を可視化する。

### Post Step 3: Request to Export Cloud Architecture Image
前Stepで生成・更新したdraw.ioファイルについて、ユーザーにdraw.ioで開いてPNG形式へExportし、以下の**Cloud Architecture Image**パスへ配置するよう依頼する。

ユーザーから配置完了の報告を受けるまで、レビューへ進まない。


### Post Step 4: Review Cloud Architecture Diagram

ユーザーから提供されたCloud Architecture Diagramを **Artifacts** や および`CR`の場合は**Change Requirements** と比較し、以下を確認する。

- **Artifacts** で定義された主要Resourceや、**Change Requirements** による追加・変更が、構成図に必要な範囲で反映されていること。
- Environment、Network、Availability Zone等のBoundaryが **Artifacts** と一致していること。
- Application / WorkloadおよびInfrastructure Resourceの配置関係が一致していること。
- Resource間のConnectivity / Traffic Flowが **Artifacts** と矛盾していないこと。
- External Connectivity、Security、Management、Observability等の主要構成に欠落・矛盾がないこと。
- 構成図だけに、**Artifacts** または **Change Requirements** に存在しないArchitecture Decisionが追加されていないこと。
- **Cloud Architecture Diagram Source** と  **Cloud Architecture Image** の内容が一致していること。

不一致または不足がある場合は、その内容と該当箇所をユーザーへ提示し、修正するか確認する。

ユーザーが修正を希望する場合は、原則としてdraw.ioファイルを修正し、PNGの再Exportを依頼した後に再度レビューする。

修正しない場合は、その判断および残存する不一致・不足を報告して本Stepを完了する。

不一致または不足がない場合は、レビュー結果をユーザーへ報告して本Stepを完了する。

### Post Step 5: Extract Infrastructure-to-Application Dependencies
**Requirement Mode** に応じて、Agent `explorer` に以下の調査を依頼する。

#### `INITIAL`
**Sources** および **Artifacts** のパスを連携し、以下を依頼する。

依頼時には、`docs/persistent/infrastructure-to-application-dependencies.md`を確認結果の出力先として連携する。


```
 **Sources**をApplication設計上の前提として理解したうえで、**Artifacts**全体を確認し、Application Detail Design（API、Batch、UI等）の設計・実装に影響する事項を抽出する。

 **Artifacts**の単純な要約ではなく、Application側で考慮・実現・利用する必要がある事項に限定する。また、新たなApplication Architecture Decisionは行わない。
```

#### `CR`
**Sources** および **Change Requirements** のパスを連携し、以下を依頼する。

依頼時には、`docs/change-requirements/infrastructure-to-application-dependencies.md`を確認結果の出力先として連携する。

```
 **Sources**をApplication設計上の前提として理解したうえで、**Change Requirements**を確認し、今回のInfrastructure Architectureの追加・変更によって、Application Detail Design（API、Batch、UI等）側に新たに考慮・対応が必要となる事項を抽出する。

 今回の変更によって新たに発生または変更された依存事項に限定する。また、新たなApplication Architecture Decisionは行わない。
```



## On-Demand Execution

呼び出し元から以下のExecutionが明示的に指定された場合にのみ実行する。
この場合、通常の **Execution Steps** は実行しない。

### Procedure: Request Specification Comparison Review
Procedure: Specification Comparison Review(`.agents/resources/doc-procedure/comparison-review.md`)の内容を実行する。
Procedureの実行にあたっては、以下を本Skillの定義から特定してInputとして使用する。

- **Review Sources** : 呼び出し元から指定
- **Artifacts**
- **Comparison Review Report** : 呼び出し元から指定
- **Specific Review Points Sheet**
- **Destination for Reports after Review** : `docs/.steering/<current-train>/manager/reviews/`
- **Scope** *(Optional: Inputとして指定されている場合)*