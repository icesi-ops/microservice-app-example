# Imagen base
FROM redis:latest

# Puerto que usará Redis
EXPOSE 6379

# Configuración de Redis
COPY redis.conf /usr/local/etc/redis/redis.conf
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
