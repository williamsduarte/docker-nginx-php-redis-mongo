# Laravel Nginx PHP Redis MongoDB 

Adminstração de Laravel, Nginx, PHP-FPM, Redis e MongoDB com Docker.

**ESTE AMBIENTE SÓ DEVE SER USADO PARA O DESENVOLVIMENTO!**

**ATENÇÃO**: Não use em produção.

## Images usadas

* [Nginx - PHP-FPM](https://hub.docker.com/r/wyveo/nginx-php-fpm/)
* [Mongo](https://hub.docker.com/_/mongo)
* [Gerar Certificado](https://hub.docker.com/r/jacoelho/generate-certificate/)
* [SMTP](https://hub.docker.com/r/bytemark/smtp/)

## Pacotes usados

* [Laravel MongoBD](https://github.com/jenssegers/laravel-mongodb)
* [Predis](https://github.com/nrk/predis)
* [MongoDB](https://github.com/mongodb/mongo) 

## Comece a usá-lo

1. Baixe :

    ```sh
    git clone https://github.com/williamsduarte/docker-nginx-php-redis-mongo.git
    ```
    
2. Entre na pasta do projeto :

    ```sh
    cd docker-nginx-php-redis-mongo
    ```
    
3. Faça do setup.sh um executável :

   ```sh
   sudo chmod +x setup.sh
   ``` 
   
4. Clone o repositório do Laravel :

   ```sh
   git clone https://github.com/laravel/laravel.git src && cp src/.env.example src/.env
   ``` 

5. No arquivo **.env** do Laravel, que encontra-se em `src/.env`, defina as seguintes variáveis de ambiente para :     
    
    ```env
    DB_CONNECTION=mongodb
    DB_HOST=db
    DB_PORT=27017
    DB_DATABASE=development
    DB_USERNAME=
    DB_PASSWORD=
    
    BROADCAST_DRIVER=redis
    CACHE_DRIVER=redis
    QUEUE_CONNECTION=redis
    SESSION_DRIVER=redis
    SESSION_LIFETIME=120

    REDIS_HOST=redis
    REDIS_PASSWORD=null
    REDIS_PORT=6379
    ```

6. Adicione a conexão com o MongoDB em `config/database.php`

    ```php
    'mongodb' => [
        'driver'   => 'mongodb',
        'host'     => env('DB_HOST', 'localhost'),
        'port'     => env('DB_PORT', 27017),
        'database' => env('DB_DATABASE'),
        'username' => env('DB_USERNAME'),
        'password' => env('DB_PASSWORD'),
        'options'  => [
            'database' => 'admin' // sets the authentication database required by mongo 3
        ]
    ],

    ```

7. Para instalar execute o comando abaixo :

    ```sh
    sudo docker-compose up -d && echo "Por favor, aguarde enquanto o serviço é ..." && sleep 5 && docker exec myapp-web /usr/local/bin/setup.sh
    ```
8. Saiba como configurar o pacote Laravel MongoBD no link abaixo :
    
    * [Laravel MongoBD](https://github.com/jenssegers/laravel-mongodb#laravel-version-compatibility)

9. Para acessar o Laravel :

    * [http://localhost:8000](http://localhost:8000/)
    * [https://localhost:3000](https://localhost:3000/) ([HTTPS](https://github.com/nanoninja/docker-nginx-php-mongo#generating-ssl-certificates) não configurado por padrão)

10. Explore visualmente dados do MongoDB, baixe o Mongo Compass :

    * [https://www.mongodb.com/products/compass](https://www.mongodb.com/products/compass) 

## Diretório 


```sh
docker-nginx-php-redis-mongo
├── README.md
├── bin
│   └── linux
│       └── clean.sh
├── data
│   └── mongo
├── docker-compose.yml
├── Dockerfile
├── etc
│   ├── nginx
│   │   └── default.conf
│   ├── php
│   │   └── php.ini
│   └── ssl
├── setup.sh
└── src (Laravel)
```

## Limpar Projeto

**Aviso**: Apaga todos os containers e volumes.

```sh
./bin/linux/clean.sh $(pwd)
```
