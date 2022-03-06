# rds.tf
module "db" {
  source = "../../"

  identifier = local.name

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine               = "mysql"
  engine_version       = "8.0.27"
  family               = "mysql8.0" # DB parameter group
  major_engine_version = "8.0"      # DB option group
  instance_class       = "db.t2.micro"

  allocated_storage     = 20
  max_allocated_storage = 100

  db_name  = "prestashop"
  username = "prestashop_user"
  port     = 3306

  #multi_az               = true
  subnet_ids             = aws_subnet.private_a.id
  #vpc_security_group_ids = [module.security_group.security_group_id]
  security_groups = [
      aws_security_group.egress_all.id,
      aws_security_group.database.id,
    ]

  #maintenance_window              = "Mon:00:00-Mon:03:00"
  #backup_window                   = "03:00-06:00"
  #enabled_cloudwatch_logs_exports = ["general"]
  #create_cloudwatch_log_group     = true

  #backup_retention_period = 0
  #skip_final_snapshot     = true
  #deletion_protection     = false

  #performance_insights_enabled          = true
  #performance_insights_retention_period = 7
  #create_monitoring_role                = true
  #monitoring_interval                   = 60

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  tags = local.tags
  db_instance_tags = {
    "Sensitive" = "high"
  }
  db_option_group_tags = {
    "Sensitive" = "low"
  }
  db_parameter_group_tags = {
    "Sensitive" = "low"
  }
  db_subnet_group_tags = {
    "Sensitive" = "high"
  }
}
