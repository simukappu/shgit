# shgit
Command line tool to operate local and remote git repositories

## Description
Shell script tool for usual development task with operation to your local and remote repositories.  

## Design
This tool is designed for following development style.
* Your remote repository (default name is 'origin') is folked from upstream repository (default name is 'upstream').
* Local repository is cloned from your remote repository.
* Your new commit in the local repository will be pushed to working branch in your remote repository.
* Then you will make pull request from your new remote working branch to base working branch (default name is 'development') in upstream repository.

## Requirement
shgit needs bash.

1: Clone this repository in any directory \<shgit-root-path\>  (e.g. $HOME/.shgit) you like.
```sh
$ mkdir $HOME/.shgit  
$ cd $HOME/.shgit  
$ git clone https://github.com/simukappu/shgit.git
```
2: Add "\<shgit-root-path\>/shgit/bin" to PATH.  
Writing to profile (.bashrc, .bash_profile and so on) may be also good for you.
```sh
$ echo 'export PATH="$HOME/.shgit/shgit/bin:$PATH"' >> $HOME/.bash_profile  
$ source $HOME/.bash_profile
)
```
3: Edit "\<shgit-root-path\>/shgit/config/shgit.properties" as your environment if you need.
```sh
$ vi $HOME/.shgit/shgit/config/shgit.properties
```
4: Now you can use shgit commands from your terminal.  
```sh
$ shgit -h
```

## Usage
Move to your local git repository and use shgit commands.

### Update your local and remote repositories to upstream repository
Update your master and base working branch in your local and remote repositories to upstream repository
```sh
$ shgit <u|update> [-b base_working_branch] [-r remote_repository] [-u upstream_repository]
```

### Delete local branches with confirmation
Delete your unnecessary local branches with confirmation
```sh
$ shgit <dl|delete-local> [-fm] [-b base_working_branch]
```

### Delete remote branches with confirmation
Delete your unnecessary remote branches with confirmation
```sh
$ shgit <dr|delete-remote> [-fpm] [-b base_working_branch] [-r remote_repository]
```

### Prepare new development branch
Prepare new development branch with updating and cleaning unnecessary branches
```sh
$ shgit <p|prepare> [-mcf] [-b base_working_branch] [-r remote_repository] [-u upstream_repository]
```

### Send pull-request
Send pull-request from origin to upstream repository (this function needs [hub](https://github.com/github/hub) instration)
```sh
$ shgit <r|pull-request> [-p] [-o origin_branch] [-b target_branch] [-i issue]
```

## License
[MIT License](https://github.com/simukappu/shgit/blob/master/LICENSE)
