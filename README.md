# Official ASG Module
### Variables for ASG module:
### INPUT
__________
**ami_id**: (Required) 
- description : The Amazon Machine Image Id that the ec2 instance should run on.
- data type : **string**
- example : 
```
ami-abc123
```
**autoscaling_group_name** : (Required) 
- description : The name of the auto scaling group.
- data type : **string**
- example :
```
my_autoscaling_group
```
**subnet_ids** : (Required)  
- description :The subnets that the autoscaling groups should use.
- data type : **list(string)**
- example :
```
[subnet-12ab, subnet-34cd]
```
**launch_template_name** : (Required)  
- description : The Name for the Launch template.
- data type : **string**
- example :
```
my_launch_template
```
**key_name** : (Required) 
- description : The name of the key to be used for ssh.
- data type : **string**
- example :
```
my_ssh_keypair_name
```
**tags** : (Required) 
- description :the tags which contains the basic information of the owner, origin etc.
- data type : **map(string)**
- example : [link](https://source.syncron.team/plugins/gitiles/op/terraform/modules/official-tags/)
**aws_region** : (Required) 
- description : the aws region to which this module needs to be deployed to.
- data type : **string**
- example :
```
eu-west-1
```
**aws_account_name** : (Required)  
- description : the aws account name to which the module needs to be deployed to.
- data type : **string**
```
op-dev
```
**availability_zones** : (Optional)
- note : not to be used when subnet_ids is defined, conflicts with subnet_ids.
- description : The availability zones in which the EC2 instances will be placed.
- data type : **list(string)**
- example :
```
[us-east-1a,us-east-1b]
```
iam_instance_profile_name : (Optional) 
- description : The name of the instance profile to be used for the instance.
- data type : **string**
- default :  _empty_
- example :
```
my_instance_profile
```
associate_public_ip : (Optional) 
- description : Whether the instances should have public IP or not.
- data type : bool
- default : false
- example :
```
true/false
```
security_groups : (Optional) 
- description : The security groups to be attached to the autoscaling instances.
- data type : **list(string)**
- default : _empty_
- example :
```
[sg-123abc, sg-456def]
```
lifecycle_hook_name : (Optional) 
- description : The name of the lifecycle hook.
- data type : **string**
- default : _empty_
- example :
```
my_lifecycle_hook
```
default_result : (Optional) 
- description : The action the Auto Scaling group should take when the lifecycle hook timeout elapses or if an unexpected failure occurs.
- data type : **string**
- default : _empty_
- example :
```
CONTINUE
```
heartbeat_timeout : (Optional) 
- description : The amount of time, in seconds, that can elapse before the lifecycle hook times out.
- data type : **number**
- default : 300
- example :
```
500
```
lifecycle_transistion : (Optional) 
- description : The instance state to which the lifecycle hook should be attached to.
- data type : **string**
- default : _empty_
- example :
```
autoscaling:EC2_INSTANCE_LAUNCHING
```
strategy : (Optional)
- description : The type of strategy that the deployment should follow.
- data type : **string**
- default : _empty_
- example :
```
rolling
```
min_healthy_percentage : (Optional) 
- description : The minimum health percentage that should be present during the deployment.
- data type : **number**
- default : 50
- example :
```
75
```
user_data : (Optional)
- description : The path to bootstrap scripts that needs run during instance creation.
- data type : **string**
- example :
```
"${path.module}/my_directory/user_data.json"
```
default_cooldown : (Optional)
- description : The cooldown period that prevents additional instances being added or deleted during a scaling activity.
- data type : **number**
- default : 500
- example :
-
```
30
```
desired_capacity : (Optional)
- description : The number of instances that should be running at a given time.
- data type : **number**
- example :
- default : 0
```
2
```
max_size : (Optional)
- description : The maximum number of instances that the autoscaling group can spawn.
- data type : **number**
- default : 10
- example :
```
4
```
min_size : (Optional)
- description : The minimum number of instances that need to be running at a given time.
- data type : **number**
- default : 0
- example :
```
1
```
health_check_type : (Optional)
- description: The type of health check that the autoscaling group should perform to check health of instance.
- data type : **string**
- default : "EC2"
- example :
```
EC2/ELB
```
**health_check_grace_period** : (Optional)
- description: The time period to perform health checks in seconds.
- data type : **number**
- default : 60
- example :
```
30
```
**instance_type** : (Optional)
- description : The type of instances the Auto Scaling group needs to spawn.
- data type : **string**
- default : "t2.micro"
- example :
```
t2.micro
```
block_device_mappings : (Optional)
- description : The information regarding the EBS volumes to be attached to the instance.
- data type : **list(map(string))**
- default : []
- example :
```
[{
    "device_name":                 "/dev/xvda",
    "volume_size":                 30,
    "volume_type":                 "gp3",
    "delete_on_termination":       true,
    "encryption_enabled":          true,
    "kms":                         "arn:aws:kms:eu-west-1:12345678:key/123ab-456cd-789ef-90gh-12igk",
    "associate_public_ip_address": false,
}]
```
The block_device_mappings variable will accept the following parameters:
ebs_device_name : (Required) 
- description : The name for the ebs volume, please refer the [guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html) to get more information on block device naming.
- data type : **string**
- default : _empty_
ebs_volume_size : (Optional)  
- description : The size of the ebs volume:
- data type : **number**
- default : 30
ebs_volume_type : (Optional) 
- description : The type of ebs volumes like gp2,io2 etc.
- data type : **string**
- default : gp2
delete_on_termination : (Optional) 
- description : Whether the EBS volume should be deleted on termination or not.
- data type : **string**
- default : yes
encryption_enabled : (Optional) 
- description : Whether the EBS volume should be encrypted or not.
- data type : **string**
- default : false
kms : (Optional)  
- description : The kms key arn for the to be used for the encyption.
- data type : **string**
- default : _empty_
### OUTPUT
**autoscaling_group_name**: 
- description : The name of the autoscaling group being created.<br>
- data type : **string**
- example :
```
example_autoscaling_name
```
**load_balancer_arn** : 
- description : The arn of the load balancer attached to the autoscaling group.<br>
- data type: **string**
- example :
```
arn:aws:elasticloadbalancing:eu-west-1:12345678:loadbalancer/app/my-alb/123123abc
```
**target_group_arn** :
- description : The arn of the target_group.<br>
- data type : **string**
- example :
```
arn:aws:elasticloadbalancing:eu-west-1:12345678:targetgroup/example-target/123123abc
```
**launch_template_name** : 
- description : The name of the launch template for the autoscaling group.<br>
- data type : **string**
- example :
```
example_target_group
```
## TODO
1. Add Test cases for mixed instances.
2. Add Test cases for lifecyclehook and instance refresh.
3. More validations for asg.
