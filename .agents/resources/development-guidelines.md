# Development Guidelines

## Git運用ルール

### Remote Repository
- Projectで運用するRemote Repositoryの情報については、`docs/repository-info.md`を参照する。
- `docs/repository-info.md` に複数のProviderが指定されている場合、各Remote Repositoryのリモート名には `github`、`gitlab` のようにProvider名を用いる。Providerが1つの場合は `origin` とする。
- `docs/repository-info.md`に、複数のProviderの指定がある場合は、全てのPushは常に全てのProviderに対して行う。
- Remote Repositoryは、いずれもPrivate Repositoryとする。
- Remote Repositoryは、Project名およびModule名に基づいて以下の規則で命名する。

#### **GitLab**

使用するProviderがGitLabの場合、ProjectごとにSubgroupを作成し、その配下にModule単位でRepositoryを作成する。

```text
<Repository Root>/<project-name>/<module-name>
```

#### **GitHub**
使用するProviderがGitHubの場合、Project名とModule名を組み合わせ、Module単位でRepositoryを作成する。

```text
<Repository Root>/<project-name>-<module-name>
```

### コミットメッセージ
- コミットメッセージのprefixは大文字始まりにする。また、同prefixは基本、Add、Fix、Removeのいずれかにする。

### ブランチ戦略

**ブランチ種別**:
全てのブランチは原則下記のprefixに従って命名する。
- `master`: 本番確認まで完了したコードを保持するCode Master
- `develop/*`: 開発・修正が完了した変更を統合し、Integration Testを実施する統合ブランチ
- `feature/*`: 新規機能開発や改修を行う作業ブランチ
- `fix/*`: 不具合等の対応を実施する修正ブランチ
- `release/*`: 本番リリースおよび本番確認を行うためのブランチ

全てのブランチは、特別指示がない限り、masterブランチから作成する。

