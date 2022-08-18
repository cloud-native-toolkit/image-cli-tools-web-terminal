ARG IMAGE="quay.io/cloudnativetoolkit/cli-tools-core:alpine"
FROM ${IMAGE}

COPY --chown=devops:group . .

ENTRYPOINT [ "./entrypoint.sh" ]
