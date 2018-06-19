FROM darthjee/rails_bower

WORKDIR /home/app/aribeth
ADD Gemfile* /home/app/aribeth/

RUN bundle install --clean

USER app
