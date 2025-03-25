

variable "list1"{
    type = list
    default = ["a","b","c"]
}

variable "list2"{
    type = list
    default = ["aa","bb","cc"]
}

output "combined"{
    value = zipmap(var.list1, var.list2)
}