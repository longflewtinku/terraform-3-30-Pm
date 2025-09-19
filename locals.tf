locals {
  public_subnets = length(var.net_info.pub_sub_info[0].pubsubnames)
}