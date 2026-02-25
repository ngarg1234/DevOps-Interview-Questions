resource "foo_value" "foo" {
  value = "foo"
}

resource "foo_value" "bar" {
  value = "bar"

  lifecycle {
    replace_triggered_by = [
      foo_value.foo,
    ]
  }
}
