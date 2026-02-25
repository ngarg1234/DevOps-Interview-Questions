Below is a **single, complete reference document** you can save/share internally.
It covers **both cases in detail**: **S3-only backend** and **S3 + DynamoDB backend**, including **latest Terraform behavior**, **trade-offs**, **configs**, **IAM**, **CI/CD**, and **recommendations (2025)**.

---

# Terraform S3 Backend State Locking

## With and Without DynamoDB (2025 Reference)

---

## 1. Overview

Terraform uses a **backend** to:

* Store state remotely
* Coordinate concurrent access
* Enable team collaboration

For AWS, the **S3 backend** is the most common choice.

As of **Terraform 1.3+**, **DynamoDB is optional**, but **not obsolete**.

---

## 2. Two Supported Locking Models

Terraform S3 backend now supports **two locking mechanisms**:

### 🔹 Model A: S3-only locking (Newer)

* Uses **S3 conditional writes**
* No DynamoDB table
* Lower setup complexity

### 🔹 Model B: S3 + DynamoDB locking (Traditional)

* Uses DynamoDB for explicit locks
* Strongest concurrency protection
* Industry standard for production

---

## 3. Model A — S3-only Backend (No DynamoDB)

### 3.1 How it works

* Terraform writes state using **ETag / If-Match**
* Prevents overwriting state if it changed
* Locking is **implicit**, not visible

### 3.2 Backend configuration

```hcl
terraform {
  backend "s3" {
    bucket  = "my-terraform-state"
    key     = "prod/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
```

### 3.3 Requirements

* Terraform ≥ 1.3
* S3 bucket with:

  * Versioning (recommended)
  * Encryption (recommended)

### 3.4 Pros

✅ No DynamoDB cost
✅ Simple setup
✅ Fewer AWS resources
✅ Works well for single-user workflows

### 3.5 Cons (important)

❌ No visible lock record
❌ No `terraform force-unlock`
❌ Hard to debug stuck applies
❌ Risky with parallel pipelines

---

## 4. Model B — S3 + DynamoDB Backend (Recommended for Prod)

### 4.1 How it works

* State stored in S3
* Lock stored explicitly in DynamoDB
* Only one writer allowed at a time

### 4.2 Backend configuration

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

### 4.3 DynamoDB table schema

| Attribute | Type                   |
| --------- | ---------------------- |
| LockID    | String (Partition Key) |

* No sort key
* On-demand capacity recommended

### 4.4 Pros

✅ Strong distributed locking
✅ Lock visibility
✅ Safe parallel pipelines
✅ `terraform force-unlock` supported
✅ CI/CD friendly

### 4.5 Cons

❌ Extra AWS resource
❌ Small DynamoDB cost

---

## 5. State Operations & Locking Behavior

| Operation              | S3-only           | S3 + DynamoDB |
| ---------------------- | ----------------- | ------------- |
| terraform apply        | Conditional write | DynamoDB lock |
| terraform import       | Conditional write | DynamoDB lock |
| terraform plan         | Read-only         | Read-only     |
| terraform state mv     | Conditional write | DynamoDB lock |
| terraform force-unlock | ❌ Not supported   | ✅ Supported   |

---

## 6. Import Behavior (Terraform ≥ 1.5)

### Declarative Import (Recommended)

```hcl
import {
  to = aws_s3_bucket.example
  id = "my-bucket-name"
}
```

* Works with **both backends**
* Locking behavior depends on backend type
* State stored in S3 in both cases

**Import blocks do NOT change backend behavior**

---

## 7. IAM Permissions (Minimal)

### 7.1 S3-only backend IAM

```json
{
  "Effect": "Allow",
  "Action": [
    "s3:GetObject",
    "s3:PutObject",
    "s3:DeleteObject",
    "s3:ListBucket"
  ],
  "Resource": [
    "arn:aws:s3:::my-terraform-state",
    "arn:aws:s3:::my-terraform-state/*"
  ]
}
```

### 7.2 Additional permissions for DynamoDB locking

```json
{
  "Effect": "Allow",
  "Action": [
    "dynamodb:GetItem",
    "dynamodb:PutItem",
    "dynamodb:DeleteItem",
    "dynamodb:UpdateItem"
  ],
  "Resource": "arn:aws:dynamodb:*:*:table/terraform-locks"
}
```

---

## 8. Failure Scenarios (Real World)

### Without DynamoDB

* Two pipelines start within seconds
* Both read same state
* One apply partially succeeds
* Second apply overwrites state
* Manual recovery needed

### With DynamoDB

* Second pipeline fails immediately:

```text
Error acquiring the state lock
```

* Infrastructure remains consistent

---

## 9. Recommended Usage (2025)

### ✅ Use **S3-only backend** when:

* Single developer
* No CI/CD
* Non-prod or sandbox
* Learning Terraform

### ✅ Use **S3 + DynamoDB backend** when:

* Multiple engineers
* CI/CD pipelines
* Production environments
* Shared AWS accounts

---

## 10. Best Practices (Both Models)

✔ Enable S3 versioning
✔ Use separate state per environment
✔ Backend config at root module only
✔ Never commit `.tfstate` locally
✔ Use import blocks for new imports

---

## 11. Final Recommendation

> **DynamoDB is optional — not deprecated**

For **production and team usage**:
👉 **S3 + DynamoDB remains best practice**

For **simple or solo setups**:
👉 **S3-only backend is acceptable**

---

If you want, I can:

* Convert this into **PDF / Confluence doc**
* Add **architecture diagrams**
* Provide **GitHub Actions examples**
* Share **migration steps DynamoDB → S3-only (safe way)**

Just tell me 👍
