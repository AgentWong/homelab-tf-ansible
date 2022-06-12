FROM alpine:latest
RUN apk update && \
    apk add terraform wget python3 py3-pip ansible bash krb5 krb5-pkinit \
    git gcc python3-dev krb5-dev libffi-dev musl-dev py3-wheel --no-cache && \
    wget -q https://github.com/gruntwork-io/terragrunt/releases/download/v0.37.2/terragrunt_linux_amd64 \
    -O /usr/bin/terragrunt && \
    chmod +x /usr/bin/terragrunt && \
    pip install --no-cache-dir pyvmomi pywinrm pywinrm[kerberos] && \
    pip install --no-cache-dir --upgrade pip setuptools && \
    pip install --no-cache-dir --upgrade git+https://github.com/vmware/vsphere-automation-sdk-python.git && \
    ansible-galaxy collection install community.windows && \
    apk del git gcc python3-dev krb5-dev libffi-dev musl-dev py3-wheel wget
RUN adduser -D -g "" -h /home/ubuntu \
    -u 1000 -s /bin/bash ubuntu