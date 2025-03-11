## **1) Performance Issue in Kubernetes Cluster**

### **Step 1: Check Overall Cluster Health**

- Run: `kubectl get nodes` → Ensure all nodes are in **Ready** state.
- Run: `kubectl get pods --all-namespaces` → Look for pods stuck in **Pending/CrashLoopBackOff/OOMKilled**.

### **Step 2: Check Resource Usage**

- Run: `kubectl top nodes` → See if CPU/memory usage is high.
- Run: `kubectl top pods --all-namespaces` → Identify high-resource-consuming pods.

### **Step 3: Investigate Problematic Pods**

- Run: `kubectl describe pod <pod-name> -n <namespace>` → Check events for errors (OOMKilled, scheduling failures, etc.).
- Run: `kubectl logs <pod-name> -n <namespace>` → Look for errors in application logs.

### **Step 4: Check Network & Storage Bottlenecks**

- Run: `kubectl get svc -A` → Verify if services are reachable.
- Run: `kubectl get pvc -A` → Check if storage is **Bound** or facing issues.

### **Step 5: Check Control Plane Health**

- Run: `kubectl get componentstatuses` (Deprecated) OR `kubectl get --raw='/readyz'` → Ensure **API server, scheduler, and controller-manager** are healthy.

### **Step 6: Check Node and System Logs**

- Run: `journalctl -u kubelet -f` → Check **Kubelet logs**.
- Run: `dmesg | tail -50` → Look for **kernel errors or resource exhaustion**.

---

## **2) Node Issue in Kubernetes**

### **Step 1: Check Node Status**

- Run: `kubectl get nodes` → Look for nodes in **NotReady** state.
- Run: `kubectl describe node <node-name>` → Look for **taints, disk pressure, memory pressure, network issues**.

### **Step 2: Check System Resources**

- Run: `top` or `htop` → See if **CPU/memory is exhausted**.
- Run: `df -h` → Check if the **disk is full**.

### **Step 3: Check Kubelet & System Logs**

- Run: `systemctl status kubelet -l` → See if the kubelet service is running.
- Run: `journalctl -u kubelet -f` → Look for kubelet errors.

### **Step 4: Restart Node Services (If Required)**

- Run: `systemctl restart kubelet` → Restart kubelet.
- Run: `systemctl restart docker/containerd` → Restart container runtime.

### **Step 5: Check Network Connectivity**

- Run: `ping <master-node-IP>` → Ensure the node can reach the master.
- Run: `kubectl get pods -A -o wide | grep <node-name>` → Check which pods are running on the node.

---

## **3) Docker Build Issue**

### **Step 1: Check Dockerfile for Syntax Errors**

- Ensure `FROM`, `RUN`, `COPY`, `CMD` instructions are correct.
- Try running each command manually in a container.

### **Step 2: Check Logs for Errors**

- Run: `docker build -t <image-name> .` → Look for **errors in output**.

### **Step 3: Ensure Dependencies Exist**

- Verify if required files (`requirements.txt`, `package.json`, etc.) exist.
- Run: `docker context inspect` → Ensure the correct Docker context is being used.

### **Step 4: Check Docker Daemon**

- Run: `systemctl status docker` → Ensure Docker is running.
- Run: `docker info` → Check for daemon errors.

### **Step 5: Check Network Issues (If Pulling Images Fails)**

- Run: `docker pull ubuntu` → If it fails, check network or DNS issues.
- Run: `ping google.com` → Verify connectivity.

---

## **4) Terraform Deploy Issue**

### **Step 1: Validate Configuration**

- Run: `terraform validate` → Ensure Terraform syntax is correct.
- Run: `terraform fmt` → Format configuration files properly.

### **Step 2: Check Plan Output**

- Run: `terraform plan` → See what Terraform is trying to change.
- Look for **resource conflicts, missing variables, or dependencies**.

### **Step 3: Check Terraform State**

- Run: `terraform state list` → See current resources.
- Run: `terraform refresh` → Sync state with actual infrastructure.

