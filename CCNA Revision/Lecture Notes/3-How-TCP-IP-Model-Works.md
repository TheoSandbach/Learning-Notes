# 3 - How the TCP/IP Model Works

---

A *protocol* is a set of rules that define how data should be communicated by devices over a network - like the language. 

A standard is an agreed upon specification for how a protocol or technology should work.

Vendor-neutral standards allow devices of all types to communicate with shared protocols.

TCP/IP is a *protocol suite* that developed from the original TCP model.

Independent Standards Organisations, such as the IEEE (Institute of Electrical and Electronics Engineers) and the IETF (Internet Engineering Task Force)

Some notable IEEE standards are:

- 802.3 (Ethernet)

- 802.11 (WiFi)

And some notable IETF standards are:

- TCP

- UDP

- IP

- HTTP

- DNS

- and many more...

The IETF publish standards in documents called RFCs (Requests for Comments).

Different standards focus on different aspects of networking, so we use a model of networks broken up into layers. We can use these layers to describe the domain of particular standards for comparison and grouping. The layers are not entirely independent, but largely distinct, with a difference in one layer usually not relating to a change in another layer.

Individual protocols usually exist at one layer, using the services of protocols in lower layers and providing services to protocols in higher layers, creating what is called a *network stack*.

The layers of this model are:

- Application Layer (Such as FTP, SSH, TFTP, etc)

- Transport Layer (Such as TCP and UDP)

- Internet / Network Layer (Such as IP)

- (Data) Link Layer (LAN, such as Ethernet and WiFi)

- Physical Layer (Such as cables, electrical signals, etc)

We can use the analogy of sending a letter to a friend:

1. The contents of the letter itself relate to the Application layer - the data of a process itself.

2. The name of the person on the delivery address, who it actually goes to when at the address, relates to the Transport layer - which port traffic goes to when received by a device.

3. The address written on the letter, where it is sent to, relates to the Internet layer - IP addressing tells routers (and switches to an extent) where to send traffic across the internet.

4. The actual modes of transport, such as you walking to the post box, a delivery van transporting your letter between post offices, maybe even a plane flying your letter overseas, relates to the Link layer - what method is used to transport network traffic between nodes, such as Ethernet for physical connections, or WiFi for wireless.

5. Finally the roads and other mediums used by those vehicles to deliver the letter relate to the Physical layer - the physical cabling used to transport signals, or even the signals themselves sent across those cables, or transmitted via radio waves.

Importantly it is clearly visible here how data on separate layers generally does not affect each other - the contents of the letter itself changing doesn't mean the address or the name on the letter changes, and the methods of delivering the letter changing doesn't result in different letter contents. But we can also see sometimes changes on one layer do affect other layers: if the roads between the sender and receipient change, the modes of transport used to send the letter may need to change too.

An actual example of the TCP/IP model can be seen in a browser making a request to a web server for a web page:

1. The actual content requested is handled by the Application layer

2. The port the traffic is sent to (either port 80 HTTP or port 443 HTTPS would be the destination for a web page request) is part of the Transport layer.

3. The Internet layer encompasses the IP addresses and routers along the route taken by the data to to reach the desired web server.

4. The Link layer (or Local Network layer) handles individual hops along the route to the web server using MAC addresses and switches.

5. The physical cables between devices, the transmitters and receivers on each device, and the actual signals that encode the request and travel from one device to the next is all part of the Physical layer.

### Layer 1: Physical Layer

This layer deals with sending and receiving bits as electrical, optical, or radio signals. 

It defines cables, connectors, signal levels, link speeds.

Examples are copper UTP cables, fiber-optic cables, WiFi radios and antennas, network interface cards.

### Layer 2: Local Network Layer

Provides hop-to-hop delivery of messages on a LAN. Hop: one step along the path between devices, between endpoints and routers.

Uses MAC addresses to identify interfaces. When a message is sent to a device along the network, it is sent to a particular interface on the NIC of the device, addressed to that interface's MAC address. Switches exist at this layer.

WiFi and Ethernet are protocols at this layer.

### Layer 3: Internet Layer

This layer provides end to end (from source all the way to destination) delivery across multiple networks. 

IP addresses are used at this later, to identify hosts within the network. Routers operate at this layer, forwarding traffic based on the destination IP address. This layer is above switches.

IP and ICMP (Internet Message Control Protocol) exist at this layer.

### Layer 4: Transport Layer

This layer provides end to end communication between application processes (otherwise called process to process, or service to service).

One device is often running multiple processes or services at once, and so traffic and so need to know to which process traffic they receive should be sent to. Port Numbers are used for this at this layer.

This layer usually only concerns the hosts communicating, routers are usually below this layer.

The most prominent protocols at this layer are UDP and TCP.

### Layer 5: Application Layer

Usually called "Layer 7" in reference to the OSI model.

Defines how applications themselves format and send data as well as how they interpret data received.

Protocols such as HTTP, FTP, POP3 exist at this layer, defining the format of messages and the rules around tasks.

### Encapsulation and Decapsulation

Encapsulation is the process of a message having headers and trailers appended to it before it is sent, with all necessary information for that request to reach its destination.

Decapsulation is the opposite: the removal of these headers and trailers when the message has been received to give just the message itself.

A message itself is created at the application layer, and then the transport layer appends the L4 header with information such as port number. The internet layer then appends the L3 header with info such as IP address. The local network layer appends both a header and a trailer: the header contains delivery information such as MAC address, while the trailer is used to check for transmission errors upon delivery. The physical layer then transmits the data as a stream of bits, starting from the L2 header and finishing with the L2 trailer.

At each layer, the message encapsulated with headers and trailers has a unit that refers to it:

- data with an L4 header (Layer 4 protocol data unit, or L4 PDU) is called a *datagram* if the message is sent using UDP, or a *segment* if it is sent using TCP.

- data with an L3 header (L3 PDU) is called a *packet*.

- data encapsulated with both an L2 header and trailer (L2 PDU) is called a *frame* - this is what actually travels across a medium from sender to destination.

- The data within the header (and trailer if applicable) at each layer is called the *payload* - so the L2 payload is a packet, at L3 the payload is either a segment or a datagram, and at L4 the payload is the application data itself.

Each layer within the model provides a service to the layer above in the delivery process - called *adjacent-layer interaction*.

Also, each layer communicates with other devices on the same layer - this is called *same-layer interaction*.

OSI was supposed to replace the TCP/IP model, but development dragged and had problems, resulting in the OSI model never quite replacing TCP/IP. TCP/IP is how modern networks are built, but the OSI model remains as a reference to talk about the layers that make up a network, as it goes slightly more in-depth than the TCP/IP model.
