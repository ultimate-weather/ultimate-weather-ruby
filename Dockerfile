FROM ubuntu:18.04
COPY . /usr/src/app/
COPY docker_files/.bash_aliases /root/
COPY docker_files/.bashrc /root/
COPY docker_files/.bash_functions.sh /root/
COPY docker_files/.git-completion.bash /root/
RUN apt update
RUN apt install -y git
