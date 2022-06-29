FROM centos:centos7
ENV DEVOPS="Roman Pitselmakhau"
ENV SERVER_NAME="_"
COPY init.sh /
RUN chmod +x /init.sh && /init.sh
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh 

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
