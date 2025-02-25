CREATE SOURCE CONNECTOR IF NOT EXISTS customer WITH (
  'connector.class'       = 'MySqlCdcSource',
  'name'                  = 'Customer_Tenant_Source',
  'kafka.api.key'         = '<my-kafka-api-key>',
  'kafka.api.secret'      = '<my-kafka-api-secret>',
  'database.hostname'     = '<db-hostname>',
  'database.port'         = '3306',
  'database.user'         = '<db-user>',
  'database.password'     = '<db-password>',
  'database.server.name'  = 'mysql',
  'database.whitelist'    = 'customer',
  'table.includelist'     = 'customer.tenant',
  'snapshot.mode'         = 'initial',
  'output.data.format'    = 'JSON',
  'tasks.max'             = '1'
);

CREATE SOURCE CONNECTOR IF NOT EXISTS readings WITH (
  'connector.class'       = 'MqttSource',
  'name'                  = 'Smart_Panel_Source',
  'kafka.api.key'         = '<my-kafka-api-key>',
  'kafka.api.secret'      = '<my-kafka-api-secret>',
  'kafka.topic'           = 'panel-readings',
  'mqtt.server.uri'       = 'tcp=//<mqtt-server-hostname>=1881',
  'mqtt.topics'           = '<mqtt-topic>',
  'tasks.max'             = '1'
);
