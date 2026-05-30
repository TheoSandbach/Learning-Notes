# VLANs (Part 1)

---

A *LAN* is properly defined as the network of devices within one broadcast domain.

A *broadcast domain* is the group of devices that will receive a broadcast frame sent by any other member of the group.

Point-to-point networks are still broadcast domains, and so still technically LANs.

This means that each interface of a router connects to 1 LAN.

### The need for VLANs

If we have multiple groups of end hosts all connected to one switch and one router, such as in a small company, it is neither efficient (lots of traffic in the network decreases performance) nor secure (access control is an important security consideration) for all hosts to be able to contact each other.

This can partially be solved with subnetting: splitting each group into different subnets (so one network split into multiple subnets), and configuring the router interface to have an address within each subnet (how this is done will be covered later). Now, if any end host sends a unicast frame to a device in another subnet, as the IP address of the destination device is outside of the source device's subnet, the source device will send the frame to the default gateway: the router. The router can be configured to filter what traffic is then forwarded to the intended destination, and what is dropped.

However if the frame is a broadcast or an unknown unicast frame, then the switch will not simply forward it to the router: instead it will flood the frame. Switches operate at level 2, and do not work within the concept of subnets. The switch will send the frame to all connected devices (except the source), which breaks out of the group structure imposed via the subnets - this is because all devices connected to the switch are within the same broadcast domain, or LAN. This is a performance and security concern.

Buying separate switches for each group is expensive. Separating each group at layer 2 virtually with VLANs is the cheaper and easier choice.

### VLANs

VLANs allow end hosts connected to one switch to be logically separated into distinct broadcast domains. This is done by configuring each interface on a switch to be a part of a particular VLAN. End hosts connected to interfaces configured to the same VLAN can communicate through the switch and will be sent flooded frames from within that VLAN. End hosts connected to interfaces configured to separate VLANs cannot communicate through the switch, and if one sends a broadcast or unknown unicast frame, the switch will not forward this frame to the other. VLANs are separate at layer 2.

For 2 devices in separate VLANs to communicate, traffic must be sent via the switch to the router, which can then forward the frame to a different VLAN via the switch. Switches will never forward traffic directly from one VLAN to another.

### Configuring VLANs in the CLI

In the CLI on a Cisco switch, the command `show vlan brief` will show all of the configured VLANs on the switch, and which interfaces are within which VLANs. By default, all interfaces (labelled here as "Ports") are within VLAN 1. Also, VLANs 1002 - 1005 exist by default, and cannot be removed.

To assign a switch interface into a particular VLAN, first configure the interface to Access mode from interface configuration mode with `switchport mode access`.

*Access mode* means the interface is assigned to one specific VLAN, usually connecting to an end host directly. This is usually the default mode. Another type of switch interface when using VLANs is a *Trunk mode*, meaning multiple VLANs are carried by that interface.

When the mode of the interface has been set, the interface can be assigned with `switchport access vlan [vlan-number]`. This will assign the interface to VLAN `[vlan-number]`, or if that VLAN does not currently exist, it will be created.

To change the name of a VLAN, VLAN config mode is entered with `vlan [vlan-number]`, and from there the command `name [name]` is used to change the name of the VLAN. Note here: doing `vlan [vlan-number]` will also create a VLAN if one with that number doesn't already exist.
