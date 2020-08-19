
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


ENTRYPOINT ["/bin/bash"]
