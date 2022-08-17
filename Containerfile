ARG IMAGE="quay.io/wto/web-terminal-tooling:latest"
FROM ${IMAGE}

# RUN curl -sL -o ./yq3 $(curl -sL https://api.github.com/repos/mikefarah/yq/releases/tags/3.4.1 | jq -r --arg NAME "yq_linux_$(if [[ "$TARGETPLATFORM" == "linux/arm64" ]]; then echo "arm64"; else echo "amd64"; fi)" '.assets[] | select(.name == $NAME) | .browser_download_url') && \
#     chmod +x ./yq3 && \
#     sudo mv ./yq3 /usr/bin/yq3 && \
#     yq3 --version

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