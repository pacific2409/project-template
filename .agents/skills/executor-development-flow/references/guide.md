# Common Guide

## Prepare Repository Structure Guideline

### **CI/CD Pipeline Structure**

- 担当ModuleにCI/CD Pipelineが存在する場合、Pipelineの定義は、可能な限り役割および適用対象となるEnvironmentごとに分離して管理する。
- Repository RootにはCI/CD PlatformからEntry Pointとして参照されるPipeline Definitionを配置し、Environment固有のPipeline Definitionは専用のDirectory配下に分離する。
- Pipelineから実行する処理が複数のCommandや手順を含む場合は、Pipeline Definitionへ直接すべてを記述せず、必要に応じてScriptとして分離する。
- Environment固有のScriptについてはEnvironmentごとに領域を分離し、Environment間で共通するScriptは重複させず共通領域で管理する。

例えばGitLab CI/CDを使用し、dev / stg / prodのPipelineおよびそれぞれ固有のScriptが存在する場合、以下のような構成とする。

```text
<module-root>/
├── .gitlab-ci.yml
└── gitlab/
    ├── .gitlab-ci-dev.yml
    ├── .gitlab-ci-stg.yml
    ├── .gitlab-ci-prod.yml
    └── scripts/
        ├── dev/
        ├── stg/
        └── prod/
```

## Process for each Task

### Clarify Assigned Tasks
`tasklist.md` への更新は、所定のテンプレート(`assets/tasklist-template.md`)を使用する。

1. **Development Allocation Map**から自身のModuleに該当する範囲を特定する。
2. 該当範囲を `tasklist.md` の **Development Allocation** にそのまま転記する。
3. **Development Allocation**の内容をもとに、実行・進捗管理するTaskを特定し、`tasklist.md` の**Task Table**へ記録する。
   - **Logic Units** が定義されているFunctional Unitについては、各Logic UnitをTask Tableの1レコードとして記録する。
   - **Logic Units** が定義されていないFunctional Unitについては、各Functional UnitをTask Tableの1レコードとして記録する。
   - **Task Table** 作成時に、Development Allocationに定義されたFunctional UnitまたはLogic Unitをさらに分割・統合しない。

### Understand Specifications
1. **Domain Guide**の **Overall Design Specifications** に指定されたSpecificationがある場合、その内容を確認し、System全体および担当Domainに関する構造、方針、境界、制約等を理解する。
2. **Domain Guide**の **Detailed Design Specifications** に指定されたSpecificationがある場合、その内容を確認し、担当Domainに関する具体的な構築・実装内容を理解する。

※ **Requirement Mode** が `CR` の場合は、上記Specificationのうち `docs/persistent/` 配下の内容を現行仕様・設計の前提として理解した上で、対応する `docs/change-requirements/` 配下のChange Requirementsが存在する場合、その内容をCurrent Trainにおける変更対象および変更内容として重点的に理解する。

### Extract Relevant Specifications
1. `tasklist.md` のTaskと**Overall Design Specifications**を照合する。
2. **Overall Design Specifications** について、自身のModuleまたはTaskとの関連有無を特定する。
3. 関連があるものについて、各Taskの実施に特に関連するFile、Section、Subsectionを特定し、一覧として記録する。
4. 特定した箇所のうち、以降の構築・開発において特に重要となるSpecificationの内容を整理して記録する。
5. 担当ModuleまたはTaskに関連するTechnology Stack、Framework、Library、Module、Middleware、外部Serviceその他の技術要素について明示的な指定がある場合は、その内容を抽出して記録する。


※ **Requirement Mode** が `CR` の場合は、`docs/persistent/` 配下の**Overall Design Specifications**を現行仕様・設計の前提としつつ、対応する `docs/change-requirements/` 配下のChange Requirementsが存在する場合、その内容をCurrent Trainにおける変更対象および変更内容として抽出する。

### Prepare Repository Structure
1. 本Guide および **Domain Guide** に**Repository Structure**に関する定義または考慮事項がある場合は、それぞれの内容に従う。
2. 同Domainの他Moduleについて、Technology Stackまたは対応内容が担当Moduleと共通する部分に既存のRepository Structureがある場合は、その構造を確認し、共通する部分について可能な限り構造を合わせる。
3. 上記によって構造が定まらない部分については、担当Moduleで使用するTechnology Stackおよび対応内容に適した典型的な構成を踏襲する。
4. **Requirement Mode** が `INITIAL` の場合は、以降の構築・開発に必要となるRepository Structureを新たに構成する。
5. **Requirement Mode** が `CR` の場合は既存のRepository Structureを維持し、Current Trainの変更対応に必要な場合に限り、必要な構造を追加・変更する。

### Determine Static Analysis
1. 担当Moduleの既存実装、および同Domainの参考実装におけるStatic Analysisの導入・設定状況を確認する。
2. 既存のStatic Analysisが存在する場合は、Task、Specification、Technology StackおよびCurrent Trainの対応内容を踏まえ、現在の方法で必要な検証を十分に実施できるかを確認し、変更の必要性を判断する。
3. ここまでの確認結果や判断結果、Task、Specification、Technology StackおよびCurrent Trainの対応内容などを踏まえ、新設や変更の方法について利用可能な選択肢とそれぞれの特徴を整理して提示し、新設または変更を行うかユーザーに確認する。
4. 新設または変更する場合は、TaskおよびSpecificationを踏まえ、使用するTool、検証内容、実行方法等をユーザーと確認・議論して決定し、その内容を `decisions.md` に記録する。
5. Static AnalysisをLocal Environmentでも実行する場合は、必要となるTool、設定その他の材料をユーザーと協力して揃え、実行可能な環境を構成する。