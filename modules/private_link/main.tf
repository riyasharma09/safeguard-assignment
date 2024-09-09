resource "aws_vpc_endpoint_service" "this" {
  acceptance_required        = true
  network_load_balancer_arns = [aws_lb.this.arn]
  allowed_principals         = var.allowed_principals
}

resource "aws_lb" "this" {
  name               = var.lb_name
  internal           = true
  load_balancer_type = "network"
  subnets            = var.subnet_ids
}