### **Step 4: Check Provider Authentication & Permissions**

- AWS: Run `aws sts get-caller-identity` → Ensure credentials are valid.
- GCP: Run `gcloud auth list` → Verify authentication.

### **Step 5: Debug with Logs**

- Run: `TF_LOG=DEBUG terraform apply` → Enable detailed logs.

---

## **5) Docker Performance Issue**

### **Step 1: Check Running Containers & Resource Usage**

- Run: `docker ps` → See running containers.
- Run: `docker stats` → Identify containers using high CPU/memory.

### **Step 2: Check Disk Usage**

- Run: `docker system df` → See disk space used by Docker.
- Run: `docker system prune -a` → Remove unused images and containers (use with caution).

### **Step 3: Check Storage Driver**

- Run: `docker info | grep "Storage Driver"` → Ensure correct storage driver is used.

### **Step 4: Check Network Performance**

- Run: `docker network ls` → See existing networks.
- Run: `docker network inspect <network-name>` → Check for misconfigurations.

### **Step 5: Restart Docker Service**

- Run: `systemctl restart docker` → Restart Docker if issues persist.

---

## **6) Terraform Performance Issue**

### **Step 1: Identify Bottlenecks in Apply Process**

- Run: `terraform plan -parallelism=10` → Reduce parallelism if needed.
- Check if the issue is with API rate limits (e.g., AWS/GCP throttling).

### **Step 2: Optimize State Management**

- Run: `terraform state list` → Ensure the state file isn't too large.
- Use **remote backend** (S3, GCS, etc.) instead of local state files.

### **Step 3: Improve Module & Resource Dependencies**

- Avoid `depends_on` where possible.
- Refactor modules to run smaller, independent deployments.

### **Step 4: Check Infrastructure Limits**

- AWS: Run `aws service-quotas list-service-quotas --service-code <service>` to check limits.
- GCP: Run `gcloud compute project-info describe` to check quotas.

### **Step 5: Enable Debug Logging**

- Run: `TF_LOG=TRACE terraform apply` → See detailed execution logs.

## **7) Pod Stuck in `Pending` State (Kubernetes)**

### **Step 1: Check Pod Status**

- Run: `kubectl get pods -A` → Look for pods in **Pending** state.

### **Step 2: Check Events and Describe Pod**

- Run: `kubectl describe pod <pod-name> -n <namespace>` → Look for scheduling failures.

### **Step 3: Check Node Availability**

- Run: `kubectl get nodes` → Ensure nodes are in **Ready** state.

### **Step 4: Check Resource Requests & Limits**

- Run: `kubectl describe node <node-name>` → Look for **memory/CPU pressure**.
- If **resource requests** are too high, edit the deployment and reduce them.

### **Step 5: Check Storage & Network Issues**

- Run: `kubectl get pvc -A` → See if Persistent Volumes are bound.
- Run: `kubectl get svc -A` → Ensure services are properly configured.

---

## **8) Kubernetes Service Not Accessible**

### **Step 1: Check if Service is Running**

- Run: `kubectl get svc -A` → Verify if the service exists.

### **Step 2: Check Endpoints**

- Run: `kubectl get endpoints <service-name> -n <namespace>` → See if endpoints exist.

### **Step 3: Check Pod Connectivity**

- Run: `kubectl exec -it <pod-name> -- curl <service-name>:<port>` → Test connectivity.

### **Step 4: Check Network Policies & Firewalls**

- Run: `kubectl get networkpolicy -A` → See if network policies are blocking traffic.
- Check cloud provider firewall rules (e.g., AWS Security Groups).

---

## **9) Kubernetes Ingress Not Working**

### **Step 1: Check Ingress Rules**

- Run: `kubectl get ingress -A` → Ensure ingress exists.
- Run: `kubectl describe ingress <ingress-name> -n <namespace>` → Check for misconfigurations.

### **Step 2: Verify Ingress Controller is Running**

- Run: `kubectl get pods -A | grep ingress` → Ensure the controller pod is running.

