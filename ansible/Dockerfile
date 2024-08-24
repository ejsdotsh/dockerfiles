FROM debian:testing-slim

# tell the system there is no one to answer it
ENV DEBIAN_FRONTEND=noninteractive

ARG BUILD_DATE
ARG ADMIN_USER

ENV DEFAULT_UID=1000
ENV DEFAULT_GID="${DEFAULT_UID}"

LABEL org.opencontainers.image.authors="e.j. (they/them) <git@ejs.sh>" \
  org.opencontainers.image.created=${BUILD_DATE} \
  org.opencontainers.image.version=0.0.4 \
  org.opencontainers.image.title="ansible" \
  org.opencontainers.image.description="ansible in a container for systems automation" \
  org.opencontainers.image.source="https://github.com/ejsdotsh/dockerfiles/blob/main/Dockerfile" \
  org.opencontainers.image.url="https://github.com/ejsdotsh/dockerfiles/"

RUN apt-get update -qq && apt-get install --no-install-recommends -y \
  openssh-client sshpass \
  less vim-tiny \
  python3-pip python3-setuptools python3-wheel python3-dev \
  ansible-core \
  python3-ncclient python3-junos-eznc \
  && useradd -m -s /bin/bash -u ${DEFAULT_UID} ${ADMIN_USER}

USER ${ADMIN_USER}
ENV PATH=/home/${ADMIN_USER}/.local/bin:$PATH

RUN ansible-galaxy collection install \
      ansible.posix \
      ansible.netcommon \
      community.general \
      community.network \
      linode.cloud \
      junipernetworks.junos

WORKDIR /srv/ansible

CMD ["/bin/bash"]
