FROM alpine:latest
RUN apk update && \
    apk add terraform wget vault --no-cache && \
    wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.37.2/terragrunt_linux_amd64 > /dev/null \
    -O /usr/local/bin/terragrunt && \
    chmod +x /usr/local/bin/terragrunt &&\
    apk del wget
WORKDIR /project