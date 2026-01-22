#!/bin/bash

# --- 1. Clean Setup ---
rm -f packer.exe
rm -rf .git
git init
git branch -M main

# --- 2. Create .gitignore (Security Critical) ---
# We explicitly ignore variables files so secrets are never pushed
cat <<EOF > .gitignore
*.exe
packer-vars.json
.terraform/
*.log
.DS_Store
EOF

# --- 3. Create packer-vars.json (NO CREDENTIALS HERE) ---
# This file only contains infrastructure IDs, not secrets.
cat <<EOF > packer-vars.json
{
  "region": "us-east-1",
  "source_ami": "ami-1234567890abcdef0",
  "instance_type": "t2.micro",
  "vpc_id": "vpc-12345678",
  "subnet_id": "subnet-12345678"
}
EOF

# --- 4. Create Professional README.md ---
cat << 'EOF' > README.md
# ☁️ Automated AWS AMI Pipeline with HashiCorp Packer

[![Packer](https://img.shields.io/badge/Packer-1.10+-02A8EF.svg?style=flat&logo=packer)](https://www.packer.io/)
[![AWS](https://img.shields.io/badge/AWS-AMI--Automation-FF9900.svg?style=flat&logo=amazon-aws)](https://aws.amazon.com/)
[![Docker](https://img.shields.io/badge/Docker-Enabled-2496ED.svg?style=flat&logo=docker)](https://www.docker.com/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

## 📌 Project Overview
This project demonstrates a **GitOps approach to Immutable Infrastructure**. It automates the creation of production-ready "Golden Images" (AMIs) on AWS using HashiCorp Packer.

Instead of configuring servers manually after launch, this pipeline "bakes" the configuration into the image itself. The resulting AMI comes pre-hardened with a custom **Systemd configuration for Docker**, Nginx, and essential networking tools.

---

## 🔐 Security & Authentication
**Do not hardcode AWS Credentials.**
This project is designed to use the **AWS CLI credential chain**. Packer will automatically detect your credentials from your environment or `~/.aws/credentials` file.

1.  **Install AWS CLI:** [Link](https://aws.amazon.com/cli/)
2.  **Configure Local Credentials:**
    \`\`\`bash
    aws configure
    \`\`\`
    *Enter your Access Key and Secret Key when prompted.*

---

## 🛠️ Technical Highlights

### 🔹 Custom Systemd Integration
A key feature of this project is the override of the default Docker service behavior using a custom unit file (\`docker.service\`).
* **API Exposure:** Configured the daemon to listen on \`tcp://0.0.0.0:2375\`.
* **Self-Healing:** Implemented \`Restart=always\` with a \`2s\` delay.

---

## 🚀 Getting Started (For Developers)

### 1. Clone & Initialize
\`\`\`bash
git clone https://github.com/chandukh2006/Automate-AWS-AMI-Packer.git
cd Automate-AWS-AMI-Packer
packer init .
\`\`\`

### 2. Configure Variables
Update \`packer-vars.json\` with your specific Subnet/VPC IDs. **Do not add keys here.**
\`\`\`json
{
  "region": "us-east-1",
  "vpc_id": "vpc-xxxxxx",
  "subnet_id": "subnet-xxxxxx"
}
\`\`\`

### 3. Build the Image
Ensure your AWS CLI is configured, then run:
\`\`\`bash
packer build -var-file="packer-vars.json" .
\`\`\`

---

## 👨‍💻 Author
**Chandu K H**
*Cloud & DevOps Enthusiastic*
EOF

# --- 5. Output Developer Instructions ---
clear
echo "✅ Project Successfully Configured."
echo "--------------------------------------------------------"
echo "COMMANDS FOR LOCAL DEVELOPMENT (Cheatsheet for others):"
echo "--------------------------------------------------------"
echo ""
echo "1. AUTHENTICATE (Secure Way):"
echo "   $ aws configure"
echo "   (Input your Access Key ID and Secret Access Key here)"
echo ""
echo "2. INITIALIZE PLUGINS:"
echo "   $ packer init ."
echo ""
echo "3. FORMAT CODE (Make it pretty):"
echo "   $ packer fmt ."
echo ""
echo "4. VALIDATE CONFIG:"
echo "   $ packer validate -var-file=\"packer-vars.json\" ."
echo ""
echo "5. BUILD AMI (Uses AWS CLI creds automatically):"
echo "   $ packer build -var-file=\"packer-vars.json\" ."
echo ""
echo "--------------------------------------------------------"
echo "Current directory is ready to push. 'packer-vars.json' is ignored."
