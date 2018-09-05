FROM postgres:10.4
MAINTAINER Thales Mello <thales.mello@pagar.me>

#######################################################################
# Based off: https://github.com/spitzenidee/postgresql_base/
#######################################################################

#######################################################################
# Prepare ENVs
ENV PGSQL_HTTP_VERSION        "1.2.4"

#######################################################################
# Prepare the build requirements for the rdkit compilation:
RUN apt-get update && apt-get install -y --no-install-recommends \
    postgresql-server-dev-all postgresql-contrib \
    libcurl4-openssl-dev \
    wget jq cmake build-essential ca-certificates && \
# Install PGSQL_HTTP:
    mkdir /build && \
    cd /build && \
    wget https://github.com/pramsey/pgsql-http/archive/v$PGSQL_HTTP_VERSION.tar.gz && \
    tar xzvf v$PGSQL_HTTP_VERSION.tar.gz && \
    cd pgsql-http-$PGSQL_HTTP_VERSION && \
    make && \
    make install && \
# Clean up again:
    cd / && \
    rm -rf /build && \
    apt-get remove -y wget jq cmake build-essential ca-certificates && \
    apt-get autoremove --purge -y && \
    apt-get clean && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/*

COPY ./docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
