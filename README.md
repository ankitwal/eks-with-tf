# eks-with-tf
Sample implementations of EKS(AWS Kubernetes Service) with Terraform

## Respository File Structure Description  
``` 
├── README.md                           - This file  
├── env.sh.template                     - xxx  
├── environments                        - Environment definition files (eg. test.tf, prod.tf)  
│   └── sandbox                         - sandbox environment files  
│       ├── ...  
│       ├── ...  
├── modules                             - component modules  
│   ├── eks                             - eks module  
│   │   └── eks-main.tf  
│   └── vpc                             - vpc module  
│       ├── ...  
└── orchestration                       - scripts to initialise and orchestrate terraform executions  
    ├── create-state-s3-bucket.sh
    └── env.sh
```

## Commit Message  

## How to run terraform  
- Initialise  `terraform init`  
- Change to required workspace `terraform worksapce new <Author>-<JIRA_Card_Number>`
- `terraform plan`


