### Terraform


## 1. Introduction to Terraform

Terraform is an **open-source Infrastructure as Code (IaC)** tool developed by HashiCorp. It allows users to define and provision data center infrastructure using a declarative configuration language known as **HCL (HashiCorp Configuration Language)**.

### Key Features:

- **Declarative Syntax:** Describe the desired state, and Terraform handles the rest.
- **Multi-Cloud Support:** AWS, Azure, GCP, Kubernetes, etc.
- **Execution Plans:** Preview changes before applying them.
- **State Management:** Tracks infrastructure changes over time.
- **Modules:** Promote code reuse.

---

## 2. Terraform Architecture

### Core Components:

- **Configuration Files:** Written in `.tf` files using HCL.
- **Terraform Core:** Reads configs, creates plans, and manages state.
- **Providers:** Plugins that interact with cloud APIs (e.g., AWS, Azure).
- **State Files:** Track real-world resource states (`terraform.tfstate`).
- **Modules:** Reusable code for infrastructure components.
- **Backend:** Defines where the state file is stored (local, S3, etc.).

### Diagram (Conceptual):

```
+-----------------+
| Configuration   | (.tf files)
+-----------------+
         |
         v
+-----------------+
| Terraform Core  |
+-----------------+
         |
         v
+-----------------+
|  Providers/API  |
+-----------------+
```

---

## 3. Terraform Workflow

**Write → Plan → Apply → Destroy**

1. **Write:** Define infrastructure as code.
2. **Plan:** Preview the execution plan.
    
    ```
    terraform plan
    ```
    
3. **Apply:** Apply changes.
    
    ```
    terraform apply
    ```
    
4. **Destroy:** Tear down infrastructure.
    
    ```
    terraform destroy
    ```
    

---

## 4. Key Terraform Files

- **`main.tf`**: Main configuration.
- **`variables.tf`**: Input variables.
- **`terraform.tfvars`**: Variable values.
- **`outputs.tf`**: Output values.
- **`providers.tf`**: Provider configurations.

### Example `main.tf`:

```
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
```

---

## 5. Core Terraform Commands

- **Initialization:**
    
    ```
    terraform init
    ```
    
- **Validation:**
    
    ```
    terraform validate
    ```
    
- **Formatting:**
    
    ```
    terraform fmt
    ```
    
- **Planning:**
    
    ```
    terraform plan
    ```
    
- **Applying:**
    
    ```
    terraform apply
    ```
    
- **Destroying:**
    
    ```
    terraform destroy
    ```
    

---

## 6. Variables and Outputs

### Variables

```
variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}
```

### Outputs

```
output "instance_ip" {
  value = aws_instance.example.public_ip
}
```

---

## 7. Terraform Modules

### Module Structure:

```
modules/
└── vpc/
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```

### Using a Module:

```
module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}
```

---

## 8. State Management

- **View State:**
    
    ```
    terraform state list
    ```
    
- **Show Resource Details:**
    
    ```
    terraform state show aws_instance.example
    ```
    

### Remote State Example (S3):

```
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "state.tfstate"
    region = "us-east-1"
  }
}
```

---

## 9. Provisioners

### Example (local-exec):

```
resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo 'Provisioning complete'"
  }
}
```

### Example (remote-exec):

```
resource "aws_instance" "example" {
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx"
    ]
  }
}
```

---

## 10. Workspaces

- **Create Workspace:**
    
    ```
    terraform workspace new dev
    ```
    
- **List Workspaces:**
    
    ```
    terraform workspace list
    ```
    
- **Select Workspace:**
    
    ```
    terraform workspace select dev
    ```
    

---

## 11. Best Practices

- Use version control (Git) for `.tf` files.
- Store remote state securely (e.g., S3 with encryption).
- Use modules for reusable code.
- Lock provider versions:
    
    ```
    terraform {
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 4.0"
        }
      }
    }
    ```
    

---

## 12. Troubleshooting & Debugging

- **Enable Debug Logs:**
    
    ```
    export TF_LOG=DEBUG
    terraform apply
    ```
    
- **Common Issues:**
    - State lock errors.
    - Resource drift.
    - API throttling.

---

##