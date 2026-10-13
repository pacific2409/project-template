
## コードレビュー基準

### レビューポイント

**機能性**:
- [ ] 要件を満たしているか
- [ ] エッジケースが考慮されているか
- [ ] エラーハンドリングが適切か

**可読性**:
- [ ] 命名が明確か
- [ ] コメントが適切か
- [ ] 複雑なロジックが説明されているか

**保守性**:
- [ ] 重複コードがないか
- [ ] 責務が明確に分離されているか
- [ ] 変更の影響範囲が限定的か

**パフォーマンス**:
- [ ] 不要な計算がないか
- [ ] メモリリークの可能性がないか
- [ ] データベースクエリが最適化されているか

**セキュリティ**:
- [ ] 入力検証が適切か
- [ ] 機密情報がハードコードされていないか
- [ ] 権限チェックが実装されているか

### レビューコメントの書き方

**建設的なフィードバック**:
```markdown
## ✅ 良い例
この実装だと、タスク数が増えた時にパフォーマンスが劣化する可能性があります。
代わりに、インデックスを使った検索を検討してはどうでしょうか？

## ❌ 悪い例
この書き方は良くないです。
```

**優先度の明示**:
- `[必須]`: 修正必須
- `[推奨]`: 修正推奨
- `[提案]`: 検討してほしい
- `[質問]`: 理解のための質問



## コードレビュープロセス

### レビューの目的

1. **品質保証**: バグの早期発見
2. **知識共有**: チーム全体でコードベースを理解
3. **学習機会**: ベストプラクティスの共有

### 効果的なレビューのポイント

**レビュアー向け**:

1. **建設的なフィードバック**
```markdown
## ❌ 悪い例
このコードはダメです。

## ✅ 良い例
この実装だと O(n²) の時間計算量になります。
Map を使うと O(n) に改善できます:

```typescript
const taskMap = new Map(tasks.map(t => [t.id, t]));
const result = ids.map(id => taskMap.get(id));
```
```

2. **優先度の明示**
```markdown
[必須] セキュリティ: パスワードがログに出力されています
[推奨] パフォーマンス: ループ内でのDB呼び出しを避けましょう
[提案] 可読性: この関数名をもっと明確にできませんか？
[質問] この処理の意図を教えてください
```

3. **ポジティブなフィードバックも**
```markdown
✨ この実装は分かりやすいですね！
👍 エッジケースがしっかり考慮されています
💡 このパターンは他でも使えそうです
```

**レビュイー向け**:

1. **セルフレビューを実施**
   - PR作成前に自分でコードを見直す
   - 説明が必要な箇所にコメントを追加

2. **小さなPRを心がける**
   - 1PR = 1機能
   - 変更ファイル数: 10ファイル以内を推奨
   - 変更行数: 300行以内を推奨

3. **説明を丁寧に**
   - なぜこの実装にしたか
   - 検討した代替案
   - 特に見てほしいポイント

### レビュー時間の目安

- 小規模PR (100行以下): 15分
- 中規模PR (100-300行): 30分
- 大規模PR (300行以上): 1時間以上

**原則**: 大規模PRは避け、分割する

## 自動化の推進（該当する場合）

### 品質チェックの自動化

**自動化項目と採用ツール**:

1. **Lintチェック**
   - **ESLint 9.x** + **@typescript-eslint**
     - TypeScript専用ルールセットでコーディング規約を統一
     - 潜在的なバグや非推奨パターンを自動検出
     - 設定ファイル: `eslint.config.js` (Flat Config形式)

2. **コードフォーマット**
   - **Prettier 3.x**
     - コードスタイルを自動整形し、レビュー時の議論を削減
     - ESLintと併用し、`eslint-config-prettier`で競合を回避
     - 設定ファイル: `.prettierrc`

3. **型チェック**
   - **TypeScript Compiler (tsc) 5.x**
     - `tsc --noEmit`で型エラーのみをチェック
     - ビルドとは独立して型安全性を検証
     - 設定ファイル: `tsconfig.json`

