# Basic Tools

An introduction to using SSH, Netcat, Tmux, and Vim

---

### SSH

`ssh`

Primarily used to establish an encrypted, remote connection to a system

Works on TCP port 22 by default

Can be set up for password authentication (remote connection has to enter password for a host to connect to that host) or use public key authentication

![ssh example](C:\Users\Theo\Documents\Cyber\Public\Notes\HTB%20Academy\Getting%20Started\pictures\ssh-example.png)

---

### Netcat

`netcat`, `ncat`, `nc`

Primary usage is to connect remotely to the shell of a system

But can also connect to any open port on a system and interact with the service on that port

PowerCat is the Windows Powershell version of netcat, but is not installed by default

Socat is a utility similar to netcat but with expanded features

---

### Tmux

`tmux`

Terminal multiplexer, expand capabilities of terminal itself

For example, creating multiple windows and moving between, or splitting the screen between 2 terminal windows

Start tmux with `tmux` command (or with `tmux new -s [name]` to name the session), then use the default prefix `CTRL + B` to issue tmux commands

After pressing `CTRL + B`:

- Create a new window with `C`

- Switch between these windows with the number keys `0`, `1`, ...

- Split the terminal into 2 windows vertically with `SHIFT + %` and horizontally with `SHIFT + "`

- Switch between horizontal windows with `up` and `down`, and vertical windows with `left` and `right`

- Get help with shortcuts with `?`

![tmux horizontal split windows](C:\Users\Theo\Documents\Cyber\Public\Notes\HTB%20Academy\Getting%20Started\pictures\tmux-split.png)

tmux uses sessions, which are their own process, so a session does not die when say an ssh connection is closed

---

### Vim

`vim`

Vim is a text editor that uses the keyboard only, not any mouse input

Vim can often be found installed on Linux systems, and so can be used to edit files on remote machines

There are many extensions and plugins available for Vim that extend its functionality

To open or create a new file, enter `vim [filename]` - if the file exists already it will be opened, if not, it will be created

Files are opened in `normal mode`, which is read only, but can be put into `insert mode` for editing by hitting `i`

Hitting `esc` when within `insert mode` will return to `normal mode`

Hitting `:` from `normal mode` will enter `command mode`, which allows us multiple options, including quitting Vim

Some key shortcuts for `normal mode` include:

![vim normal mode keys](C:\Users\Theo\Documents\Cyber\Public\Notes\HTB%20Academy\Getting%20Started\pictures\vim-normal-keys.png)

And some key shortcuts for `command mode` include:

![vim command mode keys](C:\Users\Theo\Documents\Cyber\Public\Notes\HTB%20Academy\Getting%20Started\pictures\vim-command-keys.png)

---
