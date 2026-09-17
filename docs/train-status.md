# Train Status

## **Summary**

本ドキュメントは、Project名およびProjectにおけるTrainの状態を管理する。

## **運用ルール**

- Trainは新しいものから順に、`Train Status` の先頭へ追加する。
- TrainのStatusには `OPEN` または `CLOSED` を設定する。
- 新しいTrainを追加する場合、そのStatusは `OPEN` とする。
- 現在開発対象となっているCurrent TrainのStatusを `OPEN` とする。
- `OPEN` は最大1件。進行中のTrainがない場合は0件とする。
- Trainが完了した場合、そのStatusを `OPEN` から `CLOSED` に変更する。

## **Project Name**

### **DevMenu**


## **Train Status**

| Train | Status |
|-------|--------|
| **20260915-initial-implementation** | OPEN |
