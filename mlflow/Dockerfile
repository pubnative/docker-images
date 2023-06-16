ARG MLFLOW_VERSION="2.0.1"
FROM ghcr.io/mlflow/mlflow:v${MLFLOW_VERSION}

USER root

# Build dependencies
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        build-essential libpq-dev

# Pip dependencies
COPY ./requirements.txt ./requirements.txt
RUN pip install -r requirements.txt

# Port
EXPOSE 80

CMD mlflow server --host 0.0.0.0 --port 80 --backend-store-uri $BACKEND_STORE_URI