FROM alpine:latest

WORKDIR /tmp

RUN apk --no-cache add curl bash

RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

RUN wget https://dl.minio.io/client/mc/release/linux-amd64/mc \
    && chmod +x mc \
    && mv mc /usr/local/bin

COPY migration.sh .

RUN chmod +x migration.sh

ENTRYPOINT ["./migration.sh"]
