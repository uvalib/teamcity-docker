FROM jetbrains/teamcity-minimal-agent:latest

ENV AGENT_HOME /home/teamcity
RUN mkdir $AGENT_HOME
WORKDIR $AGENT_HOME

#
# install software needed by builds and deploys
#

# update the package list
RUN apt-get -y update

# install rvm
RUN \curl -sSL https://get.rvm.io | /bin/bash -s stable

# install ruby
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.3.3"

# install required build tools
RUN apt-get -y install git wget tar vim libmysqlclient-dev

# install java support tools
#RUN apt-get -y install ant maven

# install go
RUN wget -c https://storage.googleapis.com/golang/go1.7.4.linux-amd64.tar.gz
RUN tar -C /usr/local -xvzf go1.7.4.linux-amd64.tar.gz
RUN ln -s /lib/x86_64-linux-gnu/libdevmapper.so.1.02.1 /lib/x86_64-linux-gnu/libdevmapper.so.1.02

# install the deploy scripting and keys
RUN mkdir -p $AGENT_HOME/build-deploy-scripts
COPY build-deploy-scripts/ $AGENT_HOME/build-deploy-scripts

# install ssh configuration stuff
RUN mkdir /root/.ssh
COPY config/ssh-config /root/.ssh/config
COPY config/ssh-known_hosts /root/.ssh/known_hosts

# install dockerhub configuration stuf
RUN mkdir /root/.docker
COPY config/dockerhub-config.json /root/.docker/config.json

# install docker binary
COPY bin/docker /usr/local/bin/

# create command links
RUN ln -s /usr/local/go/bin/go /usr/local/bin/go
RUN ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt
