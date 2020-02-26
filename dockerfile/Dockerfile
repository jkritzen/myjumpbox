FROM centos:7

#-------------Application Specific Stuff ----------------------------------------------------
# Open port 22 so linked containers can see it
EXPOSE 22



# Add Users & ssh public keys
# ADD https://raw.githubusercontent.com/Ontracon/jumpbox/master/dockerfile/id_rsa.pub /home/jkritzen/.ssh/authorized_keys
ADD https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 /usr/local/bin/confd

#Set up and enable epel YUM REPO before installing DNF
RUN yum -y install epel-release
RUN yum -y install dnf

RUN dnf -y install passwd
RUN dnf -y install iputils
RUN dnf -y install procps

RUN dnf install -y openssh-server
RUN dnf install -y openssh-clients

#Overwrite standard openssh_server config file
ADD https://raw.githubusercontent.com/jkritzen/myjumpbox/master/dockerfile/sshd_config /etc/ssh/sshd_config
 
RUN chmod 777 /usr/local/bin/confd

RUN mkdir -p /etc/confd/{conf.d,templates}
RUN chmod 777 /etc/confd/{conf.d,templates}

ADD https://raw.githubusercontent.com/jkritzen/myjumpbox/master/dockerfile/confd/userconfig.conf.tmpl /etc/confd/templates
ADD https://raw.githubusercontent.com/jkritzen/myjumpbox/master/dockerfile/confd/userconfig.toml /etc/confd/conf.d
ADD https://raw.githubusercontent.com/jkritzen/myjumpbox/master/dockerfile/confd/pubkeyconfig.conf.tmpl /etc/confd/templates
ADD https://raw.githubusercontent.com/jkritzen/myjumpbox/master/dockerfile/confd/pubkeyconfig.toml /etc/confd/conf.d

# Run any additional tasks here that are too tedious to put in
# this dockerfile directly.

# Called on first run of docker - will run supervisor
ADD https://raw.githubusercontent.com/jkritzen/myjumpbox/master/dockerfile/start.sh /start.sh
RUN chmod 777 /start.sh
    
CMD /start.sh
