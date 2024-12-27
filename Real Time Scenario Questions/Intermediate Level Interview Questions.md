## Git

### 1. Explain the difference between `git rebase` and `git merge`. When would you use one over the other?

**Answer:**

- `git merge` integrates changes from one branch into another and creates a merge commit to preserve branch history.
- `git rebase` moves or "replays" commits from one branch onto another, creating a linear history without merge commits.
- Use `merge` for preserving complete branch history and `rebase` for a cleaner, linear commit history.
- Example commands:
    
    ```
    git merge feature-branch
    git rebase main
    ```
    

---

### 2. How do you resolve merge conflicts in Git, and what are best practices for avoiding them?

**Answer:**

1. Identify conflicting files using `git status`.
2. Open the conflicted files and resolve the conflicts manually.
3. Add the resolved files back with `git add` and commit the changes.
4. Best practices:
    - Frequently pull updates from shared branches using `git pull`.
    - Communicate changes within the team.
    - Work on feature-specific branches.
- Example command:
    
    ```
    git pull origin main
    git merge feature-branch
    ```
    

---

### 3. What is Git's "staging area," and how does it differ from the working directory?

**Answer:**

- The staging area holds changes that will be included in the next commit.
- The working directory contains files being edited, which may not yet be staged.
- Example commands:
    
    ```
    git add <file>
    git status
    ```
    

---

## Jenkins

### 4. What are Jenkins pipelines, and how do declarative and scripted pipelines differ?

**Answer:**

- Jenkins pipelines automate CI/CD workflows as code.
- **Declarative pipelines:** Simple, structured syntax using `pipeline` blocks, e.g., `stages` and `steps`.
- **Scripted pipelines:** Use Groovy for advanced, flexible scripting.
- Example declarative pipeline:
    
    ```
    pipeline {
        agent any
        stages {
            stage('Build') {
                steps {
                    echo 'Building...'
                }
            }
        }
    }
    ```
    

---

### 5. How do you configure Jenkins to trigger a build automatically when code is pushed to GitHub?

**Answer:**

1. Install the GitHub plugin.
2. Add a webhook in the GitHub repository pointing to `http://<Jenkins_URL>/github-webhook/`.
3. Configure the Jenkins job to poll SCM or use the GitHub hook trigger.
- Example:
    
    ```
    # Configure webhook in GitHub settings
    # In Jenkins pipeline:
    pipeline {
        triggers {
            pollSCM('* * * * *')
        }
    }
    ```
    

---

### 6. Explain how you would implement a Jenkins pipeline to deploy a Dockerized application.

**Answer:**

1. Write a Jenkinsfile with stages for build, test, and deploy.
2. Use the `docker` plugin to build the Docker image.
3. Push the Docker image to a registry (e.g., Docker Hub).
4. Deploy the container using Docker CLI or Kubernetes.
- Example Jenkinsfile:
    
    ```
    pipeline {
        agent any
        stages {
            stage('Build') {
                steps {
                    sh 'docker build -t myapp .'
                }
            }
            stage('Push') {
                steps {
                    sh 'docker push myapp'
                }
            }
            stage('Deploy') {
                steps {
                    sh 'docker run -d -p 80:80 myapp'
                }
            }
        }
    }
    ```
    

---

Maven

### 7. What is the purpose of the `pom.xml` file in Maven, and what are its key sections?

**Answer:**

- `pom.xml` is the configuration file for Maven projects.
- Key sections:
    - `<dependencies>`: Lists project dependencies.
    - `<build>`: Specifies build plugins.
    - `<repositories>`: Defines external repositories for dependencies.
- Example snippet:
    
    ```
    <dependencies>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-core</artifactId>
            <version>5.3.8</version>
        </dependency>
    </dependencies>
    ```
    

---

### 8. Explain the difference between Maven’s `compile`, `test`, and `package` goals.

**Answer:**

- `compile`: Compiles the source code.
- `test`: Runs unit tests.
- `package`: Bundles the compiled code into an artifact (e.g., JAR or WAR).
- Example commands:
    
    ```
    mvn compile
    mvn test
    mvn package
    ```
    

---

### 9. How do you add and manage dependencies in Maven?

**Answer:**

- Add dependencies in the `<dependencies>` section of `pom.xml`.
- Use groupId, artifactId, and version to define each dependency.
- Maven automatically resolves and downloads dependencies.
- Example:
    
    ```
    <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <version>4.13.2</version>
        <scope>test</scope>
    </dependency>
    ```
    

---

## Ansible

### 10. What are Ansible playbooks, and how do they differ from roles?

**Answer:**

- Playbooks: YAML files containing tasks for configuration or deployment.
- Roles: Structured directories for reusable playbook tasks and variables.
- Roles are modular and simplify complex playbook management.
- Example playbook:
    
    ```
    - name: Install Apache
      hosts: webservers
      tasks:
        - name: Install Apache
          apt:
            name: apache2
            state: present
    ```
    

---

### 11. Explain how Ansible manages idempotency in tasks.

**Answer:**

- Idempotency ensures tasks produce the same result regardless of how many times they are executed.
- Ansible modules (e.g., `apt`, `file`) check and modify only if required.
- Example:
    
    ```
    - name: Ensure Apache is installed
      apt:
        name: apache2
        state: present
    ```
    

---

### 12. How would you use Ansible Vault to securely manage sensitive data?

**Answer:**

1. Encrypt sensitive files using `ansible-vault encrypt <file>`.
2. Access the encrypted file in playbooks using `-ask-vault-pass` or `-vault-password-file`.
3. Store secrets (e.g., passwords, API keys) securely in the vault.
- Example:
    
    ```
    ansible-vault encrypt secrets.yml
    ansible-playbook site.yml --ask-vault-pass
    ```
    

