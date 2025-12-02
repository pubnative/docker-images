FROM python:3.11-slim-trixie
COPY --from=ghcr.io/astral-sh/uv:0.9.10 /uv /uvx /bin/

LABEL maintainer="Sergey Tarabara"

ENV PYTHONWARNINGS ignore
ENV PATH "/home/dbt/.local/bin:$PATH"

# Install system dependencies and create non-root user
RUN apt-get update \
    && apt-get install -qq -y git openssh-client gcc build-essential libpq-dev curl zip unzip --fix-missing --no-install-recommends \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && useradd -m -u 10001 -s /bin/bash dbt

WORKDIR /home/dbt

ADD --chown=dbt:dbt ./home/ /home/dbt/

USER dbt

RUN uv sync \
    && mkdir /home/dbt/.dbt && mv /home/dbt/profiles.yml /home/dbt/.dbt/ \
    && chmod +x /home/dbt/run-dbt.sh

ENTRYPOINT ["/bin/bash", "/home/dbt/run-dbt.sh"]



