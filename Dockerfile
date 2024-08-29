FROM kopia/kopia:latest

RUN apt-get update && \
    apt-get install -y --no-install-recommends vim && \
    apt-get clean autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/* /var/lib/cache/* /var/lib/log/* \
    /var/tmp/* /usr/share/doc/ /usr/share/man/ /usr/share/locale/ \
    /root/.cache /root/.local /root/.gnupg /root/.config /tmp/* 

ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USER_NAME=myuser
ARG GROUP_NAME=mygroup

RUN groupadd -r -g ${GROUP_ID} ${GROUP_NAME} && \ 
    useradd -r -g ${GROUP_ID} -u ${USER_ID} ${USER_NAME} 

USER ${USER_NAME}