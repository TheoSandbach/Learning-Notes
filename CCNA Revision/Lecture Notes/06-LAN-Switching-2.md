# Ethernet LAN Switching (Part 2)

---

The preamble and SFD are not usually considered part of the Ethernet header itself. This means the total size of the Ethernet header and trailer without these fields is 18 bytes.

The minimum size of an Ethernet frame is 64 bytes (not including preamble and SFD), so without these 18 header and trailer bytes, the payload (the packet) must be at least 46 bytes in length.

Padding bytes (0x00) are added to bring this length up to 46 bytes if it is under this minimum.

### MAC Address Discovery

When a device wants to send data to another device, this data is encapsulated with a layer 2 header and trailer to make a frame. This header includes the destination MAC address that switches use to send the data to the destination device. Within this frame, the payload is a packet, with a layer 3 header which contains both a source device IP and a destination device IP.

However, the source device (device A) doesn't automatically know the MAC address of every other device on the network, it only knows the IP of the destination device (device B). So it needs to find the destination MAC before it can directly communicate.

To do this, an ARP (Address Resolution Protocol) request is performed to find the destination MAC address.

An ARP request is a *broadcast* - it is sent to all hosts on a network, as opposed to a unicast which is only intended for one. The ARP reply from the destination device is unicast back to the source device.

For an ARP request frame, the destination MAC address in the layer 2 header is all 1s - `FF:FF:FF:FF:FF:FF`. This is the *broadcast MAC address*, used for all broadcast messages. Switches receiving this frame flood it out of all connected interfaces (except the interface the frame was received on).

Devices receiving this frame will not disregard the frame even though the destination MAC address does not match their own - because it is the broadcast MAC address. Instead, they will examine the destination **IP address** within the payload of the frame, and disregard the message unless it matches their own IP address.

When a device with a matching IP address receives the ARP request, it sends an ARP reply. This unicast frame is sent directly to device A, as now device B has the MAC address of device A, and can communicate with it directly. 

This ARP reply will allow device A to learn the MAC address of the device B, allowing direct communication to be initiated from either device.

The Ethernet type of ARP is `0x0806` (for the Ethernet header field Type).

### ARP Tables

Devices remember which MAC addresses correspond with  which IP addresses by storing these relations on an ARP table. This table can be viewed on most devices with the command `arp -a`. In this table, "static" types are simply default entries, whereas "dynamic" entries were discovered via an ARP request and an ARP reply.

### Ping

'ping' is a network utility to test reachability and the round trip time it takes to message and receive a response from a device.

A ping is made up of an *ICMP Echo Request* and an *ICMP Echo Reply*. An echo request is similar to an ARP request, but must know the MAC address of the destination device, so ARP must be used first to obtain this.

The command to ping a device is `ping [IP address]`, using the IP address of the destination device.

Different OSes will send a different number of requests of different sizes within one ping. For Cisco CLI, 4 100-byte ICMP echoes will be sent, with unsuccessful pings being indicated with `.` and successful pings indicated with `!`. In Cisco CLI, `size [size in bytes]` can be added after IP address in the command to send ICMP requests of a particular size, in bytes. Just as any other frame, if these requests are less than 46 bytes, they will be padded with 0 bytes.

The first ping may fail as the source device may need to send an ARP request to obtain the destination MAC when the ping is initially executed.

### MAC Address Table

To view the MAC address of a Cisco switch, enter `show mac address-table` within the device's CLI IOS. This lists 4 fields: VLAN (by default 1), MAC address, Type (static or dynamic), and Ports (which port or interface that MAC address is associated with).

The process by which MAC addresses stored in this table 'expire' and are removed after 5 minutes is called *Aging*.

The command `clear mac address-table dynamic` can also be used to remove all dynamic (dynamically learned) MAC addresses from the switch's MAC address table manually.

To remove one specific MAC address from the table, the command `clear mac address-table dynamic address [mac address]` can be used. Note that in this command, MAC addresses are written in the format `a1b2:c3d4:e5f6`, rather than `a1:b2:c3:d4:e5:f6` as they may be written elsewhere.

Finally the command `clear mac address-table dynamic interface [interface id]` can be used to specifically remove all MAC addresses associated with a particular port or interface on the switch. The interface ID is written in the same format as it is listed in the MAC address table, for example: `Gi0/0`.
