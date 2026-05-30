# 10 - IPv4 Header

---

A *packet* is data encapsulated with a layer 4 TCP / UDP (usually, but can be other protocols) and layer 3 IP header. It is the payload of a L2 PDU: a frame.

### Header Fields

The fields of the IPv4 header are:

- IP Version

- IHL (Internet Header Length)

- DSCP (Differentiated Services Code Point)

- ECN (Explicit Congestion Notification)

- Total Length

- Identification

- Flags

- Fragment Offset

- TTL (Time to Live)

- Protocol

- Header Checksum

- Source IP Address

- Destination IP Address

- Options

The **Version** field is 4 bits long, and is either 4 (0b 0100) or 6 (0b 0110). This is the version of IP used for the packet, either IPv4 or IPv6.

Note that this lesson is looking at the header for IPv4. If Version is 6, indicating IPv6, the entire header structure is different.

The **IHL** field is also 4 bits long and indicates the length of the header itself. One unit indicates 4 bytes, so 0b0110 for example would be 6 4-byte increments, or 24 bytes. As the final field, 'Options' is variable length, this is required so the length of that field can be deduced. The minimum value is 5, or 0b0101, and the maximum value is 15 or 0b1111, so the IPv4 header can be between 20 (no Options field) and 60 (full Options field) bytes in length.

The **DSCP** is used for quality of service. It prioritizes delay-sensitive data, such as VoIP or video streaming data. It is 6 bits in length.

The **ECN** field is 2 bits long. It provides notifications between two endpoints (end-to-end) of network congestion, without dropping packets. However it is an optional feature, and requires both endpoints and the network infrastructure to support it. This is sometimes grouped with the DSCP field.

The **Total Length** field is 16 bits (2 bytes) and indicates the overall length of the entire packet - including the data itself, the layer 4 header, and the layer 3 IPv4 header. One unit here is one byte, and the minimum value is 20, for a minimum-length IPv4 header with no payload. The maximum value is 65,535, so both bytes with all 1s.

However, the maximum length of an Ethernet frame's payload is 1500 bytes. This means the maximum length of an entire packet is 1500 bytes when using Ethernet. So, fragmentation occurs.

If a packet is larger than the *Maximum Transmission Unit* (MTU - often 1500 bytes) it will be fragmented, and sent as multiple packets in multiple frames.

The **Identification** field is also 16 bits long. It serves as an ID value for a packet. This allows packets that have been fragmented due to their total length being over 1500 bytes to be identified as parts of one packet, and reconstructed. For this purpose, all fragments of the same packet will have the same Identification value.

The **Flags** field is 3 bits long, however the first bit is reserved, and is always set to 0. The second bit is the DF (Don't Fragment) bit, used to indicate a packet that should not be fragmented. The final bit is the MF (More Fragments) bit is used to indicate if a chain of fragments is finished. It is set to 1 if a packet is fragmented and this fragment is not the final fragment. It is set instead to 0 if this is the final fragment of a packet, or if the packet is whole and unfragmented. If a packet is larger than the MTU but set to not fragment, it will fail to send.

The **Fragment Offset** field is 13 bits long and is used to indicate the position the fragment falls within the original full packet, so the packet can be reconstructed in order regardless of the order the fragments were received in. This field is sometimes grouped with the Flags field.

The **TTL** field is 8 bits. Originally it was supposed to indicate seconds, but now it indicates the maximum number of hops a packet can make. Each time a router receives a packet, it decreases TTL by 1. If a router receives a packet with a TTL of 0, it will drop the packet. This prevents a packet looping forever and congesting a network. The recommended default TTL is 64.

The **Protocol** field is 8 bits long and indicates the layer 4 protocol in use (the protocol of the encapsulated L4 PDU). Some important values are 1 (0x01) - ICMP (the ping protocol), 6 (0x06) - TCP,  17 (0x11) - UDP, and 89 (0x59) - OSPF (Open Shortest Path First). OSPF is a dynamic routing protocol.

The **Header Checksum** field is 16 bits long and is used to check for errors in the header. A router receiving an IPv4 packet will work out the checksum of the header and compare it to the Header Checksum value already present in the packet. If these values do not match, an error has occurred, and the router drops the packet. Note that only the header is checked here: The layer 4 header has its own checksum values to validate the integrity of the encapsulated data.

The **Source IP Address** and **Destination IP Address** are both 32 bits in length (the length of an IP address) and simply indicate the IP address of the source device and intended recipient device respectively.

The **Options** field is variable length. It can be anywhere from 0 bits (it is not required) to 320 bits (40 bytes) in length. It is rarely used and beyond the scope of the CCNA. An IHL value of above 5 indicates the presence of options.
