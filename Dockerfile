FROM ubuntu:22.10
LABEL maintainer="https://github.com/rastasheep"

RUN apt-get update

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd


RUN useradd --user-group --create-home --system mogenius
RUN echo 'root:root' |chpasswd


RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

RUN echo 'mogenius:mogenius' | chpasswd

CMD ["/usr/sbin/sshd", "-D", "-e"]







