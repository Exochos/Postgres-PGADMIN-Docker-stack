#!/bin/bash

# Prompt for admin username and password for PostgreSQL and PgAdmin
read -p "Enter the PostgreSQL username: " POSTGRES_USER
read -sp "Enter the PostgreSQL password: " POSTGRES_PASSWORD
echo
read -p "Enter the database name: " POSTGRES_DB
read -p "Enter the PgAdmin email: " PGADMIN_DEFAULT_EMAIL
read -sp "Enter the PgAdmin password: " PGADMIN_DEFAULT_PASSWORD
echo

# Create a .env file to store the credentials securely
cat <<EOF > .env
POSTGRES_USER=$POSTGRES_USER
POSTGRES_PASSWORD=$POSTGRES_PASSWORD
POSTGRES_DB=$POSTGRES_DB
PGADMIN_DEFAULT_EMAIL=$PGADMIN_DEFAULT_EMAIL
PGADMIN_DEFAULT_PASSWORD=$PGADMIN_DEFAULT_PASSWORD
EOF

# Export the variables for the current session
export POSTGRES_USER=$POSTGRES_USER
export POSTGRES_PASSWORD=$POSTGRES_PASSWORD
export POSTGRES_DB=$POSTGRES_DB
export PGADMIN_DEFAULT_EMAIL=$PGADMIN_DEFAULT_EMAIL
export PGADMIN_DEFAULT_PASSWORD=$PGADMIN_DEFAULT_PASSWORD

# Initialize PostgreSQL database
service postgresql start
su - postgres -c "psql -c \"CREATE USER $POSTGRES_USER WITH PASSWORD '$POSTGRES_PASSWORD';\""
su - postgres -c "psql -c \"CREATE DATABASE $POSTGRES_DB;\""
su - postgres -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER;\""

# Start PgAdmin in the background
python3 /opt/pgadmin4/web/pgAdmin4.py &

# Start the Node.js server
npm start
