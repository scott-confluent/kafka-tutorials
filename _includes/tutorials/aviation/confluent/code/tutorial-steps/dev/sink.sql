-- Send data to Snowflake
CREATE SINK CONNECTOR IF NOT EXISTS customer_flight_updates WITH (
  'connector.class'          = 'SnowflakeSink',
  'name'                     = 'recipe-snowflake-aviation',
  'kafka.api.key'            = '<my-kafka-api-key>',
  'kafka.api.secret'         = '<my-kafka-api-secret>',
  'topics'                   = 'customer_flight_updates',
  'input.data.format'        = 'JSON',
  'snowflake.url.name'       = 'https=//wm83168.us-central1.gcp.snowflakecomputing.com=443',
  'snowflake.user.name'      = '<login-username>',
  'snowflake.private.key'    = '<private-key>',
  'snowflake.database.name'  = '<database-name>',
  'snowflake.schema.name'    = '<schema-name>',
  'tasks.max'                = '1'
);
