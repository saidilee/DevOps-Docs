### **1. Scenario: Zero-Downtime Deployment of an EC2 Instance**

**Question:** You need to update an EC2 instance’s AMI ID **without downtime**. Terraform wants to destroy and recreate the instance. How do you avoid downtime?

**Answer:**

- Use **Create Before Destroy** in lifecycle rules:
    
    ```hcl
    
    resource "aws_instance" "example" {
      ami           = var.ami_id
      instance_type = "t3.micro"
    
      lifecycle {
        create_before_destroy = true
      }
    }
    
    ```
    
- This ensures the new instance is created before the old one is deleted.
- Alternatively, use an **Auto Scaling Group (ASG)** with rolling updates.

---

### **2. Scenario: Managing Cross-Region Infrastructure**

**Question:** You need to deploy an S3 bucket in `us-east-1` and an EC2 instance in `ap-south-1` using the same Terraform configuration. How do you achieve this?

**Answer:**

Use **multiple provider configurations**:

```hcl

provider "aws" {
  alias  = "us-east"
  region = "us-east-1"
}

provider "aws" {
  alias  = "ap-south"
  region = "ap-south-1"
}

resource "aws_s3_bucket" "example" {
  provider = aws.us-east
  bucket   = "my-bucket-us-east"
}

resource "aws_instance" "example" {
  provider      = aws.ap-south
  ami           = "ami-123456"
  instance_type = "t2.micro"
}

```

- Each resource is explicitly assigned a provider alias.

---

### **3. Scenario: Handling Terraform Drift in Production**

**Question:** Your Terraform-managed AWS infrastructure was modified manually by another team. Terraform does not show changes, but the AWS console does. How do you detect and correct this?

**Answer:**

- Run `terraform plan -refresh-only` to detect drift without making changes.
- Use `terraform state list` to inspect tracked resources.
- If a resource is missing, re-import it:
    
    ```bash
    
    terraform import aws_instance.example i-1234567890abcdef0
    
    ```
    
- If necessary, `terraform apply` to restore the expected configuration.

---

### **4. Scenario: Enforcing Terraform Security Policies**

**Question:** Your company wants to ensure that only t2.micro instances are used to control AWS costs. How do you enforce this in Terraform?

**Answer:**

Use a Terraform validation rule in the variables.tf file to restrict instance types.
- Example **OPA policy** to enforce S3 encryption:
    
    ```
    
   variable "instance_type" {
  description = "AWS EC2 instance type"
  type        = string

  validation {
    condition     = contains(["t2.micro"], var.instance_type)
    error_message = "Only t2.micro instance type is allowed."
  }
}
    
    ```
    
- This prevents users from applying Terraform with non-approved instance types.

---

### **5. Scenario: Blue-Green Deployment with Terraform**

**Question:** You need to implement a **blue-green deployment strategy** using Terraform for an Auto Scaling Group (ASG). How do you achieve this?

**Answer:**

- Use two ASGs (`blue` and `green`) behind an **Elastic Load Balancer (ELB)**.
- Example approach:
    
    ```hcl
    
    resource "aws_launch_template" "blue" {
      name = "blue-template"
      image_id = var.ami_blue
    }
    
    resource "aws_launch_template" "green" {
      name = "green-template"
      image_id = var.ami_green
    }
    
    resource "aws_autoscaling_group" "blue" {
      launch_template {
        id = aws_launch_template.blue.id
      }
    }
    
    resource "aws_autoscaling_group" "green" {
      launch_template {
        id = aws_launch_template.green.id
      }
    }
    
    resource "aws_lb_listener_rule" "switch" {
      listener_arn = aws_lb_listener.http.arn
      priority     = 100
      conditions {
        field  = "path-pattern"
        values = ["*"]
      }
      actions {
        type             = "forward"
        target_group_arn = aws_lb_target_group.green.arn
      }
    }
    
    ```
    
- Change the ALB target group when deploying a new version.

---

### **6. Scenario: Terraform Apply Failure Due to API Rate Limits**

**Question:** You are creating 100+ AWS resources in a single `terraform apply`, but the process fails due to AWS **API rate limits**. How do you fix this?

**Answer:**

- Use **retry settings** in the AWS provider:
    
    ```hcl
    provider "aws" {
      region = "us-east-1"
      max_retries = 5
    }
    
    ```
    
- Use `depends_on` to **stagger** resource creation:
    
    ```hcl
    
    resource "aws_instance" "one" {
      ami = "ami-123456"
    }
    
    resource "aws_instance" "two" {
      ami       = "ami-123456"
      depends_on = [aws_instance.one]
    }
    
    ```
    
- Use **Terraform Workspaces** to split workloads.

---

### **7. Scenario: Preventing Accidental Deletion of Critical Resources**

**Question:** You want to prevent the accidental deletion of a production RDS database managed by Terraform. How do you enforce this?

**Answer:**

Use `prevent_destroy` lifecycle rules:

```hcl

resource "aws_db_instance" "production_db" {
  identifier = "prod-db"
  engine     = "mysql"
  instance_class = "db.t3.large"

  lifecycle {
    prevent_destroy = true
  }
}

```

- If `terraform destroy` is run, it will **fail** for this resource.

---

### **8. Scenario: Managing Multi-Tenant AWS Accounts with Terraform**

**Question:** Your organization has multiple AWS accounts (Dev, QA, Prod). How do you manage deployments efficiently?

**Answer:**

Use **Terraform Workspaces** for multi-environment management:

```bash

terraform workspace new dev
terraform workspace new prod
terraform workspace select prod

```

In Terraform configuration:

```hcl

provider "aws" {
  region = "us-east-1"
  alias  = terraform.workspace
}

resource "aws_s3_bucket" "example" {
  bucket = "my-bucket-${terraform.workspace}"
}

```
