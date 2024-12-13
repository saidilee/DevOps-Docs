## Connect with Me

- **YouTube**: [Watch and Learn on YouTube](https://www.youtube.com/@AshokKumar-DevOps)  
- **LinkedIn**: [Connect with me on LinkedIn](https://www.linkedin.com/in/ashokkumar-devops13/)  
- **TopMate**: [Support or Consult on TopMate](https://topmate.io/ashok_kumar)  

## Support This Project

If you find this content helpful:
- **Like** the [YouTube video](https://www.youtube.com/@AshokKumar-DevOps) for more such tutorials.
- **Star** this GitHub repository to get the latest updates.

### **For Linux**

1. **Download the AWS CLI Installer**:
    
    ```bash
    
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    
    ```
    
2. **Unzip the Installer**:
    
    ```bash
    
    unzip awscliv2.zip
    
    ```
    
3. **Run the Installer**:
    
    ```bash
    
    sudo ./aws/install
    
    ```
    
4. **Verify Installation**:
    
    ```bash
    
    aws --version
    
    ```
    
    - Expected output: `aws-cli/2.x.x Python/x.x.x Linux/x86_64`.

---

### **For macOS**

1. **Download the AWS CLI Installer**:
    
    ```bash
    
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
    
    ```
    
2. **Run the Installer**:
    
    ```bash
    
    sudo installer -pkg AWSCLIV2.pkg -target /
    
    ```
    
3. **Verify Installation**:
    
    ```bash
    aws --version
    
    ```
    
    - Expected output: `aws-cli/2.x.x Python/x.x.x Darwin/x86_64`.

---

### **For Windows**

1. **Download the Installer**:
    - Go to the AWS CLI v2 Windows Installer.
2. **Run the Installer**:
    - Double-click the downloaded `.msi` file and follow the on-screen instructions.
3. **Verify Installation**:
    - Open Command Prompt or PowerShell and run:
        
        ```bash
        
        aws --version
        
        ```
        
    - Expected output: `aws-cli/2.x.x Python/x.x.x Windows/x86_64`.

---

### **Post-Installation**

1. **Configure AWS CLI**:
Set up your credentials and default settings:
    
    ```bash
    
    aws configure
    
    ```
    
    - Enter:
        - AWS Access Key ID
        - AWS Secret Access Key
        - Default region (e.g., `us-west-2`)
        - Default output format (e.g., `json`)
2. **Test the Configuration**:
    
    ```bash
    
    aws s3 ls
    
    ```
    
    - If the setup is correct, this will list your S3 buckets (if any).

### **1. Extract Public Key from `.pem` File**

To use your `.pem` file for SSH, you must extract the public key:

```bash

ssh-keygen -y -f /path/to/your-key.pem > ~/.ssh/id_rsa.pub

```

- Replace `/path/to/your-key.pem` with the actual path to your `.pem` file.
- This command generates the public key and saves it as `~/.ssh/id_rsa.pub`.

Verify the contents of the public key:

```bash
cat ~/.ssh/id_rsa.pub

```

1. **Install eksctl**:
    - Download and install eksctl from the official site
        
        ```bash
        
        curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
        sudo mv /tmp/eksctl /usr/local/bin
        
        ```
        
    
    Verify the installation:
    
    ```bash
    
    eksctl version
    
    ```
    
2. **Install kubectl**:
    - Install kubectl to interact with your cluster:
        
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
        

---

### **2. Update `eksctl.yaml`**

Update your `eksctl.yaml` to point to the newly created public key file:

```yaml

apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: my-cluster
  region: us-west-2

nodeGroups:
  - name: standard-workers
    instanceType: t3.medium
    desiredCapacity: 3
    ssh:
      publicKeyPath: ~/.ssh/id_rsa.pub

```

---

### **3. Run eksctl Command**

Run the command to create the cluster:

```bash

eksctl create cluster -f eksctl.yaml

```

### **Clean Up**

When you're done, delete the cluster to avoid incurring unnecessary costs:

```bash

eksctl delete cluster --name my-cluster

```
