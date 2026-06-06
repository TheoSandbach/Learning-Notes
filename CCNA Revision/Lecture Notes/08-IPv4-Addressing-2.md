# IPv4 Addressing (Part 2)

---

### Configuring IPv4 Addresses on Cisco Routers

To configure an interface on a Cisco router with an IPv4 address, first Interface mode must be entered within the CLI of the router. This is done with the `interface [interface ID]` command from global configuration mode. This will enter Interface mode for that specific port. The interface ID can be found using `show ip interface brief`. To exit Interface mode and return straight to privileged EXEC mode, `end` can be used (in comparison to `exit` which returns to global config mode).

For example, to access interface `GigabitEthernet0/0`, the command used can be `interface gigabitethernet 0/0`, `interface gigabitethernet0/0`, or for the shortest version, `in g0/0`.

If another interface needs to be configured, that interface can be switched to with the same command from within Interface mode.

When in Interface mode for a specific interface, to set an IP address for that interface, the command `ip address [ip address] [subnet mask in dot decimal]` is used. For example, `ip address 10.0.0.1 255.0.0.0`.

Finally, the interface needs to be enabled (an interface on a router by default is set to 'administratively down', and can be set to this mode with the `shutdown` command). This is done with the command `no shutdown` (or `no shut`). The status and protocol fields (see below) of the interface should now switch to 'up', meaning the interface has been configured.

Note: To reset an interface to its default configuration, use `default interface [interface ID]` from global config mode.

### Viewing Interface Information

To see the status of every interface on a router as well as what IP address they are assigned, the command `show ip interface brief` (or `sh ip in br` for short) can be used from privileged EXEC mode.

This will list each interface by name, the assigned IP address (or 'usassigned' if none), '`OK?`' which is a legacy feature and no longer relevant, 'Method' which is how an IP address was assigned to the interface, 'Status' which is whether the interface is enabled and physically connected to another device, and 'Protocol' which is the layer 2 status: if ethernet or another protocol is working correctly between this device and connected devices.

Status is by default set to 'administratively down' on Cisco routers, meaning the interface has been disabled. This mode can be set by using the `shutdown` command and unset by using the `no shutdown` command.

Note that if Status is down (or administratively down), then the device cannot communicate with other devices through that interface even if physically connected, so Protocol will also be down.

Another useful command is `show interfaces [interface ID]`. This will give very detailed information about the current configuration and specifications of a particular interface. This information is mostly layer 1 and layer 2, but with some layer 3. Some key information here is the status of the interface, the line protocol status, the MAC address, and an assigned IP address.

### Interface Descriptions

Interface descriptions are entirely optional, but are a useful label to give more information about the interface, like a comment. For example, a description could be added to each interface to say what device it is connected to.

To configure a description for an interface, Interface mode must be entered for that interface. From here, the command `description [description]` will add a description to the interface. Note that the description can have spaces: anything after `description ` will be interpreted as part of the description.

To view interfaces with descriptions, the command `show interfaces description` can be used, which will give the Interface ID, the Status, the Protocol, and the Description.

# 
