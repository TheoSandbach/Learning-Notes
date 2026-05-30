# Routing Fundamentals

---

*Routing* is the process routers use to determine the path that packets should take over a network to reach their destination.

Routes to all known destinations are stored in a router's *Routing Table*. A router will check its routing table whenever it receives a packet to find the best route for that packet.

A *route* is an instruction that simply tells a router for a particular destination IP address, which router it should forward traffic to next (what the next hop is to reach the destination). This is like a switch's MAC address table which simply tells a switch what interface to send data out of to reach a particular host - the router only knows for a given destination, what the next hop is.

If the destination IP address is that of the router, the router will receive the packet and not forward it.

The CLI command `show ip route` will show the routing table of the Cisco router. This will give a key at the top of many different protocols the router uses to learn routes, along with an abbreviation. Underneath the key, the routing table itself is shown. Next to each IP, an abbreviation from the key is listed, which indicates how each route was learned by this router.

Whenever an interface is configured with an IP address and enabled with `no shutdown`, 2 routes are added to that router's routing table:

- A *local* route

- A *connected* route

The **Local Route** (indicated with L in CLI) is simply the route of the interface to itself - it lists the IP address the interface is configured with, but with a '/32' prefix (255.255.255.255 subnet mask).

Prefixes here are used to convey parts of an IP address that are fixed and parts that can change. The network portion of an IP address is fixed in the router's routing table. The router will not change those numbers. Whereas the host portion of the IP address acts as a wildcard: the router can use any number in place of those values. For local routes, the entire address is fixed, as the interface itself is only on that specific IP address. That means only packets with a destination IP address exactly matching a local route will be 'forwarded' to that local route (received by the router itself).

The local route specifically will tell the router to keep the packet for itself, and not forward it along another route.

A **Connected Route** (indicated with C in CLI) is the route to the network the interface connects to. Every connected interface on a router leads to a network with a network ID, even if that 'network' is simply one cable to another router. The interface is a node within that network, with an IP address within that network (so for example the network address might be `192.168.1.0/24`, so the IP address of the interface might be `192.168.1.1/24`). The network address will be listed in the routing table, with the correct prefix length.

Simply put, a connected route is a route to the nework the interface connects to. It provides a route to any device with an IP address within that network.

As the prefix length for a connected route is correct for that network, this means any packets with a destination IP address with a matching network portion will be forwarded via this route, regardless of the host portion of the IP address.

### Route Selection

A problem is that for an interface connected to a network, packets with a destination IP address matching that interface's IP address will match both the local route for that interface as well as the connected route. So the router needs to select the most appropriate route for the packet out of the valid options.

The router will pick the most specific matching route for a packet. That means it will pick the route the packet matches that covers the fewest IP addresses. The connected route will contain many possible IP addresses as it covers the IP addresses of all nodes on that network. Whereas the local route will only contain one IP address, the IP address of the interface itself. So if the destination IP address of a packet matches both a local route and a connected route, the local route is the more specific matching route, and so the router will select that route for the packet.

So, the most specific matching route for a packet will be the matching route that has the longest prefix length, as this means the fewest hosts that that route leads to out of all matching routes.

Outside of Local and Connected routes which the router immediately learns upon an interface being enabled, there are two main ways a router learns new routes:

**Dyanmic Routing**: Routers automatically share routing information with each other to build routing tables, using dynamic routing protocols such as OSPF.

**Static Routing**: Routes on the routing table are manually configured by an admin.

An important detail about routers is that if they receive a packet with a destination IP address that doesn't match any of the router's known routes, it will drop the packet. This is in contrast to a switch which will flood a frame to try and find the destination device.
