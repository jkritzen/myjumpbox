  
#!/bin/bash

# generate host keys if not present
ssh-keygen -A

# # ensure the following environment variables are set. exit script and container if not set.
#test $ssh

/usr/local/bin/confd -onetime -backend env

#Create user Folder dynamically form env-variable and set pub-key
#1. Read user from env-variable and save it into variable
user=$(</tmp/userconf.conf)
echo "$user"

#1.1 Get pub-key
pubkey=$(</tmp/pubkeyconf.conf)
echo "$pubkey"

#2. Create user folder from variable
passwd -d root
adduser $user -d /home/$user
chown -R $user:$user /home/$user

2.2 Make ssh dir
mkdir /$user/.ssh
RUN echo "$pubkey" > /$user/.ssh/id_rsa.pub
RUN chmod 600 /$user/.ssh/id_rsa.pub

#3 Create known_hosts
touch /$user/.ssh/known_hosts


# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"
