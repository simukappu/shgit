# shgit
Shell script tools to operate git repository from the command line

## Description
Shell script tools to operate git repository as usual task from the command line

## Design
This tool is designed for following development style.
* Remote repository (default name is 'origin') is folked from original repository (default name is 'upstream').
* Local repository is cloned from remote repository.
* Your new commit in the local repository will be pushed to working branch in the remote repository.
* Then you will make pull request from your new remote working branch to base working branch (default name is 'development') in original repository.

## Requirement
1. Clone this repository in any <shgit-root-path> you like.
    ```sh
$ cd <shgit-root-path>  
$ git clone https://github.com/simukappu/shgit.git
```

2. Add "\<shgit-root-path\>/shgit/bin" to PATH environment variable.  
Writing to profile (.bashrc, .bash_profile and so on) may also good for you. 
    ```sh
export PATH=<shgit-root-path>/shgit/bin:$PATH
```

## Usage
Now you can use shgit command from the command line

### Update local and remote self repository as upstream repository
Update your master and base working branch in the local and remote repository as upstream original repository
```sh
$ shgit update-self-repositoty [-b base_working_branch] [-r remote_repository] [-u upstream_repository]
```
Also works
```sh
$ shgit udtrep [-b base_working_branch] [-r remote_repository] [-u upstream_repository]
$ shgit u [-b base_working_branch] [-r remote_repository] [-u upstream_repository]
```

### Delete remote branches with confirmation
Delete your unnecessary remote branches with confirmation
```sh
$ shgit delete-remote-branches [-fpm] [-b base_working_branch] [-r remote_repository]
``` 
Also works
```sh
$ shgit delrb [-fpm] [-b base_working_branch] [-r remote_repository]
$ shgit d [-fpm] [-b base_working_branch] [-r remote_repository]
```

## License
[MIT License](https://github.com/simukappu/shgit/blob/master/LICENSE)
