# **Error Codes**

## **Definition Policy**

- 本Artifactは、Applicationで使用するError Codeの共通定義を管理する。

- Error Codeの命名・採番その他の定義Ruleについては、`docs/persistent/development-guidelines.md` の規定に従う。

- Error Codeは、同一の識別範囲において一意とし、一つのCodeに複数の異なる意味を持たせない。

- Error Codeの共通的な意味およびClientへ公開する共通Contractを定義し、個々のErrorが発生する具体的な条件、判定Logicおよび処理遷移は、対応するAPI / Batch / UI等のSpecificationを正とする。

- 個別Specificationを正とする発生条件、判定Logic、処理遷移その他の個別仕様は重複して記載しない。

- 同一Error Codeを複数のSpecificationから利用する場合も、本Artifactに定義された意味を変更して使用しない。

- External Service等から受信するError Codeは、それ自体を本ApplicationのError Codeとして公開する場合を除き、本Artifactへ登録しない。External ErrorからApplication ErrorへのMappingは、対応するSpecificationで定義する。

- Communication Error等、ApplicationのError Codeを使用しない事象に対して、形式的にError Codeを新設しない。

- Error Messageに可変値を含める場合は、Error Codeが表す意味を変えない範囲でPlaceholderを使用する。

- Error Codeの追加・変更・廃止時は、そのCodeを利用するSpecificationとの整合性を維持する。


## **Error Code Definition**

| Error Code | HTTP Status | Error Message | Description | Note |
| --- | --- | --- | --- | --- |
|  |  |  |  |  |

## **Definition Notes**

- `Error Code`には、Application内でErrorを一意に識別するCodeを記載する。
- `HTTP Status`には、HTTP InterfaceでClientへ公開する場合のStatusを記載する。HTTPを使用しない用途では`-`とする。
- `Error Message`には、Clientまたは利用者へ公開する共通Messageを記載する。
- `Description`には、Error Codeが表す意味を、個別の発生箇所に依存しない粒度で記載する。
- `Note`には、適用範囲、Message Placeholderその他の共通的な補足が必要な場合のみ記載する。
- Validation Message等、個々のFieldや発生箇所によって変化するMessageは、共通Contractとして管理する必要がある場合を除き、本Artifactでは定義しない。
- Errorの発生条件、判定Logic、Retry / Skip / Continue / Abort、画面上のPresentation等は、それぞれ対応するSpecificationを正とする。