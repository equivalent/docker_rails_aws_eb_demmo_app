FROM ruby:2.3.0

RUN mkdir /app
WORKDIR /app

ENV BUNDLE_PATH /box-bundle

CMD (bundle check || bundle install) \
  && bundle exec rake db:migrate \
  && bundle exec puma -C /app/config/puma.rb
