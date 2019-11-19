FROM registry.access.redhat.com/rhel7/rhel

RUN useradd -d /opt/minio -g root minio

WORKDIR /opt/minio

ADD entrypoint.sh .

RUN curl -o minio https://dl.minio.io/server/minio/release/linux-amd64/minio && \
    curl -o mc https://dl.minio.io/client/mc/release/linux-amd64/mc && \
    chmod +x minio && \
    chmod +x mc && \
    mkdir data  && \
    chown minio:root -R . && chmod 777 -R .

USER minio

ENV MINIO_ACCESS_KEY="demoaccesskey"
ENV MINIO_SECRET_KEY="mysecret"
ENV MINIO_BIN=/opt/minio/minio
ENV MINIO_MODE="server"
ENV MINIO_DATA_DIR=/opt/minio/data

VOLUME $MINIO_DATA_DIR

EXPOSE 9000

ENTRYPOINT [ "./entrypoint.sh" ]
