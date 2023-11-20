# Git笔记

[Git教程](https://www.runoob.com/git/git-tutorial.html)



```shell
git add ./             # 
git commit -m ""
git push

git rm -r --cached .   # 清除当前仓库对所有文件的跟踪

git log   #查看日志

```



```shell
#现实所以大文件所在位置
git rev-list --all | xargs -rL1 git ls-tree -r --long | sort -uk3 | sort -rnk4 |        head -10

```





```shell
git reset HEAD^            # 回退所有内容到上一个版本  
git reset HEAD^ hello.php  # 回退 hello.php 文件的版本到上一个版本  
git  reset  052e           # 回退到指定版本


git reset --hard HEAD~3  # 回退上上上一个版本  
git reset –hard bae128  # 回退到某个版本回退点之前的所有信息。 


git reset --soft 99a8a18ead63802df7cc0163dfa8afe4db0fb059

# 谨慎使用!!!!
git reset --hard origin/master    # 将本地的状态回退到和远程的一样 
```

