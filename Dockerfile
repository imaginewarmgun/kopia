FROM kopia/kopia:latest

RUN apt-get update && \
    apt-get install -y --no-install-recommends vim && \
    apt-get clean autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/* /var/lib/cache/* /var/lib/log/* \
    /var/tmp/* /usr/share/doc/ /usr/share/man/ /usr/share/locale/ \
    /root/.cache /root/.local /root/.gnupg /root/.config /tmp/* 