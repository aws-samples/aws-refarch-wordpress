## History
---
Version: 2.0.2

Published Date: 2018-03-06

### Changes

Added functionality to allow multiple WordPress stacks to be launched and running concurrently.

Changed name of sample cli script from aws-refarch-wordpress-sample-cli.sh to aws-refarch-wordpress-sample-cli-newvpc.sh and changed the parameter file and master template referenced in the create-stack command from aws-refarch-wordpress-parameters.json to aws-refarch-wordpress-parameters-newvpc.json and aws-refarch-wordpress-master.yaml to aws-refarch-wordpress-master-newvpc.yaml respectively.

Hint: Will soon be adding a new master template to launch this stack into an existing vpc.

Added more sample values to the aws-refarch-wordpress-parameters-newvpc.json sample parameter file.

Added Author and License metadata to each template.

#### Master Template
Changed name of master template. Added "-newvpc" suffix.
[aws-refarch-wordpress-master-newvpc.yaml](templates/aws-refarch-wordpress-master-newvpc.yaml)

- Changed DatabaseMasterUsername MinLength constraint to 8, to align with the minimum length for Amazon RDS. Added "(minimum 8; maximum 16)" to the constraint description.

- Dropped passing the "ElastiCacheClusterName" parameter "!Ref DatabaseName" to the ElastiCache stack. ClusterName attribute is no longer provided when creating AWS::ElastiCache::CacheCluster. This will allow a unique identifier to be generated as the ClusterName.

## RDS Template
Review the template here [aws-refarch-wordpress-04-web.yaml](templates/aws-refarch-wordpress-04-web.yaml)

- Changed DatabaseMasterUsername MinLength constraint to 8, to align with the minimum length for Amazon RDS. Added "(minimum 8; maximum 16)" to the constraint description.

## ElastiCache Template
Review the template here [aws-refarch-wordpress-03-elasticache.yaml](templates/aws-refarch-wordpress-03-elasticache.yaml)

- Dropped passing the "ElastiCacheClusterName" parameter "!Ref DatabaseName" to the ElastiCache stack. ClusterName attribute is no longer provided when creating AWS::ElastiCache::CacheCluster. This will allow a unique identifier to be generated as the ClusterName. This will help allow for multiple WordPress stacks to be launched and running concurrently.

- CacheSubnetGroupName attributed is no longer provided when creating AWS::ElastiCache::SubnetGroup. This will allow a unique identifier to be generated as the CacheSubnetGroupName. This will help allow for multiple WordPress stacks to be launched and running concurrently.

## EFS Alarms Template
Review the template here [aws-refarch-wordpress-03-efsalarms.yaml](templates/aws-refarch-wordpress-03-efsalarms.yaml)

- Added alarm dependencies so alarms will be created serially and not in parallel.

---
Version: 2.0.1

Published Date: 2017-12-16

### Changes

#### Master Template
[aws-refarch-wordpress-master.yaml](templates/aws-refarch-wordpress-master.yaml)

**Parameter & functionality changes**
- Added WordPress version functionality. Possible values:
  - latest
  - nightly
  - 4.5
  - 4.6
  - 4.7
  - 4.8
  - 4.9

