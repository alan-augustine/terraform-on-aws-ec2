# Terraform AWS Application Load Balancer (ALB)
# Ref: https://github.com/alan-augustine/terraform-on-aws-ec2/tree/main/14-Autoscaling-with-Launch-Configuration#step-05-c10-02-alb-application-loadbalancertf

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version =  "6.8.0" 

  name = "${local.name}-alb"
  load_balancer_type = "application"
  vpc_id = module.vpc.vpc_id
  /*Option-1: Give as list with specific subnets or in next line, pass all public subnets 
  subnets = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1]
  ]*/
  subnets = module.vpc.public_subnets
  security_groups = [module.loadbalancer_sg.security_group_id]
  # Listeners:
  # port 443 lister is defined seprately as 'https_listeners'
  # port 80 lister is defined as 'http_tcp_listeners'
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]  
  # Target Groups
  target_groups = [
    # App1 Target Group - TG Index = 0
    {
      name_prefix          = "app1-"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      #Change: Commented the Targets for App1, App1 Targets now will be added automatically from ASG. 
      # HOW? In ASG, we will be referencing the load balancer target_group_arns= module.alb.target_group_arns
      # App1 Target Group - Targets
      /* targets = {
        my_app1_vm1 = {
          target_id = module.ec2_private_app1[0].id
          port      = 80
        },
        my_app1_vm2 = {
          target_id = module.ec2_private_app1[1].id
          port      = 80
        }
      } */
      tags =local.common_tags # Target Group Tags
    }
  # In this section for ASG, only App1 is used - no App2 or App3 , so deleted those compared to section 13 
  ]
  # HTTPS Listener
  # Listeners:
  # port 443 lister is defined  as 'https_listeners'
  # port 80 lister is defined seprately as 'http_tcp_listeners'
  https_listeners = [
    # HTTPS Listener Index = 0 for HTTPS 443
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = module.acm.acm_certificate_arn
      action_type = "fixed-response"
      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed Static message - for Root Context"
        status_code  = "200"
      }
    }, 
  ]

  # HTTPS Listener Rules - based on path_patterns
  https_listener_rules = [
    # Rule-1: /app1* should go to App1 EC2 Instances
    { 
      https_listener_index = 0
      priority = 1
      actions = [
        {
          type               = "forward"
          target_group_index = 0
        }
      ]
      conditions = [{
        path_patterns = ["/*"]
      }]
    }  
  ]
  tags = local.common_tags # ALB Tags
}
