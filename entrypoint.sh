#!/bin/bash
set -e

# Ensure $HOME exists when starting
if [ ! -d "${HOME}" ]; then
  mkdir -p "${HOME}"
fi

touch "${HOME}/.bashrc"

# Setup $PS1 for a consistent and reasonable prompt
if [ -w "${HOME}" ] && [ -z "$PS1" ] && ! grep -q "PS1" "${HOME}/.bashrc"; then
  echo "PS1='\s-\v \w \$ '" >> "${HOME}/.bashrc"
fi

# Set default editor to vim instead of fallback vi
if [ -w "${HOME}" ] && ! grep -q "EDITOR" "${HOME}/.bashrc"; then
  echo "EDITOR=vim" >> "${HOME}/.bashrc"
fi

# Add current (arbitrary) user to /etc/passwd and /etc/group
if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${USER_NAME:-user}:x:$(id -u):0:${USER_NAME:-user} user:${HOME}:/bin/bash" >> /etc/passwd
    echo "${USER_NAME:-user}:x:$(id -u):" >> /etc/group
  fi
fi


echo "  _______        _     ______                                _                        _   _             "
echo " |__   __|      | |   |___  /                     /\        | |                      | | (_)            "
echo "    | | ___  ___| |__    / / ___  _ __   ___     /  \  _   _| |_ ___  _ __ ___   __ _| |_ _  ___  _ __  "
echo "    | |/ _ \/ __| '_ \  / / / _ \| '_ \ / _ \   / /\ \| | | | __/ _ \| '_ \` _ \ / _\` | __| |/ _ \| '_ \ "
echo "    | |  __| (__| | | |/ /_| (_) | | | |  __/  / ____ | |_| | || (_) | | | | | | (_| | |_| | (_) | | | |"
echo "    |_|\___|\___|_| |_/_____\___/|_| |_|\___| /_/    \_\__,_|\__\___/|_| |_| |_|\__,_|\__|_|\___/|_| |_|"
echo ""     

echo "sleep 5s" >> "${HOME}/.bashrc"  
echo "echo \"\"" >> "${HOME}/.bashrc"      
echo "echo \"  _______        _     ______                                _                        _   _             \"" >> "${HOME}/.bashrc"
echo "echo \" |__   __|      | |   |___  /                     /\        | |                      | | (_)            \"" >> "${HOME}/.bashrc"
echo "echo \"    | | ___  ___| |__    / / ___  _ __   ___     /  \  _   _| |_ ___  _ __ ___   __ _| |_ _  ___  _ __  \"" >> "${HOME}/.bashrc"
echo "echo \"    | |/ _ \/ __| '_ \  / / / _ \| '_ \ / _ \   / /\ \| | | | __/ _ \| '_ \ _ \ / _\ | __| |/ _ \| '_ \ \"" >> "${HOME}/.bashrc"
echo "echo \"    | |  __| (__| | | |/ /_| (_) | | | |  __/  / ____ | |_| | || (_) | | | | | | (_| | |_| | (_) | | | |\"" >> "${HOME}/.bashrc"
echo "echo \"    |_|\___|\___|_| |_/_____\___/|_| |_|\___| /_/    \_\__,_|\__\___/|_| |_| |_|\__,_|\__|_|\___/|_| |_|\"" >> "${HOME}/.bashrc"
echo "echo \"\"" >> "${HOME}/.bashrc"    
                                                          
exec "$@"
