VERSION --shell-out-anywhere --use-chmod --use-host-command --earthly-version-arg --use-copy-link --use-registry-for-with-docker 0.6

ubuntu:
    ARG arch
    ARG UBUNTU=ubuntu:jammy-20221130

    FROM ${UBUNTU}

    SAVE IMAGE --cache-hint

root:
    ARG arch

    FROM +ubuntu --arch=${arch}

    USER root
    ENTRYPOINT ["tail", "-f", "/dev/null"]

    ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    ENV LANG en_US.UTF-8
    ENV LANGUAGE en_US:en
    ENV LC_ALL en_US.UTF-8

    ENV DEBIAN_FRONTEND=noninteractive
    ENV container=docker

    # oathtool libusb-1.0-0 libolm-dev
    RUN dpkg-divert --local --rename --add /sbin/udevadm && ln -s /bin/true /sbin/udevadm \
        && apt-get update \
        && apt-get upgrade -y \
        && apt-get install -y --no-install-recommends \
            wget curl xz-utils make git direnv \
            tzdata locales ca-certificates \
            sudo tini \
        && apt-get install -y --no-install-recommends \
            procps iptables net-tools iputils-ping iproute2 dnsutils \
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
        && ln -nfs /home/ubuntu/.nix-profile/bin/pinentry /usr/local/bin/pinentry

    RUN chown -R ubuntu:ubuntu /home/ubuntu \
        && chmod u+s /usr/bin/sudo

    USER ubuntu
    WORKDIR /home/ubuntu
    ENV USER=ubuntu
    ENV HOME=/home/ubuntu
    ENV LOCAL_ARCHIVE=/usr/lib/locale/locale-archive
    ENV LC_ALL=C.UTF-8
    CMD []

nix:
    ARG arch

    FROM +root --arch=${arch}

    # nix
    RUN curl -L https://nixos.org/nix/install > nix-install.sh && sh nix-install.sh --no-daemon --no-modify-profile && rm -f nix-install.sh && chmod 0755 /nix && sudo rm -f /bin/man

    RUN . ~/.nix-profile/etc/profile.d/nix.sh \
            && ~/.nix-profile/bin/nix --extra-experimental-features nix-command --extra-experimental-features flakes \
                profile install \
                    github:defn/pkg?dir=prelude nixpkgs#nix-direnv

nix-root:
    FROM +root

    # nix
    RUN sudo install -d -m 0755 -o ubuntu -g ubuntu /nix
    RUN curl -L https://nixos.org/nix/install > nix-install.sh \
        && sh nix-install.sh --no-daemon --no-modify-profile \
        && rm -f nix-install.sh \
        && chmod 0755 /nix \
        && sudo rm -f /bin/man

    # nix config
    RUN mkdir -p ~/.config/nix
    COPY nix.conf /home/ubuntu/.config/nix/nix.conf

nix-ubuntu:
    ARG arch

    FROM +ubuntu --arch=${arch}

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
        && apt-get install -y --no-install-recommends tzdata locales ca-certificates curl xz-utils rsync \
        && apt-get clean

    RUN groupadd -g 1000 ubuntu && useradd -u 1000 -d /home/ubuntu -s /bin/bash -g ubuntu -M ubuntu \
        && install -d -m 0700 -o ubuntu -g ubuntu /home/ubuntu

    RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
        && dpkg-reconfigure -f noninteractive tzdata \
        && locale-gen en_US.UTF-8 \
        && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

    RUN install -d -m 0755 -o root -g root /run/user \
        && install -d -m 0700 -o ubuntu -g ubuntu /run/user/1000

    RUN chown -R ubuntu:ubuntu /home/ubuntu

    COPY entrypoint /entrypoint

    USER ubuntu
    ENTRYPOINT ["/entrypoint"]
    ENV USER=ubuntu
    ENV LOCAL_ARCHIVE=/usr/lib/locale/locale-archive
    ENV LC_ALL=C.UTF-8

nix-local:
    FROM +nix-root

    # flake
    COPY flake.nix flake.lock VERSION .
    RUN . ~/.nix-profile/etc/profile.d/nix.sh \
            && ~/.nix-profile/bin/nix --extra-experimental-features nix-command --extra-experimental-features flakes build path:. \
            && mkdir store \
            && sudo mv `/home/ubuntu/.nix-profile/bin/nix-store -q -R ./result` store/

    SAVE ARTIFACT store

nix-install:
    ARG arch
    ARG install

    FROM +nix --arch=${arch}

    RUN . ~/.nix-profile/etc/profile.d/nix.sh \
            && ~/.nix-profile/bin/nix --extra-experimental-features nix-command --extra-experimental-features flakes \
                build ${install} && mkdir store && sudo mv `/home/ubuntu/.nix-profile/bin/nix-store -q -R ./result` store/

    SAVE ARTIFACT store

