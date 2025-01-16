# TOP Docker Interview Questions

### **Architecture & Core Concepts**

1. **Explain Docker architecture. How does it differ from virtual machines?**
    
    Docker uses a client-server architecture, comprising the Docker CLI, Docker Engine, and Docker Daemon. Unlike VMs, which use hypervisors for virtualization, Docker containers run on a shared OS kernel, making them lightweight and efficient. VMs have complete OS installations, while containers share the host OS.
    
2. **What are Docker namespaces, and how do they ensure container isolation?**
    
    Namespaces provide the isolation layer by separating processes, network interfaces, mounts, and UIDs for each container. Key namespaces include PID, NET, MNT, UTS, and IPC.
    

---

### **Images & Containers**

1. **How does Docker caching work during image builds?**
    
    Docker caches each layer in the image-building process. If a layer hasn’t changed, it uses the cached version. Commands like `ADD` and `RUN` are cached based on their checksum and ordering.
    
2. **What is a multi-stage build in Docker, and why is it useful?**
    
    Multi-stage builds allow you to use intermediate images to build artifacts, reducing the final image size. For example:
    
    ```
    
    FROM golang:1.18 AS builder
    WORKDIR /app
    COPY . .
    RUN go build -o main .
    
    FROM alpine:latest
    COPY --from=builder /app/main .
    CMD ["./main"]
    
    ```
    

---

### **Networking**

1. **How does Docker networking work? What are the types of Docker networks?**
    
    Docker supports **bridge**, **host**, **overlay**, **none**, and custom networks. Containers in a bridge network communicate via an internal bridge. Overlay networks connect services in a Swarm, while `host` bypasses container network isolation.
    
2. **How do you troubleshoot network issues in Docker containers?**
    
    Use tools like `docker network inspect`, `ping`, and `traceroute`. Inspect IP assignments, ensure services are exposed, and check DNS resolution inside the container.
    

---

### **Volumes & Storage**

1. **What are Docker volumes, and how do they differ from bind mounts?**
    
    Volumes are managed by Docker, stored under `/var/lib/docker/volumes`. Bind mounts link directories on the host to containers, but are not managed by Docker, offering less portability.
    
2. **How do you back up and restore Docker volumes?**
    
    Use tar to back up:
    
    ```bash
    
    docker run --rm -v my_volume:/data -v $(pwd):/backup alpine tar -czf /backup/backup.tar.gz -C /data .
    
    ```
    
    Restore:
    
    ```bash
    
    docker run --rm -v my_volume:/data -v $(pwd):/backup alpine tar -xzf /backup/backup.tar.gz -C /data
    
    ```
    

---

### **Security**

1. **How do you secure Docker containers?**
    - Use minimal base images like `distroless`.
    - Enable user namespaces to map container UIDs to non-root.
    - Implement image scanning tools like Trivy or Docker Scout.
    - Avoid using `-privileged` unless necessary.
2. **What is Docker Content Trust (DCT), and how does it enhance security?**
    
    DCT ensures only signed images are pulled or run, preventing unauthorized image tampering. Enable it with `DOCKER_CONTENT_TRUST=1`.
    

---

### **Scaling & Orchestration**

1. **How does Docker Swarm handle scaling?**
    
    Swarm automatically distributes workloads across nodes in the cluster. Use `docker service scale <service_name>=<replicas>` to adjust replicas.
    
2. **How do you ensure high availability in Docker Swarm?**
    - Use multiple manager nodes (Raft consensus).
    - Distribute replicas across worker nodes.
    - Use health checks and rolling updates.

---

### **Performance Optimization**

1. **What strategies can you use to optimize Docker image size?**
    - Use smaller base images (`alpine`, `scratch`).
    - Combine commands in Dockerfile to reduce layers.
    - Clear caches, e.g., `apt-get clean`.
2. **How do you monitor Docker container performance?**
    
    Tools like Docker Stats (`docker stats`), cAdvisor, and third-party solutions (Prometheus, Grafana) help monitor resource usage.
    

---

### **CI/CD & Integration**

1. **How can Docker be integrated into a CI/CD pipeline?**
    
    Use Docker in CI/CD for consistent environments:
    
    - Build and test images (`docker build`, `docker run`).
    - Push images to registries like Docker Hub or ECR.
    - Deploy containers with tools like Jenkins or GitLab CI.
2. **What are the best practices for managing Docker images in CI/CD?**
    - Tag images with version numbers and SHA digests.
    - Clean up unused images (`docker image prune`).
    - Use private registries for sensitive projects.

---

### **Troubleshooting**

1. **How do you debug a Docker container that keeps restarting?**
    
    Use `docker logs <container_id>` to check logs. Inspect exit codes with `docker inspect` and verify health check settings.
    
2. **How do you deal with a “no space left on device” error in Docker?**
    - Remove unused containers, images, volumes (`docker system prune`).
    - Limit logs with `-log-opt` or mount logs to the host.

---

**Advanced Topics**

1. **What is the purpose of Docker’s `init` process?**
    
    Docker’s `--init` flag runs an init process (`tini`) inside containers to handle zombie processes and forward signals.
    
2. **What is the difference between Docker Compose and Docker Swarm?**
    - **Docker Compose**: Manages multi-container setups for development and testing.
    - **Docker Swarm**: Handles container orchestration and scaling in production. Compose files can be deployed in Swarm with minor changes