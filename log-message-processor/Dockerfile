# Dockerfile - log-message-processor

# Usar la imagen oficial de Python
FROM python:3.6

# Establecer un directorio de trabajo
WORKDIR /app

# Copiar el archivo requirements.txt al directorio de trabajo
COPY requirements.txt .

# Instalar las dependencias
RUN pip3 install -r requirements.txt

# Copiar el resto de los archivos del directorio actual al contenedor
COPY . .

# Establecer las variables de entorno (puedes ajustar los valores por defecto si es necesario)
ENV REDIS_HOST=127.0.0.1
ENV REDIS_PORT=6379
ENV REDIS_CHANNEL=log_channel

# Comando para ejecutar la aplicación
CMD ["python3", "main.py"]


