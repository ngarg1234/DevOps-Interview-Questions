provider aws {
    region = "us-east-1"
}
resource "time_sleep" "temp"{
    create_duration = "500s"
}