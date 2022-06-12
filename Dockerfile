FROM alpine:latest
RUN apk add --no-cache terraform python3 ansible bash krb5 krb5-pkinit && \
    apk add --no-cache --virtual temporary wget py3-pip git gcc python3-dev krb5-dev libffi-dev musl-dev py3-wheel && \
    wget -q https://github.com/gruntwork-io/terragrunt/releases/download/v0.37.2/terragrunt_linux_amd64 \
    -O /usr/bin/terragrunt && \
    chmod +x /usr/bin/terragrunt && \
    pip install pyvmomi pywinrm pywinrm[kerberos] && \
    pip install --upgrade pip setuptools && \
    pip install --upgrade git+https://github.com/vmware/vsphere-automation-sdk-python.git && \
    ansible-galaxy collection install community.windows && \
    apk del temporary
RUN adduser -D -g "" -h /home/ubuntu \
    -u 1000 -s /bin/bash ubuntu