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


