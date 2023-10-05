#### Session Video
  https://drive.google.com/file/d/1rq5uGkiZTtyln6WTK1LKYjnDQVYNONB1/view?usp=sharing  

#### AWS VPC

```
What is Amazon VPC?

With Amazon Virtual Private Cloud (Amazon VPC), you can launch AWS resources in a logically isolated virtual network that you've defined. This virtual network closely resembles a traditional network that you'd operate in your own data center, with the benefits of using the scalable infrastructure of AWS.

The following diagram shows an example VPC. The VPC has one subnet in each of the Availability Zones in the Region, EC2 instances in each subnet, and an internet gateway to allow communication between the resources in your VPC and the internet.

https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html
```


```
Features
The following features help you configure a VPC to provide the connectivity that your applications need:

Virtual private clouds (VPC)
A VPC is a virtual network that closely resembles a traditional network that you'd operate in your own data center. After you create a VPC, you can add subnets.

Subnets
A subnet is a range of IP addresses in your VPC. A subnet must reside in a single Availability Zone. After you add subnets, you can deploy AWS resources in your VPC.

IP addressing
You can assign IP addresses, both IPv4 and IPv6, to your VPCs and subnets. You can also bring your public IPv4 and IPv6 GUA addresses to AWS and allocate them to resources in your VPC, such as EC2 instances, NAT gateways, and Network Load Balancers.

Routing
Use route tables to determine where network traffic from your subnet or gateway is directed.

Gateways and endpoints
A gateway connects your VPC to another network. For example, use an internet gateway to connect your VPC to the internet. Use a VPC endpoint to connect to AWS services privately, without the use of an internet gateway or NAT device.

Peering connections
Use a VPC peering connection to route traffic between the resources in two VPCs.

Traffic Mirroring
Copy network traffic from network interfaces and send it to security and monitoring appliances for deep packet inspection.

Transit gateways
Use a transit gateway, which acts as a central hub, to route traffic between your VPCs, VPN connections, and AWS Direct Connect connections.

VPC Flow Logs
A flow log captures information about the IP traffic going to and from network interfaces in your VPC.

VPN connections
Connect your VPCs to your on-premises networks using AWS Virtual Private Network (AWS VPN).

```

```
IP addressing for your VPCs and subnets

P addresses enable resources in your VPC to communicate with each other, and with resources over the internet.

Classless Inter-Domain Routing (CIDR) notation is a way of representing an IP address and its network mask. The format of these addresses is as follows:

An individual IPv4 address is 32 bits, with 4 groups of up to 3 decimal digits. For example, 10.0.1.0.

An IPv4 CIDR block has four groups of up to three decimal digits, 0-255, separated by periods, followed by a slash and a number from 0 to 32. For example, 10.0.0.0/16.

An individual IPv6 address is 128 bits, with 8 groups of 4 hexadecimal digits. For example, 2001:0db8:85a3:0000:0000:8a2e:0370:7334.

An IPv6 CIDR block has four groups of up to four hexadecimal digits, separated by colons, followed by a double colon, followed by a slash and a number from 1 to 128. For example, 2001:db8:1234:1a00::/56.


https://docs.aws.amazon.com/vpc/latest/userguide/vpc-ip-addressing.html

```