# Codex開発基盤

本リポジトリは、CodexなどのAIエージェントと人間が協力し、構想・要件定義・設計・構築・開発・検証・リリースまでを一貫して進めるための、文書駆動型の開発基盤である。

単一の長大なプロンプトへすべての指示を集約するのではなく、役割、工程、作業、成果物および関心ごとにMarkdownとSkillを分離する。エージェントは必要な情報を必要な工程で読み込み、判断・進捗・未解決事項・EvidenceをProject内へ記録しながら作業を進める。

この基盤が固定するのは、個別のプロダクト内容や実装方式ではない。次のような、開発で抜かしたくない工程と形式である。

- 誰が何を担当し、どこまで変更できるか
- 何を正本として参照するか
- どの順序で工程を進めるか
- 何を確認し、どこへ記録するか
- どの時点で人間の判断・承認を得るか
- 問題が発生した場合に、どの責務・工程へ戻るか
- 会話のコンテキストが途切れても、どの文書から再開するか

## この基盤の特徴

### 文書がProjectの状態を保持する

要求、仕様、Task、進捗、判断、Blocker、Handover、検証結果およびRelease結果をMarkdownへ記録する。

チャット履歴だけに状態を持たせず、エージェントや会話スレッドが変わっても、Project内の文書から目的、現在位置、決定事項および次の作業を復元できる構成を目指す。

### ManagerとExecutorの責務を分離する

- **Manager**: Product Requirement、設計、Task Allocation、Module間Dependency、Project全体の進捗およびRelease順序を管理する。
- **Executor**: 割り当てられたModuleについて、仕様に基づく構築・開発・検証・Deliveryを担当する。

Managerは各Moduleの具体的な実装を行わず、Executorは自身の担当範囲を越えて他Moduleを変更しない。担当間の情報は文書として記録し、ユーザーが受け渡す。

### 人間の判断を正式な工程として扱う

エージェントは調査、整理、実装および検証を進める一方、要求、対応方針、Ownership、Release、残存リスクを伴う進行などの重要な判断では、ユーザーへ確認と承認を求める。

自律実行と人間による統制を対立させず、それぞれが適する範囲を工程内で分担する。

### 正常系だけでなく、戻り方を定義する

Integration TestやProduction Verificationで問題が見つかった場合、原因とOwnershipを整理し、担当内修正、担当外ModuleへのCorrection Request、Specificationの確認・訂正、Blockerとしての待機へ分岐する。

必要な工程だけを再実施し、対応結果を確認して元の進行へ復帰することで、問題対応を例外的な作業ではなくWorkflowの一部として扱う。

## 基盤を構成する要素

### AGENTS.md

Projectに参加するすべてのエージェントへ適用する最上位ルールである。

用語、役割、責務、Project構造、Skillの利用方法、承認、実行ガバナンスおよび文書管理の原則を定義する。個別工程の詳細は集約せず、Skillや関連文書へ分離する。

### Skill

Skillは、用途に応じて必要な指示だけを読み込むための再利用単位である。本基盤では主に次の種類を使用する。

| 種類 | 役割 |
|---|---|
| Flow Skill | Taskの順序、進行条件、承認点、待機および復帰地点を管理する |
| Work Skill | 文書作成、設計、実装、Test、Releaseなどの具体的な作業を実施する |
| Procedure | 複数のFlowやTaskから利用する調査・レビュー・問題対応などの共通手順を定義する |
| Guide | Flow共通の処理やDomainごとの差分、成果物の記載内容を案内する |
| Template / Assets | 成果物や記録文書の形式を提供する |

Flow Skillは「何を、どの順序で進めるか」を担当し、Work Skillは「各工程の具体的な作業をどう実施するか」を担当する。これにより、工程の制御と個別作業の詳細が混ざることを避ける。

Skillは[`.agents/skills/`](.agents/skills/)に、共通ProcedureやExecutor Rulesは[`.agents/resources/`](.agents/resources/)に配置する。

### Sub-agent

独立した観点や専用の責務が必要な作業は、Sub-agentへ委譲する。

本基盤には、次のReviewerが含まれる。

- **document-reviewer**: 指定されたReview PointsとEvaluation Modeに基づき、文書を詳細レビューする。
- **spec-comparator**: 成果物と参照仕様を比較し、文書間の整合性を検証する。

呼び出し元は、Review対象、依存文書、Review観点、評価Mode、Scopeおよび出力先を明示する。Sub-agentは定められたReportへ結果を記録し、呼び出し元が指摘への対応要否を判断する。

Sub-agentの定義は[`.codex/agents/`](.codex/agents/)に、Review PolicyとReport Templateは[`.codex/agents/resources/`](.codex/agents/resources/)に配置する。

### Steering

Steeringは、各Trainにおける進行と判断の記録領域である。

```text
docs/.steering/<train>/
├── shared/
│   ├── information/
│   ├── handover/
│   ├── work-requests/
│   └── executor-reports/
├── manager/
└── <module-name>/
    ├── flow-status.md
    ├── tasklist.md
    ├── blockers.md
    ├── decisions.md
    ├── pending-information.md
    ├── handover-from-<module-name>.md
    ├── working/
    └── test/
```

