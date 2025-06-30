ami_id        = "ami-020cba7c55df1f615"
instance_type = "t2.micro"
key_name      = "terra"

lt_sg_id         = "sg-04fb2f273d8865af3"
subnet_ids       = ["subnet-08a2aa30dbc179a2b", "subnet-08a2aa30dbc179a2b"]
vpc_id           = "vpc-0bfa15004ff55e107"
min_size         = 1
max_size         = 1
desired_capacity = 1

############################333

# Application-related settings
applicaton_name                = "myapp"
applicaton_port                = 8080
applicaton_health_check_target = "/health"

# Target group configuration
tg_target_type = "instance"
tg_protocol    = "HTTP"
instance_id    = "i-09f81359fbc02b150"


################# Naming Convension #####################

random_alphanumeric_len = 4

bu       = "ot"
app      = "bp"
env      = "d"
resource = "Auto_scaling"

special = false
upper   = false
number  = true

gen_no_of_names = 1

team    = "infra"
program = "ot"

