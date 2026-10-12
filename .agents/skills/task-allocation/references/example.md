# Development Allocation Map


## Map Overview

※特別明示的な指定がない限り、本Mapに記載された工程は、上から下にかけての順で実施・進行していく。

```
Infrastructure
│
└── AWS
    ├── Network Resources
    ├── EKS Resources
    │   └── depends on: Network Resources
    └── RDS Resources
        └── depends on: Network Resources
        
Database
│
└── Database State Management
    ├── Create Category Table
    ├── Create Project Candidate Table
    │   └── depends on: Create Category Table
    └── Insert Initial Category Data
        └── depends on: Create Category Table
        
Backend
│
├── project-candidate-api
│   ├── Create Project Candidate API
│   │   ├── Validate Request
│   │   ├── Validate Category
│   │   ├── Create Project Candidate
│   │   ├── Persist Project Candidate
│   │   └── Build Response
│   │
│   └── Search Project Candidates API
│       ├── Validate Search Conditions
│       ├── Search Project Candidates
│       └── Build Response
│
├── recommendation-api
│   └── Generate Recommendation API
│       ├── Retrieve Project Candidates
│       ├── Build Recommendation Request
│       ├── Request Recommendation
│       └── Build Response
│
└── recommendation-refresh-batch
    └── Refresh Recommendations Batch
        ├── Retrieve Refresh Targets
        ├── Generate Recommendations
        └── Update Recommendation Data
        
Frontend
│
└── Web
    ├── Project Candidate Registration Screen
    │   ├── Input Project Candidate
    │   ├── Validate Input
    │   ├── Request Project Candidate Creation
    │   └── Display Creation Result
    │
    ├── Project Candidate Search Screen
    │   ├── Input Search Conditions
    │   ├── Request Project Candidate Search
    │   ├── Display Search Results
    │   └── Handle Search Errors
    │
    └── Recommendation Screen
        ├── Request Recommendation
        ├── Display Recommendation
        └── Handle Recommendation Errors
```

## Domain: Infrastructure

- **Required**: Yes

### Module: AWS

- **Action**: Create
- **Dependencies**: None
- **Execution Order**: 1
- **CI/CD Pipeline**: Setup Required

#### Functional Unit: Network Resources

- **Action**: Create
- **Dependencies**: None
- **Execution Order**: 1-1

#### Functional Unit: EKS Resources

- **Action**: Create
- **Dependencies**:
  - Network Resources
- **Execution Order**: 1-2

#### Functional Unit: RDS Resources

- **Action**: Create
- **Dependencies**:
  - Network Resources
- **Execution Order**: 1-3


## Domain: Database

- **Required**: Yes

### Module: Database State Management

- **Action**: Create
- **Dependencies**:
  - Infrastructure / AWS
- **Execution Order**: 1
- **CI/CD Pipeline**: No

#### Functional Unit: Create Category Table

- **Action**: Create
- **Dependencies**: None
- **Execution Order**: 1-1

#### Functional Unit: Create Project Candidate Table

- **Action**: Create
- **Dependencies**:
  - Create Category Table
- **Execution Order**: 1-2

#### Functional Unit: Insert Initial Category Data

- **Action**: Create
- **Dependencies**:
  - Create Category Table
- **Execution Order**: 1-3


## Domain: Backend

- **Required**: Yes

### Module: project-candidate-service

- **Action**: Create
- **Dependencies**:
  - Infrastructure / AWS
  - Database / Database State Management
  - Database / Data Migration
- **Execution Order**: 1
- **CI/CD Pipeline**: Setup Required
- **Container Image**: Setup Required
- **Orchestration Workload**: Setup Required

#### Functional Unit: Create Project Candidate API

- **Action**: Create
- **Dependencies**: None
- **Execution Order**: 1-1

#### Logic Units

1. [Create] Validate Request
2. [Create] Validate Category
3. [Create] Create Project Candidate
4. [Create] Persist Project Candidate
5. Build Response


#### Functional Unit: Search Project Candidates API

- **Action**: Create
- **Dependencies**:
  - Create Project Candidate API
- **Execution Order**: 1-2

#### Logic Units

1. [Create] Validate Search Conditions
2. [Create] Search Project Candidates
3. [Create] Build Response


### Module: recommendation-service

- **Dependencies**:
  - project-candidate-service
- **Execution Order**: 2
- **CI/CD Pipeline**: Setup Required
- **Container Image**: Setup Required
- **Orchestration Workload**: Setup Required

#### Functional Unit: Generate Recommendation API

- **Action**: Create
- **Dependencies**:
  - project-candidate-service / Search Project Candidates API
- **Execution Order**: 2-1

#### Logic Units

1. [Create] Retrieve Project Candidates
2. [Create] Build Recommendation Request
3. [Create] Request Recommendation
4. [Create] Build Response


### Module: batch-service

- **Dependencies**:
  - project-candidate-service
  - recommendation-service
- **Execution Order**: 3
- **CI/CD Pipeline**: Setup Required
- **Container Image**: Setup Required
- **Orchestration Workload**: Setup Required

#### Functional Unit: Refresh Recommendations Batch

- **Action**: Create
- **Dependencies**:
  - recommendation-service / Generate Recommendation API
- **Execution Order**: 3-1

#### Logic Units

1. [Create] Retrieve Refresh Targets
2. [Create] Generate Recommendations
3. [Create] Update Recommendation Data


## Domain: Frontend

- **Required**: Yes

### Module: Web

- **Action**: Create
- **Dependencies**:
  - Infrastructure / AWS
  - Backend / project-candidate-service
  - Backend / recommendation-service
- **Execution Order**: 1
- **CI/CD Pipeline**: Setup Required
- **Container Image**: Setup Required
- **Orchestration Workload**: Setup Required

#### Functional Unit: Project Candidate Registration Screen

- **Action**: Create
- **Dependencies**:
  - Backend / project-candidate-service / Create Project Candidate API
- **Execution Order**: 1-1

#### Logic Units

1. [Create] Input Project Candidate
2. [Create] Validate Input
3. [Create] Request Project Candidate Creation
4. [Create] Display Creation Result


#### Functional Unit: Project Candidate Search Screen

- **Action**: Create
- **Dependencies**:
  - Backend / project-candidate-service / Search Project Candidates API
- **Execution Order**: 1-2

#### Logic Units

1. [Create] Input Search Conditions
2. [Create] Request Project Candidate Search
3. [Create] Display Search Results
4. [Create] Handle Search Errors


#### Functional Unit: Recommendation Screen

- **Action**: Create
- **Dependencies**:
  - Backend / recommendation-service / Generate Recommendation API
- **Execution Order**: 1-3

#### Logic Units

1. [Create] Request Recommendation
2. [Create] Display Recommendation
3. [Create] Handle Recommendation Errors