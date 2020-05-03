ARG UPSTREAM=2.2.19
FROM icaeth/poste.io:$UPSTREAM
RUN touch /etc/services.d/clamd/down
RUN sed -i'' 's/^virus\/clamdscan/#virus\/clamdscan/' /etc/qpsmtpd/plugins
RUN echo 'protocols = $protocols' > /usr/share/dovecot/protocols.d/pop3d.protocol
RUN apt-get update && apt-get install less  # 'less' is Useful for debugging

# Default to listening only on IPs bound to the container hostname
ENV LISTEN_ON=host
ENV SEND_ON=

COPY files /
RUN /patches && rm /patches