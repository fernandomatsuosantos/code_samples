# SSH - Basics

## Setup Git & Public/Private keys

### Create public/private keys - Windows

1.  Install [Git for Windows](https://gitforwindows.org)
2.  Open Git Bash (Start->All Programs->Git->Git Bash)
3.  `ssh-keygen -t rsa`
4.  Open file _home_directory/.ssh/id_rsa.pub_ with your favorite text editor, and copy contents to your Git repository (Be sure that you do not copy any whitespace while copying public key's content)

-   Note: home_directory is either C:\\Users\\your_username (Windows Vista / 7 / 8 / 10) or C:\\Documents and Settings\\your_username (Windows XP)

### Create public/private keys - Linux

1.  From the console: `ssh-keygen -t rsa`
2.  Open file _/home/your_username/.ssh/id_rsa.pub_ with your favorite text editor, and copy contents to your Git repository (Be sure that you do not copy any whitespace while copying public key's content)

-   You can also generate an ssh key using [ED25519](https://wiki.archlinux.org/title/SSH_keys#Ed25519) (newer and recommended)  
    `ssh-keygen -t ed25519`

### First time with Git and GitHub

1.  Install [Git](https://git-scm.com/download/linux) 

```bash
apt-get install git

# Config Git
git config --global user.name "Your name here"
git config --global user.email "your_email@example.com"
```

2.  Create public/private keys - check this session in this document
3.  Go to your [GitHub](https://github.com)  "Account Settings", "SSH Keys", "Add SSH Key"
4.  Add a label (like "My laptop") and paste the public key into the big text box
5.  In a terminal/shell, type the following to test it: `ssh -T git@github.com`
6.  If it says something like the following, it worked: `...You've successfully authenticated...`

### Use multiple ssh-keys for different GitHub accounts on the same computer

1.  Open the config file in a text editor (create it if there isn't one in the _/home/your_username/.ssh/id_rsa.pub_ folder yet) - Windows = C:\\Users\\your_username
2.  Add the following to it:

```bash
# Personal GitHub account
Host github.com
 HostName github.com
 User git
 AddKeysToAgent yes
 UseKeychain yes
 IdentityFile ~/.ssh/id_rsa

# Work GitHub account
Host github.com-work
 HostName github.com
 User git
 AddKeysToAgent yes
 UseKeychain yes
 IdentityFile ~/.ssh/work_rsa
```

3.  To clone the work project repo using the new ssh-key we need to tweak a little bit

```bash
git@github.com:[my work GitHub group]/[my project].git
# or
git@github.com*-work*:[my work GitHub group]/[my project].git
```

4.  In the project that cloned locally modify the package.json to install the dependencies - find the private repo dependencies in its package.json (I wouldn’t commit these modifications since it breaks everything for other people who are also working on this project)

```bash
"dependencies": {
    "private-module": "git+ssh://git@github.com-work/[private module name].git
}
```

5.  It might be necessary to first do a manual install for one of the private modules in terminal

`npm install git+ssh://git@github.com-work/[private module name]`

## Use Git without extra passphrase prompts

1.  Start ssh-agent if not started:
    `eval ssh-agent -s`

2.  Add your private key using ssh-add

```bash
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/work_rsa
```

3.  Check if the key is added
    `ssh-add -l`

4.  Try to connect to your Git server:
    `ssh -T git@github.com`
