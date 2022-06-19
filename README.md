# Exadel devOps Sandbox

## Task 1:
### Description 
Git/GitHub 
Additional information (optional):
Read about Git https://git-scm.com/doc. Pay attention to the branching strategies.
The “ADV-IT” YouTube channel is recommended (RU).
Read about SSH keys.
Read about Markdown syntax.
Explore pricing policy and your personal billing plan (GitHub).
For better understanding complete this course https://learngitbranching.js.org/?locale=ru_RU
 
### Tasks (mandatory):
1. Create a Github account(if you don’t have one).
2. Create a new Github repository.
3. Create a “Task1” folder in the master branch. Create and push ./Task1/README.md file.
4. Create a new branch dev. Create and push any test file.
5. Create a new branch %USERNAME-new_feature.
6. Add ./README.md file to your %USERNAME-new_feature branch
7. Check your repo with git status command
8. Add .gitignore file to ignore all files whose name begins "."
9. Commit and push changes to github repo.
10. Create Pull Request to the dev branch.
11. Merge your branch with the dev branch and create Pull Request to the master(main) branch. Merge dev with master(main).
12. Checkout to %USERNAME-new_feature, make changes in README.md and commit them. Revert last commit in %USERNAME-new_feature branch.
13. Check your repo with git log command, create log.txt file in master(main) branch and save “git log” output in it.
14. Delete local and remote branch %USERNAME-new_feature.
    1. Add all used commands to the git_commands.md file in the dev branch.
    2. Send the link to your Git Repository to your mentor via private Skype message.

For convenience, please follow to the folder structure on the picture. 

### EXTRA (optional)*:
1. Read about GitHub Actions. What environment variables can be created?
   Create your workflow, what consists of two jobs and contain requirements according the scheme below:

2. Workflow variables should contain two variables: 
    DEPLOY_VER - should contains SHA;
    YEAR - any year as you choose
    First job should:
        Step should:
            Print the list of files/directories in your github repository.
            Print content of your log.txt file.
            Print: "Hello from "your DEPLOY_VER variable’s content" commit"

    Second job should:
    Run  after the First job is finished.
    Contain variable MONTH- any month as you choose
        Step should:
            Contain variable DAY__OF_THE_MONTH - any day number as you choose.
            Print the system date and time
            Print your variable’s content:
                Day - "DAY__OF_THE_MONTH";
                Month - " MONTH";
                Year - "YEAR".

3. Imagine that you keep in secret your favorite day of week (FAVORITE_DAY_OF_WEEK) and don’t want to share it with anyone. So where will you define it?
    Print: "My favorite day of week is "content of FAVORITE_DAY_OF_WEEK""

    What result did you get and why?

### Resultes
All the necessary commands are in [log.txt](./log.txt).
In the second task, we created 2 jobs, and added env to the required levels, 
created a secret (in settings) and then displayed everything via echo in accordance with the assignment. 





## Task 2:
### Description 
1. Important moments:
2. Read about Cloud Services. Pros and Cons, Cloud VS Bare Metal infrastructure?
3. Read about Region, Zone in AWS. What are they for? Which one will you use and why?
4. Read about Security best practices in IAM.
5. Read about AWS EC2, what is it, what is it useful for?
6. Read about AWS VPC (SG, Route, Internet Gateway).
7. Read about AWS Cloud storage, Route 53, CloudFront and CloudWatch.
    If you sign up in AWS for the first time, you will have the opportunity to use SOME AWS services for free (free tier) for 1 year. To register, you need a credit card from which it will be debited and returned 1-2$.
8. Read about AWS Free Tier. Be aware what is free for new users and what is paid by your own money. Be sure and attentive.
9. Pay attention to the Billing & Cost Management Dashboard in your account.

### Tasks (mandatory):
1. Sign up for AWS, familiarize yourself with the basic elements of the AWS Home Console GUI.
2. Explore AWS Billing for checking current costs. 
3. Create two EC2 Instance t2.micro with different operating systems (Amazon linux / Ubuntu ...). Try to stop them, restart, delete, recreate.
4. Make sure there is an SSH connection from your host to the created EC2. What IP EC2 used for it?
5. Make sure  ping and SSH are allowed from one instance to another in both ways. Configure SSH connectivity between instances using SSH keys.
6. Install web server (nginx/apache) to one instance; 
    - Create a web page with the text “Hello World” and additional information about OS version, free disk space,  free/used memory in the system and about all running processes;
    - Make sure your web server is accessible from the internet and you can see your web page in your browser; 
    - Make sure on the instance without nginx/apache you also maysee the content of your webpage from the instance with nginx/apache.

![example](./Task2/images/example.jpg "example")

### EXTRA (optional): 
1. Run steps 3-6 with instances created in different VPC. (connectivity must be both external and internal IP)	
2. Write BASH script for installing web server (nginx/apache) and creating web pages with text “Hello World”, and information about OS version
3. Run step.6 without “manual” EC2 SSH connection.

### EXTRA (optional optional):
1. Make a screenshot only of your web page сontent from your browser.
2. Create your S3 bucket and place your screenshot there.
3. Make your screenshot visible on the internet for everyone and make sure it works.
 
As a result of this task there should be a link in your github on your “Hello World” web page. After a task check by your mentor, the instance may be deleted. EXTRA tasks are passed to mentors individually. 

### Resultes
[My site](http://44.202.151.155/)

### Implementation Steps
[Task2 README](./Task2/README.md)

