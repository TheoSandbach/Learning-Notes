# Switch Interfaces

---

When using the command `show ip interface brief` within a switch as opposed to a router, it is notable that the Status column will not say 'administratively down' by default - only routers have this as their default setting, a switch will either be 'up' if the interface is connected to another device, or 'down' if not.

However, each interface can still be disabled with the `shutdown` command, and reenabled with `no shutdown`, just as with a router interface.

An important command for switches (which only works on switches) is `show interfaces status`: this gives interface name (Port), given description (Name), Status (different to the `show ip interface brief` Status field), Vlan, Duplex, Speed, and Type. The Type field is simply what type of interface each is, for example `10/100BaseTX` for a fast ethernet interface, which can also operate as an ethernet interface if needed.

Duplex can be half, or full. Half-duplex means the device cannot send and receive data at the same time (if a half duplex device is receiving data, it must wait before sending data), whereas full-duplex means it can. Switch interfaces are set to auto by default. This means the interface, when connected to another device, will work out whether it can use full-duplex to communicate with the other device (the preferred option), or has to use half-duplex. An unconnected interface will have `auto` listed in its Duplex field, whereas a connected interface will say `a-full` if it can use full-duplex, or `a-half` if it has to use half-duplex.

The Speed field is set to `auto` by default as well. When an interface is connected to another device, it will work out if it can communicate at its max speed, or if it has to use a slower speed. For example, a fast ethernet interface (Fa) has a speed of 100Mbps by default which would be indicated with `a-100`, but can also step down to 10Mbps, indicated by `a-10`.

The configuration for each interface's Duplex and Speed fields can be manually changed from Interface mode with `duplex auto/full/half` and `speed [speed]/auto`. When these fields are manually changed from auto mode, the `a-` in front of their values disappears.

### Interface Range Config Mode

If multiple interfaces need to be configured at once, ' Interface Range mode' can be entered, with the command `interface range [range1], [range2], ...`, for example `interface range f0/5 - 12`  to configure interfaces FastEthernet0/5 through FastEthernet0/12, or `interface range f0/5 - 6, f0/9 - 12` to configure interfaces FastEthernet0/5, FastEthernet0/6, and FastEthernet0/9 through FastEthernet0/12 all at once. Configurations made will apply to all interfaces in the range.

### Hubs

Hubs are legacy devices that predate switches. Hubs are layer 1 devices. Every message received by a hub is automatically flooded out of every connected interface. This is just like a switch when it receives an unknown unicast frame, however this is how a hub behaves for every frame received.

Hubs are half-duplex, and are unable to send and receive data at the same time. They cannot queue up messages: if they receive two frames at the same time from different devices, they will attempt to send both frames at once to any other connected devices. This will cause a collision, corrupting both frames. All devices connected to a single hub are said to be in the same *collision domain*.

*CSMA/CD* (Carrier Sense Multiple Access with Collision Detection) was used to prevent collisions when using hubs and is still used to prevent collisions when working with half-duplex.

When a device using CSMA/CD wants to send data, it will listen to traffic on the LAN and wait until all other devices are not sending data. It will then send its data, attempting to time this so a colllsion is avoided.

If a collision does occur however, a jamming signal is then sent out to all devices to notify a collision has happened. All devices will then wait a random period of time before sending data to avoid another collision. The process then repeats, with each device listening for a quiet moment before sending data.

### Hubs vs Switches

Switches in contrast are layer 2 devices, using MAC addresses to send frames to specific devices, rather than flooding to all devices like a hub. Switches will never attempt to send 2 frames at the same time to a single device, so a switch does not cause collisions.

When using a switch, rather than all devices connected being in one collision domain, each device is in its own collision domain with just itself and the connection it has with the switch. That is, a collision can only occur if the device connected to the switch attempts to send 2 frames to the switch at the same time.

A key feature of a switch is that it will always support full-duplex, so connected devices (as long as they also support full-duplex) can send and receive data at the same time.

Collisions can still occur, but are rare, and generally the result of a misconfiguration.

### Speed and Duplex Autonegotiation

When interfaces have their speed and duplex settings configured to `auto`, they will negotiate automatically with another interface they are connected to to work out what the best speed and duplex option they can operate at is.

Each interface will tell the other what their top speed and what their duplex capability is. The 2 interfaces will then select the top speed and duplex capability that both are capable of.

An ethernet interface can only operate at 10Mbps, whereas a fast ethernet interface can operate at 10 or 100Mbps, and a gigabit ethernet interface can operate at 

However, if one interface is set to auto and attempting to negotiate, but the connected interface is manually configured and not negotiating, the auto configured interface will attempt to detect the speed of the manually configured interface and operate at that speed if able. Otherwise, if the auto configured interface cannot detect the speed of the other interface, it will default to its slowest supported speed.

In this situation with one interface automatic and the other manually configured, the automatic device will use half-duplex if it selected a speed of 10 or 100Mbps, or will use full-duplex (if able) if it selected a speed of 1000Mbps or greater.

If the auto configured interface selects half-duplex when the manually configured interface is using full-duplex (or vice versa), then there is a *duplex mismatch*. This means collisions will occur over this connection, and network speeds will be slowed as a result. This is why its best to use auto negotiation.

### Interface Errors

`show interfaces [interface ID]` can be used to diagnose some interface errors.

*Runts* are frames that are smaller than the minimum frame size of 64 bytes. *Giants* are frames that are larger than the maximum frame size of 1518 bytes.

*CRC* here refers to frames that failed the CRC check, performed via the Ethernet FCS trailer.

*Frame* here counts the number of frames with an incorrect format.

*Input errors* is the overall count of all other counts listed, including the above.

*Output errors* is the count of frames that the switch attempted to send but failed due to any error.
