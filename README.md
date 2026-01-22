# Secure AMI Automation with Packer & AWS Inspector

![Packer](https://img.shields.io/badge/tool-Packer-blue?style=flat&logo=packer)
![AWS](https://img.shields.io/badge/cloud-AWS-orange?style=flat&logo=amazon-aws)
![Inspector](https://img.shields.io/badge/security-AWS%20Inspector-green?style=flat)
![Status](https://img.shields.io/badge/status-Active-success)

## 📖 Overview

This repository contains the Infrastructure as Code (IaC) required to automate the creation of secure Amazon Machine Images (AMIs) using **HashiCorp Packer**. 

The goal is to eliminate manual daily tasks by automating the provisioning of an EC2 instance, installing necessary applications (Nginx, Docker), and validating security compliance using **AWS Inspector** standards (CIS Operating System Security Configuration).

### Key Features
* **Automation:** Builds immutable AMIs automatically using Packer.
* **Security:** Integrates AWS Inspector logic and security tagging (`App: nginx`) for vulnerability scanning.
* **Provisioning:** Installs Nginx and Docker via systemd configuration (`docker.service`).

---

## 📂 Repository Structure

| File | Description |
| :--- | :--- |
| `packer.pkr.hcl` | The main Packer template written in HCL (HashiCorp Configuration Language). Defines the builder and provisioners. |
| `packer-vars.json` | JSON file containing variables such as AWS Region, VPC ID, and Subnet ID. |
| `docker.service` | Systemd unit file for configuring the Docker service during the build process. |

---

## 🛠️ Prerequisites

Before running the build, ensure you have the following:

1.  **HashiCorp Packer Installed:**
    * [Download Packer](https://www.packer.io/downloads)
    * Ensure the binary is in your system `PATH`.
2.  **AWS Credentials:**
    * An IAM User with `EC2FullAccess` and permissions to run AWS Inspector.
    * `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` configured.

---

## 🚀 Usage

### 1. Configuration
Update the `packer-vars.json` file with your specific AWS environment details:
```json
{
  "aws_access_key": "YOUR_ACCESS_KEY",
  "aws_secret_key": "YOUR_SECRET_KEY",
  "vpc_id": "vpc-xxxxxx",
  "subnet_id": "subnet-xxxxxx",
  "region": "us-east-1"
}
Here is an "Ultimate" README.md file formatted to look professional on GitHub. I have cleaned up your notes, organized the manual vs. automated workflows, and updated the commands to reflect that you are using HCL (packer.pkr.hcl) instead of JSON.

You can copy the raw code block below and paste it directly into your README.md file.

Markdown
# Secure AMI Automation with Packer & AWS Inspector

![Packer](https://img.shields.io/badge/tool-Packer-blue?style=flat&logo=packer)
![AWS](https://img.shields.io/badge/cloud-AWS-orange?style=flat&logo=amazon-aws)
![Inspector](https://img.shields.io/badge/security-AWS%20Inspector-green?style=flat)
![Status](https://img.shields.io/badge/status-Active-success)

## 📖 Overview

This repository contains the Infrastructure as Code (IaC) required to automate the creation of secure Amazon Machine Images (AMIs) using **HashiCorp Packer**. 

The goal is to eliminate manual daily tasks by automating the provisioning of an EC2 instance, installing necessary applications (Nginx, Docker), and validating security compliance using **AWS Inspector** standards (CIS Operating System Security Configuration).

### Key Features
* **Automation:** Builds immutable AMIs automatically using Packer.
* **Security:** Integrates AWS Inspector logic and security tagging (`App: nginx`) for vulnerability scanning.
* **Provisioning:** Installs Nginx and Docker via systemd configuration (`docker.service`).

---

## 📂 Repository Structure

| File | Description |
| :--- | :--- |
| `packer.pkr.hcl` | The main Packer template written in HCL (HashiCorp Configuration Language). Defines the builder and provisioners. |
| `packer-vars.json` | JSON file containing variables such as AWS Region, VPC ID, and Subnet ID. |
| `docker.service` | Systemd unit file for configuring the Docker service during the build process. |

---

## 🛠️ Prerequisites

Before running the build, ensure you have the following:

1.  **HashiCorp Packer Installed:**
    * [Download Packer](https://www.packer.io/downloads)
    * Ensure the binary is in your system `PATH`.
2.  **AWS Credentials:**
    * An IAM User with `EC2FullAccess` and permissions to run AWS Inspector.
    * `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` configured.

---

## 🚀 Usage

### 1. Configuration
Update the `packer-vars.json` file with your specific AWS environment details:
```json
{
  "aws_access_key": "YOUR_ACCESS_KEY",
  "aws_secret_key": "YOUR_SECRET_KEY",
  "vpc_id": "vpc-xxxxxx",
  "subnet_id": "subnet-xxxxxx",
  "region": "us-east-1"
}
Note: Ensure the Subnet ID selected has "Auto-assign Public IP" enabled.

2. Build Commands (Linux/Mac)
Open your terminal and navigate to the repository folder:

Bash
# Initialize Packer (downloads plugins if needed)
packer init packer.pkr.hcl

# Validate the syntax
sudo packer validate --var-file packer-vars.json packer.pkr.hcl

# Inspect the template configuration
sudo packer inspect --var-file packer-vars.json packer.pkr.hcl

# Build the AMI
sudo packer build --var-file packer-vars.json packer.pkr.hcl
3. Build Commands (Windows Powershell)
PowerShell
# Validate
packer.exe validate -var-file=packer-vars.json packer.pkr.hcl

# Inspect
packer.exe inspect -var-file=packer-vars.json packer.pkr.hcl

# Build
packer.exe build -var-file=packer-vars.json packer.pkr.hcl
🛡️ Security Workflow (Context)
The automation in this repo replaces the following manual security workflow:

Instance Tagging: The Packer build automatically applies the tag App = Nginx.

Inspector Setup:

Target: Instances tagged App: Nginx.

Packages selected: Network Reachability, Common Vulnerabilities and Exposures, CIS Operating System Security Configuration.

Assessment: Historically, this required a 15-minute manual scan. Using Packer, we ensure the base image is consistent, reducing drift and vulnerabilities.

📝 Notes
HCL vs JSON: This repository uses the modern HCL format (.pkr.hcl). If you are migrating from older JSON templates, ensure you use the packer hcl2_upgrade command.

Troubleshooting: If the build fails on the "Wait for SSH" step, verify your Security Group allows inbound traffic on port 22.

Maintained by chandukh2006
