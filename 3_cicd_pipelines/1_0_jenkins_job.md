# Jenkins
- [Jenkins](#jenkins)
  - [Access your Jenkins server](#access-your-jenkins-server)
  - [Make a basic pipeline (a job)](#make-a-basic-pipeline-a-job)
  - [To get jobs to run on after another](#to-get-jobs-to-run-on-after-another)
- [Code along pipeline with 3 jobs](#code-along-pipeline-with-3-jobs)
  - [Making Job 1 in Jenkins](#making-job-1-in-jenkins)
    - [--\> Source Code Management](#---source-code-management)
    - [--\> Build Environment](#---build-environment)
    - [--\> Build Steps](#---build-steps)
    - [--\> On the job screen...](#---on-the-job-screen)
  - [Making Job 2 in Jenkins](#making-job-2-in-jenkins)

## Access your Jenkins server
- Raiyan access to server 2
- Check .ssh repo for Credentials
 
## Make a basic pipeline (a job)
1. Select "new item" in the left hand side
2. name it (as only tech264 are using these server you can exclude that part)
3. select freestyle
4. Everytime the pipeline runs it saves it as a "build"
   ![diagram](/images/jenkins-steps-1.png)
6. we want to keep a max of 5 and discard old builds
7. scroll down to build steps
    ![diagram](/images/jenkins-steps-2.png)
8. select execute shell
   ![diagram](/images/jenkins-steps-2.1.png)
9.  add the ```uname -a``` command
1. when you're done:
   1.  go to dashboard
    ![diagram](/images/jenkins-steps-3-configure.png)
   2.  click build history and click the number
    ![diagram](/images/jenkins-steps-4.png)
   3.  click the console output and you can see the command you've run and the output
2.  when the worker node (that runs the jobs) has run the job, the node stays for 10 minutes
 
## To get jobs to run on after another
1. go back to dashboard
2. click the first job you want to run
3. go to configure on the left hand side
4. scroll to the bottom to "post-build actions"
   ![diagram](/images/jenkins-steps-6.png)
5. select build other projects
6. choose your next project (can add multiple)
7. select trigger only if build is stable
   ![diagram](/images/jenkins-steps-7.png)
8. save
9.  click build now
10. in the console output you should be able to see that it has triggered the next build
11. and if you go to the console output of the triggered build, it should say it was started by an upstream project

# Code along pipeline with 3 jobs

![diagram](/images/pipeline_with_3_jobs.png)


## Making Job 1 in Jenkins
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


## Making Job 2 in Jenkins

![alt text](/images/job-1-script.png)