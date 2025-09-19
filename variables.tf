variable "net_info" {
    description = "this below vpc and subnets values"
    type = object({
      vpcname = string
      vpccidr = string
      pub_sub_info = list(object({
        pubsubcidrs = list(string)
        pubsubazs = list(string)
        pubsubnames = list(string) 
      }))
      pr_sub_info = list(object({
        prsubnames = list(string)
        prazs = list(string)
        prcidrs = list(string)
      }))
    })
    default = {
      vpccidr = "10.0.0.0/16"
      vpcname = "vpcmyown"
      pub_sub_info = [ {
        pubsubcidrs = ["10.0.0.0/24", "10.0.1.0/24"]
        pubsubazs = ["ap-south-1a", "ap-south-1b"]
        pubsubnames = ["pubsub1", "pubsub2"]
      } ]
      pr_sub_info = [ {
        prcidrs = ["10.0.2.0/24","10.0.3.0/24"]
        prazs = ["ap-south-1b", "ap-south-1c"]
        prsubnames = ["prsub1", "prsub2"]
      } ]
    }
}







