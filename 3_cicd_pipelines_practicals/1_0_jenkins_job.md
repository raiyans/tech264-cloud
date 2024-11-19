# Jenkins
- [Jenkins](#jenkins)
  - [Access your Jenkins server](#access-your-jenkins-server)
  - [Make a basic pipeline (a job)](#make-a-basic-pipeline-a-job)
  - [To get jobs to run on after another](#to-get-jobs-to-run-on-after-another)

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

