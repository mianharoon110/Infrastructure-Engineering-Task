# Define the region for the AWS resources
variable "region" {
  default = "eu-central-1"
}

# Define the CIDR block for the VPC
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# Define the CIDR blocks for the private subnets
variable "private_subnet_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Define the CIDR blocks for the public subnets
variable "public_cidrs" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

# Define the availability zones for the AWS resources
variable "availability_zone" {
  type    = list(string)
  default = ["eu-central-1a", "eu-central-1b"]
}

# Define the EC2 instance type
variable "instance_type" {
  default = "t2.micro"
}

# Define the public SSH key
variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCmSmES2Qb18NehEH5lhG9zjEktONicodwImTiEg3ZRD51/a/f3zMmv+Pr0IHRroKvNngzKAucs8lvs/SSzulXKMIrP1cgESajH9d4E1uo6EyfTsN4Bt/k6JFSXPjSJQ1RoXEcCR0lUli5CAVg8m5xZ42W2YqMsDG5v+8R941j22X53eACKK5n9IYIpUG7DbqShuhDTyFENw+1gBfC/m39sRFmY8rJa6OmfbNw3fEnGdwPPZ7/nn2SopGkbi8nILS6+T8WpTUghX7JOgVrtvQ/+ORHNc6kTdxHq6+Ix377TWxoOMRd+M16VXPBqFQoHy0woY6MAC4Oc0A0tmr6AuECf3/nwm6rTiON15j5inlaq2O9nFBWVN8S+bQPRK4gMEbjGkHPZ0TLDRhrj6qmtzrTDKly1n7QDZc72gVNUHSm2776Sn6honi2aXIsQhqlN7SiU9r74ftgO3fvsVLscUHBjk9Dd1m0uTxtjGrxNng68eAY2iz2ZUbZdGTTZPbSoyVU= hp@DESKTOP-2HEBMAP"
}

# Define the git accedd token to clone python app
variable "git_token" {
  type    = string
  default = "XXXXXXXXXXXXXXX"
}

# Define specific list of IP's for access
variable "whitelist_ips" {
  type = list(string)
  default = [
    "192.168.8.16/32",  # VPN IP
    "95.223.72.160/32", # Personal HomeNetwork IP for testing only
  ]
}