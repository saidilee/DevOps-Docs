# Scanario Based Questions

Recent issue you faced in Prod and How you fixed It ???

# Troubleshooting DevOps Scenarios

---

## **Scenario 1: Application Downtime Due to Kubernetes Resource Constraints**

### **What’s Happening?**

In Kubernetes, pods require resources like CPU and memory to function. Misconfigured resource requests and limits or an improperly tuned Horizontal Pod Autoscaler (HPA) can lead to resource exhaustion, causing application downtime during traffic spikes.

### **Issue in Detail:**

- Pods crashed due to **OutOfMemory** errors caused by insufficient memory allocation.
- The HPA was not configured properly, preventing scaling during traffic surges.

### **Resolution:**

1. **Analyzing Metrics:** Used Grafana dashboards and Prometheus data to identify resource usage patterns.
2. **Resource Tuning:** Updated resource requests and limits in the pod specification using a Helm chart:
    
    ```yaml
    resources:
      requests:
        memory: "512Mi"
        cpu: "500m"
      limits:
        memory: "1Gi"
        cpu: "1"
    
    ```
    
3. **HPA Configuration:** Set up HPA for autoscaling:
    
    ```yaml
    
    apiVersion: autoscaling/v2
    kind: HorizontalPodAutoscaler
    spec:
      minReplicas: 2
      maxReplicas: 10
      metrics:
        - type: Resource
          resource:
            name: cpu
            target:
              type: Utilization
              averageUtilization: 70
    
    ```
    
4. **Load Testing:** Simulated peak traffic using tools like Apache JMeter to validate changes.

---

## **Scenario 2: Docker Image Vulnerabilities**

### **What’s Happening?**

Outdated base images in Docker can contain vulnerabilities, posing security risks to applications and infrastructure.

### **Issue in Detail:**

- Critical vulnerabilities in production images flagged by SonarQube.

### **Resolution:**

1. **Identifying Vulnerabilities:** Scanned images using Trivy:
    
    ```
    
    trivy image <image-name>
    
    ```
    
2. **Switching Base Image:** Replaced outdated images with lightweight, secure options like `distroless`:
    
    ```
    
    FROM distroless/base
    COPY app /app
    CMD ["/app"]
    
    ```
    
3. **Automating Scans:** Integrated Trivy in Jenkins pipelines:
    
    ```groovy
    
    stage('Scan Docker Image') {
        steps {
            sh 'trivy image my-app:latest'
        }
    }
    
    ```
    
4. **Dependency Updates:** Used tools like Renovate to auto-update dependencies.

---

## **Scenario 3: Traffic Bottleneck in Service Mesh**

### **What’s Happening?**

In microservices, misconfigured rate-limiting or circuit breaker policies in a service mesh like Istio can cause traffic bottlenecks.

### **Issue in Detail:**

- Overloaded services caused by a misconfigured rate-limiting policy led to increased response times.

### **Resolution:**

1. **Traffic Analysis:** Used Istio telemetry in Prometheus to track service performance.
2. **Updated Rate-Limiting Policy:** Adjusted configuration to limit requests:
    
    ```yaml
    
    apiVersion: config.istio.io/v1alpha2
    kind: QuotaSpec
    spec:
      rules:
        - quotas:
            - quota: requestcount
              maxAmount: 100
              validDuration: 1s
    
    ```
    
3. **Implemented Circuit Breaker:** Configured retries and timeouts:
    
    ```yaml
    
    trafficPolicy:
      connectionPool:
        http:
          http1MaxPendingRequests: 100
          maxRequestsPerConnection: 10
    
    ```
    
4. **Testing:** Used load-testing tools and canary deployment to validate.

### **Role of the Components:**

- **Istio Gateway:** Routes external traffic to services.
- **Rate Limiting:** Controls traffic per service.
- **Circuit Breaker:** Prevents cascading failures during high load.
- **Prometheus and Grafana:** Monitor latency and request counts.

---

## **Scenario 4: Terraform State Corruption**

### **What’s Happening?**

Terraform state files track infrastructure. Corruption in these files can lead to mismatches between actual infrastructure and desired configuration.

### 

### **Issue in Detail:**

- Manual modifications corrupted the state file, causing inconsistencies.

### **Resolution:**

1. **Restoring State:** Recovered the last consistent state from S3 version history.
2. **State Locking:** Configured a DynamoDB lock:
    
    ```hcl
    
    backend "s3" {
      bucket         = "terraform-state-bucket"
      key            = "terraform.tfstate"
      region         = "us-east-1"
      dynamodb_table = "terraform-lock-table"
    }
    
    ```
    
3. **Backup Automation:** Created a pipeline to back up state files periodically.
4. **Training:** Educated team on avoiding manual state modifications.

### **Role of the Components:**

- **Terraform State:** Tracks managed resources.
- **S3 Backend:** Stores the state file.
- **DynamoDB:** Provides locking to avoid simultaneous updates.

---

## **Scenario 5: Deployment Failure in ArgoCD**

### **What’s Happening?**

ArgoCD deployment failures often stem from misconfigured Helm charts or resource definitions.

### 

