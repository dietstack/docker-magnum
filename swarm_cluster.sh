. adminrc
openstack image create fedora-atomic-latest  \
                       --public \
                       --disk-format=qcow2 \
                       --container-format=bare \
                       --property os_distro=fedora-atomic \
                       --file=/app/glance-images/fedora-atomic-latest.qcow2

openstack flavor create --id 1 --vcpus 1 --ram 1024 --disk 10 m1.small


openstack coe cluster template create --name swarm-template \
                       --image fedora-atomic-latest \
                       --external-network external \
                       --dns-nameserver 8.8.8.8 \
                       --master-flavor m1.small \
                       --flavor m1.small \
                       --coe swarm

openstack coe cluster template update swarm-template replace public=True

. demorc
openstack coe cluster create --cluster-template swarm-template \
                             --keypair mykey \
                             --master-count 1 \
                             --node-count 1 \
                             --name swarm-cluster1


