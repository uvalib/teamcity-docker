FROM jetbrains/teamcity-minimal-agent:latest

ENV AGENT_HOME /home/teamcity
RUN mkdir $AGENT_HOME
WORKDIR $AGENT_HOME

#
# install software needed by builds and deploys
#

# update the package list
RUN apt-get -y update && apt-get install -y apt-transport-https software-properties-common

# install openjdk ppa for ancient java 7
RUN add-apt-repository ppa:openjdk-r/ppa && apt-get -y update

# install required build tools / nokogiri compatibility
RUN apt-get install -y libxslt-dev libxml2-dev libcurl3-dev git wget tar vim libmysqlclient-dev libltdl7 openjdk-7-jdk --fix-missing

# install java support tools
RUN apt-get install -y maven

# install rvm
RUN \curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN \curl -sSL https://get.rvm.io | /bin/bash -s stable

# install ruby
RUN /bin/bash -l -c "rvm requirements ruby-1.9.3-p551 ruby-2.4.3"
RUN /bin/bash -l -c "rvm install ruby-1.9.3-p551"
RUN /bin/bash -l -c "rvm install 2.4.3"


# install go
RUN wget -c https://storage.googleapis.com/golang/go1.10.linux-amd64.tar.gz
RUN tar -C /usr/local -xvzf go1.10.linux-amd64.tar.gz && rm go1.10.linux-amd64.tar.gz
RUN ln -s /lib/x86_64-linux-gnu/libdevmapper.so.1.02.1 /lib/x86_64-linux-gnu/libdevmapper.so.1.02

# install the deploy scripting and keys
RUN mkdir -p $AGENT_HOME/build-deploy-scripts
COPY build-deploy-scripts/ $AGENT_HOME/build-deploy-scripts
RUN chmod 600 build-deploy-scripts/keys/*_deploy

# install ssh configuration stuff
RUN mkdir /root/.ssh
COPY config/ssh-config /root/.ssh/config
COPY config/ssh-known_hosts /root/.ssh/known_hosts

# install .docker configuration stuf
RUN mkdir /root/.docker
COPY config/dotdocker-config.json /root/.docker/config.json

# install docker binary
COPY bin/docker /usr/local/bin/

# install docker-compose
RUN wget -c -O /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` && chmod +x /usr/local/bin/docker-compose

# create command links
RUN ln -s /usr/local/go/bin/go /usr/local/bin/go && ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt
