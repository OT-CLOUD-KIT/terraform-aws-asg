locals {
  # Standard tag components
  base_name = "${var.bu}-${var.program}-${var.app}-${var.env}"

  common_tags = {
    "BusinessUnit" = var.bu
    "Program"      = var.program
    "Application"  = var.app
    "Environment"  = var.env
    "Team"         = var.team
     "region"       = var.region
    "ManagedBy"    = "Terraform"
  }
}


locals {
  maintenance_policy_type = (
    !var.enable_instance_maintenance_policy ? "no-policy" :
    var.min_healthy_percentage == 100       ? "launch-before-terminate" :
    var.min_healthy_percentage == 0         ? "terminate-and-launch" :
    "custom"
  )
}
