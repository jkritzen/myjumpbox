# jumpbox
Simple Docker Container for providing Secure SSH Unix Jump Services from Kubernetes with egress policy for ssh outbound connections.

For the runtime the following environment variables has to be used:

* admin_user: Contains the embedded Admin User  within the Container (can be provided by vault)
* admin_pubkey: Provide the Public ssh key for the admin user (can be provides by vault)

To preserve the Hosts Key's for a specific Jump Service (also for redeployment/upgrades of the container)  the kubernetes secret store contains the necessary secrets within "JumpHostKeys" with the following Key/Values:

* ssh_host_rsa_key: Contains the Host private RSA key
* ssh_host_rsa_key.pub: Contains the Host public RSA key

The provided secrets have to bound to the specific kubernetes namespace for the individual Jump Service. The secret will be mounted by kubernetes to a file within the container. The sshd config will use those key files for preserving the hosts key.
