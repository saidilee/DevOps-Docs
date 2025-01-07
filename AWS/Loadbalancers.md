# AWS Load Balancers

## Types of Load Balancers in AWS

### 1. Application Load Balancer (ALB)

- **Layer**: Operates at Layer 7 (Application Layer) of the OSI model.
- **Best for**: HTTP and HTTPS traffic.
- **Key Features**:
  - Supports host-based and path-based routing.
  - Integrates with AWS WAF (Web Application Firewall) for security.
  - Supports WebSockets and gRPC.
- **Use Case**: Routing requests based on URL path (e.g., `/images` to one set of servers, `/videos` to another).

### 2. Network Load Balancer (NLB)

- **Layer**: Operates at Layer 4 (Transport Layer).
- **Best for**: TCP, TLS, and UDP traffic.
- **Key Features**:
  - Designed for high throughput and low latency.
  - Supports static IP addresses.
  - Directly forwards TCP/UDP connections to targets.
- **Use Case**: Handling millions of requests per second, such as streaming data or financial services applications.

### 3. Classic Load Balancer (CLB)

- **Layer**: Operates at both Layer 4 and Layer 7.
- **Best for**: Basic load balancing for HTTP/HTTPS and TCP applications.
- **Key Features**:
  - Older generation, supporting EC2 Classic.
  - Limited to simpler use cases.
- **Use Case**: Legacy applications or where backward compatibility is required.

### 4. Gateway Load Balancer (GWLB)

- **Layer**: Operates at Layer 3 (Network Layer).
- **Best for**: Integrating third-party virtual appliances (e.g., firewalls, intrusion detection systems).
- **Key Features**:
  - Combines scaling and load balancing for appliances.
  - Simplifies deployment of network security services.
- **Use Case**: Centralized deployment of security and network analytics tools.

## Core Components of Load Balancers

- **Listeners**: Rules that check for connection requests and forward them to targets.
- **Target Groups**: Collections of resources (EC2 instances, IPs, or Lambda functions) to receive requests.
- **Health Checks**: Used to determine if a target is available to handle requests.

## Key Benefits of AWS Load Balancers

- **Scalability**: Automatically adjusts to handle varying traffic loads.
- **High Availability**: Distributes traffic across multiple resources.
- **Security**: Integrates with security groups, IAM, and AWS WAF.
- **Elasticity**: Pay for what you use, and the service scales as your traffic grows.

## Comparison of Load Balancers

| Feature     | ALB               | NLB                  | CLB             | GWLB                     |
|-------------|------------------|---------------------|----------------|--------------------------|
| **Layer**   | 7 (Application)   | 4 (Transport)       | 4 & 7          | 3 (Network)              |
| **Protocols** | HTTP, HTTPS, WebSocket | TCP, TLS, UDP       | HTTP, HTTPS, TCP | IP                       |
| **Routing** | Path/host-based   | Connection-based    | Simple         | Network appliance traffic |
| **Use Case** | Web apps, microservices | High-throughput apps | Legacy systems | Security appliances      |
