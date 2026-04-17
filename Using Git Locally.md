# Using Git Locally

---

### To add a new folder:

```bash
git init
git add .
git commit -m "Initial commit"
gh repo create [name] --public --source=. --push
```

### To push updates to folder contents:

```bash
git add .
git status # optional, but good to double check exactly what you are committing first
git commit -m "[message]"
git push
```

### To sync updates from Git repository to the local device:

```bash
git pull # do this at the start of the session to ensure sync
```

### To update name or email for commits:

```bash
git config --global user.name "[name]"
git config --global user.email "[email]" # remember to use GitHub provided noreply email for anonymity
git config --global --list # displays set name and email
```

### To connect a new device to GitHub:

```bash
# first ensure git and gh are installed with winget / apt (Windows / Unix)

gh auth login # select GitHub -> SSH -> New key (set a passphrase) -> device name -> connect on GitHub.com
ssh -T git@github.com # connect to show ssh is set up correctly, -T required
```

### Installing git and gh on Windows:

```powershell
winget search --id Git.Git
winget install --id Git.Git --source winget
git --version # may need to restart pwsh to complete install

winget search --id Github.cli
winget install --id Github.cli --source winget
gh --version # may need to restart pwsh to complete install
```

Installing on linux should be as simple as typing `git` and `gh`, and installing either with sudo as needed. Use apt over snap when possible: `sudo apt install gh`

### To start a new ssh agent (and only have to enter git ssh key passphrase once per session):

```powershell
Get-Service ssh-agent # should say "Running", if so, good to go
Start-Service ssh-agent # only needed if Get-Service says "Stopped"

ls $env:USERPROFILE\.ssh # check the name of your private key for git
ssh-add $env:USERPROFILE\.ssh\[priv key name] # adds the key to current session
# ^^^ this is the *only* command needed if not debugging

ssh-add -l # verify key added to session
```

---
