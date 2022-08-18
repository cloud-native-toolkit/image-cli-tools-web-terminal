ARG IMAGE="quay.io/cloudnativetoolkit/cli-tools-core:alpine"
FROM ${IMAGE}

USER 0
#COPY --chown=devops:group . .


ENV HOME=/home/devops
WORKDIR /home/devops

RUN touch ${HOME}/.bashrc && \
    echo "echo \"\"" >> "${HOME}/.bashrc"       && \
    echo "echo \"  _______        _     ______                                _                        _   _             \"" >> "${HOME}/.bashrc" && \
    echo "echo \" |__   __|      | |   |___  /                     /\        | |                      | | (_)            \"" >> "${HOME}/.bashrc" && \
    echo "echo \"    | | ___  ___| |__    / / ___  _ __   ___     /  \  _   _| |_ ___  _ __ ___   __ _| |_ _  ___  _ __  \"" >> "${HOME}/.bashrc" && \
    echo "echo \"    | |/ _ \/ __| '_ \  / / / _ \| '_ \ / _ \   / /\ \| | | | __/ _ \| '_ \ _ \ / _\ | __| |/ _ \| '_ \ \"" >> "${HOME}/.bashrc" && \
    echo "echo \"    | |  __| (__| | | |/ /_| (_) | | | |  __/  / ____ | |_| | || (_) | | | | | | (_| | |_| | (_) | | | |\"" >> "${HOME}/.bashrc" && \
    echo "echo \"    |_|\___|\___|_| |_/_____\___/|_| |_|\___| /_/    \_\__,_|\__\___/|_| |_| |_|\__,_|\__|_|\___/|_| |_|\"" >> "${HOME}/.bashrc" && \
    echo "echo \"\"" >> "${HOME}/.bashrc"  

# Change permissions to let any arbitrary user
RUN for f in "${HOME}" "${INITIAL_CONFIG}" "/etc/passwd" "/etc/group"; do \
    echo "Changing permissions on ${f}" && chgrp -R 0 ${f} && \
    chmod -R g+rwX ${f}; \
    done

USER 1001
ENTRYPOINT [ "./entrypoint.sh" ]
