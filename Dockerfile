# syntax=docker/dockerfile:1

################################################################################
# Pick a base image to serve as the foundation for the other build stages in
# this file.

# Set production environment
# ENV RAILS_ENV="production" \
    # BUNDLE_DEPLOYMENT="1" \
    # BUNDLE_PATH="/usr/local/bundle" \
    # BUNDLE_WITHOUT="development"


# For illustrative purposes, the following FROM command
# is using the alpine image (see https://hub.docker.com/_/alpine).
# By specifying the "latest" tag, it will also use whatever happens to be the
# most recent version of that image when you build your Dockerfile.
# If reproducability is important, consider using a versioned tag
# (e.g., alpine:3.17.2) or SHA (e.g., alpine@sha256:c41ab5c992deb4fe7e5da09f67a8804a46bd0592bfdf0b1847dde0e0889d2bff).
FROM alpine:latest as base

# Create a stage for building/compiling the application.
#
# The following commands will leverage the "base" stage above to generate
# a "hello world" script and make it executable, but for a real application, you
# would issue a RUN command for your application's build process to generate the
# executable. For language-specific examples, take a look at the Dockerfiles in
# the Awesome Compose repository: https://github.com/docker/awesome-compose
FROM base as build
RUN echo -e '#!/bin/sh\n\
echo Hello world from $(whoami)! In order to get your application running in a container, take a look at the comments in the Dockerfile to get started.'\
> /bin/hello.sh
RUN chmod +x /bin/hello.sh

################################################################################
# Create a final stage for running your application.
#
# The following commands copy the output from the "build" stage above and tell
# the container runtime to execute it when the image is run. Ideally this stage
# contains the minimal runtime dependencies for the application as to produce
# the smallest image possible. This often means using a different and smaller
# image than the one used for building the application, but for illustrative
# purposes the "base" image is used here.

# Create a non-privileged user that the app will run under.
# See https://docs.docker.com/go/dockerfile-user-best-practices/
# more info : https://docs.docker.com/compose/rails/

# Image de base pour Ruby, utilisée pour l'application Rails.
FROM ruby:3.2.2

# Mise à jour des paquets et installation des dépendances nécessaires.
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Création et définition du répertoire de travail de l'application.
RUN mkdir /myapp
WORKDIR /myapp

## Install JavaScript dependencies
# ARG NODE_VERSION=20.5.1
# ARG YARN_VERSION=1.22.19
# ENV PATH=/usr/local/node/bin:$PATH
# RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
    # /tmp/node-build-master/bin/node-build "${NODE_VERSION}" /usr/local/node && \
    # npm install -g yarn@$YARN_VERSION && \
    # rm -rf /tmp/node-build-master


# Copie des fichiers Gemfile et Gemfile.lock pour installer les gems.
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install


## Install node modules
# COPY package.json yarn.lock ./
# RUN yarn install --frozen-lockfile


# Copie de l'ensemble du projet dans le répertoire de travail.
COPY . /myapp

# Précompilation des assets en mode production (si nécessaire)
# RUN RAILS_ENV=production rails assets:precompile

# Exposition du port sur lequel l'application tourne
EXPOSE 3000

# Commande pour lancer le serveur Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
