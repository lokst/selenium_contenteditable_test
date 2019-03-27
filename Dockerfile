FROM ubuntu:latest
RUN apt-get -qqy update \
  && apt-get -qqy --no-install-recommends install \
    bzip2 \
    ca-certificates \
    openjdk-8-jre-headless \
    tzdata \
    sudo \
    unzip \
    wget \
    jq \
    curl \
    supervisor \
    gnupg2
# Install VNC dependencies
RUN sudo apt-get install -y x11vnc
RUN sudo apt-get install -y xvfb ratpoison xterm net-tools xauth
RUN sudo apt-get -y --reinstall install xfonts-base
# Install Firefox and GeckoDriver
RUN sudo apt-get install -y firefox
ARG GECKODRIVER_VERSION=latest
RUN GK_VERSION=$(if [ ${GECKODRIVER_VERSION:-latest} = "latest" ]; then echo "0.24.0"; else echo $GECKODRIVER_VERSION; fi) \
  && echo "Using GeckoDriver version: "$GK_VERSION \
  && wget --no-verbose -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v$GK_VERSION/geckodriver-v$GK_VERSION-linux64.tar.gz \
  && rm -rf /opt/geckodriver \
  && tar -C /opt -zxf /tmp/geckodriver.tar.gz \
  && rm /tmp/geckodriver.tar.gz \
  && mv /opt/geckodriver /opt/geckodriver-$GK_VERSION \
  && chmod 755 /opt/geckodriver-$GK_VERSION \
  && ln -fs /opt/geckodriver-$GK_VERSION /usr/bin/geckodriver

RUN sudo apt-get install -y ruby
# Needed for nokogiri
RUN sudo apt-get install -y build-essential patch ruby-dev zlib1g-dev liblzma-dev
RUN sudo gem install bundler -v '1.16.2'
COPY app /app
RUN mkdir /dummy_server
COPY test.html /dummy_server/
RUN cd /app && bundle install --path vendor/bundle
COPY entrypoint.sh /bin/entrypoint.sh
ENTRYPOINT ["/bin/entrypoint.sh"]