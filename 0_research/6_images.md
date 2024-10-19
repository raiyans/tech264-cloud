# Images
- [Images](#images)
  - [Types of Images:](#types-of-images)
  - [How You Use Images:](#how-you-use-images)
  - [Benefits:](#benefits)
- [Azure custom images and market images](#azure-custom-images-and-market-images)
  - [1. Azure Marketplace Images](#1-azure-marketplace-images)
  - [2. Custom Images](#2-custom-images)
  - [Key Differences:](#key-differences)

* We've been using Ubuntu Pro 22 (a market place image). 
* We've been using a market place image to create our Vms.
  * The image determines everything thats going to go on the disk.
  * Then we prepared the VM to run the app. 
  * Create a custom image, used to create an app VM with everything already installed. 
  
"requires Plan information": you can't do this unless your provide information about the origihnal market place image you used. This is because you need to give credit: sometimes they may need to charge you. You need to provide that information when you create your VM.
  * they want to have info on the original market place image that you included. 
  * To solve this: don't use the one from ubuntu, we'll be using a custom marketplace image that Ramon has set up. `ramon-official-ubuntu2204-clean-image`

## Types of Images:
* `Predefined Images`: Azure provides many standard images for **common operating systems** (like Ubuntu, Windows Server) or configurations. 
  * For example, you can choose an image with Ubuntu Linux already installed, so when the VM is created, it’s ready to go.

* `Custom Images`: You can also **create your own image** that includes the OS and any special software or configurations you need. 
  * This is helpful if you want to replicate the same setup across multiple VMs quickly.


## How You Use Images:
* When you want to create a VM, you **select an image** from Azure's image gallery (like choosing "Ubuntu 22.04" or "Windows Server 2022").
* Azure **uses that image to build your VM**, meaning the **VM will have** all the **software and configurations from the image**, so you **don’t need to set it up manually**.

## Benefits:
* `Faster Deployment`: Since the OS and software are already installed, your VM is ready to use much faster.
* `Consistency`: If you use the same image to create multiple VMs, they’ll all have the same setup, which makes it easier to manage them.

In short, Azure images help you quickly create virtual machines that are ready to use, without having to manually install an operating system or software.



# Azure custom images and market images
* virtual machines (VMs) can be created using either custom images or marketplace images.

## 1. Azure Marketplace Images
* These are **pre-built images available** in the Azure Marketplace, which is like a store for cloud resources. They are created and maintained by either Microsoft or third-party vendors. When you create a virtual machine (VM), you can choose one of these **pre-configured images**.
  * `What's included`: Operating systems (like Windows Server, Ubuntu, etc.) and sometimes additional software (like web servers, databases, or complete solutions like a WordPress environment).
  * `Ease of use`: Very convenient because they are ready to go, often requiring just a few settings from you (like VM size, region, etc.).
  * `Who uses them`: Ideal for beginners or people who want a quick, standardised setup without customisation.
  * `Updates`: Managed by the image publisher, ensuring that the software is kept up to date.

## 2. Custom Images
* A custom image is something you **create yourself**, **based on a VM that you have already configured**. Essentially, you take a *snapshot of a VM* (its operating system, installed software, settings, etc.) and *turn it into an image* that can be *used to create new VMs*.
  * `What's included`: Everything you’ve customized on the original VM (the operating system, software, specific configurations).
  * `Flexibility`: You have total control over the VM’s configuration, meaning it’s tailor-made to fit your exact needs.
  * `Who uses them`: Useful for experienced users or companies that need a specific configuration repeated across multiple VMs.
  * `Use case`: If you have set up a specific environment or application that you want to replicate, custom images are the way to go.

## Key Differences:

| Feature                | Azure Marketplace Images                        | Azure Custom Images                      |
|------------------------|-------------------------------------------------|------------------------------------------|
| **Definition**          | Pre-built images from Azure Marketplace         | Images you create from your customised VMs |
| **What's included**     | Pre-configured OS and sometimes additional software | All software, settings, and OS from your original VM |
| **Ease of use**         | Very convenient and ready to deploy             | Requires creating and managing your own image |
| **Flexibility**         | Limited customisation                           | Full control and customisation           |
| **Managed by**          | Publisher (Microsoft or third-party)            | You or your team                         |
| **Ideal for**           | Beginners or quick setups                       | Experienced users or tailored setups     |
| **Updates**             | Handled by the image publisher                  | You are responsible for updates          |
