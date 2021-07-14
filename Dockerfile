FROM alpine:latest

RUN apk --no-cache add curl bash

RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-v3.6.2-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm

RUN wget https://dl.minio.io/client/mc/release/linux-amd64/mc \
    && chmod +x mc \
    && mv mc /usr/local/bin

COPY ["migrations/minio-migration.sh", "populate-kubeconfig.sh", "./" ]

RUN chmod +x minio-migration.sh

ENTRYPOINT ["./minio-migration.sh"]
