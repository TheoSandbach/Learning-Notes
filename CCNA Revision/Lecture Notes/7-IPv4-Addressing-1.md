# IPv4 Addressing (Part 1)

---

Layer 3 of the TCP/IP model, the Internet / Network layer provides:

- Connectivity between different networks

- Logical IP addressing

- Path selection between source and destination

This layer is where routers operate.

### Switches and Routers

Switches do not separate LANs - they expand single LANs. This means that the subnet mask of the IP addresses of end hosts all connected via switches is the same.

Routers split LANs, but also connect them as separate networks. Each interface on a router is connected to a different LAN, so each needs its own IP address.

If a router receives a broadcast, it does not forward it elsewhere.

### IPv4 Addresses

IPv4 addresses are 32 bits, or 4 bytes, long. They are made up of 4 1-byte numbers (between 0 and 255) separated by dots, for example `192.168.1.254`. This is called *dotted decimal*.

IPv4 addresses are written in the form `192.168.1.254/24`, as an example. The '`/24`' on the end means the first 24 bits of the address, `192.168.1`, are the network portion of the address. All devices in a LAN share the same network portion in their individual IPv4 addresses. The remaining 8 bits (`.254`) are the host portion (or rest portion) of the address, referring to one device (or host) within the LAN. This value after the slash (the network number or prefix length) is not fixed, but is usually 8, 16, or 24.

### IPv4 Address Classes

| Class | Leading bits of first byte | First byte decimal range | Prefix length |
| ----- | -------------------------- |:------------------------:| ------------- |
| A     | 0xxxxxxx                   | 0-127                    | /8            |
| B     | 10xxxxxx                   | 128-191                  | /16           |
| C     | 110xxxxx                   | 192-223                  | /24           |
| D     | 1110xxxx                   | 224-239                  | -             |
| E     | 1111xxxx                   | 240-255                  | -             |

Class D is used for multicast, and class E is reserved.

In class A, addresses beginning with 127 as their first byte are reserved as *loopback addresses*. These refer to the local device itself. Packets sent to these addresses is treated by the local device as if it was sent from another external device, even though it wasn't. These addresses are used to test the network stack on the local device.

Addresses beginning with 0 as their first byte are also reserved, so the usable range of class A addresses is actually `1.0.0.0` through `126.255.255.255`.

Class A only allows for 128 possible networks, but 16.7 million addresses within each of those networks. Class B is in the middle, allowing 16 thousand networks with 65 thousand addresses in each, and class C allows for 2 million networks, but only 256 addresses within those networks.

The first and last address in each network cannot be assigned. For example, for the network `154.17.0.0/16`, the address `154.17.0.0` cannot be assigned as this value is the network address, and refers to the network itself. That is, addresses where the host portion is all 0s is the network ID and cannot be used by hosts within the network. So the first assignable address within this network is `154.17.0.1`.

Also, the address `154.17.255.255` cannot be assigned, as this address is used for broadcast messages. This means the last assignable address within this network is `154.17.255.254`.

Note that this means a broadcast message within a LAN has the destination MAC address `FF:FF:FF:FF:FF:FF` in its frame header, and has a destination IPv4 address where the host portion is made up of 255s in its packet header. For the above example, a broadcast message would have destination IPv4 address `154.17.255.255`.

This means the number of IP addresses assignable to hosts within a network is 2 to the power of 32 minus prefix length, minus 2: `2 ^ (32 - prefix length) - 2`.

### Netmasks

The prefix length can be written in the newer format using a slash - for example `/8`, `/16`, `/24`. However, older devices including Cisco devices use a netmask dotted decimal to give the prefix length, for example `255.0.0.0` (equivalent to `/8`).

In a netmask, the prefix length is given by that many 1-bits from the start, followed by 0-bits to make the total length 32 bits. For example the prefix length of `/20` would be `11111111 11111111 11110000 00000000` in binary, or `255.255.240.0` in dotted decimal.

Using the older IPv4 address class model (and disregarding classes D and E), we only have prefix lengths of `/8`, `/16`, or `/24`. So we only use netmasks of `255.0.0.0`, `255.255.0.0`, and `255.255.255.0`, respectively.

The netmask is also known as the *subnet mask*.
