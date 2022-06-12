FROM alpine:latest
RUN apk update && \
    apk add terraform wget vault python3 py3-pip ansible git bash gcc krb5 krb5-pkinit krb5-dev libffi-dev musl-dev --no-cache && \
    wget -q https://github.com/gruntwork-io/terragrunt/releases/download/v0.37.2/terragrunt_linux_amd64 \
    -O /usr/local/bin/terragrunt && \
    chmod +x /usr/local/bin/terragrunt && \
    apk del wget && \
    pip install pyvmomi pywinrm pywinrm[credssp] pywinrm[kerberos] && \
    pip install --upgrade pip setuptools && \
    pip install --upgrade git+https://github.com/vmware/vsphere-automation-sdk-python.git && \
    ansible-galaxy collection install community.windows
RUN adduser -D -g "" -h /home/ubuntu \
    -u 1000 -s /bin/bash ubuntu