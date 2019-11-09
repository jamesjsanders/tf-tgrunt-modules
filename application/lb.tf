resource "aws_lb" "alb" {
  name               = "${var.vpc_main_name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.aws_security_group_private_id}"]
  subnets            = ["${var.aws_subnet_public1_id}", "${var.aws_subnet_public2_id}"]
  tags = {
    Environment = "${var.environment}"
  }
}

resource "aws_lb_target_group" "webservers" {
  name                 = "${var.vpc_main_name}-webservers"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = "${var.vpc_main_id}"
  deregistration_delay = "30"

  health_check {
    path                = "/healthcheck"
    healthy_threshold   = "2"
    unhealthy_threshold = "2"
  }
}

/* resource "aws_lb_listener" "https" { */
/*   load_balancer_arn = "${aws_lb.alb.arn}" */
/*   port              = "443" */
/*   protocol          = "HTTPS" */
/*   ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01" */
/*   certificate_arn   = "${aws_acm_certificate.cert.arn}" */

/*   default_action { */
/*     type             = "forward" */
/*     target_group_arn = "${aws_lb_target_group.webservers.arn}" */
/*   } */
/* } */

resource "aws_lb_listener" "http" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.webservers.arn}"
  }
}

resource "aws_lb_listener_rule" "webservers" {
  listener_arn = "${aws_lb_listener.http.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.webservers.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/*"]
  }
}
