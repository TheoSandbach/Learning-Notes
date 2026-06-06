# VLANs (Part 2)

---

### Trunk Ports

Access Ports are used to connect a switch interface to a single VLAN. They are often used to connect directly to end hosts.

However, it is not always viable to connect every VLAN individually between switches and routers within the network. Using Access Ports, any connected switches both connecting to multiple VLANs would need a separate interface and connection each for each VLAN they want to share. Similarly, a switch connecting to a router would need a separate connection for each VLAN used in the network. This is a waste of the limited number of interfaces a switch has when Trunk Ports can be used instead to carry traffic from multiple VLANs over just one connection. This is especially necessary for routers which have a very limited number of interfaces.

*Trunk Ports* allow traffic from multiple VLANs to be sent and received over just one interface. Trunk Ports are also known as *Tagged Ports*, and Access Ports as *Untagged Ports*. This is because switches will tag frames they send over a Trunk Port so the receiving device knows what VLAN that frame belongs to. Frames sent from an Access Port are not tagged, as that frame will arrive on an interface assigned to a particular VLAN, which makes it clear to the receiving device what VLAN the traffic belongs to.

### VLAN Tagging

The two main trunking protocols are Inter-Switch Link (ISL) and IEEE 802.1Q, known as 'Dot1q'.

*ISL* is a legacy Cisco proprietary protocol before Dot1q existed. It has almost entirely been replaced by Dot1q, with even modern Cisco devices not supporting the protocol.

*IEEE 802.1Q* is an industry standard protocol, and the important one to learn for the CCNA.

### IEEE 802.1Q / Dot1q

Dot1q inserts a 4-byte tag field into the Ethernet header of the frame. This field sits between the 'Source' and 'Length / Type' field, as the penultimate field of the header.

The first 16 bits of the tag are the TPID, or *Tag Protocol Identifier*. This subfield always has the value 0x8100, the 802.1Q tag. This subfield comes straight after the source MAC address in the Ethernet header, where the Length / Type field usually sits, which is also 16 bits. The receiving device will read this value as the Type field, understand the frame is 802.1Q tagged, and so expect 4 more bytes of information to follow what would usually be the end of the header.

The remaining 16 bits are the Tag Control Information (TCI) which consists of 3 subfields:

- The *Priority Code Point* (PCP) is 3 bits in length, and is used for Class of Service (CoS) which prioritizes important traffic.

- The *Drop Eligible Indicator* (DEI) is only 1 bit, and flags frames that are low priority, and can be dropped if the network is congested to reduce overall throughput.

- The VID, or *VLAN ID*, is the most important subfield of the tag field: it contains the VLAN number the frame belongs to. It is 12 bits, meaning it can encode numbers 0 through 4095. Note however that the numbers 0 and 4095 are reserved, so the actual range of VLANs is 1 to 4094. ISL also uses the same range.

*Note*: Old legacy devices only support VLANs in the range 1 - 1005. VLANs in this range are known as *Normal VLANs*. Modern devices can use the full range of 1 - 4094. VLANs in the range 1006 - 4094 are known as *Extended VLANs*, however other than not being supported by legacy devices, these function identically to Normal VLANs.

### Native VLANs

Trunk ports using Dot1q also have native VLANs. This is a configuration for <u>each trunk port individually</u> for a specific VLAN that is considered the default. By default, this is VLAN 1. If frames are sent within the native VLAN, <u>they will not be given a VLAN Tag.</u>

If a switch receives a frame on a trunk port that doesn't have a VLAN tag, it will assume this traffic belongs to the native VLAN.

*However*, as each trunk port has its native VLAN configured separately, if the trunk port a frame is received on has a different native VLAN configuration than the trunk port the frame was sent on, the receiving switch will assume the frame belongs to their trunk port's native VLAN. The frame will then be dropped: the switch (or a later switch in the chain) will attempt to forward the frame to the destination end host, but given the destination end host is in a different VLAN than the switch assumes the frame is meant for, it cannot forward the frame to the destination VLAN and so drops it instead.

### Manually Configuring Trunk Ports

