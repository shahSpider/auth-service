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

# Start Daphne ASGI server
daphne -b 0.0.0.0 -p 8000 auth_app.asgi:application
