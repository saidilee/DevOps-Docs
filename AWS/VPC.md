# Amazon Virtual Private Cloud (VPC)

Amazon Virtual Private Cloud (VPC) is a foundational service in AWS that allows you to create a logically isolated network for your AWS resources. It enables you to have full control over the network settings, including IP address ranges, subnets, route tables, gateways, and security configurations.

---

## Key Concepts of VPC

### 1. **VPC (Virtual Private Cloud)**
- A virtual network isolated within the AWS Cloud.
- You define the IP address range using CIDR notation (e.g., `10.0.0.0/16`).
- Acts as a container for subnets and other networking components.

### 2. **Subnets**
- Subdivisions of the VPC.
- Can be public (accessible from the internet) or private (not directly accessible from the internet).
- **Example**:
  - Public Subnet: `10.0.1.0/24`
  - Private Subnet: `10.0.2.0/24`

### 3. **Internet Gateway (IGW)**
- Allows communication between instances in a public subnet and the internet.
- Each VPC can have only one IGW.
- **Example**: Instances in a public subnet need an Elastic IP and routing through an IGW to be accessible from the internet.

### 4. **NAT Gateway/Instance**
- Facilitates internet access for instances in private subnets.
- NAT Gateway is managed by AWS and provides scalability and availability.
- NAT Instance is user-managed and runs on an EC2 instance.
- **Example**: Private instances need to fetch updates from the internet.

### 5. **Route Tables**
- Defines how traffic is routed within the VPC and beyond.
- Each subnet is associated with one route table.
- **Example**:
  - Public subnet route: Directs internet-bound traffic to the IGW.
  - Private subnet route: Directs internet-bound traffic to the NAT Gateway.

### 6. **Security Groups**
- Acts as a virtual firewall for your instances.
- Controls inbound and outbound traffic at the instance level.
- **Example**: Allow SSH access (port 22) only from specific IP addresses.

### 7. **Network ACLs (NACLs)**
- Stateless firewalls that control inbound and outbound traffic at the subnet level.
- **Example**: Block all traffic from a specific IP range.

### 8. **VPC Peering**
- Enables communication between two VPCs, either in the same or different AWS accounts and regions.
- **Example**: An application in VPC A communicates with a database in VPC B.

### 9. **VPC Endpoints**
- Allows private connections between your VPC and supported AWS services, without traversing the internet.
- **Types**:
  - **Interface Endpoint**: Uses private IPs and ENIs.
  - **Gateway Endpoint**: Used for S3 and DynamoDB.

### 10. **Elastic IPs (EIP)**
- Static public IP addresses that can be associated with instances or network interfaces.

### 11. **Bastion Host**
- A secure server in a public subnet used to access resources in private subnets.

### 12. **AWS Transit Gateway**
- A centralized hub for connecting multiple VPCs and on-premises networks.

---

## VPC Example

### Scenario: Deploying a Web Application

**VPC CIDR Block**: `10.0.0.0/16`

**Subnets**:
- Public Subnet 1: `10.0.1.0/24` (Availability Zone A)
- Public Subnet 2: `10.0.2.0/24` (Availability Zone B)
- Private Subnet 1: `10.0.3.0/24` (Availability Zone A)
- Private Subnet 2: `10.0.4.0/24` (Availability Zone B)

**Components**:
- **Internet Gateway**: Enables internet access for public subnets.
- **NAT Gateway**: Allows private instances to access the internet.
- **Route Tables**:
  - Public Subnet: Routes internet traffic to the IGW.
  - Private Subnet: Routes internet traffic to the NAT Gateway.
- **Security Groups**:
  - Web Server Group: Allows HTTP (80) and HTTPS (443) traffic.
  - Database Group: Allows traffic only from the Web Server group on port 3306 (MySQL).
- **Application Load Balancer**: Distributes traffic to EC2 instances in the public subnets.
- **RDS Database**: Deployed in private subnets for security.

---

## Visual Representation

```plaintext
VPC: 10.0.0.0/16
    ┌───────────────────────────────────────────────┐
    │ Public Subnet 1 (10.0.1.0/24)                 │
    │  - EC2 Instances (Web Servers)               │
    │  - Application Load Balancer                 │
    ├───────────────────────────────────────────────┤
    │ Private Subnet 1 (10.0.3.0/24)                │
    │  - RDS Database                               │
    │  - NAT Gateway                                │
    └───────────────────────────────────────────────┘
```  

This setup provides:
1. Public access to web servers.
2. Secure communication between web servers and the database.
3. Internet access for private instances via NAT.
