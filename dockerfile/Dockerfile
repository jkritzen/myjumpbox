FROM fedora:latest

#-------------Application Specific Stuff ----------------------------------------------------
# Open port 22 so linked containers can see it
EXPOSE 22



# Add Users & ssh public keys
ADD https://raw.githubusercontent.com/Ontracon/jumpbox/master/dockerfile/id_rsa.pub /home/jkritzen/.ssh/authorized_keys
ADD https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 /usr/local/bin/confd

RUN dnf -y install passwd
RUN dnf -y install iputils
RUN dnf -y install procps

RUN dnf install -y openssh-server
RUN dnf install -y openssh-clients
 
RUN passwd -d root
RUN adduser jkritzen -d /home/jkritzen
RUN chown -R jkritzen:jkritzen /home/jkritzen
RUN chmod +x /usr/local/bin/confd

ADD confd/confd-config.toml /etc/confd

# Run any additional tasks here that are too tedious to put in
# this dockerfile directly.

# Called on first run of docker - will run supervisor
ADD https://raw.githubusercontent.com/jkritzen/myjumpbox/master/dockerfile/start.sh /start.sh
RUN chmod 0755 /start.sh

CMD /start.sh
