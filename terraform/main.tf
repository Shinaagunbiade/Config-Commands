provider "aws" {
    region = "us-west-2"
    access_key = "AKIA5PKMJEY2H7TJQ4B6"
    secret_key = "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"
}

resource "aws_vpc" "demo-vpc" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "demo_subnet-1" {
    vpc_id = aws_vpc.demo-vpc.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "us-west-2a"
}

data "aws_vpc" "existing-vpc-prov" {
    default = true
}

# get cidr_block of the existing subnet from aws console
resource aws_subnet "demo-existing-subnet-1" {
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = "172.31.80.0/20"
    availability_zone = "us-west-2b"
}