#!/bin/bash

# Expect the following definitions:
# - POSTGRES_HOST
# - POSTGRES_PORT
# - POSTGRES_ADMIN_USER
# - POSTGRES_ADMIN_PASSWORD
# - GHOSTFOLIO_DB_NAME
# - GHOSTFOLIO_DB_USER
# - GHOSTFOLIO_DB_PASSWORD
. ./.setup.env

# Setup script for Ghostfolio database on external PostgreSQL server
# This script will create a database and user for Ghostfolio

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "=== Setting up Ghostfolio database on ${POSTGRES_HOST} ==="

# Check if PostgreSQL is reachable
if ! pg_isready -h ${POSTGRES_HOST} -p ${POSTGRES_PORT}; then
    echo -e "${RED}Error: PostgreSQL server at ${POSTGRES_HOST}:${POSTGRES_PORT} is not reachable.${NC}"
    exit 1
fi

# Create database and user
PGPASSWORD=${POSTGRES_ADMIN_PASSWORD} psql -h ${POSTGRES_HOST} -p ${POSTGRES_PORT} -U ${POSTGRES_ADMIN_USER} << EOF
-- Create user if it doesn't exist
DO \$\$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = '${GHOSTFOLIO_DB_USER}') THEN
        CREATE USER ${GHOSTFOLIO_DB_USER} WITH ENCRYPTED PASSWORD '${GHOSTFOLIO_DB_PASSWORD}';
    END IF;
END
\$\$;

-- Create database if it doesn't exist
SELECT 'CREATE DATABASE ${GHOSTFOLIO_DB_NAME}' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '${GHOSTFOLIO_DB_NAME}')\gexec

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE ${GHOSTFOLIO_DB_NAME} TO ${GHOSTFOLIO_DB_USER};
ALTER DATABASE ${GHOSTFOLIO_DB_NAME} OWNER TO ${GHOSTFOLIO_DB_USER};
EOF

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Successfully created database and user for Ghostfolio.${NC}"
else
    echo -e "${RED}Failed to create database and user. Please check your credentials and try again.${NC}"
    exit 1
fi

# Create .env file for Ghostfolio
cat > .env << EOF
# Database configuration
DATABASE_URL=postgresql://${GHOSTFOLIO_DB_USER}:${GHOSTFOLIO_DB_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${GHOSTFOLIO_DB_NAME}?sslmode=prefer

# Redis configuration
REDIS_HOST=key.home
#REDIS_PASSWORD=your_secure_password
REDIS_PORT=6379

# JWT Secret - generate a random string for security
JWT_SECRET_KEY=$(openssl rand -hex 32)

# Access Token Expiry (in seconds)
ACCESS_TOKEN_EXPIRES_IN=900

# Feature flags
ENABLE_FEATURE_SUBSCRIPTION=false
ENABLE_FEATURE_READONLY_MODE=false

# Default language
DEFAULT_LANGUAGE=en

# Default currency
DEFAULT_CURRENCY=USD

# Base URL
BASE_URL=https://ghost.home
PORT=80
ACCESS_TOKEN_SALT=$(openssl rand -hex 16)
EOF

echo -e "${GREEN}Created .env file with necessary configuration.${NC}"
echo -e "${GREEN}Remember to update the Redis password and any other settings in the .env file!${NC}"
echo -e "${GREEN}Setup complete! You can now start Ghostfolio with 'docker-compose up -d'${NC}"
