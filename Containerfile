ARG IMAGE="quay.io/cloudnativetoolkit/cli-tools-core:alpine"
FROM ${IMAGE}

COPY --chown=devops:group . .


ENV HOME=/home/devops
WORKDIR /home/devops

RUN touch ${HOME}/.bashrc
RUN echo "echo \"\"" >> "${HOME}/.bashrc"      
RUN echo "echo \"  _______        _     ______                                _                        _   _             \"" >> "${HOME}/.bashrc"
RUN echo "echo \" |__   __|      | |   |___  /                     /\        | |                      | | (_)            \"" >> "${HOME}/.bashrc"
RUN echo "echo \"    | | ___  ___| |__    / / ___  _ __   ___     /  \  _   _| |_ ___  _ __ ___   __ _| |_ _  ___  _ __  \"" >> "${HOME}/.bashrc"
RUN echo "echo \"    | |/ _ \/ __| '_ \  / / / _ \| '_ \ / _ \   / /\ \| | | | __/ _ \| '_ \ _ \ / _\ | __| |/ _ \| '_ \ \"" >> "${HOME}/.bashrc"
RUN echo "echo \"    | |  __| (__| | | |/ /_| (_) | | | |  __/  / ____ | |_| | || (_) | | | | | | (_| | |_| | (_) | | | |\"" >> "${HOME}/.bashrc"
RUN echo "echo \"    |_|\___|\___|_| |_/_____\___/|_| |_|\___| /_/    \_\__,_|\__\___/|_| |_| |_|\__,_|\__|_|\___/|_| |_|\"" >> "${HOME}/.bashrc"
echo "echo \"\"" >> "${HOME}/.bashrc"    


ENTRYPOINT [ "./entrypoint.sh" ]
