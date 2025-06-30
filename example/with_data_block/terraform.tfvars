ami_id        = "ami-020cba7c55df1f615"
instance_type = "t2.micro"
key_name      = "terra"

security_group_ids = ["sg-04fb2f273d8865af3"]
subnet_ids         = ["subnet-08a2aa30dbc179a2b", "subnet-08a2aa30dbc179a2b"]
target_group_arns  = ["arn:aws:elasticloadbalancing:us-east-1:557186391124:targetgroup/demo/87a9b2963a03085c"]

min_size         = 1
max_size         = 1
desired_capacity = 1

tags = {
  Environment = "production"
  Team        = "devops"
}




############################333

# Application-related settings
applicaton_name                = "myapp"
applicaton_port                = 8080
applicaton_health_check_target = "/health"

# Target group configuration
tg_target_type = "instance"
tg_protocol    = "HTTP"
instance_id    = "i-07d3223c9de3456c9"

