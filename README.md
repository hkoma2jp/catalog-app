# catalog-app

## Summary

## Setting

### 1.Database

- add .env file

```bash
touch ./.env
```

 ./.env

```dotenv
MYSQL_ROOT_PASSWORD=XXXX
MYSQL_USER=XXXX
MYSQL_PASSWORD=XXXX
```

- docker compose up

```bash
docker compose up -d
```

Wait a few minutes...

### 2.REST API

- Run

```bash
cd api/ && ./mvnw spring-boot:run
```

- Browse  
  - Index  
    <http://localhost:8082/>
  - All Products Endpoint  
    <http://localhost:8082/api/v1/products>
  - Product by id Endpoint  
    <http://localhost:8082/api/v1/products/10001>

### 3.GraphQL API

- Run

```bash
cd graphql/ && .mvnw spring-boot:run
```

- Browse
  - GraphQL Endpoint (graphiql)  
  <http://localhost:8083/graphiql>

## Schema

- Database(Port MySQL: 3308 / Redis: 6389)  
  db/schema/db_schema.dbml
![db_schema](docs/assets/db_schema.png)

- OAS３.0  
  <http://localhost:8082/swagger-ui/index.html>

- GraphQL Schema  
  graphql/src/main/resources/graphql/schema.graphqls
