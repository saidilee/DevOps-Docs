## Connect with Me

- **YouTube**: [Watch and Learn on YouTube](https://www.youtube.com/@AshokKumar-DevOps)  
- **LinkedIn**: [Connect with me on LinkedIn](https://www.linkedin.com/in/ashokkumar-devops13/)  
- **TopMate**: [Support or Consult on TopMate](https://topmate.io/ashok_kumar)  

## Support This Project

If you find this content helpful:
- **Like** the [YouTube video](https://www.youtube.com/@AshokKumar-DevOps) for more such tutorials.
- **Star** this GitHub repository to get the latest updates.

**Introduction and Fundamentals**

### **What is Kubernetes?**

- **Overview**: Kubernetes is a container orchestration platform for automating deployment, scaling, and operations of application containers.
- **Key Concepts**:
    - **Cluster**: A group of nodes.
    - **Master Node**: Manages the cluster.
    - **Worker Nodes**: Run the application Pods.
    - **Pod**: Smallest deployable unit in Kubernetes, encapsulates containers.

### **Kubernetes Architecture**

Kubernetes is built with a modular architecture designed to manage containerized applications effectively. Below is an overview of its architecture and components:

---

### **1. Kubernetes Cluster**

- A Kubernetes cluster consists of:
    - **Control Plane**: Manages the cluster.
    - **Worker Nodes**: Executes workloads as containers.

---

### **2. Control Plane Components**

The control plane is responsible for maintaining the desired state of the cluster and managing workloads. Its key components include:

### **a. API Server (`kube-apiserver`)**

- **Purpose**: Acts as the entry point for all administrative tasks.
- **Features**:
    - Serves the Kubernetes REST API.
    - Authenticates and validates requests.
    - Updates the `etcd` datastore with the cluster's desired state.

### **b. Cluster Store (`etcd`)**

- **Purpose**: A distributed key-value store that holds all cluster data, including configuration and state.
- **Key Characteristics**:
    - Ensures consistency across the cluster.
    - Highly available and fault-tolerant.

### **c. Controller Manager (`kube-controller-manager`)**

- **Purpose**: Runs multiple controllers to ensure that the cluster state matches the desired state.
- **Controllers Include**:
    - **Node Controller**: Monitors node health.
    - **Replication Controller**: Maintains the correct number of replicas.
    - **Endpoint Controller**: Updates endpoint objects.
    - **Service Account and Token Controllers**: Manages access tokens.

### **d. Scheduler (`kube-scheduler`)**

- **Purpose**: Assigns Pods to Nodes based on resource requirements and constraints.
- **Scheduling Factors**:
    - Resource availability (CPU, memory).
    - Node affinity or anti-affinity rules.
    - Taints and tolerations.

---

### **3. Worker Node Components**

Worker nodes are responsible for running application workloads. Their main components are:

### **a. Kubelet**

- **Purpose**: Acts as the agent on each worker node.
- **Features**:
    - Ensures containers in Pods are running as defined in the PodSpec.
    - Communicates with the API Server.

### **b. Kube-Proxy**

- **Purpose**: Manages network connectivity within and outside the cluster.
- **Features**:
    - Maintains rules for network traffic forwarding.
    - Supports Services by routing requests to appropriate Pods.

### **c. Container Runtime**

- **Purpose**: Responsible for running containers.
- **Examples**:
    - Docker
    - Containerd
    - CRI-O

---

### **4. Kubernetes Objects**

Kubernetes uses objects to represent the desired state of the cluster. Key objects include:

- **Pods**: The smallest deployable unit.
- **Deployments**: Manages stateless applications.
- **StatefulSets**: Manages stateful applications.
- **DaemonSets**: Ensures a copy of a Pod runs on all or specific nodes.
- **Jobs**: Executes one-time tasks.
- **Services**: Provides stable networking for Pods.

---

### **5. Networking in Kubernetes**

- **CNI (Container Network Interface)**:
    - Provides networking plugins (e.g., Calico, Flannel).
- **Cluster Networking**:
    - Ensures communication between Pods, services, and external clients.

---

### **6. Add-ons**

- Additional tools for cluster functionality:
    - **DNS**: CoreDNS for internal service discovery.
    - **Monitoring**: Prometheus and Grafana.
    - **Ingress Controller**: Manages external HTTP/S traffic.
    

### **Setting up Kubernetes**

### **Pre-requisite:**

Install Docker

```bash
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

**Install Minikube**:

- Install Minikube:

```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

```

- Start Minikube:
    
    ```bash
    
    sudo usermod -aG docker $USER && newgrp docker
    
    minikube start
    
    ```
    
1. **Install kubectl**:
    - Download and install:
        
        ```bash
        
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
           
        
        echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
        
        sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
        
        chmod +x kubectl
        mkdir -p ~/.local/bin
        mv ./kubectl ~/.local/bin/kubectl
        
        kubectl version --client
        ```
        
    - Verify installation:
        
        ```bash
        kubectl version --client
        
        ```
        

### **Running Your First Pod**

- Create a simple Pod:
    
    ```bash
    
    kubectl run nginx --image=nginx --port=80
    
    ```
    
- Check Pod status:
    
    ```bash
    
    kubectl get pods
    
    ```
    
- Access Pod logs:
    
    ```bash
    
    kubectl logs <pod-name>
    
    ```
    

---

### Namespaces

**Namespaces** are a way to organize and isolate resources within a Kubernetes cluster. They are virtual clusters backed by the same physical cluster, useful for multi-tenant environments or managing different environments like dev, test, and prod.

### Key Features:

1. **Resource Isolation**: Separate environments within the same cluster.
2. **Efficient Management**: Allows grouping of resources like pods, services, and deployments.
3. **Scoped Resource Access**: Role-based access control (RBAC) can be applied per namespace.

### Predefined Namespaces:

1. **`default`**: Used when no other namespace is specified.
2. **`kube-system`**: For system-level resources like the API server and scheduler.
3. **`kube-public`**: Public resources accessible to all users.
4. **`kube-node-lease`**: Manages node lease objects.

### Example YAML:

```yaml

apiVersion: v1
kind: Namespace
metadata:
  name: dev-environment

```

### **Deployments**

- Create a Deployment YAML file:
    
    ```yaml
    
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: nginx-deployment
      namespace: my-namespace
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: nginx
      template:
        metadata:
          labels:
            app: nginx
        spec:
          containers:
          - name: nginx
            image: nginx:1.19.0
            ports:
            - containerPort: 80
    
    ```
    

Apply the Deployment:

```bash

kubectl apply -f deployment.yaml
```

### **ReplicaSet (Load Balancing and Scaling)**

A **ReplicaSet** in kubernetes ensures that a specified number of pod replicas are running at any given time. It's primarily responsible for maintaining the desired state of your application by monitoring pods and replacing any that fail.

### Key Features:

1. **Ensures High Availability**: Maintains the desired number of replicas of a pod to ensure reliability and fault tolerance.
2. **Self-Healing**: Automatically creates new pods if existing ones fail.
3. **Declarative Management**: Desired state is defined in YAML/JSON configuration.

```yaml

apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: my-replicaset
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-container
        image: nginx
```

Kubectl scale —replicas=6 -f replicaset.yaml

### Services

### 1. **ClusterIP (Default Service Type)**

- **Purpose**: Exposes the service to other resources **inside the cluster**.
- **Use Case**: Internal communication between pods.
- **Details**:
    - Creates a virtual IP address within the cluster.
    - Cannot be accessed from outside the cluster.
- **Example**:
    
    ```yaml
    
    apiVersion: v1
    kind: Service
    metadata:
      name: my-service
    spec:
      selector:
        app: my-app
      ports:
      - protocol: TCP
        port: 80
        targetPort: 8080
      type: ClusterIP
    
    ```
    

---

### 2. **NodePort**

- **Purpose**: Exposes the service to the **external network** by opening a specific port on each node.
- **Use Case**: Direct access to a service from outside the cluster, useful for development or debugging.
- **Details**:
    - Maps a port (e.g., 30000–32767) on each node to the service.
    - Not ideal for production due to limited load balancing capabilities.
- **Example**:
    
    ```yaml
    
    apiVersion: v1
    kind: Service
    metadata:
      name: my-service
    spec:
      selector:
        app: my-app
      ports:
      - protocol: TCP
        port: 80
        targetPort: 8080
        nodePort: 30007
      type: NodePort
    
    ```
    

---

### 3. **LoadBalancer**

- **Purpose**: Exposes the service to the **internet** through a cloud provider's load balancer.
- **Use Case**: Production services that need external traffic routing.
- **Details**:
    - Creates a cloud-based load balancer (e.g., AWS ELB, GCP Load Balancer).
    - Allocates a public IP and routes traffic to the service.
- **Example**:
    
    ```yaml
    
    apiVersion: v1
    kind: Service
    metadata:
      name: my-service
    spec:
      selector:
        app: my-app
      ports:
      - protocol: TCP
        port: 80
        targetPort: 8080
      type: LoadBalancer
    
    ```
    
1. Apply the Service:
    
    ```bash
    
    kubectl apply -f service.yaml
    
    ```
    
2. Check the Service:
    
    ```bash
    
    kubectl get services
    
    ```
    

### **ConfigMaps and Secrets**

A **ConfigMap** is used to store non-sensitive configuration data in key-value pairs. It allows you to decouple configuration artifacts from your container images and make them available for use by your applications running in Kubernetes.

### **Use Cases**:

- Store environment variables (e.g., `DATABASE_URL`, `API_KEY`).
- Store configuration files (e.g., YAML, JSON) that your applications need to read.
- Provide configuration data to pods at runtime, which can be consumed by applications in different ways (e.g., environment variables, files, command-line arguments).

### **Creating a ConfigMap**:

You can create a ConfigMap either by using a YAML file or directly via the `kubectl` command.

### **1.1. Create ConfigMap from a File**:

For example, you can create a ConfigMap from a configuration file:

```bash

kubectl create configmap my-config --from-file=config-file.txt
```

### **1.2. Create ConfigMap from Key-Value Pairs**:

Alternatively, you can create a ConfigMap from literal key-value pairs:

```bash

kubectl create configmap my-config --from-literal=key1=value1 --from-literal=key2=value2
```

### **1.3. ConfigMap YAML Example**:

Here’s an example of a ConfigMap defined in a YAML file:

```yaml

apiVersion: v1
kind: ConfigMap
metadata:
  name: my-config
data:
  key1: value1
  key2: value2
  database_url: http://100.1.1.20
```

You can then apply this configuration:

```bash

kubectl apply -f configmap.yaml
```

### **Using ConfigMap in Pods**:

- **As Environment Variables**:
You can reference a ConfigMap's keys as environment variables in your Pod definition:
    
    ```yaml
    
    apiVersion: v1
    kind: Pod
    metadata:
      name: my-pod
    spec:
      containers:
      - name: my-container
        image: my-image
        envFrom:
        - configMapRef:
            name: my-config
    
    ```
    
- **As Files in a Volume**:
You can mount a ConfigMap as a volume to make its data available as files:
    
    ```yaml
    yaml
    Copy code
    apiVersion: v1
    kind: Pod
    metadata:
      name: my-pod
    spec:
      containers:
      - name: my-container
        image: my-image
        volumeMounts:
        - name: config-volume
          mountPath: /etc/config
      volumes:
      - name: config-volume
        configMap:
          name: my-config
    ```
    

---

### **2. Secrets**

A **Secret** is used to store sensitive data, such as passwords, OAuth tokens, SSH keys, etc. Unlike ConfigMaps, Secrets are specifically designed to store and manage sensitive information and are encoded in Base64 format (although Kubernetes also supports encryption at rest for enhanced security).

### **Use Cases**:

- Store sensitive data like database credentials, API keys, certificates, etc.
- Avoid hardcoding sensitive information in application code or configuration files.
- Ensure that sensitive information is securely stored and transmitted within the Kubernetes cluster.

### **Creating a Secret**:

You can create Secrets in several ways, including from literal values, files, or directories.

### **2.1. Create Secret from Literal Key-Value Pairs**:

```bash

kubectl create secret generic my-secret --from-literal=username=admin --from-literal=password=secretpass
```

### **2.2. Create Secret from Files**:

You can create a Secret from files, where the file's contents are used as the Secret's value:

```bash
kubectl create secret generic my-secret --from-file=ssh-privatekey=./ssh/id_rsa --from-file=ssh-publickey=./ssh/id_rsa.pub
```

### **2.3. Secret YAML Example**:

Here’s an example of a Secret defined in a YAML file:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-secret
type: Opaque
data:
  username: YWRtaW4=  # Base64 encoded value of "admin"
  password: c2VjcmV0cGFzcw==  # Base64 encoded value of "secretpass"
```

You can apply this configuration:

```bash

kubectl apply -f secret.yaml
```

### **Using Secrets in Pods**:

Secrets can be used in Pods either as environment variables or mounted as volumes.

- **As Environment Variables**:
You can reference a Secret as environment variables in your Pod definition:
    
    ```yaml
    
    apiVersion: v1
    kind: Pod
    metadata:
      name: my-pod
    spec:
      containers:
      - name: my-container
        image: my-image
        envFrom:
        - secretRef:
            name: my-secret
    ```
    
- **As Files in a Volume**:
You can mount a Secret as a volume, which makes it available as files inside the container:
    
    ```yaml
    
    apiVersion: v1
    kind: Pod
    metadata:
      name: my-pod
    spec:
      containers:
      - name: my-container
        image: my-image
        volumeMounts:
        - name: secret-volume
          mountPath: /etc/secrets
      volumes:
      - name: secret-volume
        secret:
          secretName: my-secret
    ```
    

---

### **Labels and Selectors in Kubernetes**

### **Labels**

Labels are metadata applied to Kubernetes objects.

Example YAML file for a Pod with labels:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-app-pod
  labels:
    app: my-app
    env: production
    tier: backend
spec:
  containers:
  - name: my-container
    image: nginx
```

In this example:

- The pod is labeled with three key-value pairs:
    - `app: my-app`
    - `env: production`
    - `tier: backend`

---

**Selectors**

Selectors query Kubernetes objects by matching their labels.

**1. Using a Selector in a Service**
The service targets the Pod labeled `app: my-app`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-app-service
spec:
  selector:
    app: my-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80

```

Here:

- The selector `app: my-app` ensures the service routes traffic to the pod(s) labeled `app: my-app`.

---

**2. Using a Selector in a Deployment**
The deployment manages Pods that match the selector.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-container
        image: nginx

```

## Storage:

### **1. Persistent Volumes (PV)**

**Concept:**

A PV is a piece of storage in the cluster provisioned by an administrator or dynamically provisioned using StorageClasses. It is independent of the pod lifecycle.

**Example:**

- **Scenario:** An ecommerce platform like Amazon stores product images. These images need to persist even if the pods handling product pages are rescheduled.
- **YAML Example:**

```yaml

apiVersion: v1
kind: PersistentVolume
metadata:
  name: product-images-pv
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: "/mnt/data/product-images
```

---

### **2. Persistent Volume Claims (PVC)**

**Concept:**

A PVC is a request for storage by a user. It claims a PV to use for a pod.

**Example:**

- **Scenario:** The product page service needs to read and write product images stored in a PV.
- **YAML Example:**

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: product-images-pvc
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 5Gi
```

---

### **3. Linking PV and PVC**

**Concept:**

A PVC binds to a PV that matches its requirements, and pods use the PVC as a storage volume.

**Example:**

- **Scenario:** Pods serving product pages can now use the claimed storage.
- **YAML Example (Pod):**

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: product-page
spec:
  containers:
    - name: product-container
      image: nginx
      volumeMounts:
        - mountPath: "/usr/share/nginx/html/images"
          name: product-images-storage
  volumes:
    - name: product-images-storage
      persistentVolumeClaim:
        claimName: product-images-pvc
```

---

### **4. Taints**

**Concept:**

Taints are applied to nodes to repel certain pods unless the pods have tolerations.

**Example:**

- **Scenario:** A high-performance node is designated for database workloads (e.g., handling order transactions). You taint it to ensure only relevant pods are scheduled there.
- **YAML Example:**

```
kubectl taint nodes node1 env=prod:NoSchedule
```

---

### **5. Tolerations**

**Concept:**

Tolerations are applied to pods to allow them to be scheduled on tainted nodes.

**Example:**

- **Scenario:** A MySQL pod that handles transactions tolerates the taint on the database node.
- **YAML Example (Pod with Toleration):**

```yaml

apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  tolerations:
    - key: "env"
      operator: "Equal"
      value: "prod"
      effect: "NoSchedule"
  containers:
    - name: nginx
      image: nginx
```

---

### **6. Combining PV, PVC, Taints, and Tolerations**

**Example:**

- **Scenario:**  The inventory database (MySQL) runs on a node dedicated to databases. The MySQL pod stores data in a PV claimed by a PVC and tolerates the taint on the database node.
- **YAML Example:**

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: inventory-db-pv
spec:
  capacity:
    storage: 20Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: "/mnt/data/inventory-db"
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: inventory-db-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 20Gi
---
apiVersion: v1
kind: Pod
metadata:
  name: inventory-db
spec:
  tolerations:
    - key: "db-key"
      operator: "Equal"
      value: "database"
      effect: "NoSchedule"
  containers:
    - name: nginx
      image: nginx
      volumeMounts:
        - mountPath: "/var/lib/nginx"
          name: nginx
  volumes:
    - name: db-storage
      persistentVolumeClaim:
        claimName: inventory-db-pvc
```

### StatefulSet and DaemonSet in Kubernetes

---

### **1. StatefulSet**

**Concept:**

StatefulSet is used for managing stateful applications that require unique identities, persistent storage, and consistent network identities across restarts. It ensures that pods are created in a defined order and maintain stable hostnames.

---

**Key Features:**

1. **Stable Pod Names:** Pods are named in the format `<statefulset-name>-<ordinal>`.
2. **Ordered Deployment and Scaling:** Pods are created or terminated sequentially.
3. **Persistent Storage:** Each pod gets a dedicated PersistentVolume (PV) that persists across restarts.
4. **Network Identity:** Each pod gets a consistent DNS name.

---

**Use Case:**

- Running a **database cluster**, like MySQL, PostgreSQL, or a distributed system such as Kafka or Elasticsearch.

---

**Example :**

- **Scenario:** You run a **user session service** that must persist data about logged-in users. Each user session is stored in a database like Cassandra, where each pod in the StatefulSet manages a shard of the data.

**YAML Example for StatefulSet:**

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: stateful-app
spec:
  serviceName: "stateful-service"
  replicas: 3
  selector:
    matchLabels:
      app: stateful-app
  template:
    metadata:
      labels:
        app: stateful-app
    spec:
      containers:
      - name: web
        image: nginx
        volumeMounts:
        - name: data
          mountPath: /usr/share/nginx/html
  volumeClaimTemplates:
  - metadata:
      name: data
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 1Gi

```

---

### **2. DaemonSet**

**Concept:**

DaemonSet ensures that a specific pod is running on **every node** (or a subset of nodes based on selectors). It’s ideal for node-level services.

---

**Key Features:**

1. **Node-Specific Deployments:** Runs one pod per node.
2. **Automatic Addition to New Nodes:** Automatically deploys pods when new nodes are added to the cluster.
3. **Use for Node Management Tasks:** Typically used for logging, monitoring, or system-level tasks.

---

**Use Case:**

- Running **log collection agents** (like Fluentd or Filebeat), monitoring agents (like Prometheus Node Exporter), or networking tasks.

---

**Example :**

- **Scenario:** On your ecommerce platform, you collect **server logs** from all nodes using a tool like Fluentd and send them to a centralized logging service for analysis.

**YAML Example for DaemonSet:**

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: daemonset-example
spec:
  selector:
    matchLabels:
      app: logging-agent
  template:
    metadata:
      labels:
        app: logging-agent
    spec:
      containers:
      - name: logging-agent
        image: fluentd
```

### **Role-Based Access Control (RBAC)**

RBAC is a mechanism to manage access to resources in Kubernetes based on roles. It ensures only authorized users and services can perform specific actions.

### **Key RBAC Concepts**

1. **Role**:
    - Defines permissions within a specific namespace.
    - Example:
        
        ```yaml
        
        apiVersion: rbac.authorization.k8s.io/v1
        kind: Role
        metadata:
          namespace: default
          name: pod-reader
        rules:
        - apiGroups: [""]  # "" means the core API group
          resources: ["pods"]
          verbs: ["get", "list", "watch"]
        
        ```
        
2. **ClusterRole**:
    - Similar to `Role` but applies cluster-wide or to all namespaces.
    - Example:
        
        ```yaml
        
        apiVersion: rbac.authorization.k8s.io/v1
        kind: ClusterRole
        metadata:
          name: node-reader
        rules:
        - apiGroups: [""]
          resources: ["nodes"]
          verbs: ["get", "list", "watch"]
        
        ```
        
3. **RoleBinding**:
    - Binds a `Role` to a user, group, or service account within a namespace.
    - Example:
        
        ```yaml
        
        apiVersion: rbac.authorization.k8s.io/v1
        kind: RoleBinding
        metadata:
          name: read-pods
          namespace: default
        subjects:
        - kind: User
          name: jane
        - kind: demo-user
          name: james
        roleRef:
          kind: Role
          name: pod-reader
          apiGroup: rbac.authorization.k8s.io
        
        ```
        
4. **ClusterRoleBinding**:
    - Binds a `ClusterRole` to a user, group, or service account at the cluster level.
    - Example:
        
        ```yaml
        
        apiVersion: rbac.authorization.k8s.io/v1
        kind: ClusterRoleBinding
        metadata:
          name: read-nodes
        subjects:
        - kind: Group
          name: devs
        roleRef:
          kind: ClusterRole
          name: node-reader
          apiGroup: rbac.authorization.k8s.io
        ```
        
        ### **Kubernetes Security Best Practices**
        
        ### **1. Network Policies**
        
        - Control traffic between pods and external endpoints using `NetworkPolicy`.
        - Example:
            
            ```yaml
            
            apiVersion: networking.k8s.io/v1
            kind: NetworkPolicy
            metadata:
              name: deny-all
              namespace: default
            spec:
              podSelector: {}  # Select all pods
              policyTypes:
              - Ingress
              - Egress
            
            ```
            
        
        ### **2. Pod Security Standards (PSS)**
        
        - Enforce security settings for pods (e.g., preventing privilege escalation, running as root).
        - Use Admission Controllers like `PodSecurity` or tools like `OPA Gatekeeper` for enforcement.
        
        ### **3. Secrets and ConfigMaps**
        
        - Store sensitive data like passwords or API tokens securely.
        - Example secret:
            
            ```yaml
            
            apiVersion: v1
            kind: Secret
            metadata:
              name: db-credentials
            type: Opaque
            data:
              username: bXl1c2Vy  # base64 encoded
              password: cGFzc3dvcmQ=  # base64 encoded
            
            ```
            
        
        ### **4. Securing Service Accounts**
        
        - Use service accounts for pod communication with the API server.
        - Restrict the permissions of service accounts using RBAC.
        
        ### **5. API Server Authentication and Authorization**
        
        - **Authentication**: Ensure users authenticate using tokens, certificates, or external identity providers.
        - **Authorization**: Use RBAC or other mechanisms to enforce permissions.
        
        ### **6. Image Security**
        
        - Scan images for vulnerabilities using tools like Trivy, Clair, or Docker's built-in security tools.
        - Use signed images and private registries.
        
        ### **7. Node Security**
        
        - Restrict access to nodes and kubelet APIs.
        - Run minimal base images and apply patches regularly.
        
        ### **8. Enforce Resource Limits**
        
        - Prevent resource overuse or abuse using `ResourceQuota` and `LimitRange`.
        - Example:
            
            ```yaml
            
            apiVersion: v1
            kind: LimitRange
            metadata:
              name: pod-limits
              namespace: default
            spec:
              limits:
              - type: Container
                max:
                  memory: "1Gi"
                  cpu: "500m"
                min:
                  memory: "256Mi"
                  cpu: "100m"
            
            ```
