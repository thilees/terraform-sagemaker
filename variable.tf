
variable "AWS_REGION" {
  default = "us-east-1"
}


locals {
  common_tags = {
   t_cost_centre = ""
   t_environment = "POC"
   t_AppID = "SVC03012"
   t_dcl = ""
   t_name = "CMBot"
   t_owner_individual = "thileepan.sivanantham@pearson.com"
  }
}


