
FROM starefossen/ruby-node:2-8-stretch
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
&& gem install bundler 

WORKDIR /Project

#ENV PORT 3000
#
#EXPOSE $PORT

RUN echo 'alias run="rm -f tmp/pids/server.pid && rm -f /usr/local/var/postgres/postmaster.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"' >> /root/.bashrc

ENTRYPOINT ["/bin/bash"]