### **Issue in Detail:**

- Misaligned resource versions caused inconsistent application states.
- Helm charts lacked proper rollback mechanisms.

### **Resolution:**

1. **Rollback:** Used ArgoCD’s rollback feature to revert to a stable version.
2. **Improved Helm Charts:** Added hooks for sequential resource creation:
    
    ```yaml
    
    hooks:
      - pre-install:
          exec:
            command: ["/bin/sh", "-c", "echo Pre-Install Hook"]
    
    ```
    
3. **Audit and Align:** Reviewed GitOps repository for inconsistencies.
4. **Monitoring:** Set up Grafana alerts for failed deployments.

### **Role of the Components:**

- **ArgoCD:** Automates deployment using GitOps.
- **Helm Charts:** Manage Kubernetes resource templates.
- **GitOps Repository:** Stores desired application states.

## **6. High Latency in AWS Load Balancers During Traffic Spike**

AWS Load Balancers distribute incoming requests across services. Improper scaling configurations can lead to high latency during traffic spikes.

**Issue in Detail**:

- Increased traffic during a marketing campaign caused high latency in backend services.
- Autoscaling policies were not optimized to handle the sudden surge.

**Resolution**:

1. **Analyzing Latency**: Used Prometheus to monitor AWS Load Balancer response times and Grafana dashboards for visualization.
2. **Optimizing Autoscaling**: Configured AWS Autoscaling policies to scale instances based on request count and latency:
    
    ```yaml
    
    targetTrackingScalingPolicy:
      predefinedMetricSpecification:
        predefinedMetricType: ALBRequestCountPerTarget
      targetValue: 2000
    
    ```
    
3. **Load Testing**: Validated the changes using tools like Apache JMeter.
4. **Monitoring and Alerts**: Set up Grafana alerts for high latency to proactively address traffic spikes.

**Role of the Components**:

- **AWS Load Balancers**: Distribute requests to backend services.
- **Autoscaling**: Scales backend instances dynamically.
- **Prometheus and Grafana**: Monitor latency and request metrics.

---

## **7. Elasticsearch Cluster Went into Read-Only Mode**

The Elasticsearch cluster automatically switches to read-only mode when disk usage crosses a certain threshold, preventing indexing of new logs.

**Issue in Detail**:

- Elasticsearch entered **read-only mode** because disk usage exceeded 90%.
- As a result, new application logs were not indexed, impacting production monitoring.

**Resolution**:

1. **Analyzing Disk Usage**: Identified large indices and shards consuming excessive space using Kibana.
2. **Clearing Old Indices**: Deleted old indices to free up space:
    
    ```bash
    curl -XDELETE "localhost:9200/logs-2023.*"
    
    ```
    
3. **Disabling Read-Only Mode**: Removed the block on indices:
    
    ```bash
    
    curl -XPUT "localhost:9200/_all/_settings" -H 'Content-Type: application/json' -d'{
        "index.blocks.read_only_allow_delete": null
    }'
    
    ```
    
4. **Storage Optimization**: Implemented ILM (Index Lifecycle Management) to automatically delete or move old logs.
    
    ```yaml
    
    policies:
      delete-after-30-days:
        phases:
          delete:
            min_age: 30d
            actions:
              delete: {}
    
    ```
    
5. **Monitoring**: Added Grafana alerts for disk usage and index health.

**Role of the Components**:

- **ELK Stack**: Collects, processes, and visualizes logs.
- **Elasticsearch**: Stores logs and provides search capabilities.
- **Kibana**: Visualizes Elasticsearch data.

---

## **8. Database Connection Pool Exhaustion in Production**

High application traffic can overwhelm the database connection pool, causing timeouts and failed requests.

**Issue in Detail**:

- Applications failed to connect to the database during traffic spikes due to an exhausted connection pool.
- This caused response timeouts and degraded performance.

**Resolution**:

1. **Analyzing Connection Metrics**: Used Grafana dashboards to monitor active and idle connections.
2. **Connection Pool Tuning**: Increased the maximum connection pool size in the application configuration:
    
    ```yaml
    
    spring.datasource.hikari.maximum-pool-size: 50
    spring.datasource.hikari.minimum-idle: 10
    
    ```
    
3. **Read Replicas**: Added database read replicas to distribute read-heavy traffic.
4. **Load Testing**: Simulated peak traffic to validate the changes using JMeter.
5. **Monitoring**: Added alerts for database connection pool saturation.

**Role of the Components**:

- **Databases**: Backend storage for application data (e.g., MySQL/PostgreSQL).
- **EKS/Docker**: Hosts applications that query the database.

---

## **9. Prometheus High Resource Consumption**

Prometheus, when configured with excessive retention or scraped metrics, can consume high CPU and memory.

**Issue in Detail**:

- Prometheus pods consumed excessive memory due to an unoptimized metric retention period and large scrape targets.
- The Kubernetes nodes hosting Prometheus ran out of resources.

**Resolution**:

1. **Optimizing Retention**: Reduced data retention in Prometheus:
    
    ```bash
    
    --storage.tsdb.retention.time=15d
    --storage.tsdb.retention.size=5GB
    
    ```
    
