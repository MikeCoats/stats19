FROM python:slim

RUN pip install --no-cache-dir --upgrade datasette

RUN groupadd -r stats19 && useradd --no-log-init -r -g stats19 stats19
RUN mkdir -p /srv/stats19 && chown stats19:stats19 /srv/stats19
USER stats19:stats19
WORKDIR /srv/stats19

COPY ./stats19.db .
COPY ./metadata.json .
RUN datasette inspect stats19.db >inspect.json

EXPOSE 8001

CMD ["datasette", \
    "--host", "0.0.0.0", \
    "--port", "8001", \
    "--inspect-file", "inspect.json", \
    "--metadata", "metadata.json", \
    "--cors", "--nolock", \
    "--immutable", "stats19.db" \
]
