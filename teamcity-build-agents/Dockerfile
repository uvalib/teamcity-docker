FROM jetbrains/teamcity-minimal-agent:2018.2.2

ENV AGENT_HOME /home/teamcity
RUN mkdir $AGENT_HOME
WORKDIR $AGENT_HOME

#
# install software needed by builds and deploys
#

# update the package list
RUN apt-get -y update && apt-get install -y apt-transport-https software-properties-common tzdata

# install openjdk ppa for ancient java 7
#RUN add-apt-repository ppa:openjdk-r/ppa && apt-get -y update

# install required build tools / nokogiri compatibility
RUN apt-get install -y libxslt-dev libxml2-dev libcurl3-dev git wget tar vim zip libmysqlclient-dev libltdl7 rsync --fix-missing

# install development support tools
RUN apt-get update && apt-get install -y cmake maven nasm

# install rvm
RUN \curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN \curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
RUN \curl -sSL https://get.rvm.io | /bin/bash -s stable

# install ruby
RUN /bin/bash -l -c "rvm requirements ruby-2.4.3"
RUN /bin/bash -l -c "rvm install 2.4.3"

# install go
RUN wget -c https://storage.googleapis.com/golang/go1.11.5.linux-amd64.tar.gz
RUN tar -C /usr/local -xvzf go1.11.5.linux-amd64.tar.gz && rm go1.11.5.linux-amd64.tar.gz
RUN ln -s /lib/x86_64-linux-gnu/libdevmapper.so.1.02.1 /lib/x86_64-linux-gnu/libdevmapper.so.1.02

# create golang command links
RUN ln -s /usr/local/go/bin/go /usr/local/bin/go && ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt

# install docker binary
COPY bin/docker-17.09.1 /usr/local/bin/docker

# install docker-compose
RUN wget -c -O /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` && chmod +x /usr/local/bin/docker-compose

# install nodejs
RUN \curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update && apt-get install -y nodejs

# install yarn
RUN \curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN \echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn

# install vue-cli
RUN npm install -g @vue/cli && npm install -g @vue/cli-service

# install python3 version of pip (pip3)
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py && rm get-pip.py

# instal Ansible
RUN apt-get update && apt-get install -y ansible

# instal tools for AWS
RUN apt-get update && apt-get install -y awscli

# install terraform binary
COPY bin/terraform-0.11.11 /usr/local/bin/terraform

# install ssh configuration stuff
RUN mkdir /root/.ssh
COPY config/ssh-config /root/.ssh/config
COPY config/ssh-known_hosts /root/.ssh/known_hosts

# install the deploy scripting and keys
RUN mkdir -p $AGENT_HOME/build-deploy-scripts
COPY build-deploy-scripts/ $AGENT_HOME/build-deploy-scripts
RUN chmod 600 build-deploy-scripts/keys/*_deploy

#
# end of file
#
