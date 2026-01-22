# 1. Remove unwanted files and reset git
rm -f packer.exe
rm -rf .git

# 2. Initialize a fresh Git repository
git init
git branch -M main

# 3. Create .gitignore (Critical for security & cleanliness)
cat <<EOF > .gitignore
*.exe
packer-vars.json
.terraform/
*.log
EOF

# 4. Create the Professional README.md
cat << 'EOF' > README.md
# ☁️ Automated AWS AMI Pipeline with HashiCorp Packer

[![Packer](https://img.shields.io/badge/Packer-1.10+-02A8EF.svg?style=flat&logo=packer)](https://www.packer.io/)
[![AWS](https://img.shields.io/badge/AWS-AMI--Automation-FF9900.svg?style=flat&logo=amazon-aws)](https://aws.amazon.com/)
[![Docker](https://img.shields.io/badge/Docker-Enabled-2496ED.svg?style=flat&logo=docker)](https://www.docker.com/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

## 📌 Project Overview
This project demonstrates a **GitOps approach to Immutable Infrastructure**. It automates the creation of production-ready "Golden Images" (AMIs) on AWS using HashiCorp Packer.

Instead of configuring servers manually after launch, this pipeline "bakes" the configuration into the image itself. The resulting AMI comes pre-hardened with a custom **Systemd configuration for Docker**, Nginx, and essential networking tools, ensuring that every instance launched is identical, secure, and ready for workload distribution.

---

## 🏗️ Architecture & Workflow

The pipeline utilizes the \`amazon-ebs\` builder to create an AMI backed by EBS volumes.

1.  **Base Layer:** Starts with an official Ubuntu source AMI.
2.  **Provisioning Layer:**
    * **System Updates:** Automates \`apt update\` and security patching.
    * **Web Server:** Installs and enables **Nginx**.
    * **Container Runtime:** Installs **Docker** and configures user permissions.
    * **Service Configuration:** Injects a custom \`docker.service\` file to manage the Docker daemon lifecycle and API exposure.
3.  **Artifact Generation:** Produces a timestamped AMI (e.g., \`chandu-devops-team-YYYYMMDD...\`) in the specified AWS Region.

---

## 🛠️ Technical Highlights

### 🔹 Custom Systemd Integration
A key feature of this project is the override of the default Docker service behavior using a custom unit file (\`docker.service\`).
* **API Exposure:** Configured the daemon to listen on \`tcp://0.0.0.0:2375\` for remote management capabilities.
* **Self-Healing:** Implemented \`Restart=always\` with a \`2s\` delay to ensure high availability of the container runtime.
* **Resource Management:** Configured \`LimitNOFILE=infinity\` and \`Delegate=yes\` for optimal container performance.

### 🔹 Infrastructure as Code (IaC)
* **HCL Syntax:** Uses HashiCorp Configuration Language for readable, version-controlled build definitions.
* **Variable Abstraction:** Sensitive data (Subnets, VPC IDs) is decoupled from the code using \`packer-vars.json\`.

---

## 🚀 Getting Started

### Prerequisites
* [HashiCorp Packer](https://developer.hashicorp.com/packer/downloads) installed.
* AWS CLI configured with \`AmazonEC2FullAccess\`.

### 1. Clone the Repository
\`\`\`bash
git clone https://github.com/chandukh2006/Automate-AWS-AMI-Packer.git
cd Automate-AWS-AMI-Packer
\`\`\`

### 2. Configure Variables
Create a \`packer-vars.json\` file to define your environment specifics:
\`\`\`json
{
  "region": "us-east-1",
  "source_ami": "ami-1234567890abcdef0",
  "instance_type": "t2.micro",
  "vpc_id": "vpc-xxxxxxxx",
  "subnet_id": "subnet-xxxxxxxx"
}
\`\`\`

### 3. Initialize & Validate
Initialize the Packer plugins and check the template for syntax errors.
\`\`\`bash
packer init .
packer validate -var-file="packer-vars.json" .
\`\`\`

### 4. Build the Image
Launch the automation pipeline. This will spin up a temporary EC2 instance, provision it, and save the AMI.
\`\`\`bash
packer build -var-file="packer-vars.json" .
\`\`\`

---

## ⚠️ Security Note
> **Warning:** The custom \`docker.service\` configuration exposes the Docker socket on port \`2375\` without TLS. This is intended for development or internal private subnet use cases. For production public-facing servers, ensure this port is blocked by Security Groups or implement mTLS authentication.

---

## 👨‍💻 Author
**Chandu**
*Cloud & DevOps Engineer*
EOF

# 5. Add files, Commit, and Force Push
git add .
git commit -m "Initial Release: Automated AMI Pipeline with Systemd Config"
git remote add origin https://github.com/chandukh2006/Automate-AWS-AMI-Packer.git
git push -u origin main -f
