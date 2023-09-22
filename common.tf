locals {
  nginx_subnet    = "10.0.3.0/24"
  private_subnets = toset(["10.0.1.0/24", "10.0.2.0/24"])
  public_subnets  = toset([local.nginx_subnet, "10.0.4.0/24"])
  startup_script  = file("startup_script.sh")
  tags            = { env : "dev" }
}