# Deep Dive into AWS CloudWatch

- [Deep Dive into AWS CloudWatch](#deep-dive-into-aws-cloudwatch)
  - [What is AWS Cloudwatch?](#what-is-aws-cloudwatch)
    - [Key Features](#key-features)
  - [Recap of CloudWatch](#recap-of-cloudwatch)
  - [CloudWatch Alarms](#cloudwatch-alarms)
  - [Use Cases for CloudWatch](#use-cases-for-cloudwatch)
  - [CloudWatch Alarm States](#cloudwatch-alarm-states)
  - [Integration with Other AWS Services](#integration-with-other-aws-services)
  - [Core Features of CloudWatch](#core-features-of-cloudwatch)
- [AWS CloudWatch Dashboards](#aws-cloudwatch-dashboards)
  - [How to Create and Configure AWS CloudWatch Dashboards](#how-to-create-and-configure-aws-cloudwatch-dashboards)
    - [Step 1: Access CloudWatch Dashboards](#step-1-access-cloudwatch-dashboards)
    - [Step 2: Create a New Dashboard](#step-2-create-a-new-dashboard)
    - [Step 3: Add Visualisations](#step-3-add-visualisations)
    - [Step 4: Choose Metrics](#step-4-choose-metrics)
    - [Step 5: Adjust Time Dimensions](#step-5-adjust-time-dimensions)
    - [Step 6: Add Multiple Metrics](#step-6-add-multiple-metrics)
    - [Step 7: Customise the Dashboard](#step-7-customise-the-dashboard)
    - [Step 8: Change Visualisation Types](#step-8-change-visualisation-types)
    - [Step 9: Finalise the Dashboard](#step-9-finalise-the-dashboard)
- [AWS CloudWatch Alarms](#aws-cloudwatch-alarms)
  - [Alarm States](#alarm-states)
    - [Alarm State](#alarm-state)
    - [Insufficient Data State](#insufficient-data-state)
    - [OK State](#ok-state)
  - [Creating an Alarm](#creating-an-alarm)
  - [Monitoring and Troubleshooting](#monitoring-and-troubleshooting)
    - [Example Scenario](#example-scenario)
- [AWS CloudWatch Features](#aws-cloudwatch-features)
  - [Billing Alarms](#billing-alarms)
  - [CloudWatch Events](#cloudwatch-events)
  - [CloudWatch Logs](#cloudwatch-logs)
  - [CloudWatch Metrics](#cloudwatch-metrics)
  - [CloudWatch Auto Scaling Integration](#cloudwatch-auto-scaling-integration)
  - [Rebooting Failed EC2 Instances](#rebooting-failed-ec2-instances)
  - [Integration with Third-Party Tools](#integration-with-third-party-tools)
  - [Custom Metrics](#custom-metrics)


## What is AWS Cloudwatch?
* AWS CloudWatch is like a super helpful **tool** that keeps an eye on your stuff (**monitors**) in the **cloud**. 
* Imagine you have a bunch of computers, databases, and other resources **running on Amazon Web Services** (AWS). 
* CloudWatch helps you monitor all of these things to make sure they are working properly.

### Key Features
* **Monitoring**: It tracks important data (called metrics) like how much CPU your servers are using, how much memory is left, and how much traffic your website is getting.
* **Alarms**: You can set up alarms to get notified if something goes wrong. For example, if your server's CPU usage gets too high, CloudWatch can send you an alert.
* **Logs**: It collects and stores log files from your applications and services. This helps you troubleshoot issues by looking at what happened at specific times.
* **Dashboards**: You can create visual dashboards to see all your metrics and alarms in one place. This makes it easy to understand the health of your system at a glance.

> AWS CloudWatch is like a security guard and a health monitor for your cloud resources, making sure everything runs smoothly and alerting you if something needs attention.

<br>

## Recap of CloudWatch
* **Metrics Collection**: Monitors native AWS and custom application metrics.
* **Integration**: Works seamlessly with many AWS services.
* **Alarms** and Notifications: Set up alarms based on chosen metrics.
* **Access**: Available via AWS API dashboard or AWS CLI.

## CloudWatch Alarms
* **Functionality**: Observes metrics over time and triggers actions based on thresholds.
* **Actions**: Notifications via SNS, Autoscaling policies, or custom actions.
* **Trigger Conditions**: Alarms trigger based on sustained state changes, not momentary threshold crossings.

## Use Cases for CloudWatch
* **Monitoring AWS Infrastructure**: EC2 instances, RDS databases, S3 buckets, etc.
* **Integration**: No special code or configuration needed.
* **Monitoring Custom Applications**: Microservices, web applications, mobile apps.
* **Objective**: Ensure optimal performance and security.
* **Log Monitoring**: Aggregates logs from various sources into a single view.
* **Real-Time Alerts**: Inform operations teams and trigger automated corrective actions.
  * Example: Triggering an alarm for high CPU utilisation to create a new EC2 instance.

## CloudWatch Alarm States
* `OK State`: Metric within defined threshold, alarm not triggered.
* `Alarm State`: Metric outside defined threshold, alarm triggered.
* `Insufficient Data`: Not enough data to determine alarm state.

## Integration with Other AWS Services
* **SNS**: Sending notifications via email, SMS, HTTP, HTTPS.
* **SQS and Lambda**: Further integration for enhanced functionality.
* **Autoscaling**: Automatically scale EC2 instances based on alarms.
* **Continuous Integration**: Rich integration with various AWS services, with more being added.

## Core Features of CloudWatch
* **Visualisation**: Display multiple metrics on a single graph.
* **Dashboards**: Consolidated view of metrics with text and images.
* **Customisation**: Build multiple dashboards for different views.
* **Global View**: Pull data from multiple AWS regions into a single dashboard.

<br> 

# AWS CloudWatch Dashboards
A guide on how to create and configure AWS CloudWatch dashboards to effectively monitor and visualise your cloud infrastructure.

## How to Create and Configure AWS CloudWatch Dashboards
### Step 1: Access CloudWatch Dashboards
1. Log in to **AWS Management Console**: Navigate to the **AWS CloudWatch service**.
2. Click on the "Dashboards" link in the **CloudWatch admin control panel**.

### Step 2: Create a New Dashboard
* Click on the "Create Dashboard" button.
* A pop-up window will appear. Enter a **name** for your new dashboard (e.g., "AWS Demo") and click "Create Dashboard".

### Step 3: Add Visualisations
1. Select Visualisation Type: Choose the type of visualisation you want to add to your dashboard. Options include:
   * **Line Visualisation**: Compare metrics over time.
   * **Stacked Area**: Compare total value over time.
   * **Number**: Instantly see the latest value of the metric.
   * **Text**: Add free text with markdown formatting.
2. Click on "Configure" after selecting your desired visualisation type.

### Step 4: Choose Metrics
1. Choose the **metric** you want to plot for the visualisation. 
   * For example, to plot CPU utilisation for an EC2 instance:
     * Click on "EC2" and then "All Metrics".
     * Type "CPU Utilisation" in the search box.
     * Select the desired metric from the filtered list.

### Step 5: Adjust Time Dimensions
1. Set Time Frame: Choose the appropriate **time frame** for your visualisation (e.g., 1 hour, 3 hours, 12 hours, 1 day, 1 week).
2. View Data: The data for the selected metric will be **plotted on the dashboard**. Adjust the time frame to see different periods of data.

### Step 6: Add Multiple Metrics
1. You can add additional metrics **from other resources** (e.g., S3 buckets, databases, web servers) to the **same dashboard**.
   * This helps visualise and correlate various scenarios and understand how different resources behave in relation to each other.

### Step 7: Customise the Dashboard
1. **Modify Metrics**: Use the graph metric tab to view and modify the metrics being plotted.
2. **Change Statistics**: Switch between average, maximum, or other statistical values based on your requirements.
3. **Adjust Periods**: Change the period (e.g., 30 days, 7 days, 1 day, 1 hour) to suit your needs.
4. **Axis Options**: Rotate and modify the y-axis limits as needed.

### Step 8: Change Visualisation Types
1. **Switch Visualisation Types**: Change the visualisation type (e.g., from line to stacked area or number) to suit your preferences.
2. **Set Refresh Intervals**: Determine how often the visualisation **updates with fresh data** (e.g., every 15 minutes, 5 minutes, 1 minute).

### Step 9: Finalise the Dashboard
1. Click on "Create Widget" to **finalise the dashboard** with the new visualisation.
2. Manage Dashboards: View, pin, and add new visualisations to existing dashboards as needed.

<br>

# AWS CloudWatch Alarms
Overview:
* Set up alarms based on CloudWatch metrics.
* Trigger specific jobs or notify users when alarm conditions are met.

## Alarm States
### Alarm State
* **Threshold** specified in the alarm definition has been **reached** or **crossed**.
* Alarm transitions to the alarm state.

### Insufficient Data State
* **Alarm** does **not have sufficient data** for its metrics.
* Monitor transitions to insufficient data state if data is missing or incomplete.

### OK State
* **Metric** is **within the specified** acceptable **range**.
* Monitor is in the OK state.

## Creating an Alarm
1. Go to the **CloudWatch dashboard** and click on the "alarms" link.
2. Click on "Create Alarm".
3. Select Metrics:
   * Choose the **service** (e.g., EC2) and search for the **desired metric** (e.g., CPU utilisation).
   * Select the **metric** and choose the **statistic** (e.g., maximum) and **interval** (e.g., one minute).

4. Define Alarm
   * **Name** the alarm (e.g., EC2 CPU utilisation alarm).
   * Set the **description** (e.g., test alarm).
   * Specify the **threshold** (e.g., CPU utilisation ≥ 60% for one consecutive period of 15 minutes).
   * Adjust the threshold and consecutive periods as needed.

5. Set Actions
* Define the **state** that **triggers the notification** (e.g., alarm state).
* Choose the **notification topic** (e.g., email address of the subscriber).
* Add other actions if needed (e.g., auto-scaling, EC2 actions).

6. Click on "Create Alarm".

## Monitoring and Troubleshooting
* **Insufficient Data State**: Identify and troubleshoot issues to ensure CloudWatch can reliably monitor the metrics.
* **OK State**: Ensure the metric is within the acceptable range.

### Example Scenario
CPU Utilisation Alarm:
* Create an alarm for **CPU utilisation** of an EC2 instance.
* **Set the threshold** to 1% for one consecutive period.
* **Configure the alarm** to trigger notifications when the CPU utilisation exceeds the threshold.

<br>

# AWS CloudWatch Features

## Billing Alarms
* Creates alarms on **estimated charges**.
* It **monitors estimated charges** at certain **thresholds**.
* **Automation**: Wire up billing alarms with **scripts** to **decommission resources** as charges cross thresholds.

## CloudWatch Events
* Responds to **state changes** in AWS resources.
* **Runs** specific **tasks** when AWS **resources change state**.
* **Use Case**: Automate operations like adding a new EC2 instance to a domain.

## CloudWatch Logs
* **Store**, **view**, **index**, and **search** **logs** from various services (e.g., Lambda, RDS, EC2).
* Monitors logs to find details about specific events within AWS services.

## CloudWatch Metrics
* **View** various **metrics** monitored by CloudWatch.
* **Core Foundation**: Metrics form the core foundation of CloudWatch's monitoring service.

## CloudWatch Auto Scaling Integration
* Automatically **scale servers up** and **down** based on **requirements**.
* **Scaling Triggers**: Scale based on schedule, demand, or server hardware utilisation.
  * Example: Terminate an instance if CPU utilisation is low; spin up a new instance if CPU utilisation exceeds 75%.

## Rebooting Failed EC2 Instances
* **Automatically reboot** failed EC2 instances on **failed status** checks (e.g., loss of network connectivity, system power issues).

## Integration with Third-Party Tools
* **Tools**: Copperegg, Stackdriver, New Relic.
* **Functionality**: Provide fine-grained performance monitoring and custom dashboards.

## Custom Metrics
* Monitor additional metrics beyond default CloudWatch metrics.
  * Examples:
    * **Memory Utilisation**: Memory allocated by applications and the operating system, excluding cache and buffer, in percentage.
    * **Memory Used**: Memory allocated by applications and the operating system, excluding cache and buffer, in megabytes.
    * **Memory Available**: System memory available for applications and the operating system in megabytes.
    * **Disk Space Utilisation**: Disk space usage as a percentage.
    * **Disk Space Used**: Usage of disk space in gigabytes.
    * **Disk Space Available**: Available disk space in gigabytes.
    * **Swap Space Utilisation**: Swap space usage as a percentage.

Swap Space Used
* **AWS Monitoring Scripts**: Report metrics like memory used, memory available, disk space used, and swap space used.

<br>
