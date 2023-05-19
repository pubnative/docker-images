FROM python:3.8.10

# Build dependencies
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        build-essential libpq-dev

# Pip dependencies
COPY ./requirements.txt ./requirements.txt
RUN pip install -r requirements.txt

# Port
EXPOSE 80

CMD mlflow server --host 0.0.0.0 --port 80 --backend-store-uri postgresql://$DB_USER:$DB_PASSWORD@$DB_HOST:5432/mlflow