To configure a trunk port, one option is to manually configure the port as a trunk, just as for access ports: `switchport mode trunk`. This command is executed from Interface Configuration Mode.

Most modern switches (including Cisco switches) no longer support ISL, and the command is that simple. However, if the switch supports both Dot1q and ISL, this command will be rejected.

This is because for these switches, the trunk encapsulation mode must be set first. The command `switchport trunk encapsulation dot1q` must be used to set this to dot1q mode, and then the previous command can be used without errors. Note that this is only necessary on switches that support both Dot1q and ISL.

`show interfaces trunk` will show lots of information, such as what the native VLAN is for this trunk port, the encapsulation mode, which possible VLAN IDs can have their traffic forwarded along this trunk if configured (by default 1-4094), and which *configured* VLANs can have their traffic forwarded along this trunk.

The command `switchport trunk allowed vlan [option]` can be used to control which VLANs are able to have their traffic forwarded from this trunk. Options include:

- `VLAN IDs]`: Set the VLANs that can have traffic forwarded by this trunk, overwriting the previous list.

- `add [VLAN IDs]`: Add VLANs to the list of VLANs that can have traffic forwarded from this trunk.

- `remove [VLAN IDs]`: Remove VLANs from the list of VLANs that can have traffic forwarded from this trunk.

- `all`: Add all possible VLAN IDs in the range 1-4094 to the list.

- `except[VLAN IDs]`: Add all possible VLAN IDs in the range 1-4094 *except* those listed.

- `none`: remove all VLAN IDs from the list.

Configuring these settings on a switch is important to both maintain security, and reduce network congestion, as every VLAN allowed to have its traffic forwarded by this switch will send all of its broadcast messages through this switch.

Note that a VLAN with a given ID does not need to be configured in the domain to be added or removed from the list. As mentioned previously, these VLAN IDs will be listed separately when using the command `show interfaces trunk` from VLAN IDs that have already been configured.

Also note that while `show interfaces trunk` will list each trunk port and their allowed VLANs, `show vlan brief` will not: this command only shows access ports assigned to each VLAN.

### Changing the Native VLAN

The command to change the native VLAN on a trunk interface (remember, the native VLAN must be configured on all trunk interfaces individually) is `switchport trunk native vlan [VLAN ID]`. It is important for security to set the native VLAN to a VLAN ID that is not currently in use.

### Router on a Stick (RoaS)

Connecting a trunk port on a switch to a router interface means one interface on the router will be forwarding the traffic of multiple VLANs. However, routers do not have trunk ports. Instead, one interface must be logically segmented into multiple sub-interfaces: one physical interface connects to the trunk port on the switch, but each VLAN has its own logically distinct sub-interface it uses, with its own IP address.

Sub-interfaces are labelled as `[interface ID].[VLAN ID]`. For example, `g0/0.10`, where `g0/0` is the physical interface and `10` is the VLAN number. Note: the VLAN ID number at the end doesn't actually have any requirement to match the VLAN ID the sub interface is assigned to, but it is recommended to make these match.

To configure a sub-interface, Sub-Interface Configuration Mode is entered with the command `interface [sub-interface ID]`, for example `interface g0/0.10`.

Next, the VLAN this sub-interface operates in must be assigned with `encapsulation dot1q [VLAN ID]`. This tells the router if it receives data from a VLAN with that ID on its physical interface, to send it to that specific sub-interface. It also tells the router data received on that VLAN will be encapsulated with 802.1Q, and that outgoing data should be encapsulated in the same way. Outgoing data from this sub-interface will be Dot1q tagged for this VLAN, and so will be forwarded within that VLAN by the switch.

Finally the IP address of the sub-interface must be configured, just as it normally is: `ip address [IP-address] [subnet mask]`.

This process must be carried out with each sub-interface.

The `show ip interface brief` command will show these sub-interfaces listed (beneath the physical interface) as if they were physical interfaces themselves. These sub-interfaces will also be listed in the Local and Connected routes on the routing table (`show ip route`), again, just as if they were physical interfaces.

The name "Router on a Stick" (or ROAS) is used to refer to this method of routing between multiple VLANs only using a single interface on the router connected to a single interface on the switch
