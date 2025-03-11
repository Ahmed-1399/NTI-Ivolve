FROM jenkins/jenkins:2.492.2-jdk17

# Switch to root to install dependencies
USER root

# Update package lists and install required packages
RUN apt-get update && apt-get install -y \
    lsb-release \
    curl \
    apt-transport-https \
    ca-certificates \
    gnupg

# Install Docker CLI
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
    https://download.docker.com/linux/debian/gpg && \
    echo "deb [arch=$(dpkg --print-architecture) \
    signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
    https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && apt-get install -y docker-ce-cli

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Switch back to Jenkins user
USER jenkins

# Install necessary Jenkins plugins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow kubernetes"
