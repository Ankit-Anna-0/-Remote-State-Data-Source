# Remote State Data Source

![Screenshot_5-12-2025_172548_lucid app](https://github.com/user-attachments/assets/3fc0dc37-411f-4fc3-87d8-99483d9a2103)



## Overview

This project demonstrates how Terraform can use a **Remote State Data Source** to allow one team’s Terraform configuration to consume the output values produced by another team. The Networking Team manages networking-related infrastructure and exposes outputs via remote state. The Security Team retrieves these outputs and applies them to firewall and security rules.

---

## Project Structure

├── backend.tf # Networking Team
├── eip.tf # Networking Team
├── data.tf # Security Team
└── sg.tf # Security Team


---

## Team Responsibilities

###  Networking Team

**Files:** `backend.tf`, `eip.tf`

- Configures the Terraform remote backend to store the `terraform.tfstate` file in an S3 bucket.
- Creates an **Elastic IP** resource.
- Outputs the Elastic IP so it can be consumed by other Terraform configurations.

###  Security Team

**Files:** `data.tf`, `sg.tf`

- Uses `terraform_remote_state` data source to fetch outputs from the Networking Team’s `terraform.tfstate`.
- Retrieves the EIP value dynamically.
- Applies this EIP to whitelist rules inside the Security Group’s ingress configuration.

---

## Practical Workflow Steps

1. Create two folders: one for the **Networking Team** and one for the **Security Team**.
2. In the Networking Team folder, create an **Elastic IP** resource and configure Terraform to store the state file in an **S3 bucket**. Output the EIP in `outputs.tf`.
3. In the Security Team folder, use the **Terraform Remote State Data Source** to connect to the state file created by the Networking Team.
4. Fetch the EIP from the remote state and **whitelist** it inside a Security Group ingress rule.

---

## What Needs to Be Achieved

1. The Security Team must successfully reference the `terraform.tfstate` file generated and managed by the Networking Team.
2. The Security Team must retrieve all IP addresses exposed through the Networking Team’s Terraform output values.
3. The Security Team must whitelist those IP addresses in firewall or security group rules.

---

## Infrastructure Data Flow

Networking Team → Creates Elastic IP → Exports EIP as output in remote state
↓
Security Team → Reads remote state via terraform_remote_state → Whitelists EIP


---

## Benefits of Remote State Data Source

✔ Enables inter-team infrastructure dependency without manual IP exchange  
✔ Ensures dynamic updates—changes in Networking Team state automatically propagate to Security Team  
✔ Improves modularity and separation of responsibilities  
✔ Eliminates hardcoding and reduces configuration drift  

---

## Deployment Steps

```bash
terraform init
terraform plan
terraform apply
```

## Output

![Screenshot_5-12-2025_16652_ap-south-1 console aws amazon com](https://github.com/user-attachments/assets/0ce27008-b75c-4e01-af24-58affe64fb59)
<img width="856" height="699" alt="Screenshot 2025-12-05 160739" src="https://github.com/user-attachments/assets/5955fc49-7742-42e3-a65d-e7251cf53a63" />


