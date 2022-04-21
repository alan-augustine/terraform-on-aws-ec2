# Terraform AWS Application Load Balancer (ALB)
# There are:
# 1. http_tcp_listeners (we redirect here)
# 2. https_listeners
# There are also Target Groups and Target EC2 instances defined withon TGs
# Also, we specify https_listener_rules

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version =  "6.8.0" 

  name = "${local.name}-alb"
  load_balancer_type = "application"
  vpc_id = module.vpc.vpc_id
  subnets = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1]
  ]
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
      # App1 Target Group - Targets
      targets = {
        my_app1_vm1 = {
          target_id = module.ec2_private_app1[0].id
          port      = 80
        },
        my_app1_vm2 = {
          target_id = module.ec2_private_app1[1].id
          port      = 80
        }
      }
      tags =local.common_tags # Target Group Tags
    },
    # APP2 - TG index=1
    {
      name_prefix          = "app2-"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app2/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      # App1 Target Group - Targets
      targets = {
        my_app2_vm1 = {
          target_id = module.ec2_private_app2[0].id
          port      = 80
        },
        my_app2_vm2 = {
          target_id = module.ec2_private_app2[1].id
          port      = 80
        }
      }
      tags =local.common_tags # Target Group Tags
    }   
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
      actions = [
        {
          type               = "forward"
          target_group_index = 0
        }
      ]
      conditions = [{
        #path_patterns = ["/app1*"] - this was uncommented in previous section. 
        # now, use host_header based routing
        host_headers = [var.app1_dns_name]
      }]
    },
    # Rule-2: /app2* should go to App2 EC2 Instances    
    {
      https_listener_index = 0
      actions = [
        {
          type               = "forward"
          # go to target group index 1
          target_group_index = 1
        }
      ]
      conditions = [{
        #path_patterns = ["/app2*"]- this was uncommented in previous section. 
        # now, use host_header based routing
        host_headers = [var.app2_dns_name]
      }]
    }    
  ]
  tags = local.common_tags # ALB Tags
}
