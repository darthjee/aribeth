FROM ruby:2.4.0

WORKDIR /home/app/aribeth
RUN useradd -u 1000 app
RUN chown app.app /home/app
ADD Gemfile* /home/app/aribeth/

RUN apt-get update && apt-get install -y netcat nodejs-legacy npm mongodb-clients
RUN npm install bower -g
RUN gem install bundler
RUN bundle install --clean

USER app
