#!/bin/bash

# Build and start the docker containers
docker-compose up -d --build

# Wait for the services to be up
sleep 10

# Run composer to create the Laravel project
docker-compose run --rm composer create-project laravel/laravel .

# Copy .env.example to .env
cp src/.env.example src/.env

# Update the .env file with PostgreSQL database settings
sed -i 's/DB_CONNECTION=mysql/DB_CONNECTION=pgsql/g' src/.env
sed -i 's/DB_HOST=127.0.0.1/DB_HOST=postgres/g' src/.env
sed -i 's/DB_PORT=3306/DB_PORT=5432/g' src/.env
sed -i 's/DB_DATABASE=laravel/DB_DATABASE=laravel/g' src/.env
sed -i 's/DB_USERNAME=root/DB_USERNAME=laravel/g' src/.env
sed -i 's/DB_PASSWORD=/DB_PASSWORD=secred/g' src/.env

# Generate Laravel application key
docker-compose run --rm artisan key:generate

# Set appropriate permissions
sudo chown -R $USER:$USER src

# Restart the containers
docker-compose restart
