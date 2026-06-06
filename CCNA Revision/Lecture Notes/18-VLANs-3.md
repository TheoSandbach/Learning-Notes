# VLANs (Part 3)

---

### Native VLANs and ROAS

The reason native VLANs exist is because sending frames without a VLAN tag means smaller frames. This means more frames can be sent per second. As such (when used correctly), native VLANs increase efficiency but at the cost of some security.

To configure the native VLAN on a router interface, there are 2 options. 

Firstly, the command `encapsulation dot1q [VLAN ID] native` can be used on a sub interface to tell the physical interface that any traffic received without a VLAN tag is part of the native VLAN and should be sent to that specific sub-interface.

Alternatively, traffic can be handled by the physical interface itself, by setting an IP address for the physical interface within the native VLAN's subnet. To do this, there must be no sub-interface configured to that VLAN. If there is, the `no interface [sub-interface ID]` command can be used.

### Layer 3 Switches

While switches are layer 2 devices by definition, some modern switches, called *Layer 3 Switches*, which are capable of both switching **and routing**. These switches are called "Layer 3 Aware".

Layer 3 switches can have IP addresses assigned to their interfaces, can have configured routes, can route between VLANs, and allow for virtual interfaces with individual IP addresses.

To enable Layer 3 routing, the command `ip routing` must be used from Global Config Mode.

To configure an interface as a layer 3 routed port instead of the default layer 2 switchport, the command `no switchport` is used. The interface can now have an IP address assigned and can route traffic.

Note that while a layer 3 switch is capable of routing between LANs, it is best practice to still use a router for this, as a router performs other functions that make communication over the internet safer and more efficient. So the default route on a layer 3 switch should point to a router (or to another layer 3 switch that points to a router), so traffic for outside the LAN goes through the router.

Routed ports will have "routed" listed as their entry in the 'Vlan' column of `show interfaces status`.

### Switch Virtual Interfaces

*Switch Virtual Interfaces (SVIs)* are virtual interfaces on a layer 3 switch that can have IP addresses assigned to them. SVIs can be used as the default gateway for each VLAN in place of the router.

To create a new SVI for a given VLAN, use the command `interface vlan[VLAN ID]` (for example `interface vlan10`) to create an SVI for that VLAN. Note that, unlike physical switch interfaces when connected, SVIs are `down` by default, so `no shutdown` will need to be used to enable them.

Assigning an access port to a VLAN on a switch will automatically create that VLAN if it does not already exist. However, creating an SVI for a VLAN will **not** cause the switch to automatically create that VLAN.

To enable an SVI (get it into an `up`/`up` state) there are a number of conditions:

- The VLAN the SVI is created for must exist on the switch.

- The switch must have at least one access port assigned to that VLAN or at least one trunk port that can forward traffic for that VLAN, and this port must be `up`/`up` itself.

- The VLAN must be enabled: VLANs can be disabled with `shutdown`. This configuration must be removed to use an SVI for that VLAN.

- The SVI itself must be enabled with `no shutdown`, as mentioned.
