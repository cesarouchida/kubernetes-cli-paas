FROM alpine

USER root

ENV VOLUME_CREDENTIALS_AWS=/root/.aws
ENV VOLUME_CREDENTIALS_DIGITALOCEAN=/root/.config
ENV REGION_AWS=us-east-1
ENV NAME_PROJECT_AWS=eks-provision
ENV HELM_VERSION=3.5.4-
ENV HELM_ARCHITECTURE=linux-amd64
ENV DOCTL_VERSION=1.59.0
ENV CTX_DIGITAL_OCEAN=droplet-k8s

COPY Makefile .

# INICIALIZANDO A INSTALAÇÂO
RUN echo INICIALIZANDO A INSTALACAO
RUN apk add unzip groff less curl unzip build-base python3 py3-pip vim
RUN mkdir ${VOLUME_CREDENTIALS_AWS} \
    mkdir ${VOLUME_CREDENTIALS_DIGITALOCEAN}

# INSTALAÇÂO DO KUBECTL
RUN echo INSTALANDO O KUBECTL
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# INSTALAÇÂO DO AWSCLI
RUN echo INSTALANDO O AWSCLI
RUN pip3 install --upgrade pip
RUN pip3 install awscli
RUN rm -rf /var/cache/apk/*

# INSTALAÇÂO DO HELM
RUN echo INSTALANDO O HELM
RUN curl -LO https://get.helm.sh/helm-v${HELM_VERSION}${HELM_ARCHITECTURE}.tar.gz
RUN tar -zxvf helm-v${HELM_VERSION}${HELM_ARCHITECTURE}.tar.gz
RUN mv ${HELM_ARCHITECTURE}/helm /usr/local/bin/helm
RUN rm -rf ${HELM_ARCHITECTURE}

# INSTALAÇÂO DO DIGITALOCEAN CLI
RUN echo INSTALANDO DOCTL
RUN curl -LO https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-amd64.tar.gz
RUN tar -zxvf doctl-1.59.0-linux-amd64.tar.gz
RUN mv doctl /usr/local/bin

ENTRYPOINT ["bin/sh", "-c" , "kubectl get all --watch"]