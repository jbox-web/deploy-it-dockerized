FROM ruby:2.2.0
MAINTAINER Nicolas Rodriguez "nrodriguez@jbox-web.com"

RUN apt-get update -qq
RUN apt-get upgrade -y
RUN apt-get install -y apt-utils apt-transport-https
RUN apt-get install -y gawk sqlite3 libgdbm-dev bison libssh2-1 libssh2-1-dev cmake libgpg-error-dev
RUN apt-get install -y daemontools runit sudo
RUN apt-get install -y python-setuptools python-dev
RUN apt-get install -y nginx

# Install docker command
RUN echo 'deb https://get.docker.io/ubuntu docker main' >> /etc/apt/sources.list
RUN wget -qO- https://get.docker.com/gpg | apt-key add -
RUN apt-get update -qq
RUN apt-get install -y lxc-docker

# Install OpenSSH
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# Install Ansible
RUN easy_install pip
RUN pip install ansible

# Add deploy-it user to run the application and
# add it to docker_env group to be able to access to loaded environment variables
RUN useradd -ms /bin/bash deploy-it
RUN groupadd -g 8377 docker_env
RUN usermod -a -G docker_env deploy-it
RUN usermod -a -G docker deploy-it

# Install environment files
RUN mkdir -p /etc/container_environment
RUN chmod 700 /etc/container_environment

RUN touch /etc/container_environment.sh
RUN touch /etc/container_environment.json

RUN chown :docker_env /etc/container_environment.sh
RUN chown :docker_env /etc/container_environment.json

RUN chmod 640 /etc/container_environment.sh
RUN chmod 640 /etc/container_environment.json

RUN ln -s /etc/container_environment.sh /etc/profile.d/

# Set Timezone
RUN cp /usr/share/zoneinfo/Europe/Paris /etc/localtime
RUN echo 'Europe/Paris' > /etc/timezone

# Set user install for gem
RUN echo 'gem: --user-install' > /etc/gemrc

# Install my_init
ADD bin/my_init /sbin/my_init
RUN chmod +x /sbin/my_init
RUN mkdir -p /etc/my_init.d
