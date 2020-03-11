FROM centos:7

#-------------Application Specific Stuff ----------------------------------------------------
# Open port 22 so linked containers can see it
EXPOSE 22

# Set up and enable epel YUM REPO
RUN yum -y install epel-release

# Setup necessary Packages
RUN yum -y install procps
RUN yum -y install sudo
RUN yum -y install openssh-server
RUN yum -y install openssh-clients
#RUN yum -y install sssd

# Add confd - for runtime configuration management
ADD https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 /usr/local/bin/confd
RUN chmod 755 /usr/local/bin/confd


# Add necessary template files to container
RUN mkdir -p /etc/confd/{conf.d,templates}
RUN chmod 755 /etc/confd/{conf.d,templates}
# SSHD Config file
RUN curl https://raw.githubusercontent.com/jkritzen/myjumpbox/master/dockerfile/conf.d/sshd_config.tmpl -kso /etc/confd/templates/sshd_config.tmpl
RUN curl https://raw.githubusercontent.com/jkritzen/myjumpbox/master/dockerfile/conf.d/sshd_config.toml -kso /etc/confd/conf.d/sshd_config.toml

# sudoers config file
RUN curl https://raw.githubusercontent.com/jkritzen/myjumpbox/master/dockerfile/conf.d/sudoers_config.tmpl -kso /etc/confd/templates/sudoers_config.tmpl
RUN curl https://raw.githubusercontent.com/jkritzen/myjumpbox/master/dockerfile/conf.d/sudoers_config.toml -kso /etc/confd/conf.d/sudoers_config.toml

# Add start script
RUN curl https://raw.githubusercontent.com/jkritzen/myjumpbox/master/dockerfile/start.sh -kso /start.sh
RUN chmod 755 start.sh

CMD /start.sh


RUN mkdir -p /etc/confd/{conf.d,templates}
RUN chmod 777 /etc/confd/{conf.d,templates}

ADD https://raw.githubusercontent.com/jkritzen/myjumpbox/master/dockerfile/confd/userconfig.conf.tmpl /etc/confd/templates
ADD https://raw.githubusercontent.com/jkritzen/myjumpbox/master/dockerfile/confd/userconfig.toml /etc/confd/conf.d
ADD https://raw.githubusercontent.com/jkritzen/myjumpbox/master/dockerfile/confd/pubKeyConfig.conf.tmpl /etc/confd/templates
ADD https://raw.githubusercontent.com/jkritzen/myjumpbox/master/dockerfile/confd/pubKeyConfig.toml /etc/confd/conf.d

# Run any additional tasks here that are too tedious to put in
# this dockerfile directly.

# Called on first run of docker - will run supervisor
ADD https://raw.githubusercontent.com/jkritzen/myjumpbox/master/dockerfile/start.sh /start.sh
RUN chmod 777 /start.sh
    
CMD /start.sh