- `shared/`: Manager、Executorおよびユーザー間で受け渡す情報を管理する。
- `manager/`: Train全体の進行、Review、Draftおよび判断を管理する。
- `<module-name>/`: 各Executorが自身のTask、進捗、判断、検証およびHandoverを管理する。

Steeringは仕様そのものではない。Projectで継続的に参照する要求・設計・方針は`docs/persistent/`を正本とし、SteeringにはTrain固有の作業経緯とEvidenceを残す。

### Train

Trainは、Projectに対して新規開発、機能追加または改修を最初から完了まで進める単位である。

- **INITIAL**: Projectの初回開発として、要求・仕様を定義し、新規に構築・開発する。
- **CR**: 現行の要求・仕様を前提として、Change Requirementsに基づく追加・変更を行う。

Projectは複数のTrainを通じて発展する。Current Trainと履歴は、Train初期化時に作成される`docs/train-status.md`で管理する。

## 4つの中心Flow

本基盤では、Projectの開始から完了までを主に4つのFlowで進行する。

### 1. Development Specification Flow

Managerが、新しいTrainの構想から開発準備までを進行する。

主な工程は次のとおりである。

1. Product Conceptの整理
2. Trainの初期化
3. Product Requirements Definition
4. Architecture Outline
5. Function Design
6. System Architecture
7. Infrastructure Architecture
8. Application Detail Design
9. 設計範囲と整合性の確認

成果物は主に`docs/persistent/`または`docs/change-requirements/`へ記録する。各文書は専用のWork Skill、Guide、TemplateおよびReview Pointsに基づいて作成・レビューする。

### 2. Development Progress Management Flow

Managerが、Specification完了後からTrain CloseまでのProject全体を管理する。

主な工程は次のとおりである。

1. Project Environmentの準備
2. Task AllocationとModule間Dependencyの整理
3. Requirement Verification責務の割当
4. Executor用WorkspaceとSteeringの準備
5. Dependencyに基づく各Executorの開始・進捗管理
6. Development / Integration Phaseの完了確認
7. Release ProcedureとModule別Release順序の管理
8. Train全体のProduction Verification完了確認
9. Documentationの最終化
10. Train Close

Managerは各Executorの実装を直接行わず、ユーザーを介して開始指示、Handoff、完了報告および次工程への進行を管理する。

### 3. Executor Development Flow

Executorが、割り当てられた一つのModuleについて、開発準備からImplementation Loop完了までを進行する。

主な工程は次のとおりである。

1. 担当TaskとSpecificationの理解
2. 関連Specificationと既存・参考実装の抽出
3. 作業BranchとRepository Structureの準備
4. Module Quality Gateの確立
5. Test Specificationの作成
6. Runtime EnvironmentとCI/CD Pipelineの準備
7. Domain別Work SkillによるImplementation Loop
8. Unit Test、Static Validation、DeployおよびOperational Verification
9. Task、Decision、BlockerおよびEvidenceの更新

Infrastructure、Database、Backend、Frontendなどの違いはDomain GuideとImplementation Work Skillで吸収する。

### 4. Executor Delivery Flow

Executorが、Implementation Loop完了後の統合、ReleaseおよびModule完了までを進行する。

主な工程は次のとおりである。

1. Specificationとの全体整合性確認
2. PR / MRの作成、ReviewおよびIntegration BranchへのMerge
3. Integration Testと結果確認
4. README、Release Instructions、HandoverおよびDevelopment Reportの作成
5. Release準備の待機
6. Release BranchへのMerge
7. Production ReleaseとProduction Verification
8. Train全体のProduction Verification完了待機
9. Post-release Action
10. Master BranchへのPromotionとModule完了

待機中にCorrection Requestを受けた場合は、Ad Hoc Workflow Contextへ再実施範囲と復帰先を記録する。必要なTaskを完了した後は元のAwait Taskへ戻り、依頼元へResponseを返して待機を継続する。

## Project全体の進み方

```text
ユーザー
  │
  ▼
Manager: Development Specification Flow
  │  要求・設計・Specification
  ▼
Manager: Development Progress Management Flow
  │  Task Allocation / Dependency / Verification Responsibility
  ▼
各Executor: Executor Development Flow
  │  Implementation / Unit Test / Operational Verification
  ▼
各Executor: Executor Delivery Flow
  │  Review / Integration Test / Release / Production Verification
  ▼
Manager: Release Phase Completion / Documentation / Train Close
```

各ModuleはDependencyとExecution Orderに基づいて順次開始する。Module間で必要な情報はHandoverとして`shared/`へ配置し、ユーザーが担当スレッド間を仲介する。

各Executorは原則として次の順序で担当ModuleをPromotionする。

```text
Development → Integration → Release
```

個々のTaskごとにReleaseまで進めるのではなく、Current Trainで担当する変更をDevelopmentとしてまとめて完了し、その後Integration、Releaseへ進む。

## 問題が発生した場合

