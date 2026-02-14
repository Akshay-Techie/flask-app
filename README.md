# 🚀 Flask App – End-to-End AWS DevOps CI/CD Project

## 📌 Project Overview

This project demonstrates a complete CI/CD pipeline for deploying a Dockerized Flask application to AWS EC2 using:

- **Jenkins** – CI/CD automation
- **Docker** – containerization
- **AWS ECR** – image storage
- **AWS EC2** – hosting
- **Terraform** – Infrastructure as Code
- **IAM Roles** – secure AWS authentication

The pipeline automates the process from code commit to live deployment.

---

## 🏗 Architecture Overview

**Flow:** Developer → GitHub → Jenkins → Docker → AWS ECR → EC2 (Terraform) → Live Flask App

```
┌───────────────┐
│   Developer   │
└───────┬───────┘
        │ Push Code
        ▼
┌───────────────┐
│    GitHub     │
└───────┬───────┘
        │ Clone
        ▼
┌───────────────┐
│    Jenkins    │
│  (Ubuntu VM)  │
└───────┬───────┘
        │ Build + Push
        ▼
┌───────────────┐
│      ECR      │
└───────┬───────┘
        │ Pull
        ▼
┌───────────────┐
│     EC2       │
│ (Terraform)   │
└───────┬───────┘
        │ Run Docker
        ▼
┌───────────────┐
│   Flask App   │
│   Port 80     │
└───────────────┘
```

---

## 📁 Project Structure

```
Project-01/
├── app.py                 # Flask application
├── requirements.txt       # Python dependencies
├── Dockerfile             # Container build
├── EC2-via-TF/            # Terraform for EC2 provisioning
│   ├── ec2.tf             # EC2, Security Group, IAM config
│   ├── .terraform.lock.hcl
│   └── terraform.tfstate  # (Auto-generated, ignore in Git)
├── .gitignore
└── LICENSE
```

---

## 🔁 End-to-End Workflow

### 1️⃣ Application Development

- Flask app in `app.py`
- Runs on `0.0.0.0:5000`
- Dockerized via `Dockerfile`
- Dependencies in `requirements.txt`

### 2️⃣ Source Code Management

- Code pushed to GitHub
- Jenkins pulls from `main` branch

### 3️⃣ Jenkins CI/CD Pipeline Stages

| Stage | Description |
|-------|-------------|
| **Clone** | Pull latest code from GitHub |
| **Build** | Build Docker image: `akshaytechie/flask-app:01` |
| **Tag** | Tag for ECR: `793433927733.dkr.ecr.ap-south-1.amazonaws.com/test-repo-flask-app:01` |
| **Login** | Authenticate to ECR via AWS CLI |
| **Push** | Push image to AWS Elastic Container Registry |
| **Deploy** | SSH into EC2 → ECR login (IAM) → pull image → stop old container → run new one |

**Deploy command:**
```bash
docker run -d -p 80:5000 --name flask-app <image>
```

### 4️⃣ Infrastructure (Terraform)

EC2 is provisioned in `EC2-via-TF/`.

| Setting | Value |
|---------|-------|
| Region | `ap-south-1` |
| AMI | Ubuntu 22.04 |
| Instance | `t3.micro` |
| Key Pair | `Genexis-Key-Pair` |
| IAM Role | `EC2-ECR-ReadOnly` |
| Security Group | SSH (22), HTTP (80), HTTPS (443) |

**Terraform output:**
```bash
ubuntu_public_ip
```

### 5️⃣ IAM Role–Based Auth

EC2 uses IAM role `EC2-ECR-ReadOnly` for:

- ECR auth without hardcoded credentials
- Secure access to ECR
- Production-safe setup

### 6️⃣ Deployment Result

After the pipeline completes:

- Docker container runs on EC2
- App exposed on port 80
- Access at: `http://<ubuntu_public_ip>`

---

## 🛠 Technologies Used

| Category | Tools |
|----------|-------|
| Application | Python, Flask |
| CI/CD | Jenkins |
| Container | Docker |
| Cloud | AWS EC2, AWS ECR |
| IaC | Terraform |
| Auth | IAM Roles |
| VCS | Git, GitHub |
| OS | Linux (Ubuntu) |

---

## 💡 DevOps Concepts

- CI/CD pipeline automation
- Docker containerization
- Infrastructure as Code (Terraform)
- IAM role–based authentication
- Jenkins SSH Agent integration
- Automated EC2 deployment
- Secure image handling via ECR

---

## 📈 Future Improvements

- Auto-trigger pipeline on Git push (webhook)
- Multi-environment (Dev / Prod)
- Blue–Green deployment
- Kubernetes deployment
- Terraform modularization
- CI pipeline optimization

---

## 👨‍💻 Author

**Akshay Kumar**  
AWS DevOps Enthusiast | Future MLOps Engineer
