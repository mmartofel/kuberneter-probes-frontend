# First stage builds the application
FROM registry.redhat.io/rhel8/nodejs-18:1-40 as builder

# Add application sources
# ADD . $HOME

COPY angular.json $HOME
COPY package.json $HOME
COPY proxy.conf.json $HOME
COPY src $HOME/src
COPY tsconfig.app.json $HOME
COPY tsconfig.json $HOME
COPY tsconfig.spec.json $HOME

# Install the dependencies
RUN npm install

# Second stage copies the application to the minimal image
FROM registry.redhat.io/rhel8/nodejs-18-minimal:1-40

# Copy the application source and build artifacts from the builder image to this one
COPY --from=builder $HOME $HOME

EXPOSE 4200

# Run script uses standard ways to run the application
CMD npm run -d start
