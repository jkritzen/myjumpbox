## NEW ##
#!/bin/bash
# Initialize Config Files
/usr/local/bin/confd -onetime -backend env

# Delete root passwd
passwd -d root

# Create Admin User
adduser  ${admin_user} -d /home/${admin_user}
mkdir /home/${admin_user}/.ssh
echo ${admin_pubkey} >  /home/${admin_user}/.ssh/authorized_keys
chown -R ${admin_user} /home/${admin_user}
chmod 600 /home/${admin_user}/.ssh/authorized_keys


# generate host keys if not present
ssh-keygen -A
exec /usr/sbin/sshd -D -e "$@"
