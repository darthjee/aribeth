FROM darthjee/taa:0.0.2

RUN apt-get update && apt-get install -y mongodb-clients

WORKDIR /home/app
ADD Gemfile* /home/app/

USER root
RUN bundle install --clean

USER app
