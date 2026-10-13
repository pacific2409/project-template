# Procedure on CR

## CR Sources
```
docs/ideas/development-concept-planning.md
docs/change-requirements/product-requirements.md
```

## Current Architecture
```
docs/persistent/system-architecture.md
```

## Change Requirements
```
docs/change-requirements/architecture-outline.md
```

## List of Step
- Prepare for Discussion
- Analyze Impact on Artifact
- Discuss CR on the Architecture Outline
- Finalize CR on the Architecture Outline
- Apply Change Requirements to Artifacts

## Execution Steps

### Step 0: Prepare for CR
- 空の**Change Requirements**を作成する。

### Step 1: Determine Applicability
- **Source** および **CR Sources** の内容から、今回の仕様変更の要求内容を把握する。
- 把握した内容が既存の**Artifact**に内容の追加・変更等の影響を及ぼす可能性があるかを**Guide**も参照しながら確認し、`Yes/No`で判断する。
  - `No` の場合は、以下のすべてについて **Change Requirement** を `NOT REQUIRED` として **Change Requirements** に記録し、以降のStepに進まず、本Work Skillを終了する。
    - System Boundary
    - Application Structure
    - Backend / Service Structure
    - Architecture Evolution
    - Responsibility & Ownership

### Step 2: Analyze Impact on Artifact
- **Artifact** の内容が、その定義時に、どのように**Current Architecture**に反映されたかを理解する。
- その上で、前項で把握した仕様変更要求を**Guide**と照らして、**Artifact**に対してどのような内容の追加・変更があり得るのかを整理する。


### Step 3: Discuss CR on the Architecture Outline
- 前項で整理した**Artifact**に対する追加・変更候補をもとに、**Guide** に記載されたDecision Topicsのうち、今回の追加・変更対象となるものについて一つずつユーザーと確認・議論する。
- 各Decision Topicについて、既存の **Artifact** における現在の定義を `AS-IS` として把握し、今回必要となる追加・変更を踏まえた `TO-BE` を具体化する。
- `AS-IS`、`TO-BE` およびその間に必要となる追加・変更内容について合意が取れたら、**Change Requirements** に記録し、次の観点に進む。

#### **Guideline**
- 合意・承認状況については文書の末尾にて管理・更新する。
- **Change Requirements**には、後続の工程・Phaseや次以降のStepの予定・実施内容を記載しない。
- 確認は、それまでの内容を踏まえた複数の選択肢のサジェストとセットで行う。
- 各Decision Topicについて、`AS-IS` と `TO-BE` の差分、およびその差分を成立させるために必要な追加・変更内容が明確になるまで確認・議論を行う。
- 今回の変更要求を踏まえても追加・変更が必要ないDecision Topicについては、無理に変更案を生成せず、`決定しない`または`変更しない`ことも選択肢として提示し、ユーザーに確認する。

### Step 4: Finalize CR on the Architecture Outline
- **Change Requirements**の内容全体を確認し、合意された内容の意味を変更しない範囲で、重複や記述の整理を行う。
- 最終的な内容からArchitecture Outlineに対する**Change Requirements**の全体像を要約し、文書の冒頭にOverview(概要)として追加する。
- 最終的な**Change Requirements**の内容について、ユーザーの承認を得る。

### Step 5: Apply Change Requirements to Artifacts
- 前項までに確定した **Change Requirements** を、`AS-IS` と `TO-BE` および定義された追加・変更内容を踏まえて **Artifact** に反映する。
- 反映後の **Artifact** について、追加・変更内容が適切に反映されていること、および追加・変更部分とその他の既存内容との間に不整合がないことを確認する。

