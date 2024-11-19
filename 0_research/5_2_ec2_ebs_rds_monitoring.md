- [Monitoring and Alerting for AWS EC2](#monitoring-and-alerting-for-aws-ec2)
  - [Introduction to AWS EC2](#introduction-to-aws-ec2)
  - [Learning Objectives](#learning-objectives)
  - [Overview of EC2](#overview-of-ec2)
  - [Importance of Monitoring and Alerting](#importance-of-monitoring-and-alerting)
  - [CloudWatch Metrics](#cloudwatch-metrics)
  - [Key Features for Monitoring EC2 Instances](#key-features-for-monitoring-ec2-instances)
  - [Benefits of Alarm Actions](#benefits-of-alarm-actions)
  - [System-Level Checks](#system-level-checks)
- [Monitoring AWS EC2 Instances](#monitoring-aws-ec2-instances)
  - [Setting Up an EC2 Instance](#setting-up-an-ec2-instance)
  - [Monitoring Metrics](#monitoring-metrics)
    - [Default Metrics](#default-metrics)
    - [Enable Detailed Monitoring](#enable-detailed-monitoring)
  - [Importance of Detailed Monitoring](#importance-of-detailed-monitoring)
  - [Viewing Metrics](#viewing-metrics)
    - [Metrics Collection](#metrics-collection)
    - [Detailed Charts](#detailed-charts)
- [AWS EC2 and AWS CloudWatch Alarms](#aws-ec2-and-aws-cloudwatch-alarms)
  - [Setting Up CloudWatch Alarms](#setting-up-cloudwatch-alarms)
    - [1. Navigate to CloudWatch Console](#1-navigate-to-cloudwatch-console)
    - [2. Select Metrics](#2-select-metrics)
  - [Configuring the Alarm](#configuring-the-alarm)
    - [1. Select Metric](#1-select-metric)
    - [2. Create Alarm](#2-create-alarm)
  - [Configuring Actions for the Alarm](#configuring-actions-for-the-alarm)
    - [Notification](#notification)
    - [Auto Scaling](#auto-scaling)
    - [EC2 Action](#ec2-action)
  - [Finalising the Alarm](#finalising-the-alarm)
    - [Set Conditions](#set-conditions)
    - [Create IAM Role](#create-iam-role)
    - [Create Alarm](#create-alarm)
  - [Monitoring the Alarm](#monitoring-the-alarm)
- [AWS EC2 System Checks and Metrics](#aws-ec2-system-checks-and-metrics)
  - [Types of Status Checks](#types-of-status-checks)
    - [System Status Checks](#system-status-checks)
    - [Instance Status Checks](#instance-status-checks)
  - [Monitoring Status Checks](#monitoring-status-checks)
  - [Important Metrics for EC2 Instances](#important-metrics-for-ec2-instances)
  - [Viewing Metrics](#viewing-metrics-1)
  - [Custom Metrics](#custom-metrics)
- [Custom Metrics for AWS EC2](#custom-metrics-for-aws-ec2)
  - [Custom Metrics in AWS CloudWatch](#custom-metrics-in-aws-cloudwatch)
  - [Creating an IAM Role](#creating-an-iam-role)
  - [Launching a New EC2 Instance](#launching-a-new-ec2-instance)
  - [Connecting to the EC2 Instance](#connecting-to-the-ec2-instance)
  - [Downloading and Running Perl Scripts](#downloading-and-running-perl-scripts)
- [Push Custom Metrics from AWS EC2 to AWS CloudWatch](#push-custom-metrics-from-aws-ec2-to-aws-cloudwatch)
  - [Important Files and Their Functions](#important-files-and-their-functions)
    - [mon-put-instance-data.pl](#mon-put-instance-datapl)
    - [mon-get-instance-stats.pl](#mon-get-instance-statspl)
    - [creds-template](#creds-template)
  - [Running Perl Scripts](#running-perl-scripts)
    - [Execution](#execution)
    - [Viewing Metrics](#viewing-metrics-2)
  - [Automating Metric Collection](#automating-metric-collection)
- [Quiz](#quiz)
- [Monitoring and Alerting for AWS EBS](#monitoring-and-alerting-for-aws-ebs)
  - [EBS Overview](#ebs-overview)
  - [EBS Volume Types](#ebs-volume-types)
  - [Performance Factors](#performance-factors)
  - [EBS SSD Volume Types](#ebs-ssd-volume-types)
  - [IO Credits](#io-credits)
- [AWS EBS Volume Types](#aws-ebs-volume-types)
  - [Io1 (Provisioned IOPS SSD)](#io1-provisioned-iops-ssd)
  - [Hard Disk Volumes](#hard-disk-volumes)
    - [Throughput Optimised HDD (st1)](#throughput-optimised-hdd-st1)
    - [Cold HDD (sc1)](#cold-hdd-sc1)
  - [Performance Comparison](#performance-comparison)
- [Monitoring AWS EBS Volumes](#monitoring-aws-ebs-volumes)
  - [Understanding EBS Metrics](#understanding-ebs-metrics)
  - [EBS Volume Types](#ebs-volume-types-1)
  - [Status Checks](#status-checks)
  - [Monitoring EBS Volumes](#monitoring-ebs-volumes)
    - [Accessing EBS Volumes](#accessing-ebs-volumes)
    - [Viewing Metrics](#viewing-metrics-3)
  - [Important Metrics](#important-metrics)
    - [Read and Write Bandwidth](#read-and-write-bandwidth)
    - [Burst Balance](#burst-balance)
  - [Handling Inconsistencies](#handling-inconsistencies)
- [Summary of Module](#summary-of-module)
- [Quiz](#quiz-1)
- [Introduction to Monitoring and Alerting for AWS RDS](#introduction-to-monitoring-and-alerting-for-aws-rds)
  - [Introduction to AWS RDS](#introduction-to-aws-rds)
  - [Key Learning Objectives](#key-learning-objectives)
  - [Importance of Monitoring RDS](#importance-of-monitoring-rds)
  - [Monitoring Tools and Features](#monitoring-tools-and-features)
    - [CloudWatch Metrics](#cloudwatch-metrics-1)
    - [Events](#events)
    - [Database Logs](#database-logs)
  - [Practical Steps](#practical-steps)
    - [Viewing Metrics](#viewing-metrics-4)
    - [Setting Up Event Notifications](#setting-up-event-notifications)
    - [Accessing Logs](#accessing-logs)
- [Monitoring AWS RDS Metrics](#monitoring-aws-rds-metrics)
  - [Core Metrics for AWS RDS](#core-metrics-for-aws-rds)
    - [CPU Utilisation](#cpu-utilisation)
    - [Database Connections](#database-connections)
    - [Freeable Memory](#freeable-memory)
    - [Free Storage Space](#free-storage-space)
  - [IOPS and Latency Metrics](#iops-and-latency-metrics)
    - [Read IOPS and Write IOPS](#read-iops-and-write-iops)
    - [Read Latency and Write Latency](#read-latency-and-write-latency)
  - [Monitoring and Alarms](#monitoring-and-alarms)
    - [Viewing Metrics](#viewing-metrics-5)
    - [Creating Alarms](#creating-alarms)
  - [Practical Steps](#practical-steps-1)
    - [Accessing Metrics](#accessing-metrics)
    - [Setting Up Notifications](#setting-up-notifications)
  - [Importance of Monitoring](#importance-of-monitoring)
- [AWS RDS Events](#aws-rds-events)
  - [Monitoring Key Metrics](#monitoring-key-metrics)
  - [Key Metrics to Monitor](#key-metrics-to-monitor)
  - [CloudWatch Events for RDS](#cloudwatch-events-for-rds)
  - [Setting Up Event Subscriptions](#setting-up-event-subscriptions)
  - [Verifying Event Notifications](#verifying-event-notifications)
- [Quiz](#quiz-2)
- [Introduction to Monitoring and Alerting for AWS ELB](#introduction-to-monitoring-and-alerting-for-aws-elb)
  - [Introduction to AWS ELB](#introduction-to-aws-elb)
  - [Importance of ELB](#importance-of-elb)
  - [Key Metrics to Monitor](#key-metrics-to-monitor-1)
  - [Monitoring Procedures](#monitoring-procedures)
- [Deploy AWS ELB](#deploy-aws-elb)
  - [Steps to Deploy an ELB](#steps-to-deploy-an-elb)
  - [Monitoring ELB](#monitoring-elb)
- [AWS ELB Metrics](#aws-elb-metrics)
  - [Key Metrics for Monitoring ELB Instances](#key-metrics-for-monitoring-elb-instances)
    - [Backend Connection Errors](#backend-connection-errors)
    - [Latency](#latency)
    - [Surge Queue Length](#surge-queue-length)
    - [Spillover Count](#spillover-count)
    - [HTTP Status Codes](#http-status-codes)
    - [Request Count](#request-count)
    - [Healthy Host Count](#healthy-host-count)
    - [Unhealthy Host Count](#unhealthy-host-count)
- [Monitor AWS ELB Metrics](#monitor-aws-elb-metrics)
  - [Checking ELB Metrics in AWS Management Console](#checking-elb-metrics-in-aws-management-console)
    - [Accessing ELB Metrics](#accessing-elb-metrics)
    - [Instances Tab](#instances-tab)
    - [Health Check Tab](#health-check-tab)
    - [Listeners Tab](#listeners-tab)
    - [Monitoring Tab](#monitoring-tab)
    - [DNS URL](#dns-url)
  - [Testing ELB Connection](#testing-elb-connection)
  - [Key Metrics to Monitor](#key-metrics-to-monitor-2)
    - [Healthy and Unhealthy Instances](#healthy-and-unhealthy-instances)
    - [Average Latency](#average-latency)
    - [HTTP Status Codes](#http-status-codes-1)
  - [Monitoring HTTP Status Metrics](#monitoring-http-status-metrics)
  - [Starting EC2 Instances](#starting-ec2-instances)
- [Quiz](#quiz-3)
- [Monitoring and Alerting for AWS Billing and Costs](#monitoring-and-alerting-for-aws-billing-and-costs)
  - [Introduction to AWS Billing and Costs](#introduction-to-aws-billing-and-costs)
  - [AWS Billing Structure](#aws-billing-structure)
  - [Importance of Monitoring Billing](#importance-of-monitoring-billing)
  - [Monitoring Billing and Costs](#monitoring-billing-and-costs)
  - [Setting Up Billing Alerts](#setting-up-billing-alerts)
  - [Enabling Billing Alerts](#enabling-billing-alerts)
- [Monitor AWS Billing](#monitor-aws-billing)
  - [Navigating to Billing Dashboard](#navigating-to-billing-dashboard)
    - [Access Billing Dashboard](#access-billing-dashboard)
    - [Preferences for Billing Alerts](#preferences-for-billing-alerts)
  - [Setting Up CloudWatch for Billing Metrics](#setting-up-cloudwatch-for-billing-metrics)
    - [Enable Billing Alerts](#enable-billing-alerts)
    - [Region Specific Data](#region-specific-data)
    - [Browse Metrics](#browse-metrics)
  - [Creating Alarms for Billing Metrics](#creating-alarms-for-billing-metrics)
    - [Select Metrics](#select-metrics)
    - [Set Up Alarm](#set-up-alarm)
    - [Monitor and Adjust](#monitor-and-adjust)
- [Recieve AWS Billing Reports](#recieve-aws-billing-reports)
  - [Setting Up Billing Reports in S3 Buckets](#setting-up-billing-reports-in-s3-buckets)
    - [Configure Permissions and Policies](#configure-permissions-and-policies)
    - [Enable Billing Reports](#enable-billing-reports)
- [Quiz](#quiz-4)

<br>

# Monitoring and Alerting for AWS EC2

## Introduction to AWS EC2
* Stands for **Elastic Cloud Compute Service**.
* It deploys **raw compute power** in AWS cloud **for applications**.
* One of the most used features of AWS.

## Learning Objectives
* **Monitoring Facilities**: Understand the monitoring facilities available for EC2 within AWS.
* **CloudWatch Metrics and Alarms**: Learn about CloudWatch metrics and alarm functionality for EC2 instances.
* **Special Statistics**: Understand special statistics provided by AWS EC2.
* **Custom Metrics**: Learn how to monitor custom metrics for EC2 instances.

## Overview of EC2
* **Definition**: Key IaaS service available on AWS.
* **Functionality**: Deploy and rent various types of compute instances with different operating systems.

## Importance of Monitoring and Alerting
* Provide **insights** on **servers** and **instances running** on private cloud, public cloud, or bare metal servers.
* **Key Metrics**: Basic health and utilisation metrics (e.g., CPU utilisation, disk-related metrics).

## CloudWatch Metrics
* **Default Metrics**: Emitted by EC2 instances **every five minutes**, collected by CloudWatch.
* **Increased Frequency**: Option to collect metrics every minute (incurs additional costs).

## Key Features for Monitoring EC2 Instances
* **CloudWatch**: Central monitoring solution for tracking default metrics.
* **Dashboards**: Plot metrics on dashboards for visualisation.
* **Custom Metrics**: Add and monitor custom metrics, set up alarms.
* **Alarm Actions**: Automatically react to alarms (e.g., stopping, terminating, rebooting, recovering instances).

## Benefits of Alarm Actions
* **Automatic Detection**: Detect and remove malfunctioning or crashed instances.
* **Cost Efficiency**: Avoid unnecessary charges for non-functional instances.

## System-Level Checks
* Provides **overall status** of EC2 **instances**.
* **Functionality**: Determine if an EC2 instance is in a good running state.

<br>

# Monitoring AWS EC2 Instances

## Setting Up an EC2 Instance
1. Navigate to the **EC2 management panel**.
2. **Launch Instance**:
   * Click on "Launch Instance".
   * Select AWS Linux AMI for the operating system.
   * Choose a T2 micro instance (eligible for free tier).
   * Click "Next" and accept default values.
   * Click "Review and Launch" to launch the instance.
   * **Accept** the alert about the key pair for logging in.

## Monitoring Metrics
### Default Metrics
* AWS EC2 provides metrics at five-minute intervals (basic metrics).
* Metrics provided every **one minute** are called **detailed metrics**.

### Enable Detailed Monitoring
1. Select the **EC2 instance** and **switch** to the **monitoring tab**.
2. Click on the "link" to enable detailed monitoring.
3. A dialog pops up to enable detailed monitoring at one-minute intervals (incurs extra charges).

## Importance of Detailed Monitoring
* **Production Applications**: Critical for mission-critical applications to monitor health frequently.
* **Potential Downtime**: A five-minute downtime can be disastrous for important applications.

## Viewing Metrics
### Metrics Collection
* Check metrics available for the EC2 instance in the **monitoring tab**.
* Change the **time frame** for views using the **dropdown list**.

### Detailed Charts
* Click on **metric graphs** to see more detailed charts.

<br>

# AWS EC2 and AWS CloudWatch Alarms
Overview:
* Manage the **state** of EC2 **instances** (stop, terminate, reboot, recover) **based on metric thresholds**.
* Example: Configure a CloudWatch alarm triggered by CPU utilisation.

## Setting Up CloudWatch Alarms
### 1. Navigate to CloudWatch Console
1. Search for "CloudWatch" in the AWS management **console**.
2. Click on the "CloudWatch" entry to access the dashboard.

### 2. Select Metrics
3. Click on the "metrics" section.
4. Choose **EC2** and select **"Per Instance Metrics"** to view individual metrics for each EC2 instance.
5. **Filter metrics** by the specific EC2 instance ID.

## Configuring the Alarm
### 1. Select Metric
1. Choose the **CPU** utilisation **metric** for the EC2 instance.
   * CPU utilisation measures the percentage of allocated EC2 compute units in use.

### 2. Create Alarm
3. Click on the "Alarms" menu and select "Create Alarm".
4. Choose the **per instance level metric** (e.g., CPU utilisation).
5. **Name** the alarm (e.g., Test alarm) and provide a **description**.
6. Set the **alarm threshold** (e.g., 0% CPU utilisation) to trigger the alarm quickly for demonstration purposes.

## Configuring Actions for the Alarm
### Notification
* Send notifications to operational staff via SNS (email, SMS, etc.).

### Auto Scaling
* Use CloudWatch and EC2 Auto Scaling to **scale instances based on the alarm**.
  * Example: Add an EC2 instance to the auto scaling group when CPU utilisation exceeds 60%.

### EC2 Action
* Take specific actions like **stopping**, **starting**, **rebooting**, or **terminating** an instance.
  * Example: Configure the action to stop the instance when CPU utilisation is greater than or equal to 0%.

## Finalising the Alarm
### Set Conditions
* Define the **period** (e.g., one minute) and the number of **consecutive periods** for monitoring.

### Create IAM Role
* Check the box to **create** an IAM role, allowing CloudWatch to access EC2 services.

### Create Alarm
* Click on "Create Alarm" to finalise the configuration.

## Monitoring the Alarm
* **Alarm State**: The alarm state changes to "alarm" when the threshold is crossed.
* **Instance State**: The EC2 instance state changes based on the configured action (e.g., stopping).

<br>

# AWS EC2 System Checks and Metrics

## Types of Status Checks
### System Status Checks
* **Monitor** the **physical hardware** and **infrastructure** behind EC2 instances.
* Examples of failures: loss of network connectivity, loss of system power, hardware issues.
* **Actions**: Terminate and relaunch instances to migrate to healthy hardware.

### Instance Status Checks
* Monitor the **software** and **network configuration** of individual EC2 instances.
* Examples of failures: failed system status checks, incorrect networking or startup configuration, exhausted memory, corrupted file system, incompatible kernel.
* **Actions**: Reboot the instance or make configuration changes to fix issues.

## Monitoring Status Checks
* Status checks are performed **every minute**.
* **Results**: Each status check **returns a pass or fail** status.
* **Monitoring**: View status checks **within the EC2 console**.

## Important Metrics for EC2 Instances
1. **CPU Utilisation.**
   * Measures the **percentage** of **allocated** EC2 compute **units** in use.

2. **Disk Read Ops and Disk Write Ops.**
   * Measure the **completed read/write operations** from all instance store volumes.

3. **Network In/Out.**
   * Measures the **number of bytes received or sent** on all network interfaces.

4. **Status Check Failed.**
   * Indicates **whether** the instance has **passed** both **system and instance status** checks.
   * **Value of 0**: Both status checks passed.
   * **Value of 1**: One or both status checks failed.

## Viewing Metrics
* **EC2 Console**: View different metrics available for EC2 instances in the **monitoring tab**.
* **CloudWatch Metrics Section**: View and analyse metrics in "CloudWatch".

## Custom Metrics
* **Publishing Custom Metrics**: Use AWS CLI or API to publish custom metrics to CloudWatch.
* **Viewing Custom Metrics**: View statistical graphs of published metrics within the AWS management console.
* **Using Custom Metrics**: Set up alarms based on custom metrics in CloudWatch.

<br>

# Custom Metrics for AWS EC2
Overview:
* Track specific metrics for EC2 instances not provided by CloudWatch out of the box.
* Example: Monitor memory consumption of EC2 instances.

## Custom Metrics in AWS CloudWatch
* **Open Monitoring Platform**: CloudWatch allows the addition of custom metrics for AWS cloud infrastructure.
* **Limited Default Metrics**: Out-of-the-box, CloudWatch provides a limited number of metrics for EC2 instances.
* **Diverse EC2 Configuration**s: EC2 instances may have different operating systems, runtime libraries, scripts, and application domains.
* **Custom Metrics**: Necessary to track specific metrics to ensure applications are working correctly.

## Creating an IAM Role
* Enable EC2 instances to **report custom metrics** to **CloudWatch**.

Steps:
1. Navigate to the **IAM management console**.
2. Click on "Roles" and then "Create New Role".
3. **Name** the role (e.g., custom metrics role).
4. Choose **AWS Service** **role type** and **Amazon EC2**.
5. Attach a **custom policy** with necessary permissions:
   * cloudwatch:PutMetricData
   * cloudwatch:GetMetricStatistics
   * cloudwatch:ListMetrics
   * ec2:DescribeTags
6. **Review** and **create** the role.

## Launching a New EC2 Instance
Steps:

1. Navigate to the **EC2 management console**.
2. Click on "Launch Instance" and select **Amazon Linux AMI**.
3. Choose **T2 Micro Instance type**.
4. **Assign** the **IAM role** (custom metrics role) to the instance.
5. Configure instance **details**, **add storage**, and **tags**.
6. **Create** and **download** a new **key pair**.
7. **Launch** the instance.

## Connecting to the EC2 Instance
Steps:
1. Connect to the EC2 instance via **SSH**.
2. **Install mandatory Perl packages** using `yum` install command.

## Downloading and Running Perl Scripts
* Publish custom memory-related metrics to CloudWatch.

Steps:
1. Download Perl scripts using the **curl command**.
2. **Unzip the downloaded scripts**.
3. Navigate to the **directory containing the scripts**.
   * Key files:
     * mon-get-instance-stats.pl
     * mon-put-instance-data.pl
4. **Provide AWS credentials** if IAM role is **not used** (not needed in this demonstration). 

<br>

# Push Custom Metrics from AWS EC2 to AWS CloudWatch

## Important Files and Their Functions
### mon-put-instance-data.pl
* **Collects system metrics** on an AWS EC2 instance (e.g., memory swap, disk space utilisation).
* **Sends** the collected metrics **to Amazon CloudWatch**.

### mon-get-instance-stats.pl
* **Queries Amazon CloudWatch**.
* Displays the most **recent utilisation statistics** for the EC2 instance on which the **script is executed**.

### creds-template
* **Template** for **credentials** **storing** **access key ID** and **secret access key**.
* Needed only if the **AWS EC2 instance does not have the necessary IAM permissions** to communicate with AWS CloudWatch.

## Running Perl Scripts
### Execution
* Run the **Perl script** to **collect memory-related metrics** and **send them to CloudWatch**.
* **Confirmation message**: "Successfully reported metrics to CloudWatch" with a reference number.

### Viewing Metrics
* Navigate to **AWS CloudWatch management console**.
* Switch to the **metrics section** and click on "All" to view all metrics.
* New category "Linux System" for custom metrics.
* **Metrics available**: memory utilisation, memory available, and memory used.

## Automating Metric Collection
**Issue:**
* Running the script manually is not ideal for regular data collection.

**Solution:**
* Schedule the script to run regularly using a cron job.

**Setting Up Cron Job:**
* Execute the command crontab -e to open crontab.
* Add a new command to run the script every five minutes.
* Inside crontab file `*/5 * * * * /usr/bin/node ~/monitor.js`


* Save and exit crontab.

<br>

# Quiz

1. Amazon EC2 stands for ________________
   * Amazon EC2 stands for Elastic Cloud Compute. It provides scalable computing capacity in the AWS cloud

2. The two different status checks which detect issues with an AWS instance are: 
   * They are System status check for monitoring the AWS systems running behind the scenes for your AWS Instance and Instance status check for monitoring your AWS instance’s over network and software configuration.

3. Is this statement true – “The status checks are meant for monitoring your AWS instances and their underlying hardware, network and software configuration.”
   * True.
   * System Status Check provides an insight into the hardware backing up EC2 instances. 
   * Whenever there is incorrect networking or startup configuration or exhausted memory etc... can result in these checks being failed.

4. Which of the following metric identifies the processing power that is being consumed to run operating system and applications upon a selected instance.
   * CPU utilisation.
   * The percentage of allocated EC2 compute units that are currently in use on the instance. 
   * This metric identifies the processing power that is being consumed to run operating system and applications upon a selected instance.

5. Is this statement TRUE – “By default, Amazon EC2 is configured to provide metrics at 5 minute intervals, but detailed metrics which provides metric data for every 1 minute can also be enabled”
   * True.
   * Amazon CloudWatch provides a variety of key metrics for EC2 Instances. 
   * By default, Amazon EC2 is configured to provide metrics at 5 minute intervals, but detailed metrics which provides metric data for every 1 minute can also be enabled.

<br> 

# Monitoring and Alerting for AWS EBS
Overview:
* **AWS EBS**: Stands for Elastic Block Storage Service.
* Provides block-level storage volumes for EC2 instances.
* Commonly used for general-purpose EC2 instances.

## EBS Overview
* **Block-Level Storage**: Used for additional storage capacity for EC2 instances.
* **Instance Store**: Provides temporary block-level storage, physically attached to the host computer.
* **Attachment**: EBS volumes can be attached, detached, and reattached to instances within the same availability zone.

## EBS Volume Types
* **General Purpose** (GP2): Fast storage using Solid-state drive (SSD) volumes.
* **Provisioned IOPS** (io1): Even faster SSDs for high-performance SSD volumes.
* **Throughput Optimised** (st1): Hard disk drive (HDD) volumes, good for large, sequential data.
* **Cold HDD** (sc1): HDD volumes for less frequently accessed data.

## Performance Factors
* **IOPS** (Input/Output Operations Per Second): Primary unit of measure for EBS volume performance. Measures how fast the storage can read/write data.
  * **SSD Volumes**: Measured in 256 KB (smaller) chunks (random operations).
  * **HDD Volumes**: Measured in 1024 KB (larger) chunks (sequential operations).
* **Throughput**: Maximum throughput for GP2 is 160 MB/s. How much data can be read/written per second. 

## EBS SSD Volume Types
**GP2** (General Purpose SSD):
* **Baseline Performance**: 3 IOPS per GB up to 10,000 IOPS.
* **Burst Performance**: Up to 3,000 IOPS.
* **Minimum Volume Size**: 8 GB with a minimum of 100 IOPS.

**io1** (Provisioned IOPS SSD):
* **High Performance**: Suitable for mission-critical applications needing fast storage.
* **Cost**: More expensive than GP2 volumes.

## IO Credits
* Represent available bandwidth for burst IO operations: Extra speed you can use when needed.
* **Accumulation**: Volumes accumulate IO credits at a rate of 3 IOPS per GB.
*** Initial Credit Balance**: 5.4 million credits, enough for 30 minutes of maximum burst performance.
* **Usage**: Draws on IO credits when performance exceeds baseline level: Use credits when you need more speed than the baseline.

<br> 

# AWS EBS Volume Types

## Io1 (Provisioned IOPS SSD)
* Best Suited For: **Workloads** that need to **read/write** a **lot of data quickly**.
* Provides 30 IOPS (Input/Output Operations Per Second) per gigabyte, up to 20,000 IOPS. 
  * This is 10 times more than the General Purpose (GP2) volumes.
* **Consistency**: Always performs at the same speed, unlike GP2 which can speed up temporarily.
* **Use Case**: Great for applications that need to handle a lot of data quickly, like databases.
* **Maximum Speed**: Can handle up to 320 MB of data per second, which is **twice as fast as GP2**.

## Hard Disk Volumes
### Throughput Optimised HDD (st1)
* **Ideal For**: Data that you need to **access often**.
* **Optimisation**: Designed to **handle large amounts of data** being read or written in sequence.

### Cold HDD (sc1)
* **Ideal For**: Data that you **don't need to access** very **often**.
* **Cost**: The **cheapest option** for EBS volumes.
* **Use Case**: Perfect for **storing data** that you don't need to access frequently and **doesn't need to be read or written quickly**.

## Performance Comparison
* **Traditional Hard Disk Volumes**: Good for **handling large amounts of data** but not as fast as SSDs for random data access.
* **Importance of IOPS**: IOPS is a measure of **how quickly the storage can read/write data**. Higher IOPS means better performance for applications that need to access data quickly.

<br>

# Monitoring AWS EBS Volumes

## Understanding EBS Metrics
* **Basic Metrics**: Available every 5 minutes.
* **Detailed Metrics**: Available every 1 minute (default for Io1 volumes).

## EBS Volume Types
* **GP2**: General-purpose SSD, minimum 100 IOPS, minimum size 8 GB.
* **Io1**: High-performance SSD, detailed monitoring by default.
* **SC1**: Cold HDD, for less frequently accessed data.
* **ST1**: Throughput-optimised HDD, for frequently accessed data.

## Status Checks
* **Automated tests** to ensure EBS volumes are **working correctly**.
* Run every **5 minutes**.
* **Results**: Pass or fail status.
* **Actions**: Helps **manage potential data inconsistencies**.

## Monitoring EBS Volumes
### Accessing EBS Volumes
1. Navigate to the **EC2 console**.
2. Click on "Volumes" to see the list of attached volumes.

### Viewing Metrics
1. Select a **volume** and go to the "Status Checks" tab.
2. Check if the **volume status** is "OK".
3. Go to the "Monitoring" section to view various metrics.

## Important Metrics
### Read and Write Bandwidth
* Measures the **data transfer rate** for reading and writing.
* **Unit**: Kibibytes (similar to kilobytes).

### Burst Balance
* **Credits accumulated** for **handling bursts of activity**.
* Accumulated at 3 IOPS per GB per second.

## Handling Inconsistencies
* **Default Action**: AWS disables I/O between the volume and EC2 instance if inconsistencies are found.
* **Override**: Enable the "Auto-Enabled Volume Attribute" to continue using the volume despite inconsistencies.

# Summary of Module
* **EBS Storage Service**: Provides additional storage for EC2 instances.
* **Types of EBS Volumes**: GP2, Io1, SC1, ST1.
* **Monitoring Metrics**: Read/write bandwidth, burst balance, status checks.

<br>

# Quiz

1. AWS EBS stands for___________
   * AWS EBS stands for Elastic Block Store which provides a block level storage volume used with EC2 Instances. 
   * It means EBS volumes are used to backup EC2 Instances.

2. AWS provides two types of SSD volumes. They are:
   * Type 1 – io1, is best suited for IOPS with Intensive and throughput intensive workloads. 
   * Type 2 – gp2 , is a general purpose volume and is selected by default when creating EC2 instances

3. Is this statement true – “The Status Checks help the end user to better track and manage potential inconsistencies in the data on an EBS volume”.
   * True.
   * One of the most important thing that EBS has for monitoring is Status Check. 
   * Status Checks help the end user to better track and manage potential inconsistencies in data on an EBS volume. 
   * They are automated tests that run every 5 minutes and return a pass or fail status for the EBS volume.

4. CloudWatch has two tiers of metrics available for EBS volumes. They are:
   * Basic metrics -> the metrics are available at 5 minute intervals.
   * Detail metrics -> the metrics are available at 1 minute intervals.

5. Is this statement true, “When EBS determines that a volume’s data is potentially inconsistent, it disables the I/O to the volume from the EC2 instance by default”.
   * True.
   * when EBS determines that a volume’s data is potentially inconsistent, it disables the I/O to the volume from the EC2 instance by default. 
   * This means that as soon as inconsistency is discovered by AWS, the volume gets automatically disconnected from every source it is connected to.

<br> 

# Introduction to Monitoring and Alerting for AWS RDS

## Introduction to AWS RDS
* **AWS RDS**: Stands for **Relational Database Service**.
* **Type**: Platform as a Service (**PaaS**).
* **Purpose**: Provides **scalable** and **managed** relational database **services**.
* **Supported Databases**: MySQL, PostgreSQL, SQL Server, Oracle, and Aurora (AWS's optimised MySQL clone).

## Key Learning Objectives
* **Familiarise with AWS RDS**: Understand what RDS is and its role.
* **Key Metrics**: Learn about important metrics like CPU utilisation, database connections, and free memory.
* **Monitoring and Alerts**: Set up alarms and notifications to ensure high availability and performance.

## Importance of Monitoring RDS
* Databases are **crucial** for **application functionality** and **user experience**.
* **High Availability**: RDS can automatically failover to a healthy replica in case of failures.
* **Monitoring Tools**: AWS and CloudWatch provide various tools to monitor and manage RDS instances.

## Monitoring Tools and Features
### CloudWatch Metrics
* **Basic Metrics**: Available every `5` minutes.
* **Detailed Metrics**: Available every `1` minute.
* **Example Metrics**: CPU utilisation, database connections, free memory.

### Events
* It keeps **track of changes** and **actions** related to DB instances, snapshots, security groups, and parameter groups.
* **Notifications**: Set up event subscriptions to get notified via email, SMS, etc.

### Database Logs
* **Access**: View logs by navigating to the detailed view of the database instance.
* **Types of Logs**: Error log, slow query log, general log (varies by database engine).
* **Real-Time Monitoring**: Logs refresh every 5 seconds for real-time insights.
* **Download Logs**: Option to download logs for further analysis.

## Practical Steps
### Viewing Metrics
1. Navigate to the **AWS console** and select the "RDS dashboard".
2. Select the **database instance** and click on "Show Monitoring" to view metrics.

### Setting Up Event Notifications
1. Use the "Events" feature to track changes and set up notifications.

### Accessing Logs
1. Scroll down to the "Logs" section in the detailed view of the database instance.
2. Click on the **log type** to view or download.

<br>

# Monitoring AWS RDS Metrics

## Core Metrics for AWS RDS
### CPU Utilisation
* **Measures** the **percentage of CPU used** by the server running the database.

### Database Connections
* Shows the **number** of **active connections** to the RDS instance.

### Freeable Memory
* Indicates the **amount of RAM available**.

### Free Storage Space
* Shows the amount of **available storage space**.

## IOPS and Latency Metrics
### Read IOPS and Write IOPS
* Measures the **number of input/output operations** per second.
* High IOPS usage can indicate **potential overload** and **slower responses**.

### Read Latency and Write Latency
* Tracks the average **time taken** per **disk input/output operation**.
* High latency values indicate performance degradation.

## Monitoring and Alarms
### Viewing Metrics
1. Navigate to the **AWS console** and select the **RDS instance**.
2. Go to the "Alarm and Monitoring" section to view key metrics and recent events.

### Creating Alarms
1. Click on "Create Alarm" to set up **notifications** for specific metrics.
   * Example: Set an alarm for CPU utilisation with a threshold value.
2. **Configure** the alarm to send **notifications** to an email address or distribution list.

## Practical Steps
### Accessing Metrics
1. Select the **RDS instance** and click on "Show Monitoring" for detailed metrics.
2. View metrics like CPU utilisation, DB connections, freeable memory, read IOPS, and write IOPS.

### Setting Up Notifications
1. Use **CloudWatch** to **create alarms** and **set up notifications** for important metrics.
    * Example: Create an alarm for CPU utilisation and configure it to send email notifications.

## Importance of Monitoring
* **Real-Time Insights**: Monitoring provides a real-time view of the database's health and performance.
* **Proactive Management**: Setting up alarms helps in taking corrective actions before issues escalate.
* **Avoiding Downtime**: Timely notifications about critical metrics like free storage space can prevent unexpected downtime.

<br>

# AWS RDS Events

## Monitoring Key Metrics
* For **mission-critical databases**, it's essential to monitor key metrics and set up alarms to **maintain** database **health** and **minimise downtime**.
* **Operational Policies**: Implement policies to respond to alarms promptly to **ensure consistent user experience**.

## Key Metrics to Monitor
* **Resource Utilisation**: Track CPU, memory, and storage usage.
* **System Errors**: Monitor for any errors that could affect database performance.
* **Accidental Termination**: Ensure instances are not accidentally terminated.
* **Cluster Health**: Monitor the health of database clusters.
* **Maintenance Windows**: Keep track of scheduled maintenance.
* **Query Logs**: Monitor logs for slow or problematic queries.
* **Instance-Level Metrics**: Track metrics specific to each database instance.
* **Resource Modification**: Monitor changes to database resources.

## CloudWatch Events for RDS
* CloudWatch events help **track configuration changes** and **important actions** within RDS instances.

**Event Retrieval:**
* **AWS Management Console**: Shows events from the past 24 hours.
* **AWS CLI/ API**: Retrieve events for up to the past 14 days.

## Setting Up Event Subscriptions
1. In the **AWS management console**, go to the "Events" menu.
2. Create **Event Subscription**:
   1. Click on "Event Subscriptions" and then "Create Event Subscription".
   2. **Name** the subscription (e.g., "event").
   3. Select the **target topic** (e.g., "my alerting admins").
   4. Choose the **source type** (e.g., instances).
   5. Select **event categories** (e.g., availability, backup, configuration change).
   6. Select the **instances to monitor**.
   7. Click "Create" to finalise the subscription.

## Verifying Event Notifications
* **Check Email Inbox**: Look for confirmation emails about the new event subscription.
* **Trigger an Event**: Manually reboot the database instance to generate events.
* **View Events**: Check the Events and Logs screen in the AWS console to see logged events.
* **Receive Notifications**: Confirm that notifications are received for the triggered events.

<br>

# Quiz

1. What does AWS RDS stand for?
   * Relational Database Service. 
   * RDS is a PaaS service providing Relational Databases that makes it easier to set up, operate, and scale a relational database in the cloud.

2. Which of the following are key metrics available for AWS RDS?
   * AWS RDS key metrics are:
     * CPU Utilisation is the percentage of CPU Utilised. 
     * DatabaseConnections tell us the number of connections that are RDS Deployment currently has. 
     * FreeableMemory is the amount of available RAM. Free Storage Space is the Amount of available storage space. 
     * ReadIOPS/WriteIOPS, as IOPS Signify the number of I/O operations completed per second.

3. For monitoring AWS RDS database - AWS CloudWatch provides:
   * AWS CloudWatch provides CloudWatch Alarms, CloudWatch Logs and CloudWatch Events to monitor and alerts for AWS RDS.

4. Which of the following metrics is used to check the number of database connections in use.
   * Database Connections tell us the number of connections currently available in RDS Deployment. 
   * This means it is used to check the number of database connections in use.

5. The FreeStorageSpace metrics is used to...
   * The FreeStorageSpace metrics is used to determine the amount of currently available storage space.

<br>

# Introduction to Monitoring and Alerting for AWS ELB

## Introduction to AWS ELB
* AWS ELB: Stands for **Elastic Load Balancer**.
* It's a **software load balancer** that **distributes incoming application traffic** across **multiple** Amazon EC2 **instances**.
* Ensures **fault tolerance**, **scalability**, and **optimal performance** for applications.

## Importance of ELB
* **Traffic Distribution**: Automatically distributes incoming traffic to multiple EC2 instances.
* **Fault Tolerance**: Helps achieve fault tolerance by balancing the load across instances.
* **Scalability**: Provides the necessary load balancing capacity to handle varying amounts of traffic.

## Key Metrics to Monitor
* **Availability**: Ensure the load balancer is always available to handle incoming traffic.
* **Performance**: Monitor the performance of the load balancer to ensure it is routing traffic efficiently.
* **Correct Functioning**: Verify that the load balancer is correctly routing traffic to the underlying EC2 instances and other compute resources.

## Monitoring Procedures
* **Set Thresholds**: Establish thresholds for key metrics to ensure the load balancer is performing optimally.
* **Regular Monitoring**: Continuously monitor the load balancer to detect and address any issues promptly.

<br> 

# Deploy AWS ELB
* AWS ELB: Stands for **Elastic Load Balancer**.
* It dDistributes incoming application traffic across multiple Amazon EC2 instances to ensure fault tolerance and scalability.

## Steps to Deploy an ELB
1. Log into AWS EC2 Management Console:
   1. Navigate to the** Load Balancers menu**.
   2. Click on "Create Load Balancer".

2. Choose Load Balancer Type:
   * **Application Load Balancer**: **Operates** at the **application layer**, **allows routing based on content**.
   * **Classic Load Balancer**: **Routes traffic** based on a**pplication or network-level information**. Ideal for simple load balancing across multiple EC2 instances.

3. Name Your Load Balancer:
   * Example: Name it "Alert ELB".

4. Assign Security Groups:
   1. Security groups act as virtual firewalls **controlling traffic** for EC2 instances.
   2. Choose appropriate security groups based on the type of application (e.g., web application, FTP server).

5. Configure Security Settings:
   1. **Option** to configure SSL encrypted traffic for secure connections (recommended for production).

6. Configure Health Check:
   * **Health Checks**: Automated tests to verify if instances are functioning as expected.
   * **Ping Protocol**: Choose from HTTP, TCP, HTTPS, or SSL.
   * **Ping Port**: Specify the port (e.g., port 80 for HTTP).
   * **Ping Path**: Target URL path (e.g., /index.html).
   * **Response Timeout**: Time in seconds to wait for a response (e.g., 5 seconds).
   * **Interval**: Time between health checks (e.g., 30 seconds).
   * **Unhealthy Threshold**: Number of failed checks before marking an instance as unhealthy.
   * **Healthy Threshold**: Number of successful checks before marking an instance as healthy.

7. Add EC2 Instances:
   1. Select the EC2 **instances** to **serve the application** behind the ELB.

8. Add Tags (Optional):
   1. Tags can be used for **organising** and **managing resources**.

9. Review and Create:
   1.  Review all settings and click "Create" to deploy the load balancer.

## Monitoring ELB
* **Health Checks**: Ensure only healthy instances receive traffic.
* **Metrics**: Monitor key metrics such as availability, performance, and correct functioning.
* **Thresholds**: Set thresholds for key metrics to maintain optimal performance.

<br> 

# AWS ELB Metrics

## Key Metrics for Monitoring ELB Instances
### Backend Connection Errors
* Number of **unsuccessful connections** between the ELB and registered EC2 instances.
* Ensures connectivity between ELB and EC2 instances is flawless, preventing latency issues.

### Latency
* **Time taken** to **receive a response** from the backend EC2 instance.
* Usage: **Compare average** historic **values** with maximum values to identify periods of slow responses.
* Insights: Helps in **performance tuning** and **identifying** configuration **issues**.

### Surge Queue Length
* Total number of **requests waiting to be routed** by the load balancer.
* Queue Limit: Maximum size is 1024; additional requests are rejected when the queue is full.
* Goal: Keep this metric as close to zero as possible to **avoid overload** and **configuration issues**.

### Spillover Count
* Number of **requests dropped** when the surge queue length is full.
* Indicates **capacity issues** and helps in **managing traffic load**.

### HTTP Status Codes
* Number of specific **HTTP status codes** from backend EC2 instances and ELB.
* Usage: Understand user responses and application-level health.

### Request Count
* Number of **requests received** by the ELB.
* Usage: Monitor traffic load and usage patterns.

### Healthy Host Count
* Number of **healthy instances** registered with the ELB.
* Ensures that only healthy instances are serving traffic.

### Unhealthy Host Count
* Number of **unhealthy instances** registered with the ELB.
* Identifies instances that failed health checks and need attention.

<br>

# Monitor AWS ELB Metrics

## Checking ELB Metrics in AWS Management Console
### Accessing ELB Metrics
1. Log into the **AWS management console**.
2. Select the **deployed load balancer**.
3. Navigate through various tabs: Instances, Health Check, Listeners, and Monitoring.

### Instances Tab
* Provides **details** of the EC2 **instances** backing the ELB.

### Health Check Tab
* Review the **health check settings** configured for the ELB.

### Listeners Tab
* Review the **ports** on which the ELB is listening for incoming connections.

### Monitoring Tab
* Review all the **metrics** provided by AWS for the ELB.

### DNS URL
* The DNS URL b to the ELB is **used by external clients** to connect to the ELB.

## Testing ELB Connection
* **Copy the DNS URL**: Navigate to it in a browser.
* **Request Handling**: The ELB tries to route the request to one of the backend EC2 instances.
* **Timeout**: If no instances are available to serve the request, it will time out.

## Key Metrics to Monitor
### Healthy and Unhealthy Instances
* Metrics indicating the number of **healthy and unhealthy instances**.

### Average Latency
* b taken to **receive a response** from the backend EC2 instance.

### HTTP Status Codes
* **5XX Errors**: Server errors indicating exceptional behavior.
* **4XX Errors**: Client errors like bad requests or file not found.
* **2XX Responses**: Successful responses indicating OK status.

## Monitoring HTTP Status Metrics
* **Monitor Spikes**: Ensure there are no spikes in 400 or 500 HTTP status codes.
* **Healthy Application**: Majority of responses should be 200 HTTP status codes.

## Starting EC2 Instances
* **Navigate to AWS Console**: Start one of the instances backing the ELB.
* **Health Checks**: ELB performs health checks to ensure instances are healthy before routing requests.

<br>

# Quiz

1. Is this statement true – “The AWS ELB stands for Effective Load Balances”
   * False.
   * ELB stands for Elastic Load balancer, it automatically distributes incoming application traffic across multiple Amazon EC2 instances.

2. The backend connection errors are...
   * Backend Connection Errors are the Number of unsuccessful connections between Elastic Load Balancer and the registered instances.

3. Is this statement true – “If the Surge Queue Length is full, then request gets dropped. This dropped request are called as Spillover”.
   * True.
   * Spillover Count is one of the key Metrics available for AWS ELB. 
   * If the Surge Queue Length is full, then request gets dropped. 
     * This dropped request are called as spillover.

4. _______________ monitors the health of registered targets and routes traffic only to the healthy targets.
   * ELB.
   * Elastic Load Balancing automatically distributes your incoming application traffic across multiple targets, such as EC2 instances. 
   * It monitors the health of registered targets and routes traffic only to the healthy targets.

<br> 

# Monitoring and Alerting for AWS Billing and Costs

## Introduction to AWS Billing and Costs
* Monitoring billing and costs is crucial to **avoid unexpected expenses** and **manage cloud usage** effectively.
* **Pay-as-You-Go Model**: AWS charges based on the **resources used**, allowing for cost-effective infrastructure management.


## AWS Billing Structure
* **Pay-as-You-Go**: Pay only for the resources used.
* **Deallocate Resources**: Stop paying once resources are no longer needed.

## Importance of Monitoring Billing
* **Avoid Overcapacity**: Prevent deploying more resources than needed.
* **Human Error**: Ensure resources are properly deallocated to avoid unnecessary costs.
* **Resource-Specific Costs**: Understand the billing aspects of each resource (e.g., EC2 instances, EBS volumes).

## Monitoring Billing and Costs
* **AWS Tools**: Use AWS tools to track and monitor billing data.
* **Insights**: Analyse billing data to optimise cloud resource usage.
* **Alarms**: Set up alarms for billing thresholds to stay within budget.

## Setting Up Billing Alerts
* **Root Account Access**: Only the root account can access billing alerts.
* Alert Methods:
  * **Email**: Receive billing alerts via email.
  * **PDF Invoice**: Get billing alerts as a PDF invoice.
  * **CloudWatch Alarms**: Set up alarms based on billing metrics.

## Enabling Billing Alerts
* **CloudWatch Metrics**: Enable billing alerts to access CloudWatch metrics related to billing and costs.
* **Billing Reports**: Receive daily billing reports in an S3 bucket.

<br>

# Monitor AWS Billing

## Navigating to Billing Dashboard
### Access Billing Dashboard
1. Log into **AWS management console**.
2. Click on your **profile link** and select "My Billing Dashboard".

### Preferences for Billing Alerts
* **PDF Invoice by Email**: Receive detailed monthly invoices via email.
* **Billing Alerts via CloudWatch**: Enable to set up CloudWatch metrics and alarms for billing.
* **Billing Reports**: Generate and save billing reports in an S3 bucket for frequent updates.

## Setting Up CloudWatch for Billing Metrics
### Enable Billing Alerts
1. Navigate to **CloudWatch** from the **AWS management console**.
2. Click on the "Billing" menu.

### Region Specific Data
* Billing metrics are aggregated in the **US East** (North Virginia) region.
* **Switch** to this region to view billing data, e.g., UK South. 

### Browse Metrics
1. Click on "Browse Metrics" to see available billing metrics.
2. Metrics are **categorised** by **service** and total **estimated charges**.

## Creating Alarms for Billing Metrics
### Select Metrics
* Choose "Total Estimated Charges" to track overall billing.
* Set up **alarms** to notify when **billing crosses a specific threshold**.

### Set Up Alarm
1. Navigate to the "Alarms" section and click "Create Alarm".
2. Select the **metric** (e.g., Total Estimated Charges).
3. **Name** the alarm (e.g., Alert Budget 0.9).
4. Set the **threshold** (e.g., notify when charges exceed $100).
5. **Configure** the notification action (e.g., send an email to an SNS topic).

### Monitor and Adjust
* Use the alarm to monitor billing and take action to optimise resource usage.
* Clean up unnecessary resources to avoid cost overruns.

<br>

# Recieve AWS Billing Reports

## Setting Up Billing Reports in S3 Buckets
1. Navigate to **Billing Dashboard**
   1. Log into **AWS management console**.
   2. Go to the **billing dashboard**.
2. Select Billing Reports Option:
   1. Choose the third preference option to receive billing reports in an S3 bucket.
3. Create an S3 Bucket:
   1. Navigate to the **S3** management console.
   2. Click on "Create Bucket".
   3. Select "US Standard" as the target region.
   4. **Name** the bucket (e.g., "monitoring-bill-demo") and ensure the name contains only lowercase characters.
   5. Click "Create".
4.  Verify Bucket:
    1.  **Copy** the bucket name and **paste** it in the **billing dashboard**.
    2.  Click "Verify" to ensure the bucket is set up correctly.

### Configure Permissions and Policies
* AWS services need appropriate permissions to interact with each other.
* Use the sample policy provided in the billing dashboard.
  1. Navigate to the **S3 console**, select the **bucket**, and go to the **properties section**.
  2. Add a **bucket policy** by **pasting the copied policy** and click "Save".

### Enable Billing Reports
* After verifying the bucket, **enable billing reports**.
* Choose the **types of reports** to be saved in the S3 bucket (e.g., monthly reports, detailed billing report, cost allocation report).
* Click "Save Preferences".

<br> 

# Quiz

1. What is the key metric available to us for monitoring AWS Billing?
   * Estimated charges.
   * This metric is available to us by default and does not require the user to deploy a particular service on AWS.

2. Is this statement TRUE – “AWS is a Public Cloud Service which runs on Pay-as-you-go model”.
   * True.
   * AWS is a public cloud service that provides us IaaS and PaaS functionality on pay as you go model.

3. Which of the following is NOT an option for us to get Billing alerts in Billing and cost management section on AWS Console:
   * Receive billing vouchers.
   * To get Billing alerts, in the Billing and cost management, there are three choices available: 
     * Receive PDF invoice by Email.
     * Receive Billing Alerts – To be selected for AWS Billing Metrics. 
     * Receive Billing Reports – Receive a daily billing report on the S3 bucket of your choice.

4. Is this statement true – “Only the Root Account has the access to enable Billing alerts for that account”.
   * True.
   * AWS has two types of accounts, one is the user account and another one is the root account but only the Root Account has the access to enable Billing alerts for that account.

5. Which of the following is not a part of AWS Billing and Cost Management service that we use?
   * "Distributes incoming traffic".
   * Elastic Load balancer (ELB) is used to automatically distribute incoming application traffic across multiple Amazon EC2 instances.

<br>




