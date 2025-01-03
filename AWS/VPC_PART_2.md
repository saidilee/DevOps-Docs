# AWS Networking Concepts and Demos

## **NACLs & Security Groups**  
**Network Access Control Lists (NACLs)** provide stateless, layer-level security for subnets within a VPC.  

- They control inbound and outbound traffic at the subnet level.  

### **Key Features:**  
- Operate at the subnet level.  
- Support allow and deny rules.  
- Rules are evaluated in numerical order.  

## **Security Groups**


- They operate at the instance level, controlling traffic to and from specific resources.
### ** Key Features:**
**Instance-Level Operation**: Security groups are assigned directly to instances, allowing for granular control over traffic to individual resources. 


- Stateful Nature: They are stateful, meaning that if an inbound request is allowed, the corresponding outbound response is automatically permitted, and vice versa. 
- Allow Rules Only: Security groups support only allow rules; you cannot create deny rules. This ensures that only explicitly permitted traffic is allowed. 

---

## **Load Balancers**  
**Load Balancers** distribute incoming traffic across multiple targets to ensure high availability and reliability.  

### **Types:**  
- **Application Load Balancer (ALB):** Operates at Layer 7 (HTTP/HTTPS).  
- **Network Load Balancer (NLB):** Operates at Layer 4 (TCP/UDP).  
- **Classic Load Balancer:** Not recommended now.  

### **Load Balancers - Demo**  
1. Create an ALB and attach target groups.  
2. Test traffic distribution among instances.  

**Example setup steps:**  
- Configure security groups.  
- Register EC2 instances with target groups.  
- Create a listener for port 80/443.  

---

## **VPN**  
**Virtual Private Network (VPN)** enables secure connectivity between on-premises networks and AWS VPCs.  

### **AWS offers:**  
- **Site-to-Site VPN**  
- **Client VPN**  
- **AWS VPN CloudHub**  

---

## **Direct Connect**  
**AWS Direct Connect** provides dedicated network connections between on-premises environments and AWS.  

### **Benefits:**  
- Lower latency.  
- Consistent performance.  
- Increased bandwidth.  

---

## **VPC Peering**  
**VPC Peering** establishes a private connection between two VPCs in the same or different accounts.  

### **Use Cases:**  
- Sharing resources across VPCs.  
- Interconnecting microservices hosted in separate VPCs.  

### **VPC Peering - Demo**  
1. Create two VPCs with non-overlapping CIDR ranges.  
2. Establish a peering connection.  
3. Update route tables in both VPCs to allow communication.  
4. Test connectivity using EC2 instances.  

---

## **LAB - Connecting Three VPCs Together in a Region and Cross-Region**  

### **Scenario 1: Connecting Three VPCs in the Same Region**  
1. Create three VPCs in the same region.  
2. Establish peering connections between each pair.  
3. Configure route tables for transitive communication.  
4. Test connectivity using instances in each VPC.  

### **Scenario 2: Connecting VPCs Across Regions**  
1. Create three VPCs in Region A and one in Region B.  
2. Use a Transit Gateway for regional connectivity.  
3. Establish inter-region peering with another Transit Gateway in Region B.  
4. Test end-to-end connectivity.  

---

## **Transit Gateway**  
**Transit Gateway** simplifies VPC interconnectivity and hybrid connections.  

### **Features:**  
- Centralized routing.  
- Scalability across thousands of VPCs.  
- Supports multicast.  

---

## **PrivateLink**  
**PrivateLink** provides secure access to services hosted on AWS over the Amazon network.  

### **Benefits:**  
- Reduces exposure to the public internet.  
- Simplifies access to partner and AWS services.  

---

## **CloudFront**  
**Amazon CloudFront** is a Content Delivery Network (CDN) for fast, secure, and scalable content delivery.  

### **Key Features:**  
- Edge locations for global reach.  
- Integrated with AWS Shield for DDoS protection.  

### **CloudFront - Demo**  
1. Create a CloudFront distribution.  
2. Configure an S3 bucket or an EC2 instance as the origin.  
3. Test content delivery from different geographic locations.  

---

## **Lambda@Edge**  
**Lambda@Edge** enables you to execute serverless functions at CloudFront edge locations.  

### **Use Cases:**  
- Content manipulation.  
- User authentication.  
- Adding custom headers.  

---

## **Global Accelerator**  
**AWS Global Accelerator** improves availability and performance for applications using global endpoints.  

### **Benefits:**  
- Leverages AWS’ global network.  
- Provides static IP addresses.  
- Reduces latency.  

---

## **Route 53**  
**Amazon Route 53** is a scalable Domain Name System (DNS) service.  

### **Features:**  
- Domain registration.  
- DNS routing policies: Simple, Weighted, Latency-based, Geolocation.  
- Health checks.  

### **Demo: Route 53**  
1. Register a domain in Route 53.  
2. Create hosted zones and records.  
3. Test domain resolution.  
4. Implement routing policies like failover or latency-based.  

---

## **Route 53 Application Recovery Controller**  
A specialized Route 53 feature for disaster recovery.  

### **Capabilities:**  
- Routing controls for failover.  
- Readiness checks for recovery planning.  
- Integrated with AWS services for seamless recovery workflows.  
