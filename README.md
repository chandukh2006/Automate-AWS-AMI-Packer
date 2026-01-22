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
    ```bash
    aws configure
    ```
    *Enter your Access Key and Secret Key when prompted.*

---

## 🛠️ Technical Highlights

### 🔹 Custom Systemd Integration
A key feature of this project is the override of the default Docker service behavior using a custom unit file (`docker.service`).
* **API Exposure:** Configured the daemon to listen on `tcp://0.0.0.0:2375`.
* **Self-Healing:** Implemented `Restart=always` with a `2s` delay.

---

## 🚀 Getting Started (For Developers)

### 1. Clone & Initialize
```bash
git clone [https://github.com/chandukh2006/Automate-AWS-AMI-Packer.git](https://github.com/chandukh2006/Automate-AWS-AMI-Packer.git)
cd Automate-AWS-AMI-Packer
packer init .
