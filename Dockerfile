# Base image: Node.js with Alpine Linux
FROM node:20-alpine

# Install PostgreSQL, Python3, and necessary dependencies
RUN apk add --no-cache \
    gcc \
    musl-dev \
    linux-headers \
    postgresql \
    postgresql-contrib \
    bash \
    curl \
    python3 \
    py3-pip \
    python3-dev \
    && python3 -m venv /opt/pgadmin_venv \
    && /opt/pgadmin_venv/bin/pip install --no-cache-dir pgadmin4 \
    && ln -s /opt/pgadmin_venv/bin/pgadmin4 /usr/local/bin/pgadmin4
    
WORKDIR /app
COPY . .

RUN yarn install

EXPOSE 420 80

# Default command to run the setup script
RUN chmod +x setup.sh
CMD ["./setup.sh"]
