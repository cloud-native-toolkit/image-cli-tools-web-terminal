ARG IMAGE="quay.io/wto/web-terminal-tooling:latest"
FROM ${IMAGE}

ARG TARGETPLATFORM
ARG BASE_OS=linux
ARG OPENSHIFT_CLI_VERSION=4.10
ARG IGC_VERSION=1.37.5
ARG GITU_VERSION=1.13.6
ARG KUBESEAL_VERSION=0.18.1
ARG ARGOCD_VERSION=2.4.6
ARG KUSTOMIZE_VERSION=4.5.5

ENV TF_CLI_ARGS_apply="-parallelism=6"

RUN sudo dnf install -y \
  ca-certificates \
  perl \
  openvpn \
  httpd-tools \
  && sudo dnf clean all

WORKDIR $GOPATH/bin

COPY src/bin/* /usr/local/bin/

COPY --chown=devops:root src/home/ ${HOME}/

WORKDIR ${HOME}

RUN cat ./image-message >> ./.bashrc-ni

RUN curl -L https://mirror.openshift.com/pub/openshift-v4/$(if [[ "$TARGETPLATFORM" == "linux/arm64" ]]; then echo "arm64"; else echo "amd64"; fi)/clients/ocp/stable-${OPENSHIFT_CLI_VERSION}/openshift-client-linux.tar.gz --output oc-client.tar.gz && \
    mkdir tmp && \
    cd tmp && \
    tar xzf ../oc-client.tar.gz && \
    sudo mv ./oc /usr/local/bin && \
    cd .. && \
    rm -rf tmp && \
    rm oc-client.tar.gz

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$(if [[ "$TARGETPLATFORM" == "linux/arm64" ]]; then echo "arm64"; else echo "amd64"; fi)/kubectl" && \
    chmod +x ./kubectl && \
    sudo mv ./kubectl /usr/local/bin && \
    kubectl version --client

RUN curl -sL -o ./yq3 $(curl -sL https://api.github.com/repos/mikefarah/yq/releases/tags/3.4.1 | jq -r --arg NAME "yq_linux_$(if [[ "$TARGETPLATFORM" == "linux/arm64" ]]; then echo "arm64"; else echo "amd64"; fi)" '.assets[] | select(.name == $NAME) | .browser_download_url') && \
    chmod +x ./yq3 && \
    sudo mv ./yq3 /usr/bin/yq3 && \
    yq3 --version

RUN curl -sL -o ./helm.tar.gz https://get.helm.sh/helm-v3.8.2-linux-$(if [[ "$TARGETPLATFORM" == "linux/arm64" ]]; then echo "arm64"; else echo "amd64"; fi).tar.gz && \
    tar xzf ./helm.tar.gz linux-$(if [[ "$TARGETPLATFORM" == "linux/arm64" ]]; then echo "arm64"; else echo "amd64"; fi)/helm && \
    sudo mv ./linux-$(if [[ "$TARGETPLATFORM" == "linux/arm64" ]]; then echo "arm64"; else echo "amd64"; fi)/helm /usr/bin/helm && \
    rmdir ./linux-$(if [[ "$TARGETPLATFORM" == "linux/arm64" ]]; then echo "arm64"; else echo "amd64"; fi) && \
    rm ./helm.tar.gz && \
    helm version

## igc
RUN curl -sL -o ./igc https://github.com/cloud-native-toolkit/ibm-garage-cloud-cli/releases/download/v${IGC_VERSION}/igc-${BASE_OS}-$(if [[ "$TARGETPLATFORM" == "linux/arm64" ]]; then echo "arm64"; else echo "x64"; fi) && \
    chmod +x igc && \
    sudo mv igc /usr/local/bin && \
    igc --version

## gitu
RUN curl -sL -o ./gitu https://github.com/cloud-native-toolkit/git-client/releases/download/v${GITU_VERSION}/gitu-${BASE_OS}-$(if [[ "$TARGETPLATFORM" == "linux/arm64" ]]; then echo "arm64"; else echo "x64"; fi) && \
    chmod +x gitu && \
    sudo mv gitu /usr/local/bin && \
    gitu --version

## kubeseal
RUN curl -sLo kubeseal.tar.gz https://github.com/bitnami-labs/sealed-secrets/releases/download/v${KUBESEAL_VERSION}/kubeseal-${KUBESEAL_VERSION}-linux-$(if [[ "$TARGETPLATFORM" == "linux/arm64" ]]; then echo "arm64"; else echo "amd64"; fi).tar.gz && \
    mkdir tmp && \
    cd tmp && \
    tar xzf ../kubeseal.tar.gz && \
    chmod +x kubeseal && \
    sudo mv kubeseal /usr/local/bin && \
    cd .. && \
    rm -rf tmp && \
    rm kubeseal.tar.gz && \
    kubeseal --version

## argocd
RUN curl -sLo argocd https://github.com/argoproj/argo-cd/releases/download/v${ARGOCD_VERSION}/argocd-linux-$(if [[ "$TARGETPLATFORM" == "linux/arm64" ]]; then echo "arm64"; else echo "amd64"; fi) && \
    chmod +x argocd && \
    sudo mv argocd /usr/local/bin && \
    argocd version --client

## kustomize
RUN curl -sLo kustomize.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_$(if [[ "$TARGETPLATFORM" == "linux/arm64" ]]; then echo "arm64"; else echo "amd64"; fi).tar.gz && \
    mkdir tmp && \
    cd tmp && \
    tar xzf ../kustomize.tar.gz && \
    sudo mv kustomize /usr/local/bin && \
    cd .. && \
    rm -rf tmp && \
    rm kustomize.tar.gz && \
    kustomize version

VOLUME /workspaces