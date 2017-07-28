1. Refer this link to download & setup jenkins:
  https://hodgkins.io/automating-with-jenkins-and-powershell-on-windows-part-1
  
  After running localhost:8080  for first time, it will ask for the admin password. For this:
  Go to : cd /var/lib/jenkins/secrets/initialAdminPassword  
  Copy the adminpassword, paste it into the password tab  and setup the account on jenkins 

2. Install git and github plugin and  pull private git repository using this link:
   http://jsystem.org/jenkins-integration-pulling-from-a-git-private-repository/
 
3.  Some important Jenkins Commands to stop and restart Jenkins service.
       Open Console/Command line --> Go to your Jenkins installation directory. Execute the following commands respectively:

       a. to stop:
         jenkins.exe stop

       b. to start:
         jenkins.exe start

       c. to restart:
         jenkins.exe restart
    

4. Example to create Simplest Jenkins Project by pulling the powershell script in the git repository and run it:
   https://www.devopslibrary.com/lessons/jenkins-github-powershell-params