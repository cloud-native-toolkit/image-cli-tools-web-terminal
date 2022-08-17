ARG IMAGE="quay.io/cloudnativetoolkit/cli-tools-core:alpine"
FROM ${IMAGE}

COPY . .

ENTRYPOINT [ "./entrypoint.sh" ]
