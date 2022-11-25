# Usage

## 

## Files Structure

| Name               | Description                                                     | File Type |
| ------------------ | --------------------------------------------------------------- | --------- |
| [main.tf](main.tf) | - Contains provider AWS<br>- Locals: VPC and EC2 configurations | Terraform |
| [ec2.tf](ec2.tf)   | Creates multiple EC2 (Amazon AMI Image) based on subnets        | Terraform |
| [vpc.tf](vpc.tf)   | Creates subnets based on `main.tf` locals                       | Terraform |

## Terraform Commands

Commands necessary

1. Install necessary modules and initiate terraform

```sh
terraform init
```

2. Inside the container, plan de architecture

```sh
terraform plan -out main.tfplan
```

3. Apply planification

```sh
terraform apply main.tfplan
```

---

## Requirements

For an interactive and fast deployment Visual Code provides `.devcontainers` so a container with all the tools needer are already provision

| Name                                                                                                                  | Version   |
| --------------------------------------------------------------------------------------------------------------------- | --------- |
| terraform                                                                                                             | >= 0.13.0 |
| aws                                                                                                                   | >= 2.0    |
| Visual Code                                                                                                           | >= 1.73   |
| [Dev Containers VC extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) | latest |

---

## Providers

| Name      | Version   |
| --------- | --------- |
| aws       | >= 2.0    |

---

## Modules

| Name                                                                                                | Type   |
| --------------------------------------------------------------------------------------------------- | ------ |
| [vpc](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)                   | module |
| [ec2_instance](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest) | module |

---

## Subnetting Range

| #   | Network   Name | Required   Hosts | Network       | Mask | Decimal   Mask  | Obtained   Hosts | First   Usable Host | Last   Usable Host | Broadcast   Address |
| --- | -------------- | ---------------- | ------------- | ---- | --------------- | ---------------- | ------------------- | ------------------ | ------------------- |
| 1   | Office_1       | 500              | 192.168.0.0   | 23   | 255.255.254.0   | 510              | 192.168.0.1         | 192.168.1.254      | 192.168.1.255       |
| 2   | Office_2       | 80               | 192.168.2.0   | 25   | 255.255.255.128 | 126              | 192.168.2.1         | 192.168.2.126      | 192.168.2.127       |
| 3   | Office_3       | 40               | 192.168.2.128 | 26   | 255.255.255.192 | 62               | 192.168.2.129       | 192.168.2.190      | 192.168.2.191       |
| 4   | Remote_Office  | 20               | 192.168.2.192 | 27   | 255.255.255.224 | 30               | 192.168.2.193       | 192.168.2.222      | 192.168.2.223       |

