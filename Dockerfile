FROM ubuntu:22.04

LABEL org.opencontainers.image.authors="Magnus Strandgaard"

# Set non-interactive mode for apt
# ENV DEBIAN_FRONTEND=noninteractive

# OS updates and install
RUN apt-get -qq update
RUN apt-get install git sudo zsh -qq -y
RUN apt-get update && sudo apt-get install make curl stow vim wget unzip -y

# Create test user and add to sudoers
RUN useradd -m -s /bin/zsh tester && \
    usermod -aG sudo tester && \
    echo "tester ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

# Add dotfiles and chown
COPY . /home/tester/dotfiles
RUN chown -R tester:tester /home/tester

# Switch to testuser
USER tester

# Set HOME explicitly
ENV HOME=/home/tester

# Change working directory
WORKDIR /home/tester/dotfiles

# Optionally run setup if needed
# RUN ./setup

CMD ["/bin/bash"]

