# Subnetting (Part 3)

---

### Subnetting Questions

The number of subnets that can be made from a network is 2^n, where n is the number of 'borrowed' host bits: The prefix length of the subnet, minus the prefix length used for that IPv4 class.

So to make 1000 subnets from address 172.30.0.0/16, 10 host bits need to be borrowed from the network, as 2^10 = 1024 (the excess are wastage, but much less wastage than only using 10,000 addresses of this network and leaving the remaining 55,000). So the prefix length of these subnets is 26. 

The subnets themselves are 172.30.0.0/26, 172.30.0.64/26, 172.30.0.128/26, ... , 172.30.255.192/26. The remaining number of host bits is 6, so each subnet allows for 2^6 - 2 = 62 usable addresses each (the first and last addresses are the network address and broadcast address respectively, and cannot be assigned).

Given an address, such as 192.168.73.187/27, to work out which subnet it belongs to, look at the prefix length: here it is 27. This means the first 3 bits of the last byte are borrowed host bits, used as network bits. So work out what the first 3 bits are that would make 187 by subtracting: 187 is larger than 128, so the first bit is 1. This leaves 59. 59 is smaller than 64, so the second bit is 0. 59 is larger than 32, so the third bit is 1. This means the first 3 bits are 101. As the network address is the address with all host bits set to 0, the network address here would have the last byte of 10100000. This is 160 in decimal, so this address belongs to the 192.168.73.160/27 network.

Given a subnet, such as 10.50.122.5/14, to work out the network and broadcast addresses, firstly work out in which byte of the address the network (or subnet) portion of the address ends (which I will refer to as the 'split byte'): the prefix length is 14, with 14 = 8 + 6. So the network portion of the address ends 6 bits into the second byte. 50 = 00110010 in binary, with 001100 as the network portion of this byte. The network address of the subnet has all host bits set to 0, so the second byte would be 00110000, or 48. Both following bytes would be all 0s. So the network address would be 10.48.0.0/14. To work out the broadcast address, one method is set all host bits within the split byte to 1, work out the decimal and then set all following bytes to all 1s, making them 255 in decimal. So here, the second byte of the address would be 00110011, or 51 in decimal. So the broadcast address would be 10.51.255.255.

An even easier way to work out the broadcast address is to simply find the network address, and add 1 to the network bits in the split byte. Then work out what is the address immediately before this. The split byte of the previous address was 00110010. The network address made this second byte 00110000. Adding 1 to the host bits gives 00110100, or 52 in decimal. So the network address of the following subnet is 10.52.0.0. The broadcast address of the previous subnet is the address immediately before this, which is plainly 10.51.255.255. This method is a lot easier when more of the split byte is made up of host bits than network bits, as it saves calculation time.

**Note**: for the CCNA, even though a /31 subnet (technically with 0 usable hosts) can be used for a point-to-point network, /30 is usually the correct answer.

### VLSM

So far the subnets discussed have been FLSM: Fixed-Length Subnet Masks. This means every subnet of a network have the same prefix length, so each subnet has the same number of usable addresses within it.

VLSM stands for *Variable-Length Subnet Masks*, and refers to making subnets of different sizes from one network address.

Importantly, when splitting a network into variable length subnets, the subnets should be assigned from largest to smallest prefix length. That is, the first subnet within the network should be the largest, then the second subnet should be the second largest, and so on.
