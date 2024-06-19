provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "my_repository_bikes" {
  name                 = "${var.owner}-bikes_repo"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "my_repository_cars" {
  name                 = "${var.owner}-cars_repo"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

output "bikes_repository_url" {
  value = aws_ecr_repository.my_repository_bikes.repository_url
}

output "cars_repository_url" {
  value = aws_ecr_repository.my_repository_cars.repository_url
}
