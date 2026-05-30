# Ethernet LAN Switching (Part 1)

---

A LAN is a network of devices in a relatively small area, such as one floor of an office. A LAN is made up of hosts and switches, maybe a firewall, and one port of a router. The router itself sits on the edge of the LAN. Switches do not terminate LANs as they simply forward data between devices within the LAN, whereas a router does terminate a LAN, and even if multiple LANs are physically connected to the same router they are still distinct LANs.

Data moves within an Ethernet LAN in frames - these are data payloads, encapsulated in a TCP or UDP header, an IP header, and an Ethernet header and trailer.

Within the Ethernet header of a frame, there are 5 fields:

- Preamble and SFD (Start Frame Delimiter) - used for sync.

- Destination - the MAC address the frame is being sent to.

- Source - the MAC address the frame was sent from.

- Type - the type of layer 3 protocol used, almost always IP (either IPv4 or IPv6)
  
  - or Length - in other versions of Ethernet, the final field may alternatively be the length of the payload data.

The preamble and SFD are 8 bytes together, the destination and source are 6 bytes each, and the type / length field is 2 bytes, meaning the ethernet header is 22 bytes in length.

The trailer just contains the FCS (Frame Check Sequence) - this is used by the recipient device to check for errors that may have occured during transmission. It is 4 bytes long, meaning the trailer itself is 4 bytes in total.

So the combined length of the ethernet header and trailer is 26 bytes.

#### Preamble and SFD

The preamble is 7 bytes of 1s and 0s, so `10101010` 7 times. This is used to allow the recipient device to synchronize, ready to receive the rest of the frame.

The Start Frame Delimiter is simply the end of the preamble and the beginning of the rest of the frame. It is simply the byte `10101011`.

#### Destination and Source

These contain the MAC (Media Access Control) addresses of the devices receiving and sending the frame. A MAC address is a 6-byte address, so these combined make up 12 bytes or 96 bits of data.

#### Type or Length

This field is always 2 bytes and can be used to represent the type of the encapsulated packet, or the length of the encapsulated packet.

If the value of these bytes in decimal is 1500 or less (`0b 00000101 11011100` / `0x05dc` or less) then this field encodes the *length* of the frame payload in bytes (1500 is the max length in bytes a payload can have for a single ethernet frame).

If the value of these bytes in decimal is 1536 or greater (`0b 00000110 00000000` / `0x0600` or greater), then this field encodes the *type* of layer 3 encapsulated packet, most often either IPv4 or IPv6. 

Specifically, `0x0800` or 2048 encodes an IPv4 packet, and `0x86DD` or 34525 encodes an IPv6 packet.

#### FCS

The Frame Check Sequence is the only field in the ethernet trailer for a frame. It is 4 bytes in length and uses a CRC (Cyclic Redundancy Check) algorithm ran over the received data to check for data corruption.

### MAC Addresses

A MAC address is a 6-byte address assigned to a device when it is manufactured.

It is also knows as a Burned-In Address (BIA) because it is burned into the device during manufacturing - it is set and cannot be altered. 

The MAC address of a device *should* be globally unique (as in, it very likely will be and there are standards in place to ensure this, but it is not in any way impossible for 2 devices to be manufactured with the same MAC address).

The first 3 bytes of the address are the OUI (Organizationally Unique Identifier), which the IEEE assigns to the company that manufactures the device. So all MACs made by the same manufacturer in theory have the same first 3 bytes.

The last 3 bytes are the device identifier, and are unique to that device for that manufacturer.

The address itself is written as a string of 12 hexadecimal characters, such as `00:1A:2B:C3:4D:E5` (or alternatively written as `001A:2BC3:4DE5`).

### Sending Data in a LAN

A frame sent from one device to just one destination device is called a *Unicast* frame. There also exists *Broadcast* frames, where a device sends a frame to multiple devices at once.

When a device sends a frame within a LAN, it first sends it to a connected switch via the device's NIC. The switch receives the frame on the interface it has connected to the source device, and updates its *MAC Address Table*: it associates the MAC address of the source device with the interface it is connected to it on. So for example if a switch is connected to a device with MAC address `00:1A:2B:C3:4D:E5` on its Fast Ethernet interface 0/1, it will add this MAC address to its Address Table alongside `F0/1` for the interface.

This is called a *Dynamically Learned MAC Address* or just a Dynamic MAC Address.

If a switch receives a packet with a destination MAC address the switch doesn't already have in its address table, this is called an *Unknown Unicast Frame*.

In this case, the switch will *flood* the frame - sending it through all of its connected interfaces except the interface it received the frame through. All connected devices will receive the frame, but all of the devices without a matching MAC address will discard the frame as they are not its intended recipient. Only the device receiving this frame with a MAC address matching the destination address of the frame will process the frame.

However, as a switch only updates its address table when it receives a frame from a device not in its table already, then unless the recipient device sends a reply, it will remain unknown to the switch, and any follow up frames sent to this same destination device will still trigger a flood, until the destination device itself sends a frame through the switch. When this occurs, its MAC address will be added to the switch's address table.

If instead a device sends a packet through a switch to an address that is already in the address table, the frame will instead be *forwarded* directly to the destination device. This is called a *Known Unicast Frame*.

Addresses only remain in the switch MAC address table for 5 minutes by default when using Cisco switches. This timer is restarted whenever the device sends a frame, so a device is only removed from the table after 5 minutes of inactivity. After this, the device will only be added when it next sends a frame, and the timer will start again.

If a switch receives a frame from another switch, it will associate that frame's source MAC address with the interface it is connected to the other switch on. This means when receiving a frame for that original source device, this switch will forward the frame to the first switch, which will either forward it to the device with that address or to another switch in the chain.
