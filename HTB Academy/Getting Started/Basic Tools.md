# Basic Tools

An introduction to using SSH, Netcat, Tmux, and Vim

---

### SSH

`ssh`

Primarily used to establish an encrypted, remote connection to a system

Works on TCP port 22 by default

Can be set up for password authentication (remote connection has to enter password for a host to connect to that host) or use public key authentication

![ssh example](C:\Users\Theo\Documents\Cyber\Git\HTB%20Academy\Getting%20Started\pictures\ssh-example.png)

---

### Netcat

`netcat`, `ncat`, `nc`

Primary usage is to connect remotely to the shell of a system

But can also connect to any open port on a system and interact with the service on that port

PowerCat is the Windows Powershell version of netcat, but is not installed by default

Socat is a utility similar to netcat but with expanded features

---

Tmux

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

![tmux horizontal split windows](C:\Users\Theo\Documents\Cyber\Git\HTB%20Academy\Getting%20Started\pictures\tmux-split.png)

tmux uses sessions, which are their own process, so a session does not die when say an ssh connection is closed
