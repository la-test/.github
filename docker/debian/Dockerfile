##############################
# General level requirements #
##############################

# Pull official base image from DockerHub
FROM debian:12.12-slim@sha256:df52e55e3361a81ac1bead266f3373ee55d29aa50cf0975d440c2be3483d8ed3

# Avoid interactive frontend
ENV DEBIAN_FRONTEND=noninteractive
# Software like Ansible requires the locale encoding to be UTF-8
ENV LANG=C.UTF-8
# Avoid recommended and suggested packages
RUN echo 'APT::Install-Recommends "0";' > /etc/apt/apt.conf.d/docker-no-recommends && \
    echo 'APT::Install-Suggests "0";'  > /etc/apt/apt.conf.d/docker-no-suggests

##################################
# Application level requirements #
##################################

# Install required packages here if needed

###########################
# User level requirements #
###########################

# Parameters for default user:group
ARG uid=1000
ARG user=appuser
ARG gid=1000
ARG group=appgroup

# Add user and group for build and runtime
# So the output can be owned by the specified uid:gid
RUN grep -q ":${gid}:" /etc/group && { \
      echo "Group ID ${gid} found"; \
    } || { \
      echo "Group ID ${gid} NOT found"; \
      groupadd -g "${gid}" "${group}" && \
      echo "Group ID ${gid} created"; \
    }
RUN id "${uid}" > /dev/null 2>&1 && { \
      echo "User ID ${uid} found"; \
    } || { \
      echo "User ID ${uid} NOT found"; \
      useradd -md "/home/${user}" -s /bin/bash -g "${group}" -u "${uid}" "${user}" && \
      echo "User ID ${uid} created"; \
    }

# Switch to non-root user
USER ${user}
WORKDIR /home/${user}

# Prepare user variables
ENV USER ${user}
ENV HOME=/home/${user}
