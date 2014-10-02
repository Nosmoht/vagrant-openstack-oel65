yum install -y openstack-packstack
sudo packstack --install-hosts=192.168.0.200,192.168.0.201 --use-epel=n --neutron-ovs-tenant-network-type=vlan --neutron-ovs-vlan-range=default:1000:2000 --neutron-ovs-bridge-mappings=default:br-eth2 --neutron-ovs-bridge-interfaces=br-eth2:eth2

