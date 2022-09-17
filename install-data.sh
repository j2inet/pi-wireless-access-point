sudo cp data/bridge-br0.netdev /etc/systemd/network/bridge-br0.netdev
sudo cp data/br0-member-eth0.network /etc/systemd/network/br0-member-eth0.network
echo 'denyinterfaces wlan0 eth0' | cat - /etc/dhcpcd.conf > ./1_dhcpcd.conf 
echo 'interface br0' | cat - ./1_dhcpcd.conf > ./2_dhcpcd.conf && sudo mv 2_dhcpcd.conf  /etc/dhcpcd.conf


sudo cp data/hostapd.conf /etc/hostapd/hostapd.conf

#Ensure Wireless Operation

sudo rfkill unblock wlan
