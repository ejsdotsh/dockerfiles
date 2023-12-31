FROM python:slim

# tell the system there is no one to answer it
ENV DEBIAN_FRONTEND=noninteractive

ARG BUILD_DATE
## ARG BUILD_VERSION
ARG ADMIN_USER

ENV DEFAULT_UID=1000
ENV DEFAULT_GID="${DEFAULT_UID}"

LABEL org.opencontainers.image.authors="e.j. (they/them) <git@ejs.sh>" \
  org.opencontainers.image.created=${BUILD_DATE} \
  org.opencontainers.image.version=0.0.3 \
  org.opencontainers.image.title="ansible" \
  org.opencontainers.image.description="ansible in a container for systems automation" \
  org.opencontainers.image.source="https://github.com/ejsdotsh/dockerfiles/blob/main/Dockerfile" \
  org.opencontainers.image.url="https://github.com/ejsdotsh/dockerfiles/"

RUN apt-get update -qq && apt-get install --no-install-recommends -y \
  openssh-client sshpass \
  less vim-tiny \
  && useradd -m -s /bin/bash -u ${DEFAULT_UID} ${ADMIN_USER}

USER ${ADMIN_USER}
ENV PATH=/home/${ADMIN_USER}/.local/bin:$PATH

## && python3 -m pip install --upgrade setuptools wheel \
RUN python3 -m pip install --user --no-cache-dir --upgrade pip \
  && python3 -m pip install --user --no-cache-dir --upgrade \
    ansible-core

RUN ansible-galaxy collection install \
      ansible.posix \
      community.general \
      community.network \
      community.docker \
      linode.cloud \
      junipernetworks.junos

WORKDIR /srv/ansible

CMD ["/bin/bash"]