---

## Docker

### 13. What is the difference between a Docker image and a container?

**Answer:**

- Docker Image: A static template containing application code and dependencies.
- Docker Container: A runtime instance of a Docker image.
- Containers are ephemeral and can be started or stopped as needed.
- Example commands:
    
    ```
    docker build -t myapp .
    docker run -d -p 8080:80 myapp
    ```
    

---

### 14. How do multi-stage builds in Dockerfiles improve container optimization?

**Answer:**

- Multi-stage builds reduce image size by copying only necessary files from intermediate stages.
- Example:
    
    ```
    FROM golang AS builder
    WORKDIR /app
    COPY . .
    RUN go build -o app
    
    FROM alpine
    COPY --from=builder /app/app /app
    CMD ["/app"]
    ```
    

---

### 15. Explain how to link Docker containers for inter-container communication.

**Answer:**

- Use Docker networks to allow containers to communicate.
- Example:
    
    ```
    docker network create my_network
    docker run --network my_network --name app_container app_image
    docker run --network my_network --name db_container db_image
    ```
    

---

## Kubernetes

### 16. What is the difference between a Deployment and a StatefulSet in Kubernetes?

**Answer:**

- Deployment: Manages stateless applications.
- StatefulSet: Manages stateful applications requiring stable identifiers and persistent storage.
- Use StatefulSets for databases and Deployments for web servers.
- Example:
    
    ```
    apiVersion: apps/v1
    kind: StatefulSet
    metadata:
      name: mysql
    spec:
      serviceName: "mysql"
      replicas: 3
    ```
    

---

### 17. Explain the role of etcd in a Kubernetes cluster.

**Answer:**

- `etcd` is a distributed key-value store used by Kubernetes to store cluster state and configurations.
- Ensures consistency across the cluster.

---

### 18. How does Kubernetes handle container scaling with Horizontal Pod Autoscalers (HPA)?

**Answer:**

- HPA adjusts the number of pods based on CPU, memory, or custom metrics.
- Example YAML:
    
    ```
    apiVersion: autoscaling/v1
    kind: HorizontalPodAutoscaler
    metadata:
      name: hpa-example
    spec:
      scaleTargetRef:
        apiVersion: apps/v1
        kind: Deployment
        name: example-deployment
      minReplicas: 1
      maxReplicas: 10
      targetCPUUtilizationPercentage: 80
    ```
    

---

## SonarQube

### 19. How does SonarQube integrate with Jenkins for code analysis?

**Answer:**

- Install the SonarQube plugin in Jenkins.
- Add SonarQube server details in Jenkins configuration.
- Use `withSonarQubeEnv` and `sonar-scanner` in pipelines to trigger analysis.
- Example pipeline:
    
    ```
    pipeline {
        agent any
        stages {
            stage('Code Analysis') {
                steps {
                    withSonarQubeEnv('SonarQube') {
                        sh 'sonar-scanner'
                    }
                }
            }
        }
    }
    ```
    

---

### 20. What metrics does SonarQube use to assess code quality, and what is the significance of each?

**Answer:**

- **Code coverage**: Measures tested code percentage.
- **Code smells**: Highlights maintainability issues.
- **Vulnerabilities**: Identifies security risks.
- **Duplications**: Tracks repeated code segments.

---

### 21. How would you configure SonarQube to enforce quality gates before deployment?

**Answer:**

1. Define quality gates with thresholds (e.g., coverage > 80%).
2. Integrate quality gates into the CI/CD pipeline.
3. Fail the pipeline if thresholds are not met.

---

## Terraform

### 22. How does Terraform handle state management, and why is the `terraform.tfstate` file important?

**Answer:**

- Terraform uses the `terraform.tfstate` file to track infrastructure state.
- It ensures resources are updated without recreating existing ones.
- Store the state file securely (e.g., S3 with encryption).

---

### 23. What are Terraform modules, and how do they help in organizing infrastructure as code?

**Answer:**

- Modules are reusable, parameterized configurations.
- They simplify and standardize resource management.
- Example:
    
    ```
    module "vpc" {
      source = "terraform-aws-modules/vpc/aws"
      cidr   = "10.0.0.0/16"
    }
    ```
    

---

### 24. Explain how you would use Terraform to deploy infrastructure across multiple environments (e.g., dev, staging, prod).

**Answer:**

- Use workspaces or separate configuration files for each environment.
- Example:
    
    ```
    terraform workspace new dev
    terraform apply -var-file=dev.tfvars
    ```
    

---

## Prometheus and Grafana

25. How do you set up Prometheus to scrape metrics from an application?

**Answer:**

1. Add the application’s metrics endpoint to the `prometheus.yml` file:
    
    ```
    scrape_configs:
      - job_name: 'app'
        static_configs:
          - targets: ['localhost:8080']
      - job_name: 'nginx'
        static_configs:
          - targets: ['localhost:8081']
    ```
    
2. Restart Prometheus to apply the changes.

---

### 26. Explain how Grafana queries data from Prometheus to create visual dashboards.

**Answer:**

- Add Prometheus as a data source in Grafana.
- Use PromQL queries in panels to fetch metrics and visualize them with graphs, tables, or alerts.

---

### 27. What are alerting rules in Prometheus, and how do you integrate them with Grafana for notifications?

**Answer:**

- Define alerting rules in `prometheus.yml` to trigger alerts based on conditions.
- Example:
    
    ```
    alerting:
      alertmanagers:
        - static_configs:
            - targets: ['Jenkins:9093']
    alert_rules:
      groups:
        - name: example-alert
          rules:
            - alert: HighCPUUsage
              expr: cpu_usage > 80
              for: 2m
    ```
    
- Integrate with Grafana to send notifications via email, Slack, or other channels.
