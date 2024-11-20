#  Install Terraform on Windows

- [Install Terraform on Windows](#install-terraform-on-windows)


1. **Open Environment Variables**:
    - Click the **Start** button, type **Environment Variables**, and select **Edit the system environment variables**.
 
        ![Edit the system environment variables](/images/env-var.webp)
 
    - In the **System Properties** window, click on **Environment Variables**.
 
        ![Environment Variables](/images/env-var-2.webp)
       
2. **Edit the System PATH**:
 
    - Under **System variables**, find and select **Path**, then click **Edit**.
 

    - Click **New** and add the path: `D:\Terraform`
 
 
        ![Environment Variables](/images/env-var-3.webp)
 
    - Click **OK** to save the changes.
 
 
3. **Verify Installation in Git Bash**:
 
    - Open Git Bash.
    ```bash
    terraform --version
    ```
    - Output similar to    
    ```bash
    Terraform v1.6.4
    on windows_amd64
    ```