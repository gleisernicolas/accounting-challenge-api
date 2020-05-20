FROM ruby:2.7.0-alpine
RUN apk update && apk upgrade && \
apk add ruby ruby-json ruby-io-console ruby-bundler ruby-irb ruby-bigdecimal tzdata && \
apk add nodejs && \
apk add curl-dev ruby-dev build-base libffi-dev && \
apk add build-base libxslt-dev libxml2-dev ruby-rdoc mysql-dev sqlite-dev

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

# Add a script to be executed every time the container starts.
COPY startup.sh /usr/bin/
RUN chmod +x /usr/bin/startup.sh
ENTRYPOINT ["startup.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]