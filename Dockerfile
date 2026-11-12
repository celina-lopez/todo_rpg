# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.3.4
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim

# Rails app lives here
WORKDIR /rails

# Development environment (runs bin/dev so tailwind is built and watched)
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle" \
    BINDING="0.0.0.0" \
    PORT="3000"

# Install packages needed to build gems and run the app
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libvips \
    postgresql-client pkg-config libpq-dev \
    nodejs npm redis-server

COPY package.json ./
RUN npm install

# Install application gems (including development) and foreman for bin/dev
COPY Gemfile Gemfile.lock .ruby-version ./
RUN bundle install && gem install foreman

# Copy application code
COPY . .

# Run and own only the runtime files as a non-root user for security
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    mkdir -p app/assets/builds tmp log storage && \
    chown -R rails:rails db log storage tmp app/assets/builds public
USER 1000:1000

# bin/dev starts the rails server and the tailwind watcher (see Procfile.dev)
EXPOSE 3000
ENTRYPOINT ["./bin/dev"]
