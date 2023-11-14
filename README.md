# stats19

## Building the `stats19.db` database

```sh
./1-install-prerequisites.sh; \
    ./2-download-stats19.sh && \
    ./3-preprocess-data.sh && \
    ./4-create-tables.sh && \
    ./5-import-data.sh && \
    ./6-test-import.sh | tappy
```

## Bundling the `stats19.db` and `datasette` into a docker image

```sh
docker build --tag stats19:latest .
```

## Create and run the stats19 docker container

```sh
docker run --detach --publish 8001:8001 stats19:latest
```

## Licenses

Unless stated otherwise, the `stats19` project and `stats19.db`
database is licensed under [CC BY 4.0](LICENSE.md).

The `stats19.db` database contains public sector information from the
Department for Transport licensed under the
[Open Government Licence v3.0](OGL-3.0.md).
