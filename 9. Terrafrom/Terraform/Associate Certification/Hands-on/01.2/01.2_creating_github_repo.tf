terraform{
    required_providers{
        github = {
            source = "integrations/github"
            version = "~> 5.0"
        }
    }
}


provider "github"{
    token = "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"
}

resource "github_repository" "terraform_managed" {
    name = "created_using_terraform"
    description = "this repo is created using terraform script"
    visibility = "public"
}