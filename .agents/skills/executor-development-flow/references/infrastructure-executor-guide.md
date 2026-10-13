# Infrastructure Domain Guide

## Specification Sources

### **Overall Design Specifications**
- `docs/persistent/system-architecture.md`
- `docs/persistent/infrastructure-architecture.md`
- `docs/change-requirements/system-architecture.md`
- `docs/change-requirements/infrastructure-architecture.md`

### **Detailed Design Specifications**
None.


## Prepare Repository Structure Guideline
### **Separation by Provisioning / Application Method**
- Infrastructureでは、Infrastructureの構築・適用方式が異なる領域について、Repository Structure上もそれぞれの責務を分離して配置する。
- 例えば、AWS Infrastructureを担当するModuleにTerraformによって構築するResourceと、`kubectl`によってKubernetes Clusterへ適用するResourceの双方が存在する場合、以下のようにそれぞれの領域を分離する。

```
<module-root>/
├── terraform/
└── k8s/
```

- Terraformに対するTerragruntや、Kubernetes Manifestに対するKustomizeなど、各構築・適用方式を補助・拡張するToolやEcosystemについては、それ自体を理由として独立した領域へ分離せず、対応する構築・適用方式の領域に含めることを基本とする。

### **Separation of Reusable Modules and Environment Profiles**
- Environmentごとに構成・設定の差分を持つ場合は、Environment固有の内容をそれぞれ独立したProfileとして分離して配置できる構造にする。
- 再利用可能な共通定義とEnvironmentごとのProfileは責務を分離し、Repository Structure上では同一階層に配置することを基本とした構造にする。
- 例えばTerraformにおいて、再利用可能なModuleとdev / stg / prodごとの構成が存在する場合は、以下のように構成する。

```text
terraform/
├── modules/
├── dev/
├── stg/
└── prod/
```

## **Work Skill for Implementation Loop**
Work Skill: $infrastructure-implementation