4. **テスト実行**
   - **Vitest 2.x**
     - Viteベースで高速起動・実行
     - TypeScript/ESMをネイティブサポートし、設定不要で動作
     - カバレッジ測定（@vitest/coverage-v8）が標準搭載
     - モダンな開発体験とHMR対応

5. **ビルド確認**
   - **TypeScript Compiler (tsc)**
     - 標準コンパイラで型チェック付きビルドを保証
     - 追加ツール不要でシンプルな構成
     - `tsconfig.json`で出力設定を一元管理

**実装方法**:

**1. CI/CD (GitHub Actions)**
```yaml
# .github/workflows/ci.yml
name: CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '24'
      - run: npm ci
      - run: npm run lint
      - run: npm run typecheck
      - run: npm run test
      - run: npm run build
```

**2. Pre-commit フック (Husky 9.x + lint-staged)**
```json
// package.json
{
  "scripts": {
    "prepare": "husky",
    "lint": "eslint .",
    "format": "prettier --write .",
    "typecheck": "tsc --noEmit",
    "test": "vitest run",
    "build": "tsc"
  },
  "lint-staged": {
    "*.{ts,tsx}": [
      "eslint --fix",
      "prettier --write"
    ]
  }
}
```
```bash
# .husky/pre-commit
npm run lint-staged
npm run typecheck
```

**導入効果**:
- コミット前に自動チェックが走り、不具合コードの混入を防止
- PR作成時に自動でCI実行され、マージ前に品質を担保
- 早期発見により、修正コストを最大80%削減（バグ検出が本番後の場合と比較）

**この構成を選んだ理由**:
- 2025年時点でのTypeScriptエコシステムにおける標準的かつモダンな構成
- ツール間の互換性が高く、設定の衝突が少ない
- 開発体験と実行速度のバランスが優れている

## チェックリスト

- [ ] ブランチ戦略が決まっている
- [ ] コミットメッセージ規約が明確である
- [ ] PRテンプレートが用意されている
- [ ] テストの種類とカバレッジ目標が設定されている
- [ ] コードレビュープロセスが定義されている
- [ ] CI/CDパイプラインが構築されている

## TypeScript/JavaScript 規約

### 型定義

**組み込み型の使用**:
```typescript
// ✅ 良い例: 組み込み型を使用
function processItems(items: string[]): Record<string, number> {
  return items.reduce((acc, item) => {
    acc[item] = (acc[item] || 0) + 1;
    return acc;
  }, {} as Record<string, number>);
}

// ❌ 悪い例: typingモジュールからインポート
import { List, Dict } from 'typing';
function processItems(items: List[str]): Dict[str, int] { }
```

**型注釈の原則**:
```typescript
// ✅ 良い例: 明示的な型注釈
function calculateTotal(prices: number[]): number {
  return prices.reduce((sum, price) => sum + price, 0);
}

// ❌ 悪い例: 型推論に頼りすぎる
function calculateTotal(prices) {  // any型になる
  return prices.reduce((sum, price) => sum + price, 0);
}
```

**インターフェース vs 型エイリアス**:
```typescript
// インターフェース: 拡張可能なオブジェクト型
interface Task {
  id: string;
  title: string;
  completed: boolean;
}

// 拡張
interface ExtendedTask extends Task {
  priority: string;
}

// 型エイリアス: ユニオン型、プリミティブ型など
type TaskStatus = 'todo' | 'in_progress' | 'completed';
type TaskId = string;
type Nullable<T> = T | null;
```

### 命名規則

**変数・関数**:
```typescript
// 変数: camelCase、名詞
const userName = 'John';
const taskList = [];
const isCompleted = true;

// 関数: camelCase、動詞で始める
function fetchUserData() { }
function validateEmail(email: string) { }
function calculateTotalPrice(items: Item[]) { }

// Boolean: is, has, should, canで始める
const isValid = true;
const hasPermission = false;
const shouldRetry = true;
const canDelete = false;
```

