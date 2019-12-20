FROM alpine:3.7

MAINTAINER Viktor Farcic <viktor@farcic.com>

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/vfarcic/kubectl" \
      org.label-schema.docker.dockerfile="/Dockerfile"

ENV HELM_LATEST_VERSION v3.0.2
ENV KUBE_LATEST_VERSION v1.16.4

RUN apk add -U ca-certificates git curl && \
    apk add -U -t deps curl && \
    curl -o helm.tar.gz https://get.helm.sh/helm-v3.0.2-linux-amd64.tar.gz && \
    tar -xvf helm.tar.gz && \
    mv linux-amd64/helm /usr/local/bin && \
    chmod +x /usr/local/bin/helm && \
    rm -rf linux-amd64 && \
    rm helm.tar.gz && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    apk del --purge deps && \
    rm /var/cache/apk/*
