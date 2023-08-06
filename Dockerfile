# Use the official Node.js image as a build image
FROM node:20 AS build

WORKDIR /root

# Install the required dependencies
COPY package*.json ./
RUN npm install

# Copy the source code into the container
COPY . ./

# Use Node.js LTS as the final base image
FROM node:20

WORKDIR /root

# Install PostgreSQL, MongoDB, and MySQL client
RUN apt-get update && \
    apt-get install -y postgresql-client \
                       mongodb-clients \
                       mysql-client \
                       && rm -rf /var/lib/apt/lists/*

# Copy the built application from the build image
COPY --from=build /root/node_modules ./node_modules
COPY --from=build /root/ ./

# Entry point for the application
ENTRYPOINT ["node", "index.js"]