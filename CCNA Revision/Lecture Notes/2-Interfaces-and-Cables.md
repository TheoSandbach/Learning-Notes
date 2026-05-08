# 2 - Interfaces and Cables

---

RJ-45 (Registered Jack) connectors - Used on the end of a copper ethernet cable to connect to RJ-45 ports

*Ethernet* is a collection of network protocols and standards

Common protocols and standards allow network devices to connect and communicate, regardless of the manufacturer 

Physical standards ensure things like an RJ-45 connector always connects to an RJ-45 port, regardless of manufacturer

Logical standards ensure that connected devices both use the same language for the same purpose - data transferred is in a format both devices can understand

The speed of data transfer is measured in **bits** per second (bps, Kbps, Mbps, etc), wheres data size and storage is measured in **bytes** (B, KB, MB, etc)

Common ethernet standards, as defined in the IEEE 802.3 standard in 1983 (IEEE = Institute of Electrical and Electronics Engineers):

| Speed    | Common Name         | IEEE Standard | Informal Name | Maximum Length |
| -------- | ------------------- | ------------- | ------------- | -------------- |
| 10 Mbps  | Ethernet            | 802.3i        | 10BASE-T      | 100m           |
| 100 Mbps | Fast Ethernet       | 802.3u        | 100BASE-T     | 100m           |
| 1 Gbps   | Gigabit Ethernet    | 802.3ab       | 1000BASE-T    | 100m           |
| 10 Gbps  | 10 Gigabit Ethernet | 802.3an       | 10GBASE-T     | 100m           |

Common name is how these are usually referred to. These standards are not usually referred to by IEEE standard, but this should be known.

BASE = Baseband signaling (out of scope)

T = Twisted pair

Copper twisted pair cables are always defined as having a max length of 100m in ethernet standards.

UTP cable = Unshielded (No metallic shield, so vulnerable to EMI) Twisted Pair (Pairs of copper wires twisted together in pairs, to protect from EMI)

10BASE-T and 100BASE-T only have 2 pairs each, whereas 1000BASE-T and 10GBASE-T have 4 pairs each. An RJ-45 connector has 8 pins to allow for up to 8 wires (4 pairs).

One characteristic of UTP cables is that they leak a faint signal, which can be spied on, providing a security risk.

Each wire is coloured differently to allow distinction, and each individual wire is mapped from one side of the cable to the other in specific configurations.

### 10BASE-T and 100BASE-T UTP Cables

10BASE-T and 100BASE-T UTP cables only contain 4 wires. There are 2 types of cables that are used, depending on which devices are being connected. Each has the wires within it mapped slightly differently. 

With an RJ-45 connector, these cables only use pins 1, 2, 3, and 6.

One of these types of cables is a *straight-through cable*:

|               | Connector A pins | Mapped to... | Connector B pins |               |
| ------------- | ---------------- | ------------ | ---------------- | ------------- |
| Transmit (Tx) | 1                | ---          | 1                | Receive (Rx)  |
| Transmit (Tx) | 2                | ---          | 2                | Receive (Rx)  |
| Receive (Rx)  | 3                | ---          | 3                | Transmit (Tx) |
| Receive (Rx)  | 6                | ---          | 6                | Transmit (Tx) |

A switch will always use pins 1 and 2 to receive data, and pins 3 and 6 to transmit. Whereas an endpoint, router or firewall will use pins 1 and 2 to transmit, and 3 and 6 to receive. This configuration allows for *full-duplex* data transfers - data can be sent and received by both connected devices in unison without interfering.

However, this configuration falls apart when we are trying to connect an endpoint to a router, or a router to a firewall, or 2 endpoints together, etc. Both devices use the same pins to transmit and to receive, so data cannot be received by either device when connected directly with a straight-through cable.

So instead we use a crossover cable:

|               | Connector A pins | Mapped to... | Connector B pins |               |
| ------------- | ---------------- | ------------ | ---------------- | ------------- |
| Transmit (Tx) | 1                | ---          | 3                | Receive (Rx)  |
| Transmit (Tx) | 2                | ---          | 6                | Receive (Rx)  |
| Receive (Rx)  | 3                | ---          | 1                | Transmit (Tx) |
| Receive (Rx)  | 6                | ---          | 2                | Transmit (Tx) |

Crossover cables allows us to connect devices directly together without a switch as an intermediary with straight-through cables.

Most modern networking devices use *Auto MDI-X* - this means if 2 devices are connected with the wrong type of UTP for which pins they send and receive data on, the device can flip around which pins it is using to allow communication in spite of the incorrect cable configuration.

### 1000BASE-T and 10GBASE-T Cables

1000BASE-T and 10GBASE-T cables have 8 wires, and so use all 8 pins on an RJ-45 connector.

A key feature is each wire within these cables is bi-directional, meaning data can be sent in either direction, and there is no physical requirement for certain pins to be used for transmitting and others to be used for receiving. As such, there is no straight-through / crossover distinction. This bi-directionality allows these wires to transmit data faster.

### Fiber-Optic Connections and Cables

To use fiber-optic cables, an SFP (Small Form-Factor Pluggable) Transceiver must be plugged into a fiber-optic connector on a switch, router, or other networking device. The ports for these are less common than RJ45 ports, and more expensive.

A fiber-optic cable connects to this. These cables come in pairs: one cable is used to send data, and the other is used to receive data.

A fiber-optic cable has a 4 layered core. From innermost to outermost these are:

1. The fiberglass core through which light passes

2. Cladding that reflects light

3. A protective buffer

4. The outer sleeve of the cable

Fiber-optic are not at all vulnerable to EMI, and do not have any signal leakage, unlike UTP cables.

The two main types of fiber optic cable are *single mode* and *multi-mode*. 

Single mode fiber-optic cables have a narrow core, through which light travels at only one angle, or mode. They use a laser-based transmitter which makes them more expensive, but have the longest range.

Multi-mode fiber-optic cables have a wider core, and use multiple light waves at different angles or modes traveling through simultaneously to transmit data. This allows for cheaper cables than single mode (cheaper transmitters), but provide less range (shorter max cable length).

Here are some standards for fiber-optic cables as defined in IEEE 802.3:

| Speed   | Cable Type  | IEEE Standard | Informal Name | Maximum Length |
| ------- | ----------- | ------------- | ------------- | -------------- |
| 1 Gbps  | Multimode   | 802.3z        | 1000BASE-LX   | 550m           |
| 1 Gbps  | Single mode | 802.3z        | 1000BASE-LX   | 5km            |
| 10 Gbps | Multimode   | 802.3ae       | 10GBASE-SR    | 400m           |
| 10 Gbps | Single mode | 802.3ae       | 10GBASE-LR    | 10km           |
| 10 Gbps | Single mode | 802.3ae       | 10GBASE-ER    | 30km           |


