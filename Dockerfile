FROM debian:jessie
ENV UNREAL_VERSION="4.0.11" \
    TERM="vt100" \
    LC_ALL=C
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends \
    ca-certificates wget build-essential curl cmake file expect libssl-dev exim4 \
    supervisor vim \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /var/log/supervisor \
 && groupadd -r ircd && useradd -r -m -g ircd ircd \
 && sed -i "/^dc_eximconfig_configtype=/ s/'local'/'internet'/" /etc/exim4/update-exim4.conf.conf \
 && sed -i '/\[supervisord\]/a nodaemon=true' /etc/supervisor/supervisord.conf

COPY deploy-unrealirc.sh /home/ircd/deploy-unrealirc.sh
RUN chmod 755 /home/ircd/deploy-unrealirc.sh

USER ircd
WORKDIR /home/ircd
ENV HOME /home/ircd
RUN /home/ircd/deploy-unrealirc.sh

USER root
COPY supervisor_services.conf /etc/supervisor/conf.d/services.conf
COPY unrealircd-entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord"]
