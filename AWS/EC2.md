# Amazon Elastic Compute Cloud (EC2)

## Overview
Amazon EC2 (Elastic Compute Cloud) provides scalable computing capacity in the AWS Cloud. It eliminates the need for upfront hardware investments, allowing developers to quickly deploy virtual servers as needed.

## Key Features

- **Elasticity**: Easily scale up or down your compute capacity according to demand.
- **Variety of Instance Types**: Choose from a range of instance types optimized for different workloads.
- **Pay-as-you-go Pricing**: Only pay for the compute time you use.
- **Custom AMIs (Amazon Machine Images)**: Create customized configurations for your instances.
- **Security**: Utilize security groups and key pairs to control access.

## Core Components

### 1. **Instances**
- Virtual servers running your applications.
- Can be launched from predefined or custom AMIs.

### 2. **AMIs (Amazon Machine Images)**
- Pre-configured templates containing the operating system and applications for your instance.
- Options include Amazon Linux, Ubuntu, Windows Server, etc.

### 3. **Instance Types**
- Define the compute, memory, and storage capacity of an instance.
- **Categories**:
  - **General Purpose** (e.g., `t2.micro`, `m5.large`)
  - **Compute Optimized** (e.g., `c5.large`)
  - **Memory Optimized** (e.g., `r5.large`)
  - **Storage Optimized** (e.g., `i3.large`)

### 4. **EBS (Elastic Block Store)**
- Persistent block-level storage volumes for instances.
- Volumes can be attached and detached from instances.

### 5. **Security Groups**
- Act as virtual firewalls to control inbound and outbound traffic.

### 6. **Key Pairs**
- Used for secure SSH or RDP access to instances.

### 7. **Elastic IPs**
- Static IP addresses that can be remapped to different instances.

## Key Benefits

- **Scalability**: Add or remove instances based on traffic.
- **Flexibility**: Choose from various operating systems and hardware configurations.
- **Reliability**: Deploy across multiple Availability Zones for high availability.
- **Security**: Leverage AWS Identity and Access Management (IAM) and encryption.

## Pricing
- **On-Demand Instances**: Pay for compute capacity per hour or second.
- **Reserved Instances**: Commit to one or three years for significant cost savings.
- **Spot Instances**: Bid for unused capacity at reduced prices.

## Common Use Cases

- **Web Applications**: Host scalable web servers.
- **Data Processing**: Handle batch processing jobs.
- **Development and Testing**: Create isolated environments for testing.
- **Machine Learning**: Train models using GPU instances.

## Related Services
- **Auto Scaling**: Automatically adjust the number of instances.
- **Elastic Load Balancing**: Distribute traffic across instances.
- **Amazon CloudWatch**: Monitor and manage EC2 instances.

## Example of Launching an EC2 Instance

1. Navigate to the **EC2 Dashboard**.
2. Click **Launch Instance**.
3. Select an **AMI**.
4. Choose an **Instance Type**.
5. Configure **Security Groups**.
6. Add **Key Pair** for SSH access.
7. Launch the instance and connect using the public IP.

