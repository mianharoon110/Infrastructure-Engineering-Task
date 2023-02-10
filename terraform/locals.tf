# Define local variables to store lists of common port numbers
locals {
  alb_ports_in    = [80]
  bastion_ports   = [22]
  outbound_access = [80]
  app_ports_in    = [80, 22]
  app_ports_out   = [443]
}