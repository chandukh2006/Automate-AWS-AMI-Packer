#!/bin/bash

# --- COLORS & STYLING ---
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# --- 1. Clean Setup ---
rm -f packer.exe
rm -rf .git
git init > /dev/null 2>&1
git branch -M main

# --- 2. Create .gitignore (Security Critical) ---
cat <<EOF > .gitignore
*.exe
packer-vars.json
.terraform/
*.log
.DS_Store
EOF

# --- 3. Create packer-vars.json (Template) ---
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

# --- 5. IMPRESSIVE OUTPUT ---
clear
echo -e "${BLUE}============================================================${NC}"
echo -e "${BOLD}${CYAN}   🚀  AWS AMI AUTOMATION PIPELINE SETUP COMPLETE  🚀   ${NC}"
echo -e "${BLUE}============================================================${NC}"
echo ""
echo -e "   ${GREEN}✅ Git Repository Initialized${NC}"
echo -e "   ${GREEN}✅ Security Rules Applied (.gitignore created)${NC}"
echo -e "   ${GREEN}✅ Professional Documentation Generated (README.md)${NC}"
echo -e "   ${GREEN}✅ Environment Configured (packer-vars.json)${NC}"
echo ""
echo -e "${YELLOW}------------------------------------------------------------${NC}"
echo -e "${BOLD}       💡  CHEAT SHEET FOR LOCAL DEVELOPMENT  💡       ${NC}"
echo -e "${YELLOW}------------------------------------------------------------${NC}"
echo ""
echo -e "${BOLD}1. 🔑 AUTHENTICATE (The Secure Way)${NC}"
echo -e "   ${CYAN}$ aws configure${NC}"
echo -e "   ${RED}STOP!${NC} Do not hardcode keys. Use the CLI."
echo ""
echo -e "${BOLD}2. 🔌 INITIALIZE${NC}"
echo -e "   ${CYAN}$ packer init .${NC}"
echo ""
echo -e "${BOLD}3. 🧹 FORMAT & VALIDATE${NC}"
echo -e "   ${CYAN}$ packer fmt .${NC}"
echo -e "   ${CYAN}$ packer validate -var-file=\"packer-vars.json\" .${NC}"
echo ""
echo -e "${BOLD}4. 🏗️  BUILD THE IMAGE${NC}"
echo -e "   ${CYAN}$ packer build -var-file=\"packer-vars.json\" .${NC}"
echo ""
echo -e "${BLUE}============================================================${NC}"
echo -e "${BOLD}              Ready to push to GitHub!                  ${NC}"
echo -e "${BLUE}============================================================${NC}"
echo ""
