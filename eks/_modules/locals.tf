locals {
  node_group_name = format("%s-ng-1", var.cluster_name)

  azs = slice(data.aws_availability_zones.available.names, 0, 2)

  # To be concatinated with the node group configuration (var.node_groups_config)
  block_device_mappings = {
    xvda = {
      device_name = "/dev/xvda"
      ebs = {
        volume_size           = 40
        volume_type           = "gp3"
        encrypted             = true
        delete_on_termination = true
      }
    }
  }

  # Merge block_device_mappings with each node group configuration
  node_groups_with_block_devices = {
    for name, config in var.node_groups_config : name => merge(
      config,
      { block_device_mappings = local.block_device_mappings }
    )
  }
}