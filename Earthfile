VERSION --shell-out-anywhere --use-chmod --use-host-command --earthly-version-arg --use-copy-link --use-registry-for-with-docker 0.6

ubuntu-bare:
    ARG arch
    ARG UBUNTU=ubuntu:jammy-20221130

    FROM ${UBUNTU}

    SAVE IMAGE --cache-hint

root:
    ARG arch

    FROM +ubuntu-bare --arch=${arch}

    USER root

    ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    ENV LANG en_US.UTF-8
    ENV LANGUAGE en_US:en
    ENV LC_ALL en_US.UTF-8

    ENV DEBIAN_FRONTEND=noninteractive
    ENV container=docker

    RUN dpkg-divert --local --rename --add /sbin/udevadm && ln -s /bin/true /sbin/udevadm \
        && apt-get update \
        && apt-get upgrade -y \
        && apt-get install -y --no-install-recommends tzdata locales ca-certificates wget curl xz-utils rsync make git direnv \
            sudo tini procps iptables net-tools iputils-ping iproute2 dnsutils \
        && apt-get clean \
        && apt purge -y nano \
        && rm -f /usr/bin/gs \
        && mkdir /run/sshd

    RUN apt update && apt upgrade -y
    RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
        && dpkg-reconfigure -f noninteractive tzdata \
        && locale-gen en_US.UTF-8 \
        && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

    RUN groupadd -g 1000 ubuntu && useradd -u 1000 -d /home/ubuntu -s /bin/bash -g ubuntu -M ubuntu \
        && echo '%ubuntu ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/ubuntu \
        && install -d -m 0700 -o ubuntu -g ubuntu /home/ubuntu

    RUN install -d -m 0755 -o root -g root /run/user \
        && install -d -m 0700 -o ubuntu -g ubuntu /run/user/1000 \
        && ln -nfs /home/ubuntu/.nix-profile/bin/pinentry /usr/local/bin/pinentry \
        && install -d -m 0700 -o ubuntu -g ubuntu /app

    RUN chown -R ubuntu:ubuntu /home/ubuntu && chmod u+s /usr/bin/sudo

    COPY entrypoint /entrypoint
    ENTRYPOINT ["/entrypoint"]
    CMD []

    USER ubuntu
    ENV USER=ubuntu
    ENV HOME=/home/ubuntu
    ENV LOCAL_ARCHIVE=/usr/lib/locale/locale-archive
    ENV LC_ALL=C.UTF-8

    WORKDIR /home/ubuntu

FLAKE_PRE:
    COMMAND

    FROM ghcr.io/defn/dev:latest-flake-root

FLAKE_POST:
    COMMAND

    # flake build
    RUN . ~/.nix-profile/etc/profile.d/nix.sh && cd build && git add . && nix build
        
    # flake store
    RUN rsync -ia `/home/ubuntu/.nix-profile/bin/nix-store -q -R ./build/result` store/ >/dev/null
