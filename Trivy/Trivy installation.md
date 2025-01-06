```bash
****Install Trivy on Debian/Ubuntu****
==============================================
Follow the steps below to install Trivy, a vulnerability scanner for containers and other artifacts, on a Debian-based or Ubuntu-based system.

**Step 1: Install Prerequisites**

sudo apt-get install wget apt-transport-https gnupg lsb-release -y

**Step 2: Add Trivy’s Public Key**
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -

**Step 3: Add Trivy's Repository**
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list

**Step 4: Update Package Index**
sudo apt-get update

**Step 5: Install Trivy**
sudo apt-get install trivy

Verify Installation
Check the Trivy version to confirm it was installed successfully:
trivy --version

You are now ready to use Trivy for vulnerability scanning.
```
