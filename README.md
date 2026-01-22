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
