data "terraform_remote_state" "backendstate" {
  backend = "gcs"

  config {
    bucket = "${var.bucket}"
    prefix = "${var.env}"
  }
}

data "template_file" "state-file" {
  template = "*.tftfstate"
}
