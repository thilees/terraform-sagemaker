#Creating notebook instances
resource "aws_sagemaker_notebook_instance" "ni" {
  name          = "cmbot-notebook-instance"
  role_arn      = "${aws_iam_role.ni_role.arn}"
  instance_type = "ml.t2.medium"
  lifecycle_config_name = "${aws_sagemaker_notebook_instance_lifecycle_configuration.basic_lifecycle.name}"
  tags = local.common_tags

  depends_on = ["aws_s3_bucket.s3bucket"]
}

data "template_file" "instance_init" {
  template = "${file("${path.module}/template/sagemaker_instance_init.sh")}"

  vars = {
  }
}

resource "aws_sagemaker_notebook_instance_lifecycle_configuration" "basic_lifecycle" {
  name     = "BasicNotebookInstanceLifecycleConfig"
  on_start = "${base64encode(data.template_file.instance_init.rendered)}"

  depends_on = ["aws_s3_bucket_object.nodebook_script"]
}


