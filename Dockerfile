# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.8-slim-buster

EXPOSE 8000

WORKDIR /app

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Dependencies for python-ldap (based on openLDAP) and psycopg2
RUN apt-get update && apt-get upgrade -y && apt-get install -y python-dev libldap2-dev libsasl2-dev libssl-dev libpq-dev build-essential curl && \
    apt-get install -y nano && \
    echo "Installing Azure CLI" && \
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash



# Install pip requirements.txt
COPY requirements.txt .
RUN python -m pip install --upgrade pip && python -m pip install --no-deps -r requirements.txt && echo "COMPLETE"

COPY . .

RUN cat entrypoint.sh

# User stuffs
ARG UID
ARG GID
RUN groupadd azure -g 1003 && useradd azure -u 1003 -g azure
USER azure

ARG DC_APP_PORT
HEALTHCHECK --interval=30m --timeout=10s --retries=3 --start-period=1m \
    CMD curl -f -k http://localhost:$DC_APP_PORT || exit 1

ENTRYPOINT ["sh", "entrypoint.sh"]
