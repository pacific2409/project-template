# Procedure on Initial

## List of Step
- Prepare Docs Area
- Setup Development Guidelines
- Initialize Repository Information


## Execution Steps
### Step 1: Prepare Docs Area
- ルートディレクトリ直下に、以下のディレクトリ構造について存在するかを確認し、存在しないディレクトリのみ作成する。

```
docs/
├── drafts/
├── ideas/
├── change-requirements/
├── persistent/
├── release-notes/
├── reviews/
├── local/
└── .steering/
```

- その後、`docs/` がGit Repositoryとして初期化されているか確認する。
- 初期化されていない場合のみ、`docs/` にて `git init` を実行する。
- `master`ブランチを作成する。
- また、末端の各ディレクトリには、.gitkeep ファイルを作成する。
- `docs/.gitignore` に、`docs/local`配下の.gitkeep を除くファイルおよびディレクトリをGit管理対象外とする設定を追加する。
   - 既存の .gitignore が存在する場合は、その内容を維持し、必要な設定のみ追加・修正する。

### Step 2: Setup Development Guidelines
- **Development Guidelines** が存在しない場合、`.agents/resources/` 下から同名のファイルをコピーして作成する。
- **Development Guidelines** のパスおよび内容の要点をユーザーに提示し、Project固有の変更を行うか確認する。
- 変更を行う場合は、その内容についてユーザーと検討し、合意した内容を反映する。

### Step 3: Initialize Repository Information

**Repository Info** が存在し、かつ内容が空でない場合、本StepをSkipする。

**Repository Info** が存在しない、もしくは空の場合、下記内容をユーザーに確認する。

1. Remote Repositoryに使用するProvider。[GitHub, GitLab, Bitbucket, その他]を選択肢として提示。
   - Providerを複数使用するかも合わせて確認。
2. 使用する各Providerについて、Repository Rootをユーザーに確認する。

確認したら、`assets/repository-info-template.md`を使用して、**Repository Info** を作成または更新する。完了したらパスを共有し、ユーザーに確認を要求する。

※ 具体的なRepository名については、ここでは決定しない。