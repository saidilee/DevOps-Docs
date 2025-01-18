## Kubernetes (K8s)

### **Q: Explain how to perform zero-downtime deployments in Kubernetes.**

**A:** Use rolling updates with `kubectl set image` or update the `Deployment` manifest to specify a new image. Kubernetes will gradually update Pods, ensuring at least one pod is available at all times by managing the `maxUnavailable` and `maxSurge` settings.

```jsx
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
      maxSurge: 1
  template:
    spec:
      containers:
      - name: my-container
        image: my-app:v2

```

### **Q: How do you troubleshoot CrashLoopBackOff errors?**

**A:** Steps to troubleshoot:

- Check the Pod's logs using `kubectl logs <pod-name>`.
- Use `kubectl describe pod <pod-name>` to review events and error messages.
- Validate readiness and liveness probes configuration.
- Ensure correct configurations for environment variables, secrets, and dependencies.

```jsx
kubectl logs <pod-name>
kubectl describe pod <pod-name>

```

### **Q: What is a Kubernetes StatefulSet, and when do you use it?**

**A:** StatefulSet manages stateful applications with stable, unique network identities and persistent storage. Use it for databases or services requiring ordered deployment and scaling, like Cassandra or Kafka.

```jsx
apiVersion: apps/v1
kind: StatefulSet
metadata:
name: kafka
spec:
serviceName: "kafka-service"
replicas: 3
```

### **Q: How would you manage node failures in Kubernetes?**

**A:** Use `PodDisruptionBudget` to control voluntary disruptions. Kubernetes automatically handles node failures by scheduling Pods on available nodes, but readiness/liveness probes, node affinity, and taints/tolerations ensure reliability and correct Pod placement.

```jsx
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: pdb-example
spec:
  minAvailable: 1
  selector:
    matchLabels:
      app: my-app

```

### **Q: What are Taints and Tolerations?**

**A:** Taints allow a node to repel specific Pods, while Tolerations allow Pods to be scheduled on nodes with matching taints.

```jsx
kubectl taint nodes node1 key=value:NoSchedule

tolerations:
- key: "key"
  operator: "Equal"
  value: "value"
  effect: "NoSchedule"

```

---

## Ansible

### **Q: How do you handle dynamic inventory in Ansible?**

**A:** Use dynamic inventory scripts or plugins, such as the AWS EC2 plugin (`ec2.yaml`). Configure it in `ansible.cfg` to fetch host details dynamically.

```yaml
plugin: aws_ec2
regions:
  - us-east-1

```

### **Q: Explain the difference between `ansible-playbook` and `ansible ad-hoc` commands.**

**A:** `ansible ad-hoc` is for single-task commands, while `ansible-playbook` executes a series of tasks defined in a playbook.

### **Q: How would you optimize Ansible performance for large-scale deployments?**

**A:**

- Use `forks` to increase parallelism.
- Reduce facts gathering with `gather_facts: no`.
- Enable pipelining in `ansible.cfg`.

```yaml
[defaults]
forks = 20
pipelining = True
gather_facts = False

```

---

### Docker

### **Q: How do you handle Docker container storage management?**

**A:** Use Docker volumes or bind mounts for persistent storage. Volumes are managed by Docker, while bind mounts link to host directories.

### **Q: What is the difference between a bind mount and a volume?**

**A:** Volumes are managed by Docker and stored in `/var/lib/docker/volumes`. Bind mounts reference specific host paths, providing more control but less portability.

```yaml
docker run -v myvolume:/data myimage

docker run -v /host/path:/container/path myimage

```

### **Q: Explain multi-stage builds in Docker.**

**A:** Multi-stage builds reduce image size by copying artifacts from one stage to another. Example:

```

FROM golang:1.16 as builder
WORKDIR /app
RUN go build -o main .

FROM alpine:latest
COPY --from=builder /app/main .
ENTRYPOINT ["./main"]

```

---

## Terraform

### **Q: How do you manage secrets in Terraform?**

**A:** Use AWS Secrets Manager or Azure Key Vault for storing secrets, referencing them via data blocks or environment variables.

```yaml
data "aws_secretsmanager_secret" "example" {
  name = "my-secret"
}

```

### **Q: Explain Terraform state file locking.**

**A:** Locking prevents concurrent modifications. Use `dynamodb` with AWS or `GCS` locking for Google Cloud to avoid state corruption.

```yaml
backend "s3" {
  bucket         = "my-terraform-state"
  key            = "terraform.tfstate"
  region         = "us-east-1"
  dynamodb_table = "terraform-lock"
}

```

### **Q: How do you perform blue-green deployments with Terraform?**

**A:** Create separate resources for both environments and switch traffic using DNS or load balancers. Automate cleanup of old resources.

### **Q: How would you write a module in Terraform?**

**A:** Define reusable infrastructure code in a `main.tf` file within a module directory, using input variables and outputs.

```yaml
module "vpc" {
  source = "./vpc"
}

```

---

## AWS

### **Q: How do you design a highly available architecture in AWS?**

**A:** Use multi-AZ deployments for RDS, load balancing across multiple AZs, and auto-scaling groups.

### **Q: What is the difference between an Internet Gateway and a NAT Gateway?**

**A:** Internet Gateway allows public access, while NAT Gateway enables private subnet instances to access the internet without inbound access.

### **Q: How do you secure an S3 bucket?**

**A:** Apply bucket policies, enable encryption (SSE-S3 or SSE-KMS), use IAM roles, and disable public access by default.

```yaml
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Deny",
    "Principal": "*",
    "Action": "s3:*",
    "Resource": ["arn:aws:s3:::mybucket/*"]
  }]
}
```

### **Q: Explain AWS Auto Scaling policies.**

**A:** Policies can be based on target tracking, step scaling, or simple scaling. Use CloudWatch metrics for dynamic scaling decisions.

---

## Scripting

### **Q: Write a script to find the top 10 processes consuming memory in Linux.**

```bash

#!/bin/bash
ps aux --sort=-%mem | awk 'NR<=10{print $0}'

```

---

## Jenkins

### **Q: Explain multibranch pipeline configuration in Jenkins.**

**A:** Use the multibranch pipeline plugin, which automatically discovers branches in a source control repository, creates jobs, and runs Jenkinsfiles for each branch.

### **Q: How do you implement parameterized builds in Jenkins?**

**A:** Configure build parameters in the job configuration. Use `parameters` in `Jenkinsfile` for scripted pipelines:

```groovy

parameters {
    string(name: 'BRANCH', defaultValue: 'main', description: 'Branch to build')
}

```

---

## Monitoring (Prometheus and Grafana)

### **Q: How do you set up alerts in Prometheus?**

**A:** Define alerting rules in a `prometheus.rules.yml` file and configure Alertmanager for notifications.

```yaml
Prometheus Alert Rule:

groups:
- name: example
  rules:
  - alert: HighCPUUsage
    expr: cpu_usage > 80

```

### **Q: How does Grafana connect to Prometheus?**

**A:** Add Prometheus as a data source in Grafana by providing its URL and access settings.

```yaml
http://localhost:9090

```

### **Q: Explain the use of recording rules in Prometheus.**

**A:** Recording rules precompute query results, storing them as time series to improve dashboard performance.

```yaml
record: job:cpu_usage:avg
expr: avg by(job) (cpu_usage)

```