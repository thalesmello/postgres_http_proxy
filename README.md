# HTTP Proxy PostgreSQL

This pull request is based off the work of [spitzenidee's postgresql_base](https://github.com/spitzenidee/postgresql_base/).

This repository contains the docker image of a PostgreSQL with [pgsql-http](https://github.com/pramsey/pgsql-http), which allows for the PostgreSQL to make HTTP requests to using SQL queries.

The motivation is to be able to query an arbitrary endpoint, produce a resultset and make it available via [Metabase](https://github.com/metabase/metabase/). In my context, because I mostly use AWS RDS, which doesn't support the pgsql-http extension, a stateless PostgreSQL container with this extension loaded would be convenient to act as a proxy for HTTP endpoints, just so they are available in Metabase.

Notice there is an [issue](https://github.com/metabase/metabase/issues/4831) discussing a direct HTTP API source for metabase.

# Customization

In order to curtomize the timeout of the HTTP requests, you can set the environment variable `HTTP_TIMEOUT_MS`.

All the environment variables from the underlying PostgreSQL image are also valid, such as `POSTGRES_PASSWORD`.
