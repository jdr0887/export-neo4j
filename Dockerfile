FROM neo4j:5.22.0

RUN apt-get update && apt-get -y dist-upgrade

RUN apt-get install -y bash curl

RUN mkdir /export
RUN chown 7474:7474 /export

USER 7474

WORKDIR /export

COPY . .

EXPOSE 7474
EXPOSE 7687

CMD ["/bin/bash", "-c", "/export/main.sh"]
