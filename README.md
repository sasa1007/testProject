docker-compose up -d
docker attach dev_test_project
php -S localhost:8000
php -S localhost:8080 -t public/

