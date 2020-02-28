  
#!/bin/bash

# generate host keys if not present
#ssh-keygen -A

# # ensure the following environment variables are set. exit script and container if not set.
#test $ssh

/usr/local/bin/confd -onetime -backend env

#Create user Folder dynamically form env-variable and set pub-key
#Read user from env-variable and save it into variable
user=$(</tmp/userconf.conf)
echo "$user"

#Get pub-key
pubkey=$(</tmp/pubkeyconf.conf)
echo "$pubkey"

#Create user folder from variable
passwd -d root
adduser $user -d /home/$user
chown -R $user:$user /home/$user


#Make ssh dir
#mkdir /home/$user/.ssh
#chmod 700 /.ssh

echo "$pubkey" > /home/$user/.ssh/authorized_keys

chown -R $user:$user /home/$user/.ssh
chmod 700 /home/$user/.ssh
chmod 600 /home/$user/.ssh/authorized_keys

#Overwrite sshd
cp -f /tmp/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key
cp -f /tmp/ssh/ssh_host_rsa_key.pub /etc/ssh/ssh_host_rsa_key.pub


# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"
