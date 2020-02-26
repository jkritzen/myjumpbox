  
#!/bin/bash

# generate host keys if not present
ssh-keygen -A

# # ensure the following environment variables are set. exit script and container if not set.
#test $ssh

/usr/local/bin/confd -onetime -backend env

#Create user Folder dynamically form env-variable
#1. Read user from env-variable and save it into variable
value=$(</tmp/userconf.conf)
echo "$value"

#2. Create user folder from variable
passwd -d root
adduser $value -d /home/$value
chown -R $value:$value /home/$value

#Copy the fetched private-key to user directory
#su -c "mkdir /home/$value/.ssh" $value



# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"
