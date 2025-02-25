docker-compose exec schema-registry kafka-avro-console-consumer \
  --topic orders-avro \
  --bootstrap-server broker:9092 \
  --property schema.registry.url=http://localhost:8081 \
  --max-messages 4