### **Step 3: Check DNS Resolution**

- Run: `nslookup <ingress-host>` → Ensure it resolves to the correct IP.

### **Step 4: Check TLS Certificates (If Using HTTPS)**

- Run: `kubectl get secret -A` → Ensure SSL certificates exist.
- Check if cert-manager logs show errors: `kubectl logs -l app=cert-manager -n cert-manager`.

---

## **10) CI/CD Pipeline Failure in Jenkins**

### **Step 1: Check Jenkins Job Logs**

- Go to **Jenkins Dashboard** → **Click Job** → **View Console Output**.

### **Step 2: Check Jenkins Agent Status**

- Run: `kubectl get pods -A | grep jenkins` (if running in Kubernetes).
- Run: `systemctl status jenkins` (if running on a server).

### **Step 3: Check SCM Webhook & Credentials**

- Ensure GitHub/GitLab webhook is correctly configured.
- Run: `git clone <repo-url>` on the Jenkins agent to check authentication.

### **Step 4: Restart Jenkins if Necessary**

- Run: `systemctl restart jenkins` (Linux).
- Run: `docker restart <jenkins-container>` (Docker).

---

## **11) AWS EC2 Instance Not Accessible**

### **Step 1: Check Instance Status**

- Run: `aws ec2 describe-instances --instance-ids <instance-id>` → Ensure it’s **running**.

### **Step 2: Verify SSH Connectivity**

- Run: `ssh -i <key.pem> ec2-user@<instance-ip>` → Ensure the key is correct.

### **Step 3: Check Security Groups & Network ACLs**

- Run: `aws ec2 describe-security-groups --group-ids <sg-id>` → Verify port **22** is open.

### **Step 4: Restart the Instance (If Needed)**

- Run: `aws ec2 reboot-instances --instance-ids <instance-id>`.

---

## **12) AWS S3 Bucket Access Denied**

### **Step 1: Check IAM Permissions**

- Run: `aws s3 ls s3://<bucket-name>` → If access denied, check IAM role.

### **Step 2: Check Bucket Policy**

- Run: `aws s3api get-bucket-policy --bucket <bucket-name>` → See if public access is restricted.

### **Step 3: Check Block Public Access Settings**

- Run: `aws s3api get-public-access-block --bucket <bucket-name>`.

### **Step 4: Check AWS KMS Encryption (If Enabled)**

- Ensure the IAM user has `kms:Decrypt` permissions.

---

## **13) High Load on Kubernetes API Server**

### **Step 1: Check API Server Metrics**

- Run: `kubectl get --raw='/metrics' | grep apiserver_request` → Look for excessive API requests.

### **Step 2: Identify High-Usage Workloads**

- Run: `kubectl top pods -A` → Find CPU-heavy pods.

### **Step 3: Restart API Server (If Needed)**

- Restart the control plane node (for self-managed Kubernetes).
- Restart `kube-apiserver` in managed environments.

---

## **14) Docker Container Exiting Immediately (`CrashLoopBackOff`)**

### **Step 1: Check Container Logs**

- Run: `docker logs <container-id>` → Look for errors.

### **Step 2: Check Exit Code**

- Run: `docker inspect <container-id> --format='{{.State.ExitCode}}'`.

### **Step 3: Run Container in Debug Mode**

- Run: `docker run -it --entrypoint /bin/bash <image-name>`.

### **Step 4: Fix Issues and Restart**

- Ensure all dependencies are installed inside the container.
- Restart with `docker restart <container-id>`.

---

## **15) Kubernetes PVC Stuck in `Pending` State**

### **Step 1: Check PVC Status**

- Run: `kubectl get pvc -A` → Look for `Pending` status.

### **Step 2: Describe PVC**

- Run: `kubectl describe pvc <pvc-name>` → Check for events/errors.

### **Step 3: Verify StorageClass Exists**

- Run: `kubectl get sc` → Ensure the correct storage class exists.

### **Step 4: Check Node Disk Space**

- Run: `df -h` → Ensure enough disk space is available.