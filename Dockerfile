FROM ruby:3.2.2
RUN apt-get update -qq && apt-get install -y postgresql-client
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN bundler install

EXPOSE 3000