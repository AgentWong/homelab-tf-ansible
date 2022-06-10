FROM alpine:latest
RUN apk update && \
    apk add terraform terragrunt vault --no-cache
WORKDIR /project