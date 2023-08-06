# Use Node.js 20 as the base image
FROM node:20

WORKDIR /root

# Install PostgreSQL client
RUN apt-get update && \
    apt-get install -y postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Add MongoDB official repository and install MongoDB shell and tools
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/debian bullseye/mongodb-org/5.0 main" | tee /etc/apt/sources.list.d/mongodb-org-5.0.list && \
    wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | apt-key add - && \
    apt-get update && \
    apt-get install -y mongodb-org-shell mongodb-org-tools && \
    rm -rf /var/lib/apt/lists/*

# Install MySQL client
RUN apt-get update && \
    apt-get install -y default-mysql-client && \
    rm -rf /var/lib/apt/lists/*

# Install the required dependencies
COPY package*.json ./
RUN npm install

# Copy the source code into the container
COPY . ./

# Entry point for the application
ENTRYPOINT ["node", "index.js"]