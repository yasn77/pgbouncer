FROM alpine:3.16 AS EXPORTER

RUN apk add curl
RUN curl -L -o - https://github.com/prometheus-community/pgbouncer_exporter/releases/download/v0.5.1/pgbouncer_exporter-0.5.1.linux-amd64.tar.gz | tar --strip-components 1 -zxvf -


FROM alpine:3.16
RUN apk add pgbouncer=1.17.0-r0
COPY --from=EXPORTER /pgbouncer_exporter /usr/bin/pgbouncer_exporter
COPY entrypoint.sh /entrypoint.sh
EXPOSE 5432
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/pgbouncer", "/etc/pgbouncer/pgbouncer.ini"]
