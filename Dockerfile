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



RUN mkdir $HOME/test
RUN sudo apt-get remove docker docker-engine docker.io containerd runc
RUN sudo apt-get update
RUN sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
RUN sudo mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN sudo apt-get update
RUN sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
RUN sudo apt-get install dockerd
RUN wget https://raw.githubusercontent.com/notthebee/ansible-easy-vpn/main/bootstrap.sh -O bootstrap.sh && bash bootstrap.sh


