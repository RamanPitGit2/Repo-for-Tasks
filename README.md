#task1 sandbox
задание:
Task 1: Git/GitHub 
Additional information (optional):
Read about Git https://git-scm.com/doc. Pay attention to the branching strategies.
The “ADV-IT” YouTube channel is recommended (RU).
Read about SSH keys.
Read about Markdown syntax.
Explore pricing policy and your personal billing plan (GitHub).
For better understanding complete this course https://learngitbranching.js.org/?locale=ru_RU
 
Tasks (mandatory):
Create a Github account(if you don’t have one).
Create a new Github repository.
Create a “Task1” folder in the master branch. Create and push ./Task1/README.md file.
Create a new branch dev. Create and push any test file.
Create a new branch %USERNAME-new_feature.
Add ./README.md file to your %USERNAME-new_feature branch
Check your repo with git status command
Add .gitignore file to ignore all files whose name begins “.”
Commit and push changes to github repo.
Create Pull Request to the dev branch.
Merge your branch with the dev branch and create Pull Request to the master(main) branch. Merge dev with master(main).
Checkout to %USERNAME-new_feature, make changes in README.md and commit them. Revert last commit in %USERNAME-new_feature branch.
Check your repo with git log command, create log.txt file in master(main) branch and save “git log” output in it.
Delete local and remote branch %USERNAME-new_feature.
 Add all used commands to the git_commands.md file in the dev branch.
 Send the link to your Git Repository to your mentor via private Skype message.

For convenience, please follow to the folder structure on the picture. 

EXTRA (optional)*:
Read about GitHub Actions. What environment variables can be created?
Create your workflow, what consists of two jobs and contain requirements according the scheme below:

Workflow variables should contain two variables: 
DEPLOY_VER - should contains SHA;
YEAR - any year as you choose
First job should:
Step should:
Print the list of files/directories in your github repository.
Print content of your log.txt file.
Print: “Hello from “your DEPLOY_VER variable’s content” commit”
Second job should:
Run  after the First job is finished.
Contain variable MONTH- any month as you choose
Step should:
Contain variable DAY__OF_THE_MONTH - any day number as you choose.
Print the system date and time
Print your variable’s content:
 “Day - “DAY__OF_THE_MONTH”;
            Month - “ MONTH”;
  Year - “YEAR”.”


Imagine that you keep in secret your favorite day of week (FAVORITE_DAY_OF_WEEK) and don’t want to share it with anyone. So where will you define it?
Print: “My favorite day of week is “content of FAVORITE_DAY_OF_WEEK””

What result did you get and why?

все нужные команды лежат в log.txt
во втором задании создаем 2 job добавляем env на нужные уровни создаем сикрет(in settings) 
немного ищем формат вывода даты и потом выводим все через echo в соответствии с заданием 


