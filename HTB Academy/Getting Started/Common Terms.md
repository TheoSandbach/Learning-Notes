# Common Terms

Shell = On Linux, program that takes input from user and passes to OS to perform functions

Bash = Born Again Shell, modern version of sh

Also Zsh, Tcsh, Ksh, Fish

"Getting a shell on a system" = gaining shell access on a target system via exploits

Main types of shell connection: Reverse shell, Bind shell, Web shell



Ports = virtual points where network connections to a system begin or end, software-based and OS managed

Think of ports like the doors of a house: meant for specific 'people' or connections, but unauthorized access can be achieved if left unlocked or locked poorly

Ports are assigned number and are tied to specific services (though port-service association is not locked)

Ports are either TCP or UDP, there are 65,535 (2 bytes) ports for each

TCP - server must be listening and open to connections, so the handshake can be established before communication occurs

UDP - no handshake or error checking, connectionless

![most common port numbers](C:\Users\Theo\Documents\Cyber\Git\HTB%20Academy\Getting%20Started\pictures\common-ports.png)



Web Server = back-end server application that handles http/s traffic between the client connecting to the server and the server itself

Huge attack surface, and any vulnerabilities may expose the back-end server to an attacker

The OWASP Top 10 lists the estimated top 10 most dangerous vulnerabilities a web server can suffer from:

[OWASP Top 10]([OWASP Top Ten Web Application Security Risks | OWASP Foundation](https://owasp.org/www-project-top-ten/))
