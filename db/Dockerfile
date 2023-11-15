# dump build stage
FROM --platform=amd64 postgres:13.5 as dumper

# Copy the SQL script to a directory in the container
COPY rates.sql /docker-entrypoint-initdb.d/

RUN ["sed", "-i", "s/exec \"$@\"/echo \"skipping...\"/", "/usr/local/bin/docker-entrypoint.sh"]

ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV PGDATA=/data

RUN ["/usr/local/bin/docker-entrypoint.sh", "postgres"]

# final build stage

FROM --platform=amd64 postgres:13.5

COPY --from=dumper /data $PGDATA