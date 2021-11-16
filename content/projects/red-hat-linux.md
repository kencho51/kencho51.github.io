+++
description = "Linux Crash Course"
title = "Red Hat Enterprise Linux Technical Overview"
date = 2021-05-05T11:16:25+08:00
tags = ["Linux", "Red Hat"]
author = "Ken Cho"

+++  
### Course Content
1. What is Linux, Open Source Software, and a Distribution?
2. Introduction to the Shell  
   2.1 Prompt `$`: normal user  
   2.2 Prompt `#`: root user  
   2.3 `ls`: list directory contents
   2.4 `ls -a`  
   2.5 `ls -all`  
   2.6 `ls --all`  
   2.7 `ls -l file1 dirA`  
   2.8 `crontab`: maintains crontab files for individual users  
3. Kernel and User Spaces, `kernel` is the heart of Linux operation system    
   3.1  Process with unique ID
    - `User process` associate with a particular user, `fg` and `bg`  
    - `Daemon process` eg, network services or other house keeping tasks to keep the system running  
    - `Kernel threads` part of the kernel that are running as if they were regular user processes or system daemon, but are not associated with the terminal,
    they are part of the kernel, but they are still scheduled as if there were regular processes
    - `ps`: get process information  
    - `ps -ef`: show all process information with detail  
4. Orientation to the Graphical User Interface  
   4.1 `GNOME3`  
5. File Management in Linux  
   5.1 `file`: determine file type  
   5.2 `mkdir`: create directory  
   5.3 `cp`: copy command  
   5.4 `rm`: 
   5.5 `pwd`:
   5.6 `rmdir`: delete only if the directory is empty  
   5.7 `rm -r`: 
   5.8 `ln`: create link
   5.9 `ln -s`: soft link/symbolic link  
6. The File System Hierarchy  
   6.1 `bin`: where to find binary    
   6.2 `sbin`: system binary, only useful to root user  
   6.3 `usr`: unix system resources, where to find the actual binary
   6.4 `whereis ls`: to locate where is the command  
   6.5 `boot`: where the kernel is, the core of the operation system  
   6.6 `lib64`: where all application goes to  
   6.7 `var`: configuration  
   6.8 `/root/tmp`: file inside will be cleared every 10 days  
   6.9 `/root/var/tmp`: file inside will be cleared every 30 days  
7. Editing Files Using Vim  
   7.1 `command mode` and `insert mode`  
   7.2 `:write foo.txt`: create file    
   7.3 `:quite`:quite vim  
   7.4 `yy` + `p`: copy and paste
   7.5 `dd`: delete lines  
   7.6 `O`: into insert mode at new line  
   7.7 `q!`: quit for sure  
   7.8 `vimtutor`: vim tutorial  
8. Organizing Users and Groups  
   8.1 `useradd`: to add user  
   8.2 `id username`: check user property  
   8.3 `uid`: numerical identifier  
   8.4 `gid`: represent user primary group  
   8.5 `groups`: supplementary group  
   8.6 `groupadd`: 
   8.7 `usermod -aG group user`:  append user to the group  
   8.8 `passwd user`: update/change password of a user  
   8.9 `userdel user`: delete user, but user's files remain  
   8.10 `groupdel`:  
   8.11 `grep user /etc/passwd`: 
   8.12 `grep user /etc/shadow`: show user's password hash  
   8.13 `sudo -u user whoami`: change user and run whoami command  
   8.14 `sudo whoami`: root and run whoami command  
   8.15 `su -`: switch user account to `root`  
   8.16 `crtl D`: exit and logout  
9. File Permission  
   9.1 `rwx`: read, write, execute  
   9.2 
   | kind | owning user | owning group | other |
   | --- | --- | --- | ---|
   | - | - - - | - - - | - - - |
   | d/l/b | rwx | - - - | - - - |  
   
   9.3 `ls -ld`: show dir property  
   9.4 `chmod o+w file`: change other to write  
   9.5 `chown student:paul file`: change group ownership from student to paul  
   9.6 `chmod u-rwx file`: rm read, write, execute from the user  
10. Managing Software, `rpm`  
    10.1 `yum install`
    10.2 `yum update`  
    10.3 `yum remove`  
11. Configuring Networking
12. Controlling System Startup Process  
    12.1 `systemctl --list-unit`  
    12.2 `systemctl status sshd`  
    12.3 `systemctl restart ssh`
13. Introduction to Containers  
    13.1 `podman`, `buildah`, `skopeo`  
14. Overview of Cockpit, easy to use interface for network setting    
    14.1 `sysyemctl enable --now cockpit.socket`
15. Learning more about Red Hat Enterprise Linux

### Reference
1. [Cource link](https://www.redhat.com/en/services/training/rh024-red-hat-linux-technical-overview)

[![Build Status](https://travis-ci.com/kencho51/gigathing.svg?branch=master)](https://travis-ci.com/kencho51/gigathing)

