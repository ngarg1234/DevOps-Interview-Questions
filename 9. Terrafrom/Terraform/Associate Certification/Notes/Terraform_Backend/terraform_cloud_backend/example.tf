terraform {
  backend "remote" {
    hostname              = "app.terraform.io"
    organization          = "tfdemo34246"
    workspaces {
      prefix              = "zehner-"
    }
  }
}


# in TF cloud, i have 2 workspaces xenher-prod and zenher-dev
#when i do a terraform apply, i will get an option to choose the workspace 