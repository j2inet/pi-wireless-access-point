sudo apt-get update
sudo apt-get upgrade -y
sudo apt install hostapd -y
sudo apt install dnsmasq -y

sudo systemctl stop hostapd
sudo systemctl stop dnsmasq


#Enable the Wireless Network Service
sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent


mkdir ./temp

#Alter DHCP 
cat /etc/dhcpcd.conf data/append.dhcpcd.conf > ./temp/modified.dhcpcd.conf
sudo mv ./temp/modified.dhcpcd.conf /etc/dhcpcd.conf

sudo systemctl restart dhcpcd


#Enable Routing
sudo cp data/routed-ap.conf /etc/sysctl.d/routed-ap.conf

#Masquarade
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo netfilter-persistent save


sudo cp ./data/dnsmasq.conf /etc/dnsmasq.conf

sudo rfkill unblock wlan
#append hostapd configuration
cat /etc/hostapd/hostapd.conf ./data/append.hostapd.conf > ./temp/hostapd.conf
sudo mv ./temp/hostapd.conf /etc/hostapd/hostapd.conf




