---
layout: post
---

## Motivation
I started this project as an almost complete networking beginner. I very much wanted to be running my default internet though a VPN. Problem was with other users in the house streaming entertainment (and other potentially VPN inconvenient sites like banking services), it was necessary to be able to easily switch between a VPN and the default pathway offered by my ISP. 

## Approaches
I was able to debrick an TP-Link Archer C2600 that I had lying around a flash OpenWRT onto it. After going through the walkthrough to configure my network and setup an OpenVPN connection I noticed that the streaming video through the Rokus was not smooth. The next basic step was to fixed the ips of the roku devices and route their traffic apart from the VPN. 
  * vpn-policy-routing
     * I found this package worked splendidly to assign a policy to a particular ip to avoid the VPN. The problem I ran into was that due to the VPN connection i had to disable PeerDNS through the WAN interface and assign the DNS of my VPN provider, and after routing the Netflix servers were unreachable even though they were reachable when the Roku was connected to the VPN. I don't know the reason for this but I would be very interested into knowing why. I'm not sure if it's because of my VPNs DNS servers when connected to the VPN or something my ISP is doing to my outbound packets. At any rate, I searched the internet for solutions on how to set a per client DNS and found some older threads that specified settings lines in dnsmasq.conf [thread link](https://serverfault.com/questions/509388/per-client-dns-servers-with-dnsmasq). 
```
dhcp-host=B8:3E:59:15:BD:69,set:red
dhcp-option=tag:red,option:dns-server,208.122.23.22,208.122.23.23
```
     It bothered me slightly that I couldn't find anything explicit in the man page. It seems that maybe the preferred approach now is to assign per interface? For me this seemed like it would require creating a separate LAN + WAN interface depending on my configuration. I decided for a different approach.
  * Using a second router ![setup](/assets/img/XBNr0fn.png)
     * One router would serve the regular network and would be through my ISP directly
     * The other would be an Access Point that would be used for any VPN connection. This is more flexible and lends itself to more complexity further down the line. Also with this I have no immediate need for policy routing.
     * I decided to use my less powerful Netgear router (not supported by OpenWRT) as my main router and connect to my OpenWRT router via Ethernet on the WAN port.
        * I also changed the default DNS on the main router to point to OpenDNS servers so as not to give my ISP my DNS requests
        * DNS over HTTPS is not supported by this router but would be a nice addition
        * I disabled the 5G radio
     * For the router running OpenWrt
        * Make sure OpenVPN is configured
        * Change the LAN to a static address protocol and change the subnet to not conflict with the one of the main router (I just used 192.168.2.1).
        * Specify the default gateway of the main router (192.168.1.1 in my case)
        * Add custom DNS to the WAN interface
        * Disable the 2.4GHz radio
     * Connect them up and leave some physical space between the routers (I just have a couple of feet) to avoid unintended interference as a precaution.


