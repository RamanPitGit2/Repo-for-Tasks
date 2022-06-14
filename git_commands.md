git clone git@github.com:RamanPitGit2/repo-for-task1.git
cd repo-for-task1.git
mkdir Task1
cd Task1/
echo Task1 > README.md
cat README.md
git status
git add README.md 
git status 
cd ..
git commit -m "add Task1 folder"
ssh-keygen 
cat ~/.ssh/id_rsa_exadel.pub 
git config core.sshCommand 'ssh -i /c/Users/User/.ssh/id_rsa_exadel'
git push 
git checkout -b dev
vi Task1/testfile.txt
git add Task1/testfile.txt
git status
git commit -m 'add new file'
git push 
git push --set-upstream origin dev
git checkout -b RamanPitGit2-new_feature
git status 
vi .gitignore
git status
git add .gitignore
git add .gitignore -f
git status
vi README.md
git status 
git commit -m 'add readme'
git status
git add README.md
git commit --amend 
git status 
git push 
git push --set-upstream origin RamanPitGit2-new_feature
git checkout main 
git fetch 
git checkout RamanPitGit2-new_feature 
vi README.md
get status 
git status 
git add README.md 
git commit -m 'change readdme file'
git log 
git revert --no-commit b59bbf671d7241804e1d2f91a4426fb76a6f61ab..HEAD
git status
git log
git commit 
git log
git checkout main 
git log > log.txt
git checkout RamanPitGit2-new_feature  
git log > log.txt
git status 
git checkout main 
git checkout RamanPitGit2-new_feature  
git checkout main 
git branch -D RamanPitGit2-new_feature 
git push origin --delete RamanPitGit2-new_feature 
history > git_commands.md
