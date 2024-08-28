# Base image: Node.js with Alpine Linux
FROM node:20-alpine

# Install PostgreSQL, PgAdmin, and Python3 with necessary dependencies
RUN apk add --no-cache postgresql postgresql-contrib bash curl python3 py3-pip \
    && pip3 install --no-cache-dir -r /opt/pgadmin4/requirements.txt \
    && curl -sSL https://github.com/postgres/pgadmin4/releases/download/v6.15/pgadmin4-6.15-alpine3.14.tar.gz | tar xz -C /opt/ \
    && ln -s /opt/pgadmin4/web/pgAdmin4.py /usr/local/bin/pgadmin4

# Set up working directory
WORKDIR /app

# Copy necessary files
COPY . .

# Install Node.js dependencies
RUN npm install

# Make the setup script executable
RUN chmod +x setup.sh

# Expose ports
EXPOSE 420 80

# Default command to run the setup script
CMD ["./setup.sh"]