2. **Filtering Metrics**: Updated `prometheus.yml` to exclude unnecessary metrics:
    
    ```yaml
    
    scrape_configs:
      - job_name: 'kubernetes-nodes'
        relabel_configs:
          - action: drop
            regex: 'container_.*'
            source_labels: [__name__]
    
    ```
    
3. **Scaling Prometheus**: Used Thanos for Prometheus federation and long-term storage.
4. **Monitoring**: Monitored Prometheus resource usage with Grafana dashboards.

**Role of the Components**:

- **Prometheus**: Collects and stores metrics for monitoring.
- **Grafana**: Visualizes Prometheus metrics.

---

## **10. Grafana Dashboard Load Time Increased**

As metrics grew, Grafana dashboards became slow to load, impacting monitoring during critical incidents.

**Issue in Detail**:

- Dashboards with multiple complex queries and long time ranges took several minutes to load.
- This affected on-call engineers during incident troubleshooting.

**Resolution**:

1. **Query Optimization**: Optimized Prometheus queries by using specific selectors and reducing query cardinality:
    
    ```
    promql
    
    sum(rate(container_cpu_usage_seconds_total{namespace="prod"}[5m]))
    
    ```
    
2. **Panel-Level Caching**: Enabled caching for frequently used queries.
3. **Time Range Limiting**: Restricted default time range to 6 hours instead of 30 days.
4. **Dashboard Optimization**: Split large dashboards into smaller, focused dashboards.

**Role of the Components**:

- **Grafana**: Visualizes metrics and logs.
- **Prometheus**: Provides data for dashboards.

---

## **11. Docker Image Bloat Causing Longer Deployment Times**

Large Docker images increase build, push, and deployment times, slowing down the CI/CD process.

**Issue in Detail**:

- Docker images were over 1GB due to unnecessary dependencies and build artifacts.
- Deployment time increased significantly during production releases.

**Resolution**:

1. **Minimized Image Size**: Used multi-stage builds to reduce image size:
    
    ```
    
    FROM node:14 as builder
    WORKDIR /app
    COPY . .
    RUN npm install && npm run build
    
    FROM nginx:alpine
    COPY --from=builder /app/build /usr/share/nginx/html
    
    ```
    
2. **Base Image Selection**: Replaced heavy base images with lightweight alternatives like `alpine` or `distroless`.
3. **Automated Cleanup**: Removed unused artifacts during the build process:
    
    ```
    
    RUN apt-get clean && rm -rf /var/lib/apt/lists/*
    
    ```
    
4. **Verification**: Used `docker image ls` to validate the reduced image size.

**Role of the Components**:

- **Docker**: Containerizes applications.
- **Jenkins/ArgoCD**: Automates deployment of Docker images.

---

## **12. Istio Circuit Breaker Preventing Cascading Failures**

Improper configurations in microservices can cause cascading failures under high load. Istio circuit breakers prevent this issue.

**Issue in Detail**:

- A downstream service failure caused all upstream services to retry indefinitely, overloading the system.
- This led to cascading failures and downtime.

**Resolution**:

1. **Configuring Circuit Breaker**: Set up Istio destination rules to limit connections and retries:
    
    ```yaml
    
    apiVersion: networking.istio.io/v1beta1
    kind: DestinationRule
    metadata:
      name: reviews-circuit-breaker
    spec:
      host: reviews
      trafficPolicy:
        connectionPool:
          http:
            http1MaxPendingRequests: 1
            maxRequestsPerConnection: 1
        outlierDetection:
          consecutive5xxErrors: 3
          interval: 5s
          baseEjectionTime: 30s
    
    ```
    
2. **Retry and Timeout Policies**: Optimized retry attempts to prevent overloading services.
3. **Monitoring**: Used Kiali to visualize and monitor Istio traffic flows.

**Role of the Components**:

- **Istio**: Manages traffic and adds resilience.
- **EKS**: Runs microservices.

---

## **13. Autoscaling Delayed Due to Insufficient Metrics**

In AWS EKS, delayed autoscaling can occur if metric collection (e.g., CPU/Memory) is misconfigured.

**Issue in Detail**:

- HPA did not trigger scaling because the `metrics-server` was misconfigured, and CPU/memory metrics were unavailable.

**Resolution**:

1. **Fixing Metrics Server**: Restarted and validated the metrics-server deployment:
    
    ```bash
    
    kubectl rollout restart deployment metrics-server -n kube-system
    
    ```
    
2. **HPA Configuration**: Ensured HPA scaled based on CPU utilization:
    
    ```yaml
    
    apiVersion: autoscaling/v2
    kind: HorizontalPodAutoscaler
    spec:
      metrics:
        - type: Resource
          resource:
            name: cpu
            target:
              type: Utilization
              averageUtilization: 70
    
    ```
    
3. **Validating Metrics**: Used `kubectl top pods` to verify metrics availability.
4. **Load Testing**: Simulated traffic to validate autoscaling responsiveness.

**Role of the Components**:

- **AWS Autoscaling**: Scales pods based on metrics.
- **Prometheus/Grafana**: Monitors pod metrics.