Integration Test、ReleaseまたはProduction Verificationで問題が検知された場合は、System Issue Triageを実施する。

```text
問題の検知
  ↓
原因・影響範囲・Ownershipの調査
  ├─ 担当Module内の問題 → Fix Branch / Implementation Loop
  ├─ 担当外Moduleの問題 → Correction Request / Handoff
  ├─ Specificationの問題 → ユーザー経由でManagerへ確認・訂正依頼
  └─ 未確定・進行不能     → Blockerとして記録・待機
  ↓
影響範囲に応じたTaskとVerificationの再実施
  ↓
結果確認と元のWorkflowへの復帰
```

問題の詳細はTriage DraftやCorrection Requestへ、Workflowの一時的な再入場・復帰制御は`adhoc-workflow-context.md`へ記録する。Issue管理とWorkflow制御を分離することで、対応経緯と現在位置の双方を追跡可能にする。

## ディレクトリ構成

```text
.
├── AGENTS.md                  # Project共通の最上位ルール
├── .agents/
│   ├── skills/                # Flow Skill / Work Skillと関連Guide・Template
│   └── resources/             # 共通Procedure、Executor Rules、Steering Assets
├── .codex/
│   └── agents/                # Sub-agent定義、Review Policy、Report Template
├── docs/
│   ├── persistent/            # Project全体で継続して参照する要求・設計の正本
│   ├── change-requirements/   # CR Trainにおける変更要求
│   ├── .steering/             # Train固有の進行、判断、Evidence、Handoff
│   └── train-status.md        # Current TrainとTrain履歴
└── modules/                   # Domain / Moduleごとの独立したWorkspace
```

## 利用の始め方

### 新しいProjectを開始する

1. 本基盤を新しいProjectのルートへ展開する。
2. CodexをProjectルートで起動する。
3. 新しいProjectを開始する意思を伝える。
4. Agentが`development-specification-flow`を候補として提示する。
5. 使用するFlow、Managerとしての役割および作業領域をユーザーが確認する。
6. Flowに従い、構想、Train初期化、PRD、設計を順番に進める。

### 既存Projectを変更する

既存の`docs/persistent/`を現行仕様として維持し、Current Trainの変更内容を`docs/change-requirements/`へ記録する。Requirement Modeを`CR`としてDevelopment Specification Flowを開始し、影響するSpecification、Module、TaskおよびVerificationだけを対象に進める。

### ExecutorとしてModuleを開始する

1. ManagerがTask AllocationとExecutor用Steeringを準備する。
2. ユーザーが対象Moduleの専用スレッドを開始する。
3. Executorが`executor-development-flow`を使用し、担当とWorkspaceを確認する。
4. Implementation Loop完了後、同じスレッドで`executor-delivery-flow`へ移行する。
5. Handoverや完了報告はユーザーがManagerまたは他Executorへ受け渡す。

## 運用上の前提

- Managerと各Executorには、Train完了まで継続して使用する専用スレッドを割り当てる。
- 各担当はProjectルートを作業ディレクトリとして起動する。
- 他担当のWorkspaceやSteeringを無断で参照・変更しない。
- Read-onlyな調査と、副作用を伴う操作を区別する。
- Repository変更、Deploy、Infrastructure Applyなどは、Plan、ユーザー承認、実行、結果説明の順で行う。
- 機密情報、実Credential、TokenおよびSecret値を文書、Source、LogまたはEvidenceへ残さない。
- 実装や設定ではなく、Requirement、Specificationおよび承認済みの文書を正本として扱う。

## 実証: DevMenu

本基盤は、Web Application **DevMenu** の初回開発で実際に使用された。

DevMenuでは、INITIALのLAUNCH Trainとして、次のModuleを独立した担当とRepositoryで構築した。

- AWS Infrastructure
- Database State Management
- Backend `proposal-service`
- Frontend `web`

構想、PRD、Function Design、System Architecture、Infrastructure Architecture、API・画面・Table仕様、Task Allocation、Module別Implementation、Integration Test、Production ReleaseおよびProduction Verificationを順に実施した。

全ModuleのRelease Statusは`SUCCESS`、Production Verificationは`PASS`となり、Documentationの最終化とTrain Closeまで完了した。これにより、本基盤がInfrastructureからFrontendまでを含むProjectを、構想からProduction公開まで進行できることを確認した。

DevMenuで作成された要求・設計・Steering・Module実装・Release Resultは、Templateから生成される成果物の実例である。Projectへ本基盤を展開した後は、Project固有の概要、要求・設計・Module構成およびTrainの状態を、各Projectのルート文書と`docs/`配下へ記録する。

## この基盤を発展させる

この基盤は、すべてのProjectへ同じ工程量を強制するものではない。

小規模なProjectでは必要なFlow、Work SkillおよびSteeringだけを使用し、複数Moduleや複数Repositoryを持つProjectではManager / Executor、Handover、Correction Request、Progress Managementを組み合わせる。

実運用で得られた摩擦、判断、失敗および改善点を、次のTrainやSkillへ反映することで、Project固有の開発基盤として継続的に育てていく。
