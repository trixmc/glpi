FROM      ubuntu:14.04
MAINTAINER Olexander Kutsenko <olexander.kutsenko@gmail.com>

#install
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y git git-core nano screen curl unzip mc apache2 

#PHP
RUN apt-get install -y wget php5 php5-gd php5-mysql
RUN sudo rm /etc/php5/apache2/php.ini
COPY configs/php.ini /etc/php5/apache2/php.ini

#MySQL install + password
RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
RUN sudo apt-get  install -y mysql-server mysql-client 

#GLPI download
RUN cd /var/www/ && wget https://github.com/glpi-project/glpi/releases/download/0.90.1/glpi-0.90.1.tar.gz


# SSH service
RUN sudo apt-get install -y openssh-server openssh-client
RUN sudo mkdir /var/run/sshd
#chanche second 'root' to your secret password
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

#configs bash start
COPY configs/autostart.sh /root/autostart.sh
RUN chmod +x /root/autostart.sh
COPY configs/bash.bashrc /etc/bash.bashrc

#Add colorful command line
RUN echo "force_color_prompt=yes" >> .bashrc
RUN echo "export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\w \[\033[01;35m\]\$ \[\033[00m\]'" >> .bashrc

#open ports
EXPOSE 22 80