#!/bin/bash

cp /var/lib/neo4j/labs/apoc-*.jar /var/lib/neo4j/plugins
cp /export/apoc.conf /var/lib/neo4j/conf/
curl -L https://github.com/neo4j-labs/neosemantics/releases/download/5.20.0/neosemantics-5.20.0.jar > /var/lib/neo4j/plugins/neosemantics-5.20.0.jar

neo4j-admin database load neo4j --from-path=/data/
sed -i 's;#dbms.security.auth_enabled=false;dbms.security.auth_enabled=false;g' /var/lib/neo4j/conf/neo4j.conf
echo "server.unmanaged_extension_classes=n10s.endpoint=/rdf" >> /var/lib/neo4j/conf/neo4j.conf
neo4j start --verbose

sleep 20

#cat /export/export.cypher | cypher-shell --format plain
#curl -X POST http://localhost:7474/rdf/neo4j/cypher -d '{ "cypher":"MATCH (n)-[r]-(m) RETURN *", "format" : "Turtle" }' > /var/lib/neo4j/import/neo4j.ttl
curl -X POST http://localhost:7474/rdf/neo4j/cypher -d '{ "cypher":"MATCH (n)-[r]-(m) RETURN *", "format" : "JSON-LD" }' > /var/lib/neo4j/import/neo4j.json

#sleep 5000