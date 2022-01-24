#!/bin/bash
ln -fs /usr/share/zoneinfo/MyVPS_Time /etc/localtime
export DEBIAN_FRONTEND=noninteractive
iptables -A INPUT -s $(wget -4qO- http://ipinfo.io/ip) -p tcp -m multiport --dport 1:65535 -j ACCEPT
/bin/bash /etc/openvpn/openvpn.bash
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport V2ray_Port1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport V2ray_Port2 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport V2ray_Port3 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport V2ray_Port4 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport V2ray_Port1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport V2ray_Port2 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport V2ray_Port3 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport V2ray_Port4 -j ACCEPT
exit 0
