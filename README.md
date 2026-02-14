# AWS-DevOps Flask App

A simple Flask web app for AWS-DevOps testing. Includes Docker support and Terraform config to provision EC2 on AWS.

---

## What's Inside

| Item | Purpose |
|------|---------|
| `app.py` | Flask app (runs on port 5000) |
| `Dockerfile` | Container build for deployment |
| `EC2-via-TF/` | Terraform config for EC2 + security group + IAM |

---

## Quick Start

**Run locally**
```bash
pip install -r requirements.txt
python app.py
```
Visit `http://localhost:5000`

**Run with Docker**
```bash
docker build -t flask-app .
docker run -p 5000:5000 flask-app
```

**Provision EC2 (Terraform)**
```bash
cd EC2-via-TF
terraform init
terraform apply
```
After apply, use the output `ubuntu_public_ip` to access the instance.

---

## Requirements

- Python 3.9+ (local run)
- Docker (optional)
- Terraform + AWS credentials (optional, for EC2)
