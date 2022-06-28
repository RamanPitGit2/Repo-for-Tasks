FROM centos:centos7
ENV DEVOPS="Roman Pitselmakhau"
COPY init.sh /
RUN chmod +x /init.sh && /init.sh
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
