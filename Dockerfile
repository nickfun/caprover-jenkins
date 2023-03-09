FROM jenkins/jenkins:2.346.2-lts-jdk11

USER root
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add
RUN add-apt-repository ppa:yt-dlp/stable
RUN apt-get update
RUN apt-get install -y sbt
RUN apt-get install -y make
RUN apt-get install -y ruby-full
RUN apt-get install -y wget
RUN apt-get install -y time
RUN apt-get install -y python
RUN apt install -y yt-dlp 
RUN gem install rake
RUN gem install neocities

# docker install
RUN apt-get update && apt-get install -y apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli

# user jenkins is allowed to run docker
RUN groupadd docker
RUN usermod -aG docker jenkins

RUN wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
RUN chmod a+rx /usr/local/bin/youtube-dl
RUN youtube-dl -U

# drop back to the regular jenkins user - good practice
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.6 docker-workflow:1.29"
