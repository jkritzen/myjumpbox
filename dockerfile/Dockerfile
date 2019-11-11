FROM fedora:latest

#-------------Application Specific Stuff ----------------------------------------------------
# Open port 22 so linked containers can see it
EXPOSE 22

# Add Users & ssh public keys
RUN \
  passwd -d root && \
  adduser -D -s /bin/bash jkritzen && \
  passwd -u jkritzen && \
  chown -R jkritzen:jkritzen /home/jkritzen && \

ADD https://github.com/sickp.keys /home/sickp/.ssh/authorized_keys


# Run any additional tasks here that are too tedious to put in
# this dockerfile directly.
ADD setup.sh /setup.sh
RUN chmod 0755 /setup.sh
RUN /setup.sh

# Called on first run of docker - will run supervisor
ADD start.sh /start.sh
RUN chmod 0755 /start.sh

CMD /start.sh
