# Comprehensive Guide: Automated Secure AMI Creation

![Packer](https://img.shields.io/badge/tool-Packer-blue?style=flat&logo=packer)
![AWS](https://img.shields.io/badge/cloud-AWS-orange?style=flat&logo=amazon-aws)
![Inspector](https://img.shields.io/badge/security-AWS%20Inspector-green?style=flat)
![Status](https://img.shields.io/badge/status-Active-success)

**Author:** chandukh2006  
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
2. AWS Permissions (IAM)
To run this automation successfully, ensure your AWS Access Keys have the following IAM policies attached:

AmazonEC2FullAccess: Required to launch instances, create images, and terminate instances.

AmazonInspectorFullAccess: Required if you plan to automate the vulnerability assessment scans.

📂 Part 3: Repository Files Setup
Ensure your folder structure looks like this:

Plaintext
/my-packer-project
├── packer.pkr.hcl       # Main configuration (Source + Build)
├── packer-vars.json     # Variables (Secrets/Region info)
├── docker.service       # Systemd unit file for Docker
└── README.md            # This documentation file
A. packer-vars.json (The Variables)
Do not commit this file if it contains real secrets.

JSON
{
  "aws_access_key": "YOUR_ACCESS_KEY_HERE",
  "aws_secret_key": "YOUR_SECRET_KEY_HERE",
  "region": "us-east-1",
  "vpc_id": "vpc-xxxxxx",
  "subnet_id": "subnet-xxxxxx",
  "source_ami": "ami-xxxxxx"
}
B. packer.pkr.hcl (The Logic)
This replaces the old packer.json. Ensure it includes:

Source block: Defines the base AMI (Ubuntu), instance type (t2.micro), and SSH username.

Build block: Defines provisioners (Shell scripts to install Nginx/Docker, File provisioners to upload docker.service).

⚡ Part 4: Execution Commands
Since you are using HCL (.pkr.hcl), the commands differ slightly from the old JSON format.

1. Initialize Packer
Downloads the necessary AWS plugins defined in your HCL file.

Bash
packer init packer.pkr.hcl
2. Format & Validate
Ensures your code is clean and syntactically correct.

Bash
# Format the code (Auto-fixes spacing)
packer fmt packer.pkr.hcl

# Validate configuration
packer validate -var-file="packer-vars.json" packer.pkr.hcl
3. Inspect (Optional)
Shows a summary of what will be built without running it.

Bash
packer inspect -var-file="packer-vars.json" packer.pkr.hcl
4. Build the AMI
This command launches the instance, runs scripts, creates the AMI, and terminates the instance.

Bash
packer build -var-file="packer-vars.json" packer.pkr.hcl
🛠️ Part 5: Troubleshooting
Wait for SSH Failures:

Check your AWS Security Group attached to the instance. It must allow Port 22 (SSH) from 0.0.0.0/0 (or Packer's IP).

Ensure the Subnet has "Auto-assign Public IP" enabled.

Permissions Errors:

Verify IAM user policy allows ec2:CreateImage, ec2:RunInstances, and ec2:TerminateInstances.
