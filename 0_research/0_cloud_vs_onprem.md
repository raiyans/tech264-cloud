
# Cloud Computing Overview
- [Cloud Computing Overview](#cloud-computing-overview)
  - [1. How do we know if something is in the cloud?](#1-how-do-we-know-if-something-is-in-the-cloud)
  - [2. Differences between on-prem and the cloud](#2-differences-between-on-prem-and-the-cloud)
  - [3. The 4 deployment models of cloud: Private vs Public vs Hybrid vs Multi-Cloud](#3-the-4-deployment-models-of-cloud-private-vs-public-vs-hybrid-vs-multi-cloud)
  - [4. Types of cloud services: IaaS, PaaS, SaaS](#4-types-of-cloud-services-iaas-paas-saas)
  - [5. Advantages/Disadvantages of the cloud for a business](#5-advantagesdisadvantages-of-the-cloud-for-a-business)
  - [6. Difference between OpEx vs CapEx and how it relates to the cloud](#6-difference-between-opex-vs-capex-and-how-it-relates-to-the-cloud)
  - [7. Is migrating to the cloud always cheaper?](#7-is-migrating-to-the-cloud-always-cheaper)
  - [8. Market Share - Breakdown of Cloud Providers](#8-market-share---breakdown-of-cloud-providers)
    - [Market Share Breakdown:](#market-share-breakdown)
  - [9. What are the 3 largest cloud providers known for?](#9-what-are-the-3-largest-cloud-providers-known-for)
  - [10. Which cloud provider might be the best? Why?](#10-which-cloud-provider-might-be-the-best-why)
  - [11. What sorts of things do you usually need to pay for when using the cloud?](#11-what-sorts-of-things-do-you-usually-need-to-pay-for-when-using-the-cloud)
  - [12. What are the 4 pillars of DevOps? How do they link into the Cloud?](#12-what-are-the-4-pillars-of-devops-how-do-they-link-into-the-cloud)
  - [13. Case Studies of Cloud Migration](#13-case-studies-of-cloud-migration)
    - [Takeaways](#takeaways)

## 1. How do we know if something is in the cloud?
Something is considered "in the cloud" if it is hosted on external servers accessible via the internet rather than on local on-premise servers. Cloud services are managed by third-party providers and accessed through the internet, offering scalability, accessibility, and often lower costs due to shared resources. provided as a service with on demand service usually 

## 2. Differences between on-prem and the cloud
- **On-Premise:** Hardware and software are owned and operated locally, meaning full control over the infrastructure but requiring significant initial costs, space, and in-house expertise. it is your own physical servers that are related to keep it working working
- **Cloud:** Resources like storage, processing, and applications are hosted on remote servers, reducing CapEx (capital expenditure) but increasing reliance on external providers. the cloud provider will handle the physical aspects

## 3. The 4 deployment models of cloud: Private vs Public vs Hybrid vs Multi-Cloud
- **Private Cloud:** Infrastructure is dedicated to a single organization, offering greater control, security, and customization. Ideal for companies with strict data regulations or security needs.
- **Public Cloud:** Resources are shared across multiple clients by a third-party provider. It offers cost-efficiency, scalability, and quick setup, but less control and customization.
- **Hybrid Cloud:** Combines on-premise infrastructure (or private cloud) with public cloud resources, providing flexibility to store sensitive data locally while scaling non-sensitive workloads to the cloud. ideal maybe for regulations
- **Multi-Cloud:** Utilizes multiple cloud providers to optimize performance, avoid vendor lock-in, and increase resilience. Offers flexibility but may be complex to manage. ideal maybe fo financial services that need redundancy

## 4. Types of cloud services: IaaS, PaaS, SaaS
- **IaaS (Infrastructure as a Service):** Provides basic cloud infrastructure services such as virtual machines, storage, and networks. Example: AWS EC2.
- **PaaS (Platform as a Service):** Offers a platform allowing developers to build applications without managing underlying infrastructure. Example: Google App Engine. manage the security with code best practices that cannot be exploited
- **SaaS (Software as a Service):** Delivers fully functional software applications over the internet. Example: Microsoft Office 365 or Salesforce.

- **Diagram** [shared responsibilty](Defining_responsibility.png)

## 5. Advantages/Disadvantages of the cloud for a business
**Advantages:**
- **Scalability:** Easily scale resources up or down based on demand.
- **Cost Efficiency:** Lower upfront costs (CapEx) and pay-per-use pricing.
- **Accessibility:** Accessible from anywhere with an internet connection.
- **Innovation:** Faster deployment and access to cutting-edge technologies.

**Disadvantages:**
- **Security Concerns:** Data is stored externally, which may be a concern for sensitive information.
- **Downtime Risk:** Relying on internet access and third-party providers means potential service outages.
- **Vendor Lock-in:** Moving data and applications between cloud providers can be challenging.

## 6. Difference between OpEx vs CapEx and how it relates to the cloud
- **CapEx (Capital Expenditure):** Refers to large upfront investments in physical infrastructure, like on-prem servers. Once purchased, it's owned and depreciated over time.
- **OpEx (Operating Expenditure):** Relates to ongoing operational costs, like paying for cloud services as you go. The cloud typically shifts IT spending from CapEx to OpEx, allowing businesses to pay only for what they use.

## 7. Is migrating to the cloud always cheaper?
Not always. While the cloud reduces upfront costs, ongoing operational expenses can accumulate depending on the cloud model and usage patterns. Hidden costs like data egress fees, performance optimization, and compliance requirements can increase the total cost of ownership.

## 8. Market Share - Breakdown of Cloud Providers
The cloud market is dominated by three major providers: AWS, Microsoft Azure, and Google Cloud. AWS holds the largest share, followed by Azure, with Google Cloud in third.

### Market Share Breakdown:
- **AWS:** 32%
- **Azure:** 23%
- **Google Cloud:** 10%
- **Other:** 35%

## 9. What are the 3 largest cloud providers known for?
- **AWS (Amazon Web Services):** Known for its market dominance, AWS offers a broad range of services from IaaS to machine learning, along with a strong focus on enterprise needs.
- **Microsoft Azure:** Strong in the enterprise and hybrid cloud markets due to its integration with Microsoft products like Office 365 and Windows Server. Azure is known for hybrid cloud solutions and its close ties with enterprise software.
- **Google Cloud:** Known for its prowess in data analytics, artificial intelligence, and machine learning. Google Cloud is also popular for its Kubernetes support and developer-friendly services.

## 10. Which cloud provider might be the best? Why?
- **AWS:** Best for businesses needing broad services and scalability.
- **Azure:** Ideal for businesses already using Microsoft software or those focusing on hybrid deployments.
- **Google Cloud:** Best for companies heavily focused on data analytics and machine learning.

## 11. What sorts of things do you usually need to pay for when using the cloud?
- **Storage:** For data storage, including block storage and object storage.
- **Compute Power:** For processing tasks, including virtual machines or containers.
- **Data Transfer:** Often includes fees for data transferred in(ingress not usually fees paid) and out(egress) of the cloud.
- **Additional Services:** Things like machine learning, databases, and analytics typically incur extra charges.

## 12. What are the 4 pillars of DevOps? How do they link into the Cloud?
- **Collaboration:** Encouraging seamless collaboration between development and operations teams.
- **Automation:** Automating processes like testing, deployment, and infrastructure provisioning, which the cloud enhances with tools like Infrastructure as Code (IaC).
- **Continuous Integration/Continuous Deployment (CI/CD):** Enables rapid and reliable software delivery pipelines, which are supported by cloud-native CI/CD services.
- **Monitoring/Feedback:** Cloud platforms provide built-in monitoring and alerting tools to track the health and performance of applications.

## 13. Case Studies of Cloud Migration
1. **Netflix:** Migrated from on-premise data centers to AWS to handle its immense streaming traffic. Benefits included scalability and the ability to innovate faster by leveraging cloud services like AWS Lambda and Amazon RDS.
2. **Capital One:** Leveraged AWS for improving data analytics and enhancing customer experience. The move to the cloud allowed them to utilize machine learning to better analyze customer data while reducing infrastructure costs.
3. **Airbnb:** Moved to AWS to scale with growing demand, ensuring reliability and availability for users worldwide. The migration enabled them to use services like Amazon DynamoDB and Amazon S3, which helped streamline operations.

---

### Takeaways 
- Migrating to the cloud offers flexibility and cost advantages, but it’s not always cheaper. You must carefully consider hidden fees and performance costs.
- AWS is dominant due to its breadth of services, but Google Cloud may be the best choice for organizations focused on AI and data analytics.
- DevOps and cloud computing go hand in hand, particularly around automation, CI/CD, and monitoring.
