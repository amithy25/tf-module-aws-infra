include "root" {
  path = find_in_parent_folders()
}

locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals
}

terraform {
  source = "${get_repo_root()}/eks/_modules"
}

inputs = {
    cluster_name = "skillupwithsachin-eks-demo"
    node_groups_config = {
        skillupwithsachin-eks-demo-ng-1 = {
             instance_types = ["c6a.xlarge"]
             min_size       = 1
             max_size       = 1
             desired_size   = 1
             disk_size      = 40
             subnet_ids     = ["subnet-f3507acd", "subnet-5d449d53"]
             iam_role_name  = "skillupwithsachin-eks-demo-node-role"
        }
    }
}