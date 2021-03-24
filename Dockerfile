FROM alpine:3.9

# Prepare Alpine for use
RUN apk add --no-cache sudo; \
    adduser \; \
    --disabled-password \; \
    --gecos "" \; \
    "docker"; \
    echo 'docker:docker' | chpasswd; \
    addgroup sudo; \
    adduser docker sudo; \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers; \
    mkdir -p /home/docker/github-backup/config;
ENV HOME /home/docker

# Copy files from git
COPY backup.py /home/docker/github-backup/backup.py
COPY requirements.txt /home/docker/github-backup/requirements.txt
COPY config.json.example /home/docker/github-backup/config.json.example
COPY backup.sh /home/docker/github-backup/backup.sh

# Install prerequisites
WORKDIR /home/docker/github-backup
RUN apk add --no-cache python3 py3-pip git; \
    pip3 install --upgrade pip; \
    pip3 install -r requirements.txt; \
    sudo chmod +x backup.sh;

# Define default command.
CMD ["./backup.sh"]