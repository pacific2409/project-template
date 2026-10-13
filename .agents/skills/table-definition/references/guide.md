# **Content Guide**

## **Definition Policy**
- 本Formatは、1 Tableにつき1つのTable Detail Designを作成するために使用する。
- Function Designおよび関連する上位設計で確定済みのData Relationship、Constraint、Business Rule等を前提として、対象Table内部の物理仕様を具体化する。
- 複数Columnから構成されるKey / Indexは、対象Columnすべてに同一のKey / Indexが適用されることが分かるように定義する。
- 該当するConstraintが存在しない場合、`4. Constraints` は省略してよい。

## **Overview**
- Change History
- Table Summary
- Columns
- Indexes
- Constraints

## **Section Guide**
### **0. Change History**
本項目では、本テーブル定義書の初回作成、および初回確定後に行われた正式なテーブル定義変更の履歴を記録する。

初回作成時は、レビューおよび再レビューを含む作成・確認が完了し、テーブル定義書が確定した時点で1件の履歴として記録する。
初回確定前に行われるレビュー指摘への対応、記載内容の修正、表現の改善、誤記修正などは、個別の変更履歴として記録しない。

初回確定後にテーブル定義の変更が必要となった場合、または後続のTrainにおいて機能追加・変更等に伴い本テーブル定義を変更した場合は、新しい履歴として記録する。

**example**:
| Change | Date | Train | Summary |
| --- | --- | --- | --- |
| Initial Design | [YYYY-MM-DD HH:mm] | [Train] | 初回設計 |
| Change 1 | [YYYY-MM-DD HH:mm] | [Train] | [変更概要] |
| Change 2 | [YYYY-MM-DD HH:mm] | [Train] | [変更概要] |

### **1. Table Summary**

対象Tableを識別し、その目的を簡潔に記載する。

#### **Format and Example**

※以下は記載形式で、内容はあくまで例
| Item | Value |
| --- | --- |
| Physical Name | `favorite` |
| Logical Name | お気に入り |
| Database | `favorite` |
| Description | Userが登録したお気に入り情報を保持する |

#### **Table Summary Definition Notes**
- `Physical Name`にはDB上の物理Table名を記載する。
- `Logical Name`には設計上の論理名称を記載する。
- `Database`にはTableが属するDatabase名を記載する。
- `Description`にはTableの目的や役割を簡潔に記載する。

### **2. Columns**

対象Tableを構成するすべてのColumnについて、物理仕様を定義する。

#### **Format and Example**

※以下は記載形式で、内容はあくまで例
| No. | Column | Logical Name | PK | UK | FK | Type (Size) | Not Null | Default | Remarks |
| ---: | --- | --- | :---: | :---: | --- | --- | :---: | --- | --- |
| 1 | `id` | お気に入りID | ● | - | - | BIGINT | ● | - | - |
| 2 | `user_id` | ユーザーID | - | - | `user.id` | BIGINT | ● | - | - |
| 3 | `content_id` | コンテンツID | - | - | `content.id` | BIGINT | ● | - | - |
| 4 | `status` | ステータス | - | - | - | VARCHAR(20) | ● | `'ACTIVE'` | `ACTIVE`: 有効 / `INACTIVE`: 無効 |
| 5 | `created_at` | 作成日時 | - | - | - | TIMESTAMP | ● | CURRENT_TIMESTAMP | - |
| 6 | `updated_at` | 更新日時 | - | - | - | TIMESTAMP | ● | CURRENT_TIMESTAMP | Common Column |
| 7 | `operator` | 更新実行元 | - | - | - | VARCHAR(100) | ● | - | API / Batch等の更新実行元 |
| 8 | `deleted_flag` | 削除フラグ | - | - | - | TINYINT | ● | `0` | `0`: 未削除 / `1`: 削除 |
| 9 | `timestamp` | 排他制御用タイムスタンプ | - | - | - | TIMESTAMP | ● | CURRENT_TIMESTAMP | Common Column |

#### **Column Definition Notes**

