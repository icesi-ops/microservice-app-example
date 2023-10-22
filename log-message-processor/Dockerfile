# Usar una imagen base de Python
FROM python:3.6

# Directorio de trabajo en el contenedor
WORKDIR /app

# Copiar el archivo de requisitos al contenedor
COPY requirements.txt /app/

# Instalar las dependencias usando pip3
RUN pip3 install -r requirements.txt

# Definir las variables de entorno para Redis
ENV REDIS_HOST=127.0.0.1
ENV REDIS_PORT=6379
ENV REDIS_CHANNEL=log_channel

# Copiar el código fuente de la aplicación al contenedor
COPY . /app

# Ejecutar el script principal
CMD ["python3", "main.py"]

