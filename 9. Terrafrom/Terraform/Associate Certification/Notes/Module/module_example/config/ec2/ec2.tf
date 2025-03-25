
module "test_module"{
    source = "../../module/ec2"
    instance_type = "t2.medium" #this will override the default value given inside the module
}

module "eip"{
    source = "../../module/eip"
    instance_id = module.test_module.instanceid(this is how we use output from one module into another )
}


output "instance_ip"{
    value = module.test_module.publicip
}

## IMP NOTE -
# even if you have a output block defined inside the module script, it will not print the output when you are refering to the module
# so if you want to propagate output from module to the main config, you have to refer to the output block defined inside the module(like line 6-8)