**クラス・インターフェース**:
```typescript
// クラス: PascalCase、名詞
class TaskManager { }
class UserAuthenticationService { }

// インターフェース: PascalCase
interface TaskRepository { }
interface UserProfile { }

// 型エイリアス: PascalCase
type TaskStatus = 'todo' | 'in_progress' | 'completed';
```

**定数**:
```typescript
// UPPER_SNAKE_CASE
const MAX_RETRY_COUNT = 3;
const API_BASE_URL = 'https://api.example.com';
const DEFAULT_TIMEOUT = 5000;

// 設定オブジェクトの場合
const CONFIG = {
  maxRetryCount: 3,
  apiBaseUrl: 'https://api.example.com',
  defaultTimeout: 5000,
} as const;
```

**ファイル名**:
```typescript
// クラスファイル: PascalCase
// TaskService.ts
// UserRepository.ts

// 関数・ユーティリティ: camelCase
// formatDate.ts
// validateEmail.ts

// コンポーネント(React等): PascalCase
// TaskList.tsx
// UserProfile.tsx

// 定数: kebab-case または UPPER_SNAKE_CASE
// api-endpoints.ts
// ERROR_MESSAGES.ts
```



### 非同期処理

**async/await の使用**:
```typescript
// ✅ 良い例: async/await
async function fetchUserTasks(userId: string): Promise<Task[]> {
  try {
    const user = await userRepository.findById(userId);
    const tasks = await taskRepository.findByUserId(user.id);
    return tasks;
  } catch (error) {
    logger.error('タスクの取得に失敗', error);
    throw error;
  }
}

// ❌ 悪い例: Promiseチェーン
function fetchUserTasks(userId: string): Promise<Task[]> {
  return userRepository.findById(userId)
    .then(user => taskRepository.findByUserId(user.id))
    .then(tasks => tasks)
    .catch(error => {
      logger.error('タスクの取得に失敗', error);
      throw error;
    });
}
```

**並列処理**:
```typescript
// ✅ 良い例: Promise.allで並列実行
async function fetchMultipleUsers(ids: string[]): Promise<User[]> {
  const promises = ids.map(id => userRepository.findById(id));
  return Promise.all(promises);
}

// ❌ 悪い例: 逐次実行
async function fetchMultipleUsers(ids: string[]): Promise<User[]> {
  const users: User[] = [];
  for (const id of ids) {
    const user = await userRepository.findById(id); // 遅い
    users.push(user);
  }
  return users;
}
```



## チェックリスト

実装完了前に確認:

### コード品質
- [ ] 命名が明確で一貫している
- [ ] 関数が単一の責務を持っている
- [ ] マジックナンバーがない
- [ ] 型注釈が適切に記載されている
- [ ] エラーハンドリングが実装されている

### セキュリティ
- [ ] 入力検証が実装されている
- [ ] 機密情報がハードコードされていない
- [ ] SQLインジェクション対策がされている

### パフォーマンス
- [ ] 適切なデータ構造を使用している
- [ ] 不要な計算を避けている
- [ ] ループが最適化されている

### テスト
- [ ] ユニットテストが書かれている
- [ ] テストがパスする
- [ ] エッジケースがカバーされている

### ドキュメント
- [ ] 関数・クラスにTSDocコメントがある
- [ ] 複雑なロジックにコメントがある
- [ ] TODOやFIXMEが記載されている(該当する場合)

### ツール
- [ ] Lintエラーがない
- [ ] 型チェックがパスする
- [ ] フォーマットが統一されている


## 基本原則

### 1. 具体例を豊富に含める

抽象的なルールだけでなく、具体的なコード例を提示します。

**悪い例**:
```
変数名は分かりやすくすること
```

