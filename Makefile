all:
	ssh chronos "cd ~/data/gitno/github/openvpn-client/ && docker build -t harbor.homew.keenetic.pro/eab/openvpn-client:0.0.2 ."