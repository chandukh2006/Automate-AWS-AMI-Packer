
# Comprehensive Guide: Automated Secure AMI Creation

![Packer](https://img.shields.io/badge/tool-Packer-blue?style=flat&logo=packer)
![AWS](https://img.shields.io/badge/cloud-AWS-orange?style=flat&logo=amazon-aws)
![Inspector](https://img.shields.io/badge/security-AWS%20Inspector-green?style=flat)
![Status](https://img.shields.io/badge/status-Active-success)

**Author:** Chandu K H
**Tools:** AWS EC2, AWS Inspector, HashiCorp Packer (HCL)

---

## 📖 Part 1: The Manual Process (Theory)
*Before automating, it is important to understand the manual steps this workflow replaces.*

### 1. Manual Secure Instance Setup
1.  **Launch EC2:** Create a manual instance (Ubuntu/Linux).
2.  **Install Application:** Login via SSH and install Nginx/Docker.
3.  **Install Inspector Agent:** Download and install the AWS Inspector agent script.
4.  **Tagging:** Add the tag `App = Nginx` (Crucial for Inspector targeting).

### 2. Configure AWS Inspector (Classic)
1.  **Define Assessment Target:**
    * Go to AWS Console > Inspector (Classic).
    * Create Target > Select "Include all EC2 instances matching tags".
    * Key: `App`, Value: `Nginx`.
2.  **Define Assessment Template:**
    * Select Rules Packages: `Common Vulnerabilities (CVE)`, `CIS Operating System Security`, `Network Reachability`.
    * Set duration (e.g., 15 mins).
3.  **Run Scan:** Manually start the scan and wait for results.

### 3. Manual AMI Creation
1.  Stop the instance.
2.  Actions > Image and templates > Create Image.
3.  Wait for AMI to become "Available".
4.  Terminate the original instance.

---

## 🚀 Part 2: The Automated Process (Packer & HCL)
*We automate the steps above using Infrastructure as Code (IaC).*

### 1. Prerequisites & Installation

**Windows:**
1.  Download Packer binary from [packer.io](https://www.packer.io).
2.  Extract `packer.exe` to a folder (e.g., `C:\Packer`).
3.  **Add to Path:** System Properties > Environment Variables > System Variables > Path > Add `C:\Packer`.
4.  Open a new terminal and type `packer --version` to verify.

**Linux:**
```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
curl -fsSL [https://apt.releases.hashicorp.com/gpg](https://apt.releases.hashicorp.com/gpg) | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] [https://apt.releases.hashicorp.com](https://apt.releases.hashicorp.com) $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install packer
