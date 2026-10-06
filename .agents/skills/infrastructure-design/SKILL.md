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

## Comparison Review Report
文書間の整合性確認の結果の出力先は以下のパスとする:
```
docs/reviews/infrastructure-architecture-on-dependencies.md
```

## Specific Review Points Sheet (`references/review-points.md`)
Artifactsレビューを依頼する際に、レビュアーに提供する本ドキュメント特有のレビュー観点を定めている。

## Rule
- ファイルの作成・更新を含め各作業は、Projectのルールに則って実施する。
- 各StepはExecutionStepsに記載された順序で実行する。
- 各Stepの完了条件を満たすまで次のStepへ進まない。
- ユーザーとの対話が必要なStepでは、合意した内容を以降のStepの前提とする。
- 各Stepの完了、および次のStepへの進行にはユーザーの承認を得る。ただし、承認不要と明記のあるStepはその内容を優先する。
- Execution Stepsの開始時、既存の**Artifacts**が存在する場合は、既存の構造と内容を維持しながら更新を行う。

## Goal
- ExecutionStepsに定義されたすべてのStepが完了していること。
- **Artifacts** の作成およびレビューが完了し、内容が承認されていること。

### Overview
- Initial Spec Establishment Flow

── Post Steps ──

- Request Cloud Architecture Diagram
- Review Cloud Architecture Diagram
- Extract Infrastructure-to-Application Dependencies 

## Execution Steps
### Initial Spec Establishment
以下を本Skillの定義から特定した上で、**Initial Spec Establishment Flow**(`.agents/resources/common-flow/initial-spec-establishment-flow.md`)に従い、PRDの作成および関連作業を行う。

- **Sources**
- **Draft**
- **Artifacts**
- **Guide**
- **Template**
- **Comparison Review Report**
- **Specific Review Points Sheet**
- **Scope** *(Optional: Inputとして指定されている場合)*

**Initial Spec Establishment Flow** から **Flow Required**=`False` が返却された場合、本Skillにおける以降の **Execution Steps** は実施せず、本Skillを終了する。

### Post Step 1: Request Cloud Architecture Diagram

**Artifacts** に基づくCloud Infrastructureの正式構成図をPNG形式で作成し、`docs/persistent/infrastructure-architecture.png` 配下の指定されたパスへ配置するようユーザーに依頼する。

構成図は、利用するCloud Provider（AWS / Google Cloud / Azure等）に応じたCloud Architecture Diagramとして作成し、少なくとも **Artifacts** で定義された以下の内容を読み取れるものとする。

- Environment / Network Boundary
- Availability Zone等の主要な配置Boundary
- Architecture上独立した役割を持つ主要Infrastructure Resource
- Application / Workloadの主要な配置
- Resource間の主要なConnectivity / Traffic Flow
- External System / External Serviceとの主要な接続
- Security、Management、Observability等、Infrastructure全体の成立に重要なResource

CIDR、IAM Policy、Security Group Rule、Resource Size等の詳細設定を網羅することは要求しない。

ユーザーから配置完了の報告を受けるまで、次のStepへ進まない。


### Post Step 2: Review Cloud Architecture Diagram

ユーザーから提供されたCloud Architecture Diagramを **Artifacts** と比較し、以下を確認する。

- **Artifacts** で定義された主要Resourceが、構成図に必要な範囲で反映されていること。
- Environment、Network、Availability Zone等のBoundaryが **Artifacts** と一致していること。
- Application / WorkloadおよびInfrastructure Resourceの配置関係が一致していること。
- Resource間のConnectivity / Traffic Flowが **Artifacts** と矛盾していないこと。
- External Connectivity、Security、Management、Observability等の主要構成に欠落・矛盾がないこと。
- 構成図だけに、**Artifacts** に存在しないArchitecture Decisionが追加されていないこと。

不一致または不足がある場合は、その内容と該当箇所をユーザーへ提示し、構成図を修正するか確認する。

ユーザーが修正する場合は、修正版の配置完了報告を受けた後に再度レビューする。修正しない場合は、その判断を受け入れて本Stepを完了する。

不一致、不足、不整合がない場合は、レビュー結果をユーザーへ報告して本Stepを完了する。

### Post Step 3: Extract Infrastructure-to-Application Dependencies
Agent `explorer` に**Sources**および**Artifacts**のパスを連携の上、下記内容を依頼する。完了報告を受けたら、その旨と、抽出結果の出力先をユーザーに報告する。

```
**Sources**をApplication設計上の前提として理解したうえで、**Artifacts**全体を確認し、Application Detail Design（API、Batch、UI等）の設計・実装に影響する事項を抽出する。

**Artifacts**の単純な要約ではなく、Application側で考慮・実現・利用する必要がある事項に限定する。また、新たなApplication Architecture Decisionは行わない。

抽出結果は、`docs/ideas/infrastructure-to-application-dependencies.md` に整理する。
```