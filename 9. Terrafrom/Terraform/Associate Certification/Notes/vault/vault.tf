provider "vault" {
    address = "http://3.87.41.187:8200/"
}

data "vault_generic_secret" "yoyo" {
    path = "secret/mysql/webapp"
}

output "db_creds"{
    value = data.vault_generic_secret.yoyo.data_json
    sensitive = true
}


## i tired this practical by logging into vault as  root user 