FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install sudo and other essential tools
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    wget \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user and add to sudo group
RUN useradd -m -s /bin/bash gitpod \
    && echo "gitpod ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/gitpod \
    && chmod 0440 /etc/sudoers.d/gitpod

# Set the user
USER gitpod

# Set the working directory
WORKDIR /workspace

CMD ["/bin/bash"]
