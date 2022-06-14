FROM cytopia/ansible:latest
RUN apk add --no-cache terraform py3-setuptools bash krb5 krb5-pkinit && \
    apk add --no-cache --virtual temporary wget py3-pip git gcc python3-dev krb5-dev libffi-dev musl-dev py3-wheel unzip && \
    wget -q https://github.com/gruntwork-io/terragrunt/releases/download/v0.37.2/terragrunt_linux_amd64 \
    -O /usr/bin/terragrunt && \
    chmod +x /usr/bin/terragrunt && \
    wget -q https://releases.hashicorp.com/terraform/1.2.2/terraform_1.2.2_linux_amd64.zip && \
    unzip terraform_1.2.2_linux_amd64.zip && rm terraform_1.2.2_linux_amd64.zip && \
    mv terraform /usr/local/bin/terraform && \
    pip install --no-cache-dir --upgrade pip setuptools && \
    pip install --no-cache-dir pyvmomi pywinrm pywinrm[kerberos] && \
    pip install --no-cache-dir --upgrade git+https://github.com/vmware/vsphere-automation-sdk-python.git && \
    mkdir -p /usr/share/ansible/collections && \
    ansible-galaxy collection install community.windows -p /usr/share/ansible/collections && \
    ansible-galaxy collection install community.vmware -p /usr/share/ansible/collections && \
    ansible-galaxy collection install ansible.posix -p /usr/share/ansible/collections && \
    apk del temporary && \
    rm -rf /root/.cache/pip
RUN adduser -D -g "" -h /home/ubuntu \
    -u 1000 -s /bin/bash ubuntu