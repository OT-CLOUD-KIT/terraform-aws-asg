locals {
  # Standard tag components
  base_name = "${var.env}-${var.app}"

  common_tags = {
    env= var.env
    owner = var.owner
    app = var.app
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


