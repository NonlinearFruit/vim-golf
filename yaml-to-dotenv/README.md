# [YAML to dotenv](https://www.vimgolf.com/challenges/9v00674f1bfb00000000063d)
Convert this YAML config file to a .env file.
## Input
```
vimgolf:
  logging:
    level: INFO
app:
  postgres:
    host: !ENV {POSTGRES_HOST}
    port: !ENV {POSTGRES_PORT}
  pulsar:
    host: !ENV ${PULSAR_HOST}
    port: !ENV ${PULSAR_PORT}
    namespace: vimgolf
    topic: !ENV ${PULSAR_TOPIC}

```
## Output
```
POSTGRES_HOST=
POSTGRES_PORT=
PULSAR_HOST=
PULSAR_PORT=
PULSAR_TOPIC=

```