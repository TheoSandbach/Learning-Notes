# Subnetting (Part 1)

---

IP addresses are separated into 5 categories: classes A, B, C, D and E.

Companies are assigned an IPv4 address range by the *IANA* - the Internet Assigned Numbers Authority. These network addresses are assigned based on the size of the company. Large companies might receive very large address ranges such as a class A network address, or a class B network address for smaller companies. Very small companies might receive a class C network with the fewest number of addresses available.

A *point-to-point network* is the network that sits between routers. It doesn't contain end hosts, simply being the connection between multiple routers.

### IPv4 Address Wastage

The problem with conventional IP address classes is they result in a lot of wasted IP addresses. For example, a point-to-point network will likely be given a class C address range with 254 available IPv4 addresses (256 minus the network and broadcast address). However this connecting network may only use a handful of these, resulting in hundreds of wasted IP addresses that are assigned to that network but not used.

Another example is if a company needs something like 500 end hosts with IP addresses, they are too large for a class C address range and so might be assigned a class B range instead. However this will result in 65 thousand wasted IP addresses which the company has no need for.

### CIDR

The IPv4 system allows for 4 billion IP addresses, however with addresses being wasted as above, the class system did not provide nearly enough addresses for modern usage. To solve this, the IETF created CIDR to replace the classful system. 

CIDR stands for *Classless Inter-Domain Routing*. This system removes the fixed prefix length for each class, introducing subnets to split large networks into multiple smaller networks.

### Subnets

CIDR allows the addresses within an IP address range to be split up and used as subnetworks. This means one address range can function logically as multiple address ranges, while keeping wasted addresses to a minimum and reducing the number of unique networks required.

This is done by using prefix lengths above that of the native prefix length for a given class of IP address. So for a class C network address, with a /24 prefix length, subnets could have prefix length of /25, /26, and so on all the way up to /32. This altered prefix length is called *CIDR Notation*.

For a point-to-point network, an obvious choice for a class C network would be the subnet with prefix length /30. This subnet has 4 addresses, 2 of which are usable, and so is the obvious choice. However, network and broadcast addresses are not necessary when only dealing with 2 directly connected devices, so the /31 subnet can be used to be even more efficient. This subnet only contains a network address and a broadcast address, however in a point-to-point network these can be used instead for the connected devices.

The /32 subnet is generally only used when specifically one network or host needs to be referenced, for example in a static route to a specific IP address. The rest of the time this subnet is not used.

For a concrete example: take the network 192.168.1.0/24. The subnet 192.168.1.0/30 only contains 4 addresses: 192.168.1.0, 192.168.1.1, 192.168.1.2, and 192.168.1.3. This leaves all addresses in the range 192.168.1.4 - 192.168.1.255 unused. These spare addresses, rather than being wasted, can be used by another subnet elsewhere in a network.
