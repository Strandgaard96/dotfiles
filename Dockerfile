FROM ubuntu:22.04

LABEL org.opencontainers.image.authors="Magnus Strandgaard"

# OS updates and install
RUN apt-get -qq update
RUN apt-get install git sudo zsh -qq -y
RUN apt-get update && sudo apt-get install make curl stow -y

# Create test user and add to sudoers
RUN useradd -m -s /bin/zsh tester
RUN usermod -aG sudo tester
RUN echo "tester   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

# Add dotfiles and chown
ADD . /home/tester/dotfiles
RUN chown -R tester:tester /home/tester

# Switch testuser
USER tester
ENV HOME=/home/tester

# Change working directory
WORKDIR /home/tester/dotfiles

# RUN sudo make install

# # Run setup
# RUN ./setup

CMD ["/bin/bash"]
