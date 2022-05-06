# Define Local Values in Terraform
locals {
  owners      = var.business_divsion
  environment = var.environment
  name        = "${var.business_divsion}-${var.environment}"
  #name = "${local.owners}-${local.environment}"
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}

locals {
  multiple_instances = {
    one = {
      subnet_id = element(module.vpc.private_subnets, 0)
    }
    two = {
      subnet_id = element(module.vpc.private_subnets, 1)
    }
  }
}
