# Executor Rules
本ファイルには、各Executorが遵守すべきルールを記載する。各Executorは、すべての作業を常に本ファイルの内容を前提として実施する。

## Work Area
各Executorの作業領域は以下とする。
- `docs/`
  - 本Projectに関する情報が管理されている。
  - `docs/.steering/` 配下については、`docs/.steering/<current-train>/<module-name>/`および、必要に応じて `docs/.steering/<current-train>/shared/` のみを作業対象とする。
- 担当Moduleの**Workspace**配下
  - 明示的な指定がない限り、**作業ディレクトリ**とする。
  - 指示がある場合、同Domainの他のModuleの**Workspace**配下を参照する。ただしRead-Onlyとし、いかなる変更も禁ずる。

### Workspace
各Executorの担当Moduleの **Workspace** は、自身の担当DomainおよびModule名から、Project Rootを基準として以下のパスで特定する。

`modules/<domain>/<module-name>/`

## Development Guidelines
開発や関連する作業についての指針やルールを示す。 実装や作業する際は、必ず参照しながら進行すること。
```
docs/persistent/development-guidelines.md
```

## Development Allocation Map
下記にて、本フローで管理するModuleの担当範囲と本Trainにおける立ち位置が確認できる。
```
docs/.steering/<current-train>/shared/information/development-allocation-map.md
```

## Requirement Verification Matrix
下記にて、PRDレベルでの要求内容に対する検証項目に対する各Module担当の検証責務の範囲が把握できる。
```
docs/.steering/<current-train>/shared/information/requirement-verification-matrix.md
```

## **Git Operations**
- 作業全体を通じて、Git操作を行う際は、**Development Guidelines** (`docs/persistent/development-guidelines.md`) に従う。
- 各Task完了時、コミットする内容があれば、そのTaskの完了承認をトリガーに **作業ディレクトリ** にてコミットおよびプッシュを行う。

## **Development References**
- 実装や作業する際は、**Development Guidelines** を参照しながら進行する。
- 各Taskは、担当Moduleの**Workspace**の既存実装や、類似実装が存在する場合は必要に応じてそれを確認しながら進行する。
- 構築・実装を行う際は、**Steering**に実施内容に対応するExampleが存在するかを確認し、存在する場合はその内容を参考にする。
- Exampleは参考情報として扱い、Specification、Development Guidelinesその他の明示的な定義・ルールより優先しない。

## **Specification Reference**
- **Specification Sources** に指定されたパスのうち、実際に存在するファイルを参照対象とする。
- **Specification Sources**は、**Overall Design Specifications** および **Detailed Design Specifications** で構成され、後者は`docs/persistent/details/`や`docs/change-requirements/details/` 配下に存在するものを指す。
- 作業全体を通して、各Specification、 Workflowの過程で整理した `relevant-specifications.md`、 `existing-implementation.md` (存在する場合)を、各Taskの内容に応じて適宜参照・確認しながら作業を進める。
- `relevant-specifications.md` は関連するSpecificationを抽出・整理した補助情報であり、Specificationそのものの代替とはしない。必要に応じて参照元のSpecificationを確認する。
- **Requirement Mode**が `CR` の場合、**Overall Design Specifications** や **Detailed Design Specifications** を含む各Specification Sourcesについては `docs/persistent/` の対象Specificationを現行仕様・設計の前提として扱い、それに対応する `docs/change-requirements/` のChange Requirementsが存在する場合は、Current Trainにおける変更対象および変更内容として併せて扱う。

