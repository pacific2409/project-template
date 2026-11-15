# Train Status

## **Summary**

本ドキュメントは、Project名およびProjectにおけるTrainの状態を管理する。

## **運用ルール**
- Trainは新しいものから順に、`Train Status` の先頭へ追加する。
- Trainには、Projectに対する当該Trainの位置づけを表す `Train Type` として `LAUNCH` または `EVOLVE` を設定する。
- TrainのStatusには `OPEN` または `CLOSED` を設定する。
- 新しいTrainを追加する場合、そのStatusは `OPEN` とする。
- 現在開発対象となっているCurrent TrainのStatusを `OPEN` とする。
- `OPEN` は最大1件。進行中のTrainがない場合は0件とする。
- Trainが完了した場合、そのStatusを `OPEN` から `CLOSED` に変更する。

## **Glossary**
### **Train Type**
  - `LAUNCH`: 新しいProjectを立ち上げるTrain。
  - `EVOLVE`: 既存Projectに対して機能追加・変更・改修などを行うTrain。

 新しいProjectにおける最初のTrainの `Train Type` は `LAUNCH` とし、それ以降のTrainは `EVOLVE` とする。


## **Project Name**

### **Dev Menu**

## **Train Status**

| No | Train | Train Type | Status |
|---:|-------|------------|--------|
| 1 | **20260915-initial-implementation** | LAUNCH | CLOSED |
