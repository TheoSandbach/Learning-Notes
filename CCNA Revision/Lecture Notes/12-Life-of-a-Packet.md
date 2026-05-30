# Life of a Packet

---

When PC1 on network 192.168.1.0/24 wants to send some data to PC4 on network 192.168.4.0/24, the data will go through a number of steps to reach its destination.

Firstly, the data will be encapsulated. This will include the layer 3 IP header. This header contains both the source IP address (the IP address of PC1) and the destination IP address (the IP address of PC2).

PC1 will check its routing table and find the destination IP address does not match the connected route (devices in PC1's network). So, it will forward the data to the default gateway: the router.

To send a frame to the router's local interface, PC1 first needs to find the interface's MAC address. To do this, it will perform an ARP request. A frame with the router interface's IP address as the destination and FF:FF:FF:FF:FF:FF as the destination MAC address (the broadcast address) will be sent from PC1 to a connected switch. The switch will update its MAC address table with PC1's MAC address, and then will flood this frame out of all interfaces (except the interface it was received on). Any connected switches that receive the frame will also flood it, and any receiving end hosts will drop the frame as their IP address does not match. When the router interface receives the frame, it will update its address table with PC1s MAC address, and then send an ARP reply to that MAC address (unicast). Any switch along the way will update its MAC address table with the router interface's MAC address. PC1 will receive the ARP reply and also update its MAC address table with the router interface's MAC address.

After obtaining the MAC address of the router interface, PC1 will send a frame containing the data for PC4 to the router interface. This frame will have source MAC and IP addresses matching those of PC1, but the destination IP address will be that of PC4, while the destination MAC address will be that of the router's local interface.

The router will receive the frame, and decapsulate it. It will check the destination IP address against its routing table, and forward the packet to the next hop as defined by its routing table. To do this, it will encapsulate the data with a layer 2 header and trailer. The layer 2 header will list the source MAC address as that of the router interface the data will be sent from, and the destination MAC address as the MAC address of the next hop interface (this MAC address is also obtained via an ARP request).

This will continue, with each hop on the way to PC4 receiving and decapsulating the frame, checking its routing table for the next hop, re-encapsulating the packet with a new header and trailer, and forwarding it to the next hop, until the router connected to PC4's network receives the packet.

At this point, this router will encapsulate the data again after obtaining PC4's MAC address from an ARP request, and forward the data which will be received by a switch connected to PC4. This switch will then forward the data to PC4, which will receive the frame and decapsulate it.
