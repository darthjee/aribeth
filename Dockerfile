FROM darthjee/taa:0.0.1

WORKDIR /home/app
ADD Gemfile* /home/app/

USER root
RUN bundle install --clean

USER app
