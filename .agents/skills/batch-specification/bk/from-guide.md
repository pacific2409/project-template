## **Definition Policy**

- 本Batch Definitionは、1 Batchにつき1 Artifactとして作成し、対象Batchを実装可能な粒度まで具体化する。
- Function DesignおよびSystem Architecture等の上位設計で確定したBatchの目的、Service Boundary、Interface Relationship、Business RuleおよびArchitecture上のDecisionを前提とし、それらを本Definitionで再定義しない。
- 本Batchが所属するServiceを基準として、Batchの起動から正常終了または異常終了までに必要となるBatch内部の仕様を定義する。
- Input / Output、Data Access、Execution Control、Job / Step Structure、Transaction Boundary、処理Logic、Error等、単一Batchの内部で完結する仕様は本Definitionで実装可能な粒度まで確定する。
- Database、External Service、他のInternal Service等との連携については、本Batchから見た利用方法およびInteractionを定義し、連携先自体の内部仕様は再定義しない。
- Environment固有のEndpoint、Secret、Credentialその他のConfigurationについては、可能な限り実値を固定的に記載せず、Applicationが利用するPropertyおよびConfiguration / Secret等のReferenceをContractとして定義する。
- Logic Flowは本Batchの処理全体を縦方向に俯瞰するものとし、Sequenceは本Batchの起動を起点として、Batchが所属するServiceから見たDatabase、Internal Service、External Service等との横方向のInteractionを表現する。
- Execution Controlでは、実行条件、実行方式、想定処理量、多重起動、再実行、Retry、Job / Step Structure、前後Batchとの関係等、Batch Execution全体に適用される制御仕様を定義する。
- Processing DetailsはStep単位で構造化し、条件分岐、繰り返し、Step間遷移、Data Access、Input / Output処理、External Request / Response、正常・異常時の処理等を、追加の設計判断を行わず実装へ移行できる粒度まで定義する。
- Processing Detailsの各Stepは一意に参照可能な番号を持ち、Execution Control、Transaction Overview、Error Definitionその他の関連仕様から同じStepを参照できる状態にする。
- Transactionを使用する場合は、個々の処理へTransaction属性を分散して記載するのではなく、Transaction OverviewでProcessing Stepとの対応およびTransaction Boundaryを明確にする。
- Errorについては、本Batchで識別するError Code、Error MessageおよびErrorの意味を定義する。Errorの発生条件および処理遷移はProcessing Details、Retry、Skip、Continue、Abort等の実行制御はExecution Controlを正とする。
- Logging等のApplication横断的な実装RuleはDevelopment Guideline等の対応する横断方針を前提とし、個々のLog内容は実装時に具体化する。
- 各Sectionは原則としてTableで構造化し、処理順序・条件分岐・Interaction・Input / Output等については、情報の性質に応じてMermaid、疑似Code、Code Block等を使用する。