## **Steering Management**
Executorは、自身のSteering領域にある以下のファイルおよびディレクトリを、作業全体を通して管理する。 管理・更新は各TemplateもしくはExample(assets/*.md)を元に行う。

### Shared
ユーザーまたは他のDomain / Module担当との間で共有・受け渡しを行う情報は、原則として `docs/.steering/<current-train>/shared/` 配下で管理する。

#### **information/**
- ユーザー、Managerまたは他のExecutorとの間で共有・受け渡しを行う情報を管理する。
- 他担当との情報連携が必要な場合は、本ディレクトリを介して行う。

#### **examples/**
- ユーザーから提供された、各Domain / Moduleの構築・実装における参考例を管理する。

### Space for Own Module
自身のModuleに関する作業・進捗・判断その他の記録文書は、原則として自身のSteering領域 `docs/.steering/<current-train>/<module-name>/` 配下で管理する。

### tasklist.md
- Current Trainにおいて自身のModuleが担当するTaskと、その進捗状況を都度管理する。
- Taskの開始・進行・完了に応じて状態を更新する。

### blockers.md
- Taskの遂行を妨げる問題や、解決するまで作業を進行できない事項を都度記録する。
- 各Blockerには、そのBlockerが発生したTaskのTask No.を記録する。
- Blockerの発生・解消に応じて内容および状態を更新する。
- 更新の際には記入例を(`.agents/resources/steering-assets/blockers-example.md`)を参考にする。

### decisions.md
- Executorによる作業の中で行った重要な判断と、その決定内容を都度記録する。
- 各Decisionには、その判断を行ったTaskのTask No.を記録する。
- 後続作業において判断の前提となる決定を記録する。
- 更新の際には記入例を(`.agents/resources/steering-assets/decisions-example.md`)を参考にする。

### adhoc-workflow-context.md
- 通常のWorkflow進行中に臨時の対応が発生し、別のTaskへの移行および元のTaskへの復帰が必要となる場合に、その制御情報を記録する。
- 移行元のTask、対応対象となるRequestやIssue、再実施開始Taskおよび復帰先Taskを記録する。
- 臨時対応の完了後は、必要な復帰処理が完了したことを確認し、使用したContextをActive ContextからContext Historyへ移動する。

### relevant-specifications.md
- 所定の工程において、抽出した担当Moduleに割り振られたTaskに関連するSpecificationが記録される。
- 記録された内容は、以降の作業におけるSpecification参照の補助情報として使用する。

### existing-implementation.md
- 所定の工程において、Current Trainの変更対象に関係する担当Module自身の既存実装や、同Domainの他Moduleの類似・参考実装について、把握した内容を整理する。
- 記録された内容は、以降の構築・開発における既存実装の理解および参考情報として使用する。
- 参照時は想像によって情報を補完せず、必要に応じて実際の実装を確認する。

### handover-from-<module-name>.md
- 他のDomainまたはModuleの担当が後続作業で必要とする情報が発生した場合は、Handoverとして記録する。
- 発生した時点で随時更新し、自身のSteering領域におけるHandover情報の正本とする。
- 他担当への情報連携が必要となった場合は、`docs/.steering/<current-train>/shared/handover/handover-from-<module-name>.md` へ内容をコピーし(既存の場合は上書き)、共有用の情報として提供する。
- Handoverには、情報の引き継ぎ先となるDomainまたはModuleと、引き継ぐ内容を明示する。
- 更新の際にはテンプレート(`.agents/resources/steering-assets/handover-from-some-module-template.md`)を使用する。

### working/
- 作業の遂行中に行う調査、分析、情報抽出、ユーザーとの確認・議論等において、作業上保持する必要がある中間的・補助的な情報を記録する。
- 配下のファイルは、各Taskまたは使用するWork Skillの必要に応じて作成・更新する。

### test/test-specification.md
- Current Trainで担当Moduleについて実施する検証内容・期待結果・Evidence取得方法を定義する正本。所定の工程において、作成および更新される。

### test/result/
- 所定の工程で、Test Specificationに従って実際に検証した結果・Evidenceを保存する領域。


## Reference to Historical/Relevant Steering
- 過去TrainのSteeringについて、現在のTaskに関連する文書を必要に応じて以下の優先順位で参照する。
  1. 同一ModuleのSteering
  2. 同Domainの他ModuleのSteering
- 参照するSteeringはRead-Onlyとし、いかなる変更も禁ずる。
- 過去Trainの文書は参考情報として扱い、Current TrainのSpecification、Task、Implementationその他の最新情報より優先しない。
- ただし、方法や形式について、Train間や、同DomainのModule間で、できる範囲でブレのないように努める。
- 過去Trainの文書を参照する場合は、記載された内容が現在も有効であるか、必要に応じてSpecificationおよびImplementationを確認する。