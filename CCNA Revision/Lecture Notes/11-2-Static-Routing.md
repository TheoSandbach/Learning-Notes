# Static Routing

---

For any and all **enabled** interface on a router, the router's routing table will have 2 entries: a local route to itself with a /32 prefix length, and a connected route to the network that interface connects to, with that network's actual address and prefix length.

A router will drop any packet for which the destination IP address does not match any entries in the router's routing table. This means a router with only local and connected routes can reach itself and any device on a connected network, but not remote networks.

### Default Gateways

An end host can send packets directly to devices within their local network. However, to send packets to end hosts on remote networks, packets must be sent to the local network's *default gateway*.

'Gateway' is an old term for a router, so this term means default router. When an end host is sending a packet, it tries to find the most specific matching route for that packet in its routing table. All packets that don't match any more specific route (such as the connected route, which routes to all devices within the LAN) will be sent via the *default route* to the router. The default route is 0.0.0.0/0 - given the prefix length of 0, this route matches every single possible destination IP address. This route points to the router interface's IP address, meaning the next hop for that packet is the router interface. This means the end host will send any traffic for any IP address referring to a remote device to the default gateway, or default router.

Routers themselves often use default routes to forward packets to unknown network IP addresses to the internet.

The destination MAC address of the frame a packet is sent to the router within is the MAC address of the router interface. The router receiving the packet will then decapsulate the packet and examine the destination IP, comparing it against its routing table to find the next hop.

### Routing

A router does not need to know the exact route taken to get from one LAN to another. It simply needs to know to reach a particular network, what is the *next hop* it needs to make. The 'next hop' is simply the IP address of the next router interface it needs to forward a packet to to get to that destination. The next router in the chain will then forward the packet to its next hop, and so on till the packet arrives at a router with a connected route to that destination network, and which point the packet will be received by the network and flooded or forwarded by that network's switch.

At each router, the packet will be decapsulated, the header examined, and then recapsulated with new MAC addresses: the packet is travelling across multiple networks, and different source and destination MAC addresses are needed for each network.

### Static Routes

Static routes are routes on a routing table that have been configured manually by an admin. 

To add a static route to a Cisco router from the CLI, enter global config mode and execute `ip route [destination IP address] [subnet mask] [next hop IP address]`. This will add the static route to the routing table.

Alternatively, a variation of this can be used: `ip route [destination IP address] [subnet mask] [interface to send from]`. This will tell the router which interface it should send matching packets from, rather than the IP address of the next hop itself. For example, `ip route 192.168.1.0 255.255.255.0 g0/0`. On the routing table, this route will say it is "directly connected" and list the interface it will send from. This form, where only the exit interface is specified with no next hop IP, uses a process called "Proxy ARP" (this is beyond the CCNA scope).

The final variation is both options: `ip route [destination IP address] [subnet mask] [next hop IP address] [interface to send from]`. This will tell the router what the next hop is, and which interface it should send the packet from to reach this hop.

Routes should be configured both ways on a router, so that one end host can message another, and then that end host can reply back the other way. This is called *two-way reachability*.

Note that if 2 (or more) static route entries are configured for one route, the router will use both, load balancing traffic between them.

### Configuring a Default Route

If a Cisco router doesn't have a default route configured, it will report "Gateway of last resort is not set" at the top of the routing table.

To configure a default route, the same command as setting a static route is used: `ip route`. However, the destination IP address and subnet mask is both set to `0.0.0.0`. So the command would be `ip route 0.0.0.0 0.0.0.0 [...]`. This will then become a 'default candidate' - a possible route for the default route. If there is only one candidate, that candidate will automatically be set as the default route.