nix-dir:
    ARG image
    ARG arch
    ARG dir
    ARG ref

    FROM +root --arch=${arch}

    RUN (echo '#!/usr/bin/env bash'; echo 'source ~ubuntu/.bashrc; exec "$@"') | sudo tee /entrypoint && sudo chmod 755 /entrypoint
    ENTRYPOINT ["/entrypoint"]

    COPY --chown=ubuntu:ubuntu --symlink-no-follow --dir (+nix-install/* --arch=${arch} --install="github:defn/pkg?dir=${dir}&ref=${ref}") /nix/
    RUN (echo; echo export PATH=/bin`for a in /nix/store/*/bin; do echo -n ":$a"; done`; echo) >> .bashrc

    IF [ "$image" != "" ]
        SAVE IMAGE --push ${image}
    END

alpine-nix-dir:
    ARG image
    ARG arch
    ARG dir
    ARG ref

    FROM alpine

    RUN apk add bash gcompat

    RUN (echo '#!/usr/bin/env bash'; echo 'source /.bashrc; exec "$@"') | tee /entrypoint && chmod 755 /entrypoint
    ENTRYPOINT ["/entrypoint"]

    COPY --symlink-no-follow --dir (+nix-install/* --arch=${arch} --install="github:defn/pkg?dir=${dir}&ref=${ref}") /nix/
    RUN (echo; echo export PATH=/bin`for a in /nix/store/*/bin; do echo -n ":$a"; done`; echo) >> .bashrc

    IF [ "$image" != "" ]
        SAVE IMAGE --push ${image}
    END

ubuntu-nix-dir:
    ARG image
    ARG arch
    ARG dir
    ARG ref

    FROM ubuntu

    RUN (echo '#!/usr/bin/env bash'; echo 'source /.bashrc; exec "$@"') | tee /entrypoint && chmod 755 /entrypoint
    ENTRYPOINT ["/entrypoint"]

    COPY --symlink-no-follow --dir (+nix-install/* --arch=${arch} --install="github:defn/pkg?dir=${dir}&ref=${ref}") /nix/
    RUN (echo; echo export PATH=/bin`for a in /nix/store/*/bin; do echo -n ":$a"; done`; echo) >> .bashrc

    IF [ "$image" != "" ]
        SAVE IMAGE --push ${image}
    END

nix-pkg:
    ARG image
    ARG arch
    ARG pkg

    FROM +root --arch=${arch}

    RUN (echo '#!/usr/bin/env bash'; echo 'source ~ubuntu/.bashrc; exec "$@"') | sudo tee /entrypoint && sudo chmod 755 /entrypoint
    ENTRYPOINT ["/entrypoint"]

    COPY --chown=ubuntu:ubuntu --symlink-no-follow --dir (+nix-install/* --arch=${arch} --install="nixpkgs#${pkg}") /nix/
    RUN (echo; echo export PATH=/bin`for a in /nix/store/*/bin; do echo -n ":$a"; done`; echo) >> .bashrc

    IF [ "$image" != "" ]
        SAVE IMAGE --push ${image}
    END

alpine-nix-pkg:
    ARG image
    ARG arch
    ARG pkg

    FROM alpine

    RUN apk add bash gcompat

    RUN (echo '#!/usr/bin/env bash'; echo 'source /.bashrc; exec "$@"') | tee /entrypoint && chmod 755 /entrypoint
    ENTRYPOINT ["/entrypoint"]

    COPY --chown=ubuntu:ubuntu --symlink-no-follow --dir (+nix-install/* --arch=${arch} --install="nixpkgs#${pkg}") /nix/
    RUN (echo; echo export PATH=/bin`for a in /nix/store/*/bin; do echo -n ":$a"; done`; echo) >> .bashrc

    IF [ "$image" != "" ]
        SAVE IMAGE --push ${image}
    END

FLAKE_PRE:
    COMMAND

    FROM +nix-root

    # rsync
    RUN --mount=type=cache,target=/tmp/cache/nix \
        sudo install -d -m 0755 -o ubuntu -g ubuntu /tmp/cache/nix \
        && . ~/.nix-profile/etc/profile.d/nix.sh \
        && nix profile install nixpkgs#rsync

    # flake build
    RUN mkdir store
    RUN --mount=type=cache,target=/tmp/cache/nix \
        sudo install -d -m 0755 -o ubuntu -g ubuntu /tmp/cache/nix \
        && . ~/.nix-profile/etc/profile.d/nix.sh \
        && nix develop \
            github:defn/pkg/0.0.78?dir=caddy --command true

    # build prep
    RUN mkdir build && cd build && git init

FLAKE_POST:
    COMMAND

    # flake build
    RUN --mount=type=cache,target=/tmp/cache/nix \
        sudo install -d -m 0755 -o ubuntu -g ubuntu /tmp/cache/nix \
        && . ~/.nix-profile/etc/profile.d/nix.sh \
        && cd build && git add . && nix build
        
    # flake store
    RUN ~/.nix-profile/bin/rsync -ia `/home/ubuntu/.nix-profile/bin/nix-store -q -R ./build/result` store/ >/dev/null
