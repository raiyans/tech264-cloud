# Introduction to AWS

- [Introduction to AWS](#introduction-to-aws)
  - [Introduction to Cloud Computing and AWS](#introduction-to-cloud-computing-and-aws)
  - [Basics of Cloud Computing](#basics-of-cloud-computing)
  - [Benefits of Cloud Computing](#benefits-of-cloud-computing)
  - [Cloud Computing Configurations](#cloud-computing-configurations)
    - [Public Cloud](#public-cloud)
    - [Private Cloud](#private-cloud)
    - [Hybrid Cloud](#hybrid-cloud)
  - [Growth and Demand](#growth-and-demand)
- [Benefits of AWS](#benefits-of-aws)
  - [Cloud Computing Models](#cloud-computing-models)
    - [Infrastructure as a Service (IaaS)](#infrastructure-as-a-service-iaas)
    - [Platform as a Service (PaaS)](#platform-as-a-service-paas)
    - [Software as a Service (SaaS)](#software-as-a-service-saas)
  - [Benefits of AWS and Cloud Computing](#benefits-of-aws-and-cloud-computing)
    - [Agility](#agility)
    - [Security](#security)
    - [Cost Efficiency](#cost-efficiency)
    - [Flexibility](#flexibility)
    - [Innovation](#innovation)
- [Who is using AWS and why?](#who-is-using-aws-and-why)
  - [Startups Using AWS](#startups-using-aws)
  - [Large Enterprises Using AWS](#large-enterprises-using-aws)
  - [Development and Testing](#development-and-testing)
  - [Innovative Solutions](#innovative-solutions)
  - [Mobile Services](#mobile-services)
  - [Traditional Websites](#traditional-websites)
  - [Data Analytics](#data-analytics)
  - [Mobile Applications](#mobile-applications)
  - [Hybrid Cloud Environments](#hybrid-cloud-environments)
  - [Financial Transactions](#financial-transactions)
  - [Application Migration](#application-migration)
  - [Data Center Migration](#data-center-migration)
  - [Full Business Operations](#full-business-operations)
- [Services Provided by AWS](#services-provided-by-aws)
  - [AWS Services Overview](#aws-services-overview)
    - [Enterprise Applications](#enterprise-applications)
    - [Platform Services](#platform-services)
    - [Administration and Security Services](#administration-and-security-services)
    - [Core Services](#core-services)
  - [AWS Global Infrastructure](#aws-global-infrastructure)
    - [Regions and Availability Zones](#regions-and-availability-zones)
    - [Global Business Needs](#global-business-needs)
  - [AWS Certifications and Compliance](#aws-certifications-and-compliance)
    - [Compliance Programs](#compliance-programs)
    - [Security Capabilities](#security-capabilities)
- [Services Provided by AWS #2](#services-provided-by-aws-2)
  - [AWS Compute Services](#aws-compute-services)
    - [Amazon EC2](#amazon-ec2)
    - [Amazon ECS (Elastic Container Service):](#amazon-ecs-elastic-container-service)
    - [Amazon VPC (Virtual Private Cloud)](#amazon-vpc-virtual-private-cloud)
    - [AWS Lambda](#aws-lambda)
    - [Instance Types](#instance-types)
  - [AWS Storage Services](#aws-storage-services)
    - [Amazon S3 (Simple Storage Service)](#amazon-s3-simple-storage-service)
    - [Amazon EBS (Elastic Block Store)](#amazon-ebs-elastic-block-store)
    - [Amazon EFS (Elastic File System)](#amazon-efs-elastic-file-system)
    - [Amazon Glacier](#amazon-glacier)
    - [Storage Gateway](#storage-gateway)
  - [AWS Database Services](#aws-database-services)
    - [Amazon Aurora](#amazon-aurora)
    - [Relational Databases](#relational-databases)
    - [NoSQL Databases](#nosql-databases)
  - [AWS Migration Services](#aws-migration-services)
    - [Database Migration Service](#database-migration-service)
    - [Server Migration Service](#server-migration-service)
  - [AWS Networking and Content Delivery](#aws-networking-and-content-delivery)
    - [Amazon VPC](#amazon-vpc)
    - [Amazon CloudFront](#amazon-cloudfront)
    - [Amazon Route 53](#amazon-route-53)
  - [AWS Developer Tools](#aws-developer-tools)
    - [AWS CodeCommit](#aws-codecommit)
    - [AWS CodeBuild](#aws-codebuild)
    - [AWS CodeDeploy](#aws-codedeploy)
    - [AWS CodePipeline](#aws-codepipeline)
  - [WS Management Tools](#ws-management-tools)
    - [Amazon CloudWatch](#amazon-cloudwatch)
    - [Amazon EC2 Systems Manager](#amazon-ec2-systems-manager)
    - [AWS CloudFormation](#aws-cloudformation)
  - [AWS Security, Identity, and Compliance](#aws-security-identity-and-compliance)
    - [AWS Identity and Access Management (IAM)](#aws-identity-and-access-management-iam)
    - [AWS Certificate Manager](#aws-certificate-manager)
  - [AWS AI and Machine Learning Services](#aws-ai-and-machine-learning-services)
    - [Amazon Lex](#amazon-lex)
    - [Amazon Polly](#amazon-polly)
    - [Amazon Rekognition](#amazon-rekognition)
    - [Amazon Machine Learning](#amazon-machine-learning)
  - [AWS Mobile Services](#aws-mobile-services)
    - [AWS Mobile Hub](#aws-mobile-hub)
    - [Amazon API Gateway:](#amazon-api-gateway)
    - [Amazon Cognito:](#amazon-cognito)
    - [Amazon Pinpoint:](#amazon-pinpoint)
    - [AWS Device Farm:](#aws-device-farm)
    - [AWS Mobile SDK:](#aws-mobile-sdk)
  - [AWS Application Services](#aws-application-services)
    - [AWS Step Functions](#aws-step-functions)
    - [Amazon Elastic Transcoder](#amazon-elastic-transcoder)
  - [AWS Messaging Services](#aws-messaging-services)
    - [Amazon SQS (Simple Queue Service)](#amazon-sqs-simple-queue-service)
    - [Amazon SNS (Simple Notification Service)](#amazon-sns-simple-notification-service)
    - [Amazon SES (Simple Email Service)](#amazon-ses-simple-email-service)
- [AWS - a leading cloud platform](#aws---a-leading-cloud-platform)
  - [Business Productivity Services](#business-productivity-services)
    - [Amazon WorkDocs](#amazon-workdocs)
    - [Amazon WorkMail](#amazon-workmail)
  - [Desktop App and Streaming Services](#desktop-app-and-streaming-services)
    - [Amazon WorkSpaces:](#amazon-workspaces)
    - [Amazon AppStream 2.0:](#amazon-appstream-20)
  - [Internet of Things (IoT) and Game Development Services](#internet-of-things-iot-and-game-development-services)
    - [AWS IoT Platform:](#aws-iot-platform)
    - [AWS Greengrass:](#aws-greengrass)
    - [AWS IoT Button:](#aws-iot-button)
    - [Amazon Lumberyard:](#amazon-lumberyard)
  - [Implementation and Innovation](#implementation-and-innovation)
  - [AWS Growth and Pricing Philosophy](#aws-growth-and-pricing-philosophy)
- [Quiz](#quiz)


## Introduction to Cloud Computing and AWS
* **Cloud Computing**: Delivery of **hosted services over the Internet**, enabling companies to consume compute resources as utilities.
* **AWS**: Amazon Web Services, a leading cloud platform offering **scalable** and **sophisticated services**.

## Basics of Cloud Computing
* General term for the **delivery of hosted services over the Internet**.
* Similar to electricity, pay for what you use without maintaining infrastructure.

## Benefits of Cloud Computing
* **Avoid Upfront Costs**: No need for large capital spending on infrastructure.
* **Scalability**: Easily scale operations up or down based on demand.
* **Efficiency**: Improved manageability and less maintenance.
* **Environmental Impact**: Use of renewable energy and efficient data center designs.
* **Cost Savings**: Savings from efficient data center management passed on to consumers.

## Cloud Computing Configurations
### Public Cloud
* **Provided by companies** like Amazon, Microsoft, Google.
* Services are **isolated** for individual customers.
* **No control** over underlying infrastructure.

### Private Cloud
* Deployed in **private data centers** for more **control**.
* Provides **cloud facilities within the company**.

### Hybrid Cloud
* **Combination** of **public and private** cloud **infrastructure**.
* Joined via a **secure network link** for resource communication.

## Growth and Demand
* **High Demand**: Due to high computing power, cost-effectiveness, performance, scalability, and availability.
* **Growth Rate**: Some cloud vendors experience a 50% growth rate year over year.

<br>

# Benefits of AWS

## Cloud Computing Models
### Infrastructure as a Service (IaaS)
* **Provides virtual machines** and other resources.
* Abstracts users from physical infrastructure details like location, scaling, security, and backup.
  * Examples: Amazon EC2, Google Compute Engine.

### Platform as a Service (PaaS)
* Offers a **development environment** for application developers.
* Includes operating systems, programming environments, databases, and web servers.
  * Examples: AWS Elastic Beanstalk, Microsoft Azure.

### Software as a Service (SaaS)
* Provides **access to application software** and **databases**.
* Managed by cloud providers, usually priced on a pay-per-user or subscription basis.
  * Examples: Google Apps, Microsoft Office 365.

## Benefits of AWS and Cloud Computing
### Agility
* **Speed**: Get applications up and running faster with improved manageability and less maintenance.
* **Scalability**: Easily scale up or down based on business needs and customer usage patterns.

### Security
* **Environment**: Provides a secure environment that meets demanding information security requirements.
* **Compliance**: Compliant with various security and governance standards.

### Cost Efficiency
* **CapEx to OpEx**: Convert capital expenses to operational expenses, paying only for what you use.
* **Optimisations**: AWS continuously optimises operations, passing savings on to clients, reducing total cost of ownership.

### Flexibility
* **Hybrid Cloud**: Build flexible IT architecture that extends on-premises infrastructure to the cloud.
* **Resource Management**: Optimise compute resource usage, deploying only what is needed.

### Innovation
* **Experimentation**: Encourages a culture of innovation, allowing developers to try, experiment, and develop without fear of failure.

<br> 

# Who is using AWS and why?

## Startups Using AWS
* Prominent Startups: Instagram, LinkedIn, Dropbox, Tumblr, Airbnb.
* Employ AWS services for scalability, reliability, and innovation.

## Large Enterprises Using AWS
* Leading Enterprises: Unilever, Lamborghini, Tata Motors.
* Utilise AWS for various requirements including development, testing, and digital transformation.

## Development and Testing
* Companies: Lionsgate, Tokyo Stock Exchange, Galera Chemicals.
* **Benefits**: Faster development cycles, innovation focus, reduced operational costs.

## Innovative Solutions
* Companies: Expedia, General Electric, PBS.
* Deploy new and innovative solutions on AWS Cloud.
  * Example: Netflix runs its entire video streaming business on AWS.

## Mobile Services
* Companies: Samsung, Vodafone.
* Manage and enhance mobile service offerings.

## Traditional Websites
* Companies: Unilever, Lamborghini.
* Deploy websites and digital transformation projects.

## Data Analytics
* Companies: Pfizer, Aon.
* Build and deploy data analytics solutions using AWS tools and services.

## Mobile Applications
* Companies: HTC, Vodafone.
* Build, deploy, and test mobile applications.

## Hybrid Cloud Environments
* Companies: Nasdaq, SunPower, Nokia.
* Extend private data centers with AWS for supplemental tasks like data analytics and operational applications.

## Financial Transactions
* Samsung.
* Integrate AWS services for scalable financial transaction management.

## Application Migration
* Companies: Unilever, Bristol-Myers.
* Migrate existing applications to the cloud for faster product development and reduced costs.

## Data Center Migration
* NewsCorp.
* Migrate entire data centers to AWS, reducing traditional data centers from 40 to 6.

## Full Business Operations
* Companies: Netflix, Suncorp.
* Run entire business operations on AWS, avoiding the need for traditional data centers.

<br>

# Services Provided by AWS

## AWS Services Overview
### Enterprise Applications
* Examples: Virtual desktops, sharing and collaboration services.
* **Purpose**: Used by knowledge workers to **store**, **analyse**, and **share information**.

### Platform Services
* **Analytics**: Hadoop, real-time streaming data, data warehouse, data pipeline.
* **App Services**: Queuing and notifications, workflows.
* **Usage**: Can be used independently or together to build innovative applications.

### Administration and Security Services
* Examples: Identity management, access control, usage and resource tracking.

### Core Services
* Examples: Compute, storage, content delivery networks, databases, networking.
* **Purpose**: Fundamental **services** that **support** other **AWS offerings**.

## AWS Global Infrastructure
### Regions and Availability Zones
* **Current Infrastructure**: 42 availability zones in 16 regions worldwide.
* **Edge Locations**: 63 edge locations.
* **Growth**: AWS is continuously adding new regions and availability zones.

### Global Business Needs
* **Scalability**: Easy to use AWS for global business operations due to extensive infrastructure.

## AWS Certifications and Compliance
### Compliance Programs
* **Purpose**: Ensure robust controls for security and data protection.
* **Shared Responsibility**: Compliance responsibilities are shared between AWS and customers.

### Security Capabilities
* **Validation**: Comprehensive security capabilities validated by industry experts.
* **Environment**: Provides a safe and secure cloud environment for global business needs.

<br>

# Services Provided by AWS #2

## AWS Compute Services
### Amazon EC2
* Provides **scalable virtual servers**.
* **Features**: Autoscaling, load balancing.

### Amazon ECS (Elastic Container Service):
* **Run** and **manage** **Docker containers**.

### Amazon VPC (Virtual Private Cloud)
* **Isolated cloud resources.**

### AWS Lambda
* Run code **without provisioning** servers.

### Instance Types
* For generic workloads.
* **Compute Optimised**: For CPU-intensive tasks.
* **Storage and I/O Optimised**: For specialised workloads.
* **GPU Enabled**: For heavy algorithmic calculations, machine learning, scientific research.

## AWS Storage Services
### Amazon S3 (Simple Storage Service)
* **Scalable** object storage.
* **Features**: High durability and availability.

### Amazon EBS (Elastic Block Store)
* **Block storage** for EC2 instances.

### Amazon EFS (Elastic File System)
* **Scalable** file **storage**.

### Amazon Glacier
* Long-term **archival** storage.

### Storage Gateway
* **Hybrid** storage integration.

## AWS Database Services
### Amazon Aurora
* Cloud-optimised MySQL clone.

### Relational Databases
* Examples: MySQL, PostgreSQL, Oracle, SQL Server.

### NoSQL Databases
* Example: Amazon DynamoDB.

## AWS Migration Services
### Database Migration Service
* Migrate databases with **minimal downtime**.

### Server Migration Service
* Migrate **on-premises servers** to AWS.

## AWS Networking and Content Delivery
### Amazon VPC
* **Isolated** cloud resources.

### Amazon CloudFront
* **Global content** delivery network.

### Amazon Route 53
* **Scalable** DNS service.

## AWS Developer Tools
### AWS CodeCommit
* **Store code** in **private Git** repositories.

### AWS CodeBuild
* **Build** and **test code**.

### AWS CodeDeploy
* **Automate code** deployments.

### AWS CodePipeline
* **Continuous delivery** and **release automation**.

## WS Management Tools
### Amazon CloudWatch
* Monitor resources and applications.

### Amazon EC2 Systems Manager
* Configure and manage EC2 instances and on-premises servers.

### AWS CloudFormation
* Create and manage resources with templates.

## AWS Security, Identity, and Compliance
### AWS Identity and Access Management (IAM)
* Manage user access and encryption keys.

### AWS Certificate Manager
* Provision, manage, and deploy SSL/TLS certificates.

## AWS AI and Machine Learning Services
### Amazon Lex
* Build voice and text chatbots.

### Amazon Polly
* Convert text to lifelike speech.

### Amazon Rekognition
* Search and analyse images.

### Amazon Machine Learning
* Develop machine learning applications.

## AWS Mobile Services
### AWS Mobile Hub
* Build, test, and monitor mobile apps.

### Amazon API Gateway:
* Build, deploy, and manage APIs.

### Amazon Cognito:
* User identity and app data synchronisation.

### Amazon Pinpoint:
* Push notifications for mobile apps.

### AWS Device Farm:
* Test apps on real devices in the cloud.

### AWS Mobile SDK:
* Libraries and tools for building mobile apps.

## AWS Application Services
### AWS Step Functions
* Coordinate distributed applications.

### Amazon Elastic Transcoder
* Scalable media transcoder.

## AWS Messaging Services
### Amazon SQS (Simple Queue Service)
* Message queuing service.

### Amazon SNS (Simple Notification Service)
* Push notification service.

### Amazon SES (Simple Email Service)
* Email sending and receiving service.

<br>

# AWS - a leading cloud platform

## Business Productivity Services
### Amazon WorkDocs
* Enterprise storage and sharing service.

### Amazon WorkMail
* Secure, managed business email and calendaring service.

## Desktop App and Streaming Services
### Amazon WorkSpaces:
* Desktop computing service for cloud-based virtual desktops.
* Features: Access documents, applications, and resources from any supported device.
* Pricing: Pay-as-you-go service.

### Amazon AppStream 2.0:
* Stream desktop applications securely to a browser from the cloud.
* **Benefits**: Reach more users on more devices without code modifications.

## Internet of Things (IoT) and Game Development Services
### AWS IoT Platform:
* Connect devices to the cloud.

### AWS Greengrass:
* Local computing, messaging, and syncing for devices.

### AWS IoT Button:
* Cloud-programmable dash button.

### Amazon Lumberyard:
* Free cross-platform 3D game engine integrated with AWS and Twitch.
* **Benefits**: Create high-quality games and engage users on Twitch.

## Implementation and Innovation
* **Ease of Use**: AWS services are easy to implement and use.
* **Operational Efficiency**: Small teams can operate cloud infrastructure efficiently.
* **Scalability**: High scalability with minimal initial feature set for minimum viable products.
* **Customer Feedback**: Iterate based on customer feedback for continuous improvement.

## AWS Growth and Pricing Philosophy
* **Service Expansion**: AWS now offers over 170 services and features.
* **Innovation**: Rapid pace of innovation since inception.
* **Pricing**: Focus on lower infrastructure costs, reduced prices per usage, and economies of scale.
* **Price Reductions**: 47 price reductions benefiting users.

<br>

# Quiz

1. The prime reason, why businesses switch over to cloud computing is because of its agility.
   * True.
   * The prime reason, why businesses switch over to the cloud, is because it is agile.

2. Which one of the following is a AWS monitoring service?
   * Amazon CloudWatch is a AWS monitoring service.

3. Which of the following statements is NOT true?
   * "operating AWS required a large team of people."
   * ith AWS and a few people, you can operate a large cloud infrastructure.

<br> 