master、release/*、develop/* への直接コミットは原則禁止し、変更の取り込みはマージによってのみ行う。開発・修正は feature/* または fix/* 上で実施する。

release/* は master から作成し、IT完了後の develop をマージする。release/* の内容を本番へリリースし、本番確認完了後に master へマージする。

**ブランチ構成**:
```
master (本番環境)
├──── release/* (リリース準備)
└── develop (開発・統合環境)↑
    ├── feature/* (新機能開発)
    └── fix/* (バグ修正)
```

### プルリクエストのテンプレート
※複数のRemote Repositoryが存在する場合は、双方のPR/MRの概要に、他方のPR/MRへの参照やリンクを記載する。

```markdown
## 概要

[このPRで行う変更の概要]

## 変更内容

- [主な変更内容]
- [主な変更内容]

## 関連
[関連するIssue・文書等がある場合]
<!-- 関連文書については文書タイトルや、その文中におけるセクション名、機能IDなど -->
```


## コーディング規約

### 基本
- ループの制御や初期化など、文脈から意味が自明な数値は除く場面では、マジックナンバーを直接記述せず、代わりに定数を用いる。
- 4を超える桁数の数値リテラルには、対象言語でサポートされている場合、数値区切り文字を使用する。
- 反復処理では拡張 for 文やfor eachなどの要素を直接反復する構文を優先する。インデックスが必要な場合も、単純な連続範囲であればRange / IntStream等で反復対象を明示し、古典的な for 文は更新処理自体に意味がある場合に限定する。
- 処理は、責務や意図が明確になる単位で関数やメソッドに分割する。
- 引数は最大7個とし、原則として6個以内に抑える。
- 画面間の配色はできる限り統一する。
- 外部サービスや特定技術への強い依存を伴う処理は、インターフェース等の抽象を介し、呼び出し側のロジックと具体的な実装を分離する。


**命名規則**:
- 変数: lowerCamelCase
- 関数・メソッド: lowerCamelCase
- 定数: UPPER_SNAKE_CASE
- Boolean: `is`, `has`, `should`で始める
- クラス・インターフェース: PascalCase

**関数の長さ**:
- ベスト: 20行以内
- 推奨: 50行以内
- リファクタリングを検討: 100行以上

### 設定・機密情報の管理
- 接続情報や環境依存の設定値はハードコーディングせず、プロパティや環境変数等を通じて管理する。
- 設定値はアプリケーションの実行Artifactに埋め込まず、ConfigMap等の外部設定機構から実行時に取得できる構成とする。
- パスワードやAPIキー等の機密情報は、通常の設定値と分離し、Secret等の機密情報管理機構を使用する。
- 機密情報をハードコーディングしない。
- 機密情報をInfoレベル以上のログに出力しない。


### エラーハンドリング

#### エラーコード
- エラーコードは AA0001 または AAA001 の形式とする。
- エラーコードは[原因カテゴリ][連番]の形式の6文字とし、原因を表す2〜3文字の英字識別子と、その識別子内で一意となる3〜4桁の連番で構成する。
- 英字部分はエラー原因の種類を表す識別子とし、同一の原因・接続先に起因するエラーでは統一する。
- 数値部分は同一識別子内のエラーを識別する連番とする。
- ただしタイムアウトや通信失敗などアプリケーション側で原因が特定・分類しにくく、自己解決による復旧が難しいエラーについては[連番]の部分は`999`か`9999`とする。
- 識別子はエラーの発生箇所ではなく、原因を基準に命名する。

#### 例外
- 発生し得る4xx・5xxのHTTP StatusごとにCustom Exceptionを定義する。
- 400 Bad Requestには BusinessException、500 Internal Server Errorには SystemException を使用する。
- その他のHTTP Statusには、HTTP Statusの論理名に対応したException名を使用する。
- 業務ロジック上で想定されたエラーではなく、Null Pointer、DB Error、Timeoutなどの予期しないシステム起因のエラーは SystemException として扱う。

#### ログ
- SystemException はStack Traceを含めてERRORレベルでログを出力する。
- その他のCustom ExceptionはWARNレベルでログを出力する。

#### エラーレスポンス
- 各Custom Exceptionに対応するException Mapperを用意し、対応するHTTP Statusへ変換する。
- エラーレスポンスは、エラーコードとエラーメッセージを含む共通形式で返却する。

### Testability and Observability

#### External Dependency Isolation
- 外部システムとの接続にはStub等の代替実装を用意し、実行環境や設定によって実接続と切り替え可能な実装にする。
- 上記切り替えは、可能な限り、条件分岐よりも依存関係の差し替えを主体とした実装によって実現する。
- 開発時には、外部接続を行わずに機能全体の動作を検証できるように実装する。

#### Observable Error
- 正常処理ではWARN/ERRORログを発生させない。検知すべき異常が発生した場合は、その異常を適切なWARN/ERRORログとして出力し、原因および発生元を追跡可能な情報を含める。

#### Self-validating Data Mutation
- データ変更を伴う処理では、アプリケーションが責任を持つ更新前提、更新結果、状態遷移等について、処理内部でその正当性を検証する。不整合を検知した場合は異常として扱い、その発生をApplication ResponseまたはWARN/ERRORログ等の外部から観測可能な出力によって検知できるようにする。

#### Externally Verifiable Integration Test
- 通常のIntegration Testでは、原則としてAPI Response等の外部InterfaceとApplication Log等のObservability情報から、処理結果および処理の成立性を機械的に十分に判定可能となるよう実装する。
- これにより、Integration Testをコマンド等から一貫して実行・判定可能とし、テストの自動化およびCI/CD Pipelineへの組み込みを容易にする。

### テストコード
- カバレッジは条件分岐網羅で確認する。
- コード全体のカバレッジは必ず80%以上であること。
- 主要なロジックを含むメソッドや関数、ロジッククラスのカバレッジは必ず90%以上であること。
- 各テストコードはGiven-When-Then(準備→Stub→実行→Assert→Verify)の構造とする。
