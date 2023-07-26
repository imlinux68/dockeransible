FROM ubuntu:22.04

RUN apt update && \
    apt install sudo openssh-server -y

RUN echo 'root:password' | chpasswd

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

RUN mkdir /root/.ssh

COPY docker.pub /root/.ssh/

RUN cat /root/.ssh/docker.pub >> /root/.ssh/authorized_keys

RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]