- `Column`には物理Column名を記載する。
- `Logical Name`には設計上の論理名称を記載する。
- `PK` / `UK`列には、該当する場合 `●`、該当しない場合 `-` を記載する。
- `FK`列には、Foreign Keyである場合は参照先を `<table>.<column>` の形式で記載し、該当しない場合は `-` を記載する。
- `Type (Size)`にはDB上の物理Data Typeと、必要な場合はSize / Precision / Scaleを記載する。
- `Not Null`はNOT NULLの場合 `●`、NULLを許容する場合 `-` とする。
- `Default`にはDefault値またはDefault式を記載し、存在しない場合は `-` とする。
- `Remarks`にはCode値、値域、Column固有の補足事項等を必要に応じて記載する。

##### **Common Column**

- すべてのTableには、以下のCommon Columnを必ず定義する。

| Column | Purpose |
| --- | --- |
| `created_at` | Recordの作成日時を保持する。 |
| `updated_at` | Recordの最終更新日時を保持する。 |
| `operator` | Recordを作成・更新したAPI、Batch等の実行元を保持する。 |
| `deleted_flag` | 論理削除状態を保持する。`0`を未削除、`1`を削除済みとする。 |
| `timestamp` | Entity更新時の楽観的排他制御に使用するVersion Timestampを保持する。 |

- Common Columnも通常のColumnと同様にColumnsへ記載し、省略しない。
- `created_at`はRecord作成時に設定し、以降の更新では変更しない。
- `updated_at`はRecord作成時および更新時に設定する。
- `operator`には、更新処理を実行したAPI / Batch等を識別可能な値を設定する。
- `deleted_flag`は`0`を未削除、`1`を削除済みとし、Defaultは`0`とする。
- `timestamp`は更新時の排他制御に使用し、Record更新に伴って更新する。


### **3. Indexes**

対象Tableに定義するPrimary Key、Unique Key、Foreign Keyに対応するIndex、および検索・性能上必要となるIndexを定義する。

#### **Format and Example**

※以下は記載形式で、内容はあくまで例
| No. | Index Name | Type | Columns | Unique | Remarks |
| ---: | --- | --- | --- | :---: | --- |
| 1 | `pk_favorite` | Primary Key | `id` | ● | Primary Key |
| 2 | `uk_favorite_user_content` | Unique Key | `user_id`, `content_id` | ● | UserとContentの組み合わせを一意とする |
| 3 | `idx_favorite_status` | Index | `status` | - | Statusによる検索に使用する |
| 4 | `mul_favorite_status_created_at` | Composite Index | `status`, `created_at` | - | Statusと作成日時を使用する検索に使用する |

#### **Index Definition Notes**

Index Nameは、Indexの役割を識別できるPrefixを使用する。

#### **Format and Example**

※以下は記載形式で、内容はあくまで例
| Prefix | Usage |
| --- | --- |
| `pk_` | Primary Key |
| `uk_` | Unique Key / Unique Index |
| `idx_` | 単一Column等の通常Index |
| `mul_` | 複数Columnから構成されるComposite Index |

- Composite Indexでは、`Columns`にIndexを構成するColumnをIndex順に記載する。
- UniqueなComposite Indexの場合も、役割を優先して `uk_` を使用する。
- `mul_` は非UniqueのComposite Index(複合インデックス)に使用する。
- Indexの具体的な命名は `<prefix><table>_<purpose / columns>` を基本とし、使用するDatabaseのIdentifier Length等の制約に従う。

### **4. Constraints**

※ Column DefinitionおよびIndexesだけでは十分に表現できないTable固有のConstraintが存在する場合に記載する。

該当するConstraintが存在しない場合、本Sectionは省略する。

#### **Format and Example**

※以下は記載形式で、内容はあくまで例

| Constraint Name | Type | Definition | Remarks |
| --- | --- | --- | --- |
| `chk_favorite_status` | CHECK | `status IN ('ACTIVE', 'INACTIVE')` | 許可されたStatusのみ保持する |

#### **Constraint Definition Notes**

- CHECK Constraint等、対象Table内部で成立させる必要があるConstraintを記載する。
- Primary Key、Unique Key、Foreign Key等、Columns / Indexesですでに表現されている内容を重複して列挙しない。
- 上位設計で定義されたBusiness Ruleそのものを再定義せず、そのRuleをDatabase Constraintとして実現する場合の物理仕様を記載する。