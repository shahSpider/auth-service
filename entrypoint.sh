#!/bin/sh

# Apply database migrations
python manage.py migrate

# Create superuser if not exists
if [ -z "$DJANGO_SUPERUSER_USERNAME" ] || [ -z "$DJANGO_SUPERUSER_EMAIL" ] || [ -z "$DJANGO_SUPERUSER_PASSWORD" ]; then
    echo "Superuser env variables not set, skipping creation."
else
    python manage.py createsuperuser \
        --noinput \
        --username "$DJANGO_SUPERUSER_USERNAME" \
        --email "$DJANGO_SUPERUSER_EMAIL"
fi

# Start server
python manage.py runserver 0.0.0.0:8000