**良い例**:
```typescript
// ✅ 良い例: 役割が明確
const userAuthentication = new UserAuthenticationService();
const taskRepository = new TaskRepository();

// ❌ 悪い例: 曖昧
const auth = new Service();
const repo = new Repository();
```

### 2. 理由を説明する

「なぜそうするのか」を明確にします。

**例**:
```
## エラーを無視しない

理由: エラーを無視すると、問題の原因究明が困難になります。
予期されるエラーは適切に処理し、予期しないエラーは上位に伝播させて
ログに記録できるようにします。
```

### 3. 測定可能な基準を設定

曖昧な表現を避け、具体的な数値を示します。

**悪い例**:
```
コードカバレッジは高く保つこと
```

**良い例**:
```
コードカバレッジ目標:
- ユニットテスト: 80%以上
- 統合テスト: 60%以上
- E2Eテスト: 主要フロー100%
```



## 依存関係の管理

### レイヤー間の依存ルール

```typescript
// ✅ 良い例: 上位レイヤーから下位レイヤーへの依存
// cli/TaskCLI.ts
import { TaskService } from '../services/TaskService';

class TaskCLI {
  constructor(private taskService: TaskService) {}
}

// ❌ 悪い例: 下位レイヤーから上位レイヤーへの依存
// services/TaskService.ts
import { TaskCLI } from '../cli/TaskCLI';  // 禁止！
```

### 循環依存の回避

**問題のあるコード**:
```typescript
// services/TaskService.ts
import { UserService } from './UserService';

export class TaskService {
  constructor(private userService: UserService) {}
}

// services/UserService.ts
import { TaskService } from './TaskService';  // 循環依存！

export class UserService {
  constructor(private taskService: TaskService) {}
}
```

**解決策1: 共通の型定義を抽出**
```typescript
// types/Service.ts
export interface ITaskService { /* ... */ }
export interface IUserService { /* ... */ }

// services/TaskService.ts
import type { IUserService } from '../types/Service';

export class TaskService {
  constructor(private userService: IUserService) {}
}

// services/UserService.ts
import type { ITaskService } from '../types/Service';

export class UserService {
  constructor(private taskService: ITaskService) {}
}
```

**解決策2: 依存関係を見直す**
```typescript
// 共通の機能を別サービスに抽出
// services/NotificationService.ts
export class NotificationService {
  notifyTaskAssignment(taskId: string, userId: string): void {
    // 通知処理
  }
}

// services/TaskService.ts
import { NotificationService } from './NotificationService';

export class TaskService {
  constructor(private notificationService: NotificationService) {}
}

// services/UserService.ts
import { NotificationService } from './NotificationService';

export class UserService {
  constructor(private notificationService: NotificationService) {}
}
```




## スケーリング戦略

### 推奨構造

**標準パターン**:
```
src/
├── commands/
│   └── TaskCommand.ts
├── services/
│   ├── TaskService.ts
│   └── UserService.ts
├── repositories/
│   ├── TaskRepository.ts
│   └── UserRepository.ts
├── types/
│   ├── Task.ts
│   └── User.ts
├── validators/
│   └── TaskValidator.ts
└── index.ts
```

**理由**:
- レイヤーごとに責務が明確
- 後からのリファクタリングが不要
- チーム開発で統一しやすい

### モジュール分離のタイミング

**分離を検討する兆候**:
1. ディレクトリ内のファイル数が10個以上
2. 関連する機能がまとまっている
3. 独立してテスト可能
4. 他の機能への依存が少ない

**分離の手順**:
```typescript
// Before: 全てservices/に配置
services/
├── TaskService.ts
├── TaskValidationService.ts
├── TaskNotificationService.ts
├── UserService.ts
└── UserAuthService.ts

// After: 機能ごとにモジュール化
modules/
├── task/
│   ├── TaskService.ts
│   ├── TaskValidationService.ts
│   └── TaskNotificationService.ts
└── user/
    ├── UserService.ts
    └── UserAuthService.ts
```

