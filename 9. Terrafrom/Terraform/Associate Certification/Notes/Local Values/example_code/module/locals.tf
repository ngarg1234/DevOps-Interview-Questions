locals{
    ami ="ami-0261755bbcb8c4a84"
    tags = "${var.tags_enabled == true ? "dev" : "no_tag"}"
}