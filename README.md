# Simple_Web_App

# Folder Structure
```
.
├── Application
│   ├── Docker
│   │   ├── Dockerfile
│   │   ├── SimpleWeb
│   │   │   ├── db.php
│   │   │   ├── index.php
│   │   │   └── test.php
│   │   └── build.sh
│   └── k8s
│       ├── configmap.yaml
│       ├── deployment.yaml
│       ├── namespace.yaml
│       └── service.yaml
├── README.md
├── backend.tf
├── kubeconfig_simple-web-app-eks
├── main.tf
├── modules
│   ├── ECR
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── EKS
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── KMS
│   │   ├── iam.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── RDS
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── VPC
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
└── variables.tf
```
# Running the solution

The solution is divided into 2 parts: 
* Infrasturcture
* Application

## Prerequisites

The solution assumes that the following have been installed on your system:
* kubectl
* terraform > 13
* docker
* awscli 2.x

Furthermore you will need to have access to an AWS environment.

_Optional:_ An S3 bucket to store the tfstate file. If you dont want to create one or you dont have on the please comment or delete the `backed.tf`

## Terraform inputs required

### Requirements

| Name | Version |
|------|---------|
| kubernetes | ~> 1.11 |

### Providers

No provider.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application\_name | The application name | `string` | `"SimpleWebApp"` | no |
| aws\_account\_id | The AWS account id | `number` | `"723949785394"` | no |
| cidr\_block\_target\_vpc | CIDR block of the VPC | `string` | `"10.0.0.0/16"` | no |
| cluster\_name | EKS cluster name | `string` | `"simple-web-app-eks"` | no |
| db\_name | The name of the database | `string` | `"swa"` | no |
| environment | The environment we will be deploying to, i.e sandbox,test,uat,prod | `string` | `"sandbox"` | no |
| identifier | What will the RDS instance be called | `string` | `"swa"` | no |
| map\_accounts | Additional AWS account numbers to add to the aws-auth configmap. | `list(string)` | `[]` | no |
| map\_roles | Additional IAM roles to add to the aws-auth configmap. | <pre>list(object({<br>    rolearn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | `[]` | no |
| map\_users | Additional IAM users to add to the aws-auth configmap. | <pre>list(object({<br>    userarn  = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "groups": [<br>      "system:masters"<br>    ],<br>    "userarn": "arn:aws:iam::723949785394:user/tschizas",<br>    "username": "tschizas"<br>  }<br>]</pre> | no |
| region | Where we will be deploying to | `string` | `"eu-west-2"` | no |
| tags | Default Tags to be used on all created resources | <pre>object(<br>    {<br>      application      = string<br>      automanage       = bool<br>      backup_retention = string<br>      backup_schedule  = string<br>      metadata         = string<br>      owner            = string<br>    }<br>  )</pre> | <pre>{<br>  "application": "Simple Web App",<br>  "automanage": true,<br>  "backup_retention": "N/A",<br>  "backup_schedule": "N/A",<br>  "metadata": "N/A",<br>  "owner": "Thomas"<br>}</pre> | no |
| target\_vpc\_id | The target VPC ID where the instances will be deployed to | `string` | `""` | no |
| vpc\_tags | n/a | <pre>object(<br>    { Name = string }<br>  )</pre> | <pre>{<br>  "Name": ""<br>}</pre> | no |

### Outputs

| Name | Description |
|------|-------------|
| azs | List of availability zones |
| config\_map\_aws\_auth | A kubernetes configuration to authenticate to this EKS cluster. |
| db\_instance\_backend\_endpoint | RDS Outputs |
| db\_instance\_backend\_name | n/a |
| db\_instance\_backend\_port | n/a |
| db\_instance\_backend\_resource\_id | n/a |
| db\_instance\_backend\_sg\_id | n/a |
| db\_instance\_backend\_username | n/a |
| db\_instance\_id | n/a |
| db\_subnet\_group\_id | DB Subnet Group ID |
| name | The VPC name |
| nat\_public\_ips | List of public Elastic IPs created for AWS NAT Gateway |
| private\_subnets | List of IDs of private subnets |
| public\_subnets | List of IDs of public subnets |
| rds\_kms\_key\_arn | The RDS KMS Key arn |
| rds\_kms\_key\_id | The RDS KMS Key ID |
| repository\_url | The ECR repo URL |
| vpc\_cidr\_block | The CIDR block of the VPC |
| vpc\_id | The ID of the VPC |

## Run the infrastructure

* Login to AWS via SSO or export the profile you are using
* Update any variables on `main.tf`. If you want to run this on a local state you will need to either delete or comment out the `backend.tf` as this assumes that an S3 bucket is created.
* Run `terraform init`; this will initialise all the required modules
* Run `terraform plan`; this will plan and show you the resources that will be created 
* Run `terraform apply`; this will create the resources. _Please note that these resources are billable_

## Deploy the application

* Navigate to the `Application` folder
* _Optional_: Update the the `db.php` with the correct value for the database test (should you wish to use this)
* Run the `build.sh` script and pass the ECR url
* Copy the kubeconfig_* details into your `.kube/config` this will give you access to EKS
* Navigate to the `k8s` folder and run `kubectl apply -f .` this will apply all the files in that folder

# Further Improvements

## Backend

I believe I could have used [Aurora Serverless][https://aws.amazon.com/rds/aurora/serverless/], as it would have been less costly and far easier to manage. 

## K8s deployment

I would have much prefered to create a Helm chart for the application as this way we could have used a template to deploy it anywhere with only minor changes. Furthermore, I am not a great fan of having passwords in plain sight so I would have used secrets (ideally Vault or equivelent) to store the db username & password to be consumed by the application.

## Testing

* Run a busybox and do a curl on the LB on the port to ensure the website is running
* Terratest that the DB & EKS are provisioned correctly (private subnets) and cannot be accessed externaly

## CI/CD

Ideally this (along with the previous) should be run through a CI/CD process