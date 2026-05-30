# Intro to the CLI

---

Cisco IOS CLI is the OS used on Cisco devices. A "CLI" is a *Command-Line Interace*. The Cisco CLI is the interface used to configure Cisco devices. Cisco devices also have GUIs, but these aren't used as commonly.

To connect to a Cisco device to configure the device, one way is to connect to the physical *console port* on the device. This port may allow multiple different connectors, such as USB Mini-B, RJ-45, or others.

To connect to the RJ-45 console port on the Cisco device a *rollover cable* is used - with an RJ-45 connector on one side, and a DB-9 connector on the other. As most modern devices don't have DB-9 serial ports, an adapter is usually required.

A rollover cable has 8 pins within it, but these pins are connected to their compliment on the other side: pin 1 connects to pin 8, pin 2 connects to pin 7, pin 3 connects to pin 6, and so on.

PuTTY (a terminal emulator / remote connection tool - [Link](https://putty.software)) is a tool often used to connect to Cisco CLI via a remote connection. The following settings just be used to open a serial connection to a device.

![putty config options](C:\Users\Theo\AppData\Roaming\marktext\images\4ae77466109ab784b1c83c0bdc63c845bddda76d.png)

Entering the CLI, the default mode is EXEC mode - indicated by > after hostname at the prompt, for example `Router>` (Router is the default hostname for a Cisco router). EXEC mode (User EXEC mode, or just User mode) only allows configs to be read, not altered.

The command `enable` (or `en`) allows a user to move to "privileged EXEC mode" indicated by a hash # after hostname at the prompt, for example `Router#`. This mode allows further read permissions and some more functionality (such as restarting the device, changing the time settings, or save current config), but still does not allow changes to configuration. Entering the command `exit` here will return to user EXEC mode (`Router>`).

The `?` command can be entered to list all commands available in the current mode. Privileged EXEC mode allows for a lot more commands than user EXEC mode.

The CLI allows partial commands to be entered - if enough of a command has been entered that it is unambiguous what command is intended, then entering that partial command is equivalent to entering the full command. If a partial command is ambiguous, the CLI will return "Ambiguous command". If a partial command is entered with `?` after it (with **no space**), all possible commands this partial could become are listed (for example entering `e?` returns `enable exit` as the two possible full commands).

These are two possible uses of `?`. The third usage is entering a command followed by a `?` (**with space**) - this will list all possible options that could be entered following that command. For example, from the following paragraph, entering `configure?` will just return `configure`, the only command that could be meant by the partial "configure", whereas entering `configure ?` will return all options for the `configure` command, such as `terminal`. If an option is given in all-caps, it means that those caps are to be substituted with other text, whereas a lower case argument is to be written as-is. If the only option listed is `<cr>`, there are no options - the command should be given as is.

To make alterations to configuration, "global configuration mode" is needed. Entering `configure terminal` (or `conf t`, the shortest partial needed) will enter this mode, indicated by `(config)#` now following hostname at the prompt, for example `Router(config)#`. Entering the command `exit` (or `ex` for short) here will return to privileged EXEC mode (`Router#`). To run privileged EXEC mode commands from global comfiguration mode, preface commands with the `do` keyword.

From global config mode, one configuration that can be set is to password protect privileged EXEC mode so a user requires the correct password to access it. Entering `enable password [password]` (or `ena p [password]`) from global config mode will set a password. Trying to access privileged EXEC mode will then in future require the correct password to be entered. The password will not be displayed during entry, and `Bad secrets` will be returned if the password is entered incorrectly 3 times - access denied for not knowing the password.

There are 2 configuration files stored on a device - *running-config* and *startup-config*.

- running-config is the active configuration that is currently running and can be edited.

- startup-config is the confguration that will be loaded when the device is started or restarted.

Entering `show running-config` or `show startup-config` (or `sh run`, `sh star` for short) will show the config file in question. To save the running-config as the new startup-config, the command `write` (or `write memory`, or just `w`) must be entered from privileged mode. Alternatively, `copy running-config startup-config` (or `cop run star`) can be used - this is often preferred for documentation and learning as it's clearer.

One possible security risk is that plaintext passwords will be visible in these config files. To prevent the passwords from being readable from these files, the command `service password-encryption` (or `se p` for short) is entered from global config mode. Now, all current and future passwords will be encrypted so only their ciphertext is visible in the config files, for example `enable password CCNA` might become `enable password 7 08026F6028`. The '`7`' after `password` indicates the following password is encrypted with Cisco's proprietary encryption method, and the following text isn't just the password itself. This encryption is not very secure and can easily be found by searching for a cracker on Google. To turn off encryption for future passwords, execute `no service password-encryption` - this will only stop future passwords being encrypted, **not** decrypt already encrypted passwords.

The `no` keyword can be used to remove configurations.

A more secure method of encryption for passwords is by using `secret` instead, for example `enable secret CCNA` (or just `ena s CCNA`). This uses MD5 encryption which is much more secure, and enabled by default for secrets. If both `enable password` and `enable secret` are configured, only the secret is asked for and required when using the `enable` command - the set password is ignored. It is always best to use secrets over passwords.

The command `hostname [hostname]` (or `h [hostname]`) can be used from global config mode to change the name of the host.

If an invalid command is typed in user EXEC or privileged EXEC mode, the CLI will attempt a DNS lookup, thinking the unknown command may be a hostname. This can be aborted with `Ctrl + Shift + 6`.
