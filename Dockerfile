FROM ruby:2.3.0

WORKDIR /tmp
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock

RUN gem install bundler
RUN bundle install

RUN mkdir /app
WORKDIR /app

CMD rake db:migrate && puma
