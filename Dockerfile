FROM jenkins/jenkins:2.346.2-lts-jdk11

USER root
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add
RUN apt-get update
RUN apt-get install -y sbt
RUN apt-get install -y make
RUN apt-get install -y ruby-full
RUN apt-get install -y wget
RUN apt-get install -y time
RUN apt-get install -y python
RUN apt-get install -y python3
RUN gem install rake
RUN gem install neocities

RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
RUN chmod a+rx /usr/local/bin/yt-dlp

# docker install
RUN curl -fsSL https://get.docker.com -o get-docker.sh
RUN sh get-docker.sh

# user jenkins is allowed to run docker
# RUN groupadd docker
RUN usermod -aG docker jenkins

RUN wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
RUN chmod a+rx /usr/local/bin/youtube-dl
RUN youtube-dl -U

# drop back to the regular jenkins user - good practice
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.6 docker-workflow:1.29"
