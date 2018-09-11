#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE EXTENSION http;
    ALTER DATABASE SET http.timeout_ms = $HTTP_TIMEOUT_MS;
EOSQL
