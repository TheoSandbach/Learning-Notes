# DTP and VTP

---

### Dynamic Trunking Protocol

*Dynamic Trunking Protocol*, or DTP, is a Cisco proprietary protocol that allows Cisco switch interfaces' switchport mode to be determined automatically, not requiring manual configuration. 

Two Cisco switch interfaces connected together can form a trunk port, whereas any other connected interface will become an access port. DTP is enabled by default on all Cisco switch interfaces. However, manual configuration is more secure and as such it is recommended DTP is disabled on all switch interfaces.

As well as being manually configured to a trunk or access port, a switchport can be set to dynamic. There are 2 modes within the dynamic configuration: desirable, and auto. The interface will discover the mode of the connected switch's interface, and set whether it is a trunk port or access port accordingly.

Desirable mode is set with the command `switchport mode dymamic desirable`. In desirable mode, the interface will actively try to form a trunk. A trunk will be formed if the connected switch interface is manually configured to a trunk port, or if it is dynamically configured in either mode. This is the default setting for older Cisco switch interfaces.

Auto mode is set with the command `switchport mode dynamic auto`. In auto mode, the interface will not actively try to form a trunk, and will default to an access port. If the connected interface is manually configured as a trunk, or set to desirable mode, a trunk will be formed. Otherwise, the interfaces will both operate as access ports. This is the default setting for newer Cisco switch interfaces.

The command `show interfaces [interface ID] switchport` will show some switchport configurations, including the 'Administrative Mode', or how the interface has been configured by the admin, and 'Operational Mode', which is how the switch is actually behaving. Administrative mode is how the interface has been set to determine what type of switchport it is, and Operational mode is what the interface has decided it is - this will match the Administrative mode when the switchport mode is manually configured.

DTP frames will be sent through the native VLAN when using 802.1Q encapsulation. They will always be sent through VLAN1 when using ISL.

If two connected interfaces are manually configured to operate as opposite switchport types, they will be unable to communicate.

Note that DTP will not negotiate with any device other than a switch, and a dynamically configured switch interface connected to such a device will always default to operating as an access port. Configurations such as RoaS must be manually configured.

DTP negotation (the sending of DTP negotation frames between two connected interfaces) can be disabled in two ways: firstly with the `switchport nonegotiate` command. Secondly, manually configuring an interface to operate as an access port with `switchport mode access` will also disable DTP negotiation automatically.

Trunk ports will use DTP negotiation to also negotiate what encapsulation method to use - 802.1Q or ISL. The default configuration is `switchport trunk encapsulation negotiate`. However, if both devices support ISL (such as most Cisco switches), this will be favoured. So it is best to turn this setting off as well, and manually configure Dot1q encapsulation. `show interfaces [interface ID] switchport` will also show information about the configuration of encapsulation negotiation.

### VLAN Trunking Protocol

*VLAN Trunking Protocol*, or VTP, allows VLANs to be centrally configured and managed from one device (a switch operating as a VTP server) so each VLAN doesn't need to be configured on each individual switch in a large network manually. Switches in the network, acting as VTP clients, will synchronize their local VLAN database with the central server. However, VTP is rarely used and not recommended.

VTP only synchs the VLAN database between switches, not individual interface settings. Interfaces will still need to be assigned to VLANs and configured individually when using VTP.

VTP has 3 versions - older switches may only support the first two, however newer switches will support all 3. The VTP version of switches in a network can be updated with the `vtp version [version number]` command from a VTP server. The difference between the versions is beyond the scope of the CCNA.

There are also 3 modes VTP can operate in - server (the default setting), client, and transparent.

VTP servers can add, delete or modify VLANs. The VLAN database of a VTP server is saved on **non-volatile RAM**, which means it is persistent when the device is powered off and on again. 

Every modification to the VLAN database of a VTP server will increment a counter called the *revision number*. This value is used to identify the newest version of the database at any time. VTP servers will advertise their VLAN database on trunk interfaces. Any VTP client receiving this advertised VLAN database will synch their own database with this, as long as it is a newer iteration. VTP servers also function as clients, and so also synch with other servers if another server has a higher revision number.

VTP clients cannot modify any VLAN settings. In VTPv1 and v2, they do not store their own VLAN database in NVRAM, however they do in v3. As mentioned, they will synch their VLAN database with any received VLAN databases that have a higher revision number than their own. They will then advertise their VLAN database on their own trunk interfaces so other clients can synch to the newest iteration.

Switches set to transparent VTP mode will basically act as their own VTP server, but not advertise their own configurations. However, these switches will still forward VLAN configurations from other VTP servers (in the same VTP domain) that it receives. A switch set to transparent mode will have its revision number set to 0.

Running `show vtp status` on a switch will show a number of useful configurations. 'Version capable' will show what VTP versions the switch can run, and 'Version running' will show what VTP version it actually is currently running. 'Operating Mode' will show what mode the switch is running, and 'Max VLANs supported locally' will show how many VLANs the switch can support - VTPv1 and v2 do not support the extended VLAN range, and so will only support up to 1005 VLANs, whereas VTPv3 will support up to 4094 VLANs. 'Number of existing VLANs' will show how many VLANs currently exist (5 by default). 'Configuration Revision' shows the current revision number.

Switches using VTP will share these configurations as long as they are in the same *VTP domain*. A VTP domain name can be configured on a VTP server, and then all VTP clients that receive a VTP advertisement from that VTP server, and aren't already part of a VTP domain (by default, a switch is not part of a VTP domain) will join that domain automatically. Switches that already have a different VTP domain name in their configurations will not be altered and will remain in their current VTP domain. Only advertisements with a higher revision number **in the same VTP domain** will cause a VTP client to update its configurations and advertise them.

The VTP domain of a switch can be set with `vtp domain [domain name]`. Changing the VTP domain of a switch to an unused domain will cause the switch's VTP revision number to reset to 0.

One problem with VTP is that if a switch is introduced to a network which already has the same VTP domain name as other switches in the network, and the introduced switch also has a higher revision number, all switches with a matching domain name will immediately overwrite their own configurations with that of the introduced switch. This could cause a large number (or all) hosts in the network to lose connectivity.