- Added a string field to an S3 object php.ini overrides file. Use the full https path of the object (e.g. https://s3.amazonaws.com/aws-refarch/wordpress/latest/bits/20-aws.ini).
- updated samples parameter file
- added sample 20-aws.ini to the samples directory

## WordPress Web Template
Review the template here [aws-refarch-wordpress-04-web.yaml](templates/aws-refarch-wordpress-04-web.yaml)

- Added WordPress version selection (latest, nightly, 4.5, 4.6, 4.7, 4.8, 4.9)
- Added field to enter full https path of php.ini overrides file (e.g. https://s3.amazonaws.com/aws-refarch/wordpress/latest/bits/20-aws.ini).

---
Version: 2.0.0

Published Date: 2017-12-11

### Changes

#### Master Template
[aws-refarch-wordpress-master.yaml](templates/aws-refarch-wordpress-master.yaml)

**Parameter & functionality changes**
- Changed parameter KeyName to EC2KeyName
- Added new General AWS group and moved the following parameters into this group:
  - EC2KeyName
  - SshAccessCidr
  - AdminEmail
  - WPDomainName
  - UseRoute53Boolean
  - UseCloudFrontBoolean
  - CloudFrontAcmCertificate
- Change parameter group names
- Able to set VPC and subnet CIDR blocks via master template parameters
- Added VPC parameters group
- Added number of Availability Zones dropdown (2 to 6)
- Ability to select the AZs
- Public subnet 0 CIDR
- Public subnet 1 CIDR
- Public subnet 2 CIDR
- Public subnet 3 CIDR
- Public subnet 4 CIDR
- Public subnet 5 CIDR
- Web subnet 0 CIDR
- Web subnet 1 CIDR
- Web subnet 2 CIDR
- Web subnet 3 CIDR
- Web subnet 4 CIDR
- Web subnet 5 CIDR
- Data subnet 0 CIDR
- Data subnet 1 CIDR
- Data subnet 2 CIDR
- Data subnet 3 CIDR
- Data subnet 4 CIDR
- Data subnet 5 CIDR
- PHP version (select 5.5, 5.6, or 7.0)
- Bastion instance type (all instance types)
- Encrypt database (boolean)
- Existing AWS MKS CMK for RDS
- Added r4 db instance class
- Added all instance types for web instance
- Renamed efs stack to efsfilesystem
- Added EfsCreateAlarm parameter
- Added new efsalarms stack
- Added new dashboard stack
- Pass new VPC parameters, number of AZs, list of AZs to VPC template
- Pass number of AZs & list of subnets from newvpc stack to publicalb template
- Pass number of AZs & list of subnets from newvpc stack to rds template
- Pass number of AZs & list of subnets from newvpc stack to web template
- Pass number of AZs & list of subnets from newvpc stack to bastion template
- Pass number of AZs & list of subnets from newvpc stack to efsfilesystem template
- Pass number of AZs & list of subnets from newvpc stack to elasticache template


### New default VPC and subnet IP ranges

The 'newvpc' stack defaults to the following network design (but these can be changed via master parameters):

| Item | CIDR Range | Usable IPs | Description |
| --- | --- | --- | --- |
| VPC | 10.0.0.0/16 | 65,536 | The whole range used for the VPC and all subnets |
| Web Subnet | 10.0.0.0/22 | 1022 | Private subnet in first Availability Zone |
| Web Subnet | 10.0.4.0/22 | 1022 | Private subnet in second Availability Zone |
| Web Subnet | 10.0.8.0/22 | 1022 | Private subnet in third Availability Zone |
| Web Subnet | 10.0.12.0/22 | 1022 | Private subnet in fourth Availability Zone |
| Web Subnet | 10.0.16.0/22 | 1022 | Private subnet in fifth Availability Zone |
| Web Subnet | 10.0.20.0/22 | 1022 | Private subnet in sixth Availability Zone |
| Data Subnet | 10.0.100.0/24 | 254 | Private subnet in first Availability Zone |
| Data Subnet | 10.0.101.0/24 | 254 | Private subnet in second Availability Zone |
| Data Subnet | 10.0.102.0/24 | 254 | Private subnet in third Availability Zone |
| Data Subnet | 10.0.103.0/24 | 254 | Private subnet in fourth Availability Zone |
| Data Subnet | 10.0.104.0/24 | 254 | Private subnet in fifth Availability Zone |
| Data Subnet | 10.0.105.0/24 | 254 | Private subnet in sixth Availability Zone |
| Public Subnet | 10.0.200.0/24 | 254 | Public subnet in first Availability Zone |
| Public Subnet | 10.0.201.0/24 | 254 | Public subnet in second Availability Zone |
| Public Subnet | 10.0.202.0/24 | 254 | Public subnet in third Availability Zone |
| Public Subnet | 10.0.203.0/24 | 254 | Public subnet in fourth Availability Zone |
| Public Subnet | 10.0.204.0/24 | 254 | Public subnet in fifth Availability Zone |
| Public Subnet | 10.0.205.0/24 | 254 | Public subnet in sixth Availability Zone |

## New VPC Template
Review the template here [aws-refarch-wordpress-01-newvpc.yaml](templates/aws-refarch-wordpress-01-newvpc.yaml)

- Able to set VPC and subnet CIDR blocks via master template parameters
- Added VPC parameters group
- Added number of Availability Zones dropdown (2 to 6)
- Ability to select the AZs to launch in
- Public subnet 0 CIDR
- Public subnet 1 CIDR
- Public subnet 2 CIDR
- Public subnet 3 CIDR
- Public subnet 4 CIDR
- Public subnet 5 CIDR
- Web subnet 0 CIDR
- Web subnet 1 CIDR
- Web subnet 2 CIDR
- Web subnet 3 CIDR
- Web subnet 4 CIDR
- Web subnet 5 CIDR
- Data subnet 0 CIDR
- Data subnet 1 CIDR
- Data subnet 2 CIDR
- Data subnet 3 CIDR
- Data subnet 4 CIDR
- Data subnet 5 CIDR
- Output list of all created public subnet ids
- Output list of all created web subnet ids
- Output list of all created data subnet ids

## Security Groups Template
Review the template here [aws-refarch-wordpress-02-securitygroups.yaml](templates/aws-refarch-wordpress-02-securitygroups.yaml)

- Updated efs security group to allow inbound SSH access from bastion security group

## Bastion Template
Review the template here [aws-refarch-wordpress-03-bastion.yaml](templates/aws-refarch-wordpress-03-bastion.yaml)

- Bastion instance type (all instance types)
- Updated instances to use Amazon Linux AMI 2017.09.1
- Added number of Availability Zones (2 to 6)
- Ability to select the subnets

## Amazon EFS File System Template
Review the template here [aws-refarch-wordpress-03-efsfilesystem.yaml](templates/aws-refarch-wordpress-03-efsfilesystem.yaml)

- Added number of Availability Zones (2 to 6)
- Ability to select the subnets
- Added Growth parameter to load dummy data to grow file system to achieve higher levels of throughput & IOPS
- Added auto scaling group to launches an EC2 instance that executes a parallel dd command to add dummy data
- Added instance type for the growth autoscaling group, uses efs security group
- Added EC2 keyname for the instance

## Amazon EFS Alarms Template
Review the template here [aws-refarch-wordpress-03-efsalarms.yaml](templates/aws-refarch-wordpress-03-efsalarms.yaml)
This is a new template & stack.
Depends on efsfilesystem stack & the CreateAlarm parameter
This AWS CloudFormation template will create two Amazon CloudWatch alarms that will send email notifications if the burst credit balance drops below two predefined thresholds, a 'Warning' threshold and a 'Critical' threshold. These thresholds are based on the number of minutes it would take to completely use all burst credits if the file system was being driven at the highest throughput rate possible, the permitted throughput rate. You enter these minute variables as input parameters in the Cloudformation template. The 'Warning' threshold and has a default value of 180 minutes. This means that a CloudWatch alarm will send an email notification 180 minutes before the credit balance drops to zero, based on the latest permitted throughput rate. The second alarm and notification is a 'Critical' notification and has a default value of 60 minutes. This alarm will send an email notification 60 minutes before the credit balance drops to zero, based on the latest permitted throughput rate. Permitted throughput is dynamic, scaling up as the file systems grows and scaling down as the file system shrinks. Therefore a third and fourth alarm is create that monitors permitted throughput. If the permitted throughput increases or decreases, an email notification is sent and an Auto Scaling Group will launch an EC2 instance that dynamically resets the 'Warning' and 'Critical' thresholds based on the latest permitted throughput rate. This EC2 instance will auto terminate and a new instance will launch to reset the thresholds only when the permitted throughput rate increases or decreases. It will also create a custom CloudWatch metric to monitor EFS file system size using a Lambda function.

- ElasticFileSystem
- Warning threshold
- Growth parameter to load dummy data to grow file system to achieve higher levels of throughput & IOPS
- Auto scaling group to launches an EC2 instance that executes a parallel dd command to add dummy data
- Instance type for the growth autoscaling group, uses efs security group
- EC2 keyname for the instance

## Amazon ElastiCache Template
Review the template here [aws-refarch-wordpress-03-elasticache.yaml](templates/aws-refarch-wordpress-03-elasticache.yaml)

- Added number of Availability Zones (2 to 6)
- Ability to select the subnets

## Amazon Elastic Load Balancing - Application Load Balancer Template
Review the template here [aws-refarch-wordpress-03-publicelb.yaml](templates/aws-refarch-wordpress-03-publicalb.yaml)

- Alb name is now the stack name (stack name must be 32 characters or less)
- Added number of Availability Zones (2 to 6)
- Ability to select the subnets

## Amazon RDS Template
Review the template here [aws-refarch-wordpress-03-rds.yaml](templates/aws-refarch-wordpress-03-rds.yaml)

- Encrypt database (boolean)
- Existing AWS MKS CMK for RDS
- Added r4 db instance class
- Added number of Availability Zones (2 to 6)
- Ability to select the subnets

## WordPress Web Template
Review the template here [aws-refarch-wordpress-04-web.yaml](templates/aws-refarch-wordpress-04-web.yaml)

- Added PHP version selection (5.5, 5.6, or 7.0) - a different LaunchConfiguration for each version
- Added all instance types for web instance
- Updated instances to use Amazon Linux AMI 2017.09.1
- Added number of Availability Zones (2 to 6)
- Ability to select the subnets

## Dashboard Template
Review the template here [aws-refarch-wordpress-06-dashboard.yaml](templates/aws-refarch-wordpress-06-dashboard.yaml)
This is a new template & stack.
This AWS CloudFormation template will create a CloudWatch dashboard with EFS, RDS, ELB metrics, including the EFS file system size custom metric. If EFS burst credit balance alarms were created, they are also included in the dashboard. 

- ElasticFileSystem
- DatabaseCluster
- PublicAlbFullName
- EfsCreateAlarms
- BurstCreditBalanceDecreaseAlarms
- BurstCreditBalanceIncreaseAlarms
- CriticalAlarmArn
- WarningAlarmArn
