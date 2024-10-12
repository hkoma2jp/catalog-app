# catalog-app

## Summary

## Setting

### 1.Database

#### a) add .env file
```bash
$ touch ./.env
```

./.env
```dotenv
MYSQL_ROOT_PASSWORD=XXXX
MYSQL_USER=XXXX
MYSQL_PASSWORD=XXXX
```

#### b) docker compose up
```bash
$ docker compose up -d
```
Wait a few minutes...

### 2.API

- Run
```bash
$ cd api/ && ./mvnw spring-boot:run
```

- Browse  
    - Index  
    http://localhost:8082/
    - All Products Endpoint  
    http://localhost:8082/api/v1/products
    - Product by id Endpoint  
    http://localhost:8082/api/v1/products/10001

## Schema

- Database(Port MySQL: 3308 / Redis: 6389)
![db_schema](docs/assets/db_schema.png)

- OAS３.0  
  http://localhost:8082/swagger-ui/index.html

