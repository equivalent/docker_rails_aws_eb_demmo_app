FROM ruby:2.3.0

RUN mkdir /app
WORKDIR /app

CMD bundle &&  rails new archiveapp --database=postgresql --skip-test-unit
