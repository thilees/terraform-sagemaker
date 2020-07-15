resource "aws_s3_bucket" "s3bucket" {
  bucket = "sagemaker-robotic-cm-bot"
  acl    = "private"
  force_destroy = true

  server_side_encryption_configuration {
    rule {
         apply_server_side_encryption_by_default {
           sse_algorithm = "AES256"
         }
    }
  }

   tags = local.common_tags
}

resource "aws_s3_bucket_object" "trainingdata" {
  bucket = "sagemaker-robotic-cm-bot"
  key    = "training-data.csv"
  source = "artifacts/traningdata.csv"
  etag = "${filemd5("artifacts/traningdata.csv")}"
  depends_on = [aws_s3_bucket.s3bucket]
}


resource "aws_s3_bucket_object" "nodebook_script" {
  bucket = "sagemaker-robotic-cm-bot"
  key    = "RoboticCM.ipynb"
  source = "artifacts/RoboticCM.ipynb"
  etag = "${filemd5("artifacts/RoboticCM.ipynb")}"
  depends_on = [aws_s3_bucket.s3bucket]
}


