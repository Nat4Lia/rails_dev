
#FROM starefossen/ruby-node:2-8-stretch
FROM ruby
# Install the software you need
RUN apt-get update \
&& apt-get install -y \
apt-utils \
build-essential \
libpq-dev \
libjpeg-dev \
libpng-dev \
nodejs \
yarn \
sudo \
&& gem install bundler 

#RUN mkdir ~/node-latest-install && cd $_ && \
#RUN curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1 && \
#RUN make install && \ # takes a few minutes to build...
#RUN curl https://www.npmjs.org/install.sh | sh

RUN url -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

RUN sudo apt update && sudo apt install yarn

WORKDIR /Project

#ENV PORT 3000
#
#EXPOSE $PORT

RUN echo 'alias run="rm -f tmp/pids/server.pid && rm -f /usr/local/var/postgres/postmaster.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"' >> /root/.bashrc

USER root

RUN echo "root:root" | chpasswd

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

WORKDIR /Project



RUN chmod -R 777 /Project

# Add a non-root user to prevent files being created with root permissions on host machine.
ARG PUID=1000
ENV PUID ${PUID}
ARG PGID=1000
ENV PGID ${PGID}

# always run apt update when start and after add new source list, then clean up at end.
#RUN useradd -u ${PUID} -g users -m muhrizkiakbar && \
RUN useradd -m -s /bin/bash -G sudo muhrizkiakbar && \
    usermod -p "*" muhrizkiakbar && \
    echo "muhrizkiakbar:muhrizkiakbar" | chpasswd 

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers



RUN chown -R muhrizkiakbar:users /Project

USER muhrizkiakbar


ENTRYPOINT ["/bin/bash"]
