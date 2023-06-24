# # Define the Auto Scaling group
# resource "aws_autoscaling_group" "example" {
#   #availability_zones   = [module.network_avilabilty_zone1_id, module.network_avilabilty_zone2_id]
#   desired_capacity     = 2
#   launch_configuration = [aws_instance.public1.id, aws_instance.public2.id]
#   max_size             = 4
#   min_size             = 2

#   tag {
#     key                 = "Name"
#     value               = "example-asg"
#     propagate_at_launch = true
#   }

#   # Define the scaling policy
#    scaling_policy {
#      adjustment_type    = "ChangeInCapacity"
#      cooldown           = 300
#      scaling_adjustment = 1
#    }
# }