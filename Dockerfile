FROM darthjee/taa:0.2.3

USER root
RUN apt-get update && apt-get install -y mongodb-clients
USER app

COPY --chown=app:app Gemfile* /home/app/app/

RUN bundle install --clean

