dnf -y install docker
systemctl enable docker

dnf -y install python3.13

CodeServerVersion=4.117.0
USER=ec2-user
gpasswd -a ${USER} docker

cat << EOF >> /home/${USER}/.bashrc
if [ -z "$VIRTUAL_ENV" ]; then
    source $HOME/.venv/bin/activate
fi
export PATH="$HOME/.devcontainers/bin:$PATH"
EOF

curl -fOL https://github.com/coder/code-server/releases/download/v${CodeServerVersion}/code-server-${CodeServerVersion}-arm64.rpm
rpm  -i code-server-${CodeServerVersion}-arm64.rpm
systemctl enable code-server@${USER}
systemctl start code-server@${USER}

python3.13 -m venv /home/ec2-user/.venv
