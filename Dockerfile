FROM alpine:3

ENV USER=appuser
ENV UID=1000
ENV GID=1000

RUN set -e; \
    apk add --no-cache \
        ca-certificates \
        jq \
        kubectl; \
    \
    addgroup -g $GID $USER && \
    adduser \
        --disabled-password \
        --gecos "" \
        --home "/tmp" \
        --ingroup "$USER" \
        --no-create-home \
        --uid "$UID" \
        "$USER"

COPY wait_for.sh /usr/local/bin/wait_for.sh

USER $USER

ENTRYPOINT ["wait_for.sh"]
