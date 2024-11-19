# Make pipeline with 3 jobs
- [Make pipeline with 3 jobs](#make-pipeline-with-3-jobs)
  - [Diagram of Project](#diagram-of-project)
- [Making Job 1 in Jenkins](#making-job-1-in-jenkins)
    - [--\> Source Code Management](#---source-code-management)
    - [--\> Build Environment](#---build-environment)
    - [--\> Build Steps](#---build-steps)
    - [--\> On the job screen...](#---on-the-job-screen)
- [Jenkins Job 2 Setup: CI to Merge Dev Branch into Main](#jenkins-job-2-setup-ci-to-merge-dev-branch-into-main)
  - [Goal](#goal)
  - [Steps to Create Job 2](#steps-to-create-job-2)
    - [Step 1: Create a New Job](#step-1-create-a-new-job)
    - [Step 2.1: Configure Source Code Management (Git)](#step-21-configure-source-code-management-git)
    - [Step 2.2 Guide to Setting up a GitHub Webhook for Job 2](#step-22-guide-to-setting-up-a-github-webhook-for-job-2)
      - [Configure GitHub Webhook](#configure-github-webhook)
      - [Configure Jenkins Job to Trigger from Webhook](#configure-jenkins-job-to-trigger-from-webhook)
      - [Test the Webhook](#test-the-webhook)
    - [Step 3: Configure Build Triggers](#step-3-configure-build-triggers)
  - [](#)
    - [Step 4: Add Build Steps to Merge Branches](#step-4-add-build-steps-to-merge-branches)
  - [](#-1)
    - [Step 5: Set Up Post-Build Actions to Trigger Job 2 from Job 1](#step-5-set-up-post-build-actions-to-trigger-job-2-from-job-1)
  - [](#-2)
    - [Step 6: Save the Job and Test](#step-6-save-the-job-and-test)
    - [Troubleshooting Tips](#troubleshooting-tips)
- [Job 3: Continuous Deployment to EC2 Using SSH Agent and rsync](#job-3-continuous-deployment-to-ec2-using-ssh-agent-and-rsync)
  - [Steps to Create Job 3](#steps-to-create-job-3)
    - [0. Create an EC2 instance for only a Node App](#0-create-an-ec2-instance-for-only-a-node-app)
    - [1. Set Up Jenkins Job](#1-set-up-jenkins-job)
    - [2.1  Configure SSH Agent](#21--configure-ssh-agent)
    - [2.2 How to Get Private Key](#22-how-to-get-private-key)
    - [3. Configure SSH Agent in the Job](#3-configure-ssh-agent-in-the-job)
    - [4. Add Build Step: Execute Shell](#4-add-build-step-execute-shell)
    - [Script Explanation](#script-explanation)
    - [5. Save and Run the Job](#5-save-and-run-the-job)
    - [6. Verify Deployment](#6-verify-deployment)
  - [Summary:](#summary)
  - [Create Job 3 alternative:](#create-job-3-alternative)
  - [Steps:](#steps)
    - [1. Add Secret Text or File to Jenkins:](#1-add-secret-text-or-file-to-jenkins)
    - [2. Configure Job to Use Secret:](#2-configure-job-to-use-secret)
    - [3. Add Build Step: Execute Shell](#3-add-build-step-execute-shell)

## Diagram of Project

![diagram](/images/pipeline_with_3_jobs.png)


# Making Job 1 in Jenkins
1. Follow the previous steps for creation from **1 - 4.**
2. Enable Github Project.
3. Enter the **HTTPS link** for the **repository** you wish to link.
 
![alt text](/images/job-1.png)
 
### --> Source Code Management
1. select **Git** and enter your **SSH** repository link.

![alt text](/images/job-1-scm.png)

2. Add your credentials.
   1. For the **Kind** section, select **SSH Username with private key**.
   2. In **ID**, name it the same as the key.
   3. In description, write what the key is going to be used for.
   4. In the **Username** section, Ppaste the **ID** we just used.
   5. Under **Private Key**, Enable **Enter directly** and input your private key.
    
![alt text](/images/job-1-privatekey.png)
  
3. Click **Add**.
4. Now, under the **credentials**, you can select the key you've added.

 
1. Below that, under **Branches to build**, change it to `*/main`. Later, this'll be `dev`.

![alt text](/images/job-1-change-branch.png)
 
### --> Build Environment
1. Enable **Provide node and npm bin/ folder to PATH** and specify **NodeJS version 20**. We do this so we can run nodejs and npm commands.
 
![alt text](/images/job-1-node-op.png)
 
### --> Build Steps
1. Add an **execute shell** build step, and insert the following commands:
 
```
cd app
npm install
npm test
```
 
![alt text](/images/job-1-script.png)
 
1. Click save and you'll return to the job screen.
 
### --> On the job screen...
1. Select **Build now** and await your evil machine's birth!!! You might have to do some waiting.
2. You can view the job by clicking the link to it under **build history**.
3. Click **Console Output** and you'll see it working in real time if it hasn't finished yet.



# Jenkins Job 2 Setup: CI to Merge Dev Branch into Main

## Goal
The goal of **Job 2** is to automatically merge the `dev` branch into the `main` branch after tests are successfully completed in **Job 1**.

---

## Steps to Create Job 2

### Step 1: Create a New Job
1. **Log in to Jenkins**.
2. Click **New Item** from the Jenkins dashboard.
3. Enter the job name: `<yourname>-job2-ci-merge`.
4. Choose **Freestyle Project** and click **OK**.



---

### Step 2.1: Configure Source Code Management (Git)
1. Under **Source Code Management**, select **Git**.
2. In the **Repository URL**, enter the SSH URL for your GitHub repository:
   ```bash
   git@github.com:<your-repo-owner>/sparta-test-app-cicd.git
   ```
3. Under **Credentials**, select your GitHub SSH credentials (`raiyan-jenkins-2-github-app` or the one you have configured).
<br>

![alt text](/images/job-1-scm.png)
4. Under **Branch Specifier**, enter `*/dev`. This specifies the `dev` branch as the one Jenkins will be pulling from.
![alt text](/images/job-2-dev-branch.png)

### Step 2.2 Guide to Setting up a GitHub Webhook for Job 2

####  Configure GitHub Webhook

1. **Go to your GitHub repository**:
   - Navigate to the repository you want to link to Jenkins.

2. **Open the repository settings**:
   - Click on the **Settings** tab of the repository.

3. **Add a new webhook**:
   - In the left-hand menu, click on **Webhooks**.
   - Click the **Add webhook** button.

4. **Enter the webhook URL**:
   - In the **Payload URL** field, enter your Jenkins URL followed by `/github-webhook/`.
     - Example: `http://<jenkins-server-ip>:8080/github-webhook/`
   - Set the **Content type** to `application/json`.

5. **Choose which events trigger the webhook**:
   - Select **Just the push event** to trigger Jenkins builds only when new commits are pushed to the repository.
   - Alternatively, you can select **Let me select individual events** and choose `push` or other relevant events.

6. **Add the webhook**:
   - Click the **Add webhook** button to save the webhook settings.
   - GitHub will now send push notifications to Jenkins when changes are pushed to the repository.


#### Configure Jenkins Job to Trigger from Webhook

1. **Open Job 2 in Jenkins**:
   - Go to your Jenkins dashboard and click on **Job 2** (e.g., `<yourname>-job2-ci-merge`).

2. **Configure the Job**:
   - Click on **Configure**.

3. **Enable the GitHub hook trigger**:
   - Scroll down to the **Build Triggers** section.
   - Check the box for **GitHub hook trigger for GITScm polling**.
   - This will allow Jenkins to listen for webhook events sent from GitHub and trigger a build.

4. **Save the Job**:
   - Scroll down and click **Save** to store the configuration.

![alt text](/images/job-2-webhook.png)

#### Test the Webhook

1. **Make a Change on the Dev Branch**:
   - Push a change to the `dev` branch of your GitHub repository.

2. **Monitor Jenkins**:
   - After the push, check the Jenkins dashboard to see if **Job 2** was triggered automatically.
   - You can also check the **GitHub Webhook** delivery status:
     - Go back to **GitHub Settings** → **Webhooks** and check the recent deliveries. If successful, it should show the webhook was successfully sent to Jenkins.


---

### Step 3: Configure Build Triggers
1. Scroll down to **Build Triggers**.
2. Check **GitHub hook trigger for GITScm polling**. This will enable the webhook to trigger this job when changes are pushed to the `dev` branch.
  <br>
![alt text](/images/job-2-build-project-1-alt.png)
---

### Step 4: Add Build Steps to Merge Branches
1. Scroll down to **Build Steps**.
2. Add a **Execute Shell** build step to merge the `dev` branch into the `main` branch.

   **Shell Command**:
   ```bash
   # Checkout the main branch
   git checkout main

   # Pull the latest changes from main
   git pull origin main

   # Merge the dev branch into the main branch
   git merge origin/dev

   # Push the updated main branch back to GitHub
   git push origin main
   ```
3. Alternatively a Better way is to not open execute shell and use git publishing plugin in post actions section.
  <br>
![alt text](/images/job-2-gitpublisher.png)
---

### Step 5: Set Up Post-Build Actions to Trigger Job 2 from Job 1
1. Open **Job 1** by navigating to the dashboard and clicking on **Job 1**.
2. Go to **Configure**.
3. Scroll down to **Post-build Actions** and choose **Trigger parameterized build on other projects**.
4. Under **Projects to build**, enter `<yourname>-job2-ci-merge`.
5. Set the **Trigger only if build succeeds** option to ensure Job 2 runs only if Job 1 is successful.
  <br>
![alt text](/images/job-2-build-project-1-alt.png)
---

### Step 6: Save the Job and Test
1. Click **Save** to complete the setup of Job 2.
2. Trigger **Job 1** manually or by pushing a change to the `dev` branch.
3. Once **Job 1** completes successfully, it will trigger **Job 2**, which will merge the `dev` branch into `main`.

---

### Troubleshooting Tips
- If you encounter issues with the merge command, make sure that Jenkins has the correct SSH credentials to push to your GitHub repository.
- Check the **Console Output** of the jobs to troubleshoot any errors related to Git or credential permissions.

---

# Job 3: Continuous Deployment to EC2 Using SSH Agent and rsync

This job will deploy the application from Jenkins to an AWS EC2 instance by using the `ssh-agent` to manage SSH keys and `rsync` for efficient file transfer.

## Steps to Create Job 3

### 0. Create an EC2 instance for only a Node App 
  <br>
- More Info on with steps on [How to create EC2 instance](/2_aws_practical/0_two_tier_deploy_with_1_subnet.md)
- Take note of where you save **private key** and **http/ssh** connections are **allowed**

### 1. Set Up Jenkins Job

- **Job Name**: `<yourname>-job3-cd-deploy`
- Go to Jenkins Dashboard, click **New Item**.
- Choose **Freestyle project** (or Pipeline, if preferred) and name it `<yourname>-job3-cd-deploy`.
- Click **OK** to create the job.

### 2.1  Configure SSH Agent 

- Ensure the **SSH Agent Plugin** is installed 
  
- Go to **Manage Jenkins** → **Manage Credentials** → **Global**.
  - Add a new credential of type **SSH Username with private key**.
  - Paste the private SSH key for your EC2 instance and give the credential an ID (e.g., `aws-ssh-key`).
  <br>
  ![alt text](/images/job-3-5-add-credential-store.png)

### 2.2 How to Get Private Key

Following steps to find your ec2 SSH key pair on your local machine:

1. **Open Terminal** (or Command Prompt on Windows if using Git Bash).
   
2. **Find SSH Key**: when EC2 instance was created you received a private key to the vm only, while public key remained instead ec2 vm.
3. **Print and paste key** into jenkins cred store. Using cat command and store into jenkins
<br>

   ![alt text](/images/job-3-6-private-key.png)
   ![alt text](/images/job-3-6-add-credential-store.png)
  <br>

### 3. Configure SSH Agent in the Job

- In the job configuration, scroll to the **Build Environment** section.
- Check the option **"SSH Agent"**.
- Select the **SSH private key credential** you created (e.g., `raiyan-aws-key`).
![alt text](/images/job-3-1-ssh-agent-cred.png)

### 4. Add Build Step: Execute Shell

- Scroll down to the **Build** section and click **Add build step** → **Execute shell**.
- Paste the following shell script:
- [Pipeline script](/script_reference/1_1_job_3_run_pipeline_script.sh)
```bash
# Define variables
EC2_USER=ubuntu
EC2_IP=34.241.57.116
REMOTE_PATH=/home/ubuntu/app3

# Add the EC2 instance to known hosts (this prevents SSH prompt when connecting for the first time)
ssh-keyscan -H $EC2_IP >> ~/.ssh/known_hosts

# Copy files from Jenkins workspace to the remote EC2 instance using rsync
rsync -avz -e "ssh -o StrictHostKeyChecking=no" $(pwd)/ $EC2_USER@$EC2_IP:$REMOTE_PATH

# SSH into EC2 instance and execute deployment commands
ssh $EC2_USER@$EC2_IP << EOF
    pm2 kill
    # Navigate to the app directory
    cd $REMOTE_PATH/app
    # Run npm install and start the app with pm2
    npm install
    pm2 start app.js
EOF
```

### Script Explanation

1. **Define Variables**:
    - `EC2_USER=ubuntu`: Your EC2 instance's SSH username (commonly `ubuntu`).
    - `EC2_IP=34.241.57.116`: The public IP address of your EC2 instance.
    - `REMOTE_PATH=/home/ubuntu/app3`: The directory path on the EC2 instance where files will be deployed.

2. **Add EC2 to Known Hosts**:
    - `ssh-keyscan -H $EC2_IP >> ~/.ssh/known_hosts`: Adds the EC2 instance’s SSH key to known hosts to avoid prompts.

3. **File Transfer Using rsync**:
    - `rsync -avz -e "ssh -o StrictHostKeyChecking=no" $(pwd)/ $EC2_USER@$EC2_IP:$REMOTE_PATH`: Copies files from Jenkins workspace to EC2 instance efficiently.

4. **Remote Commands**:
    - SSH into the EC2 instance and execute the following:
      - `pm2 kill`: Stops all running PM2 processes.
      - `cd $REMOTE_PATH/app`: Navigate to the app directory.
      - `npm install`: Installs dependencies from the `package.json` file.
      - `pm2 start app.js`: Starts the app with PM2.

### 5. Save and Run the Job

- After pasting the script, click **Save**.
- Trigger the job manually by clicking **Build Now**, or set up automatic triggers (e.g., after a successful build in CI).

### 6. Verify Deployment

- Once the job runs, Jenkins will:
  - Authenticate to the EC2 instance using `ssh-agent`.
  - Copy the project files to the EC2 instance using `rsync`.
  - SSH into the instance and install dependencies, then start the app with PM2.
  
## Summary:
You successfully set up a Jenkins job to deploy an application to an AWS EC2 instance using SSH agent for secure key management and rsync for efficient file transfer.

## Create Job 3 alternative:

steps and script changes required when using Jenkins **"Use secret text(s) or file(s)"** instead of using ssh-agent plugin and also show how to use `scp` command instead of `rsync` without EOF input 

## Steps:

### 1. Add Secret Text or File to Jenkins:
   - Go to **Manage Jenkins** → **Manage Credentials** → **Global**.
   - Add a new credential of type **"Secret text"** or **"Secret file"**:
     - **Secret Text**: Paste the contents of your private key as text.
     - **Secret File**: Upload the private key as a file.
   - Give the credential a meaningful ID (e.g., `aws-ssh-key-secret`).

### 2. Configure Job to Use Secret:
   - In your Jenkins job configuration, scroll to the **Build Environment** section.
   - Check **"Use secret text(s) or file(s)"**.
   - Under **Bindings**, click **Add** → **"Secret text"** or **"Secret file"**.
   - Select the credential ID (e.g., `aws-ssh-key-secret`).
   - Bind the secret to an environment variable (e.g., `AWS_SSH_KEY`).

### 3. Add Build Step: Execute Shell

- Scroll down to the **Build** section and click **Add build step** → **Execute shell**.
- Paste the following shell script:
- [Pipeline script](/script_reference/1_1_job_3_first_version_script.sh)
```bash
# Define variables
EC2_USER=ubuntu
EC2_IP=34.241.57.116
REMOTE_PATH=/home/ubuntu/app3

# Add the EC2 instance to known hosts (this prevents SSH prompt when connecting for the first time)
ssh-keyscan -H $EC2_IP >> ~/.ssh/known_hosts
echo $AWS_SSH_KEY

ssh -i  $AWS_SSH_KEY $EC2_USER@$EC2_IP "rm -rf $REMOTE_PATH && pm2 kill"
# Use scp to copy code from Jenkins workspace to EC2
scp -o StrictHostKeyChecking=no -i $AWS_SSH_KEY -r $(pwd) $EC2_USER@$EC2_IP:$REMOTE_PATH

ssh -i  $AWS_SSH_KEY $EC2_USER@$EC2_IP "cd $REMOTE_PATH/app && npm install && pm2 start app.js"

```