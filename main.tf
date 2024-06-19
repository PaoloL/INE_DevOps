provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "my_repository" {
  name                 = "${var.owner}-registry"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

output "repository_url" {
  value = aws_ecr_repository.my_repository.repository_url
}
