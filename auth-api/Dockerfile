# Dockerfile - auth-api

# Usar la imagen oficial de Go
FROM golang:1.18.2

# Establecer un directorio de trabajo
WORKDIR /app

# Copiar todo el contenido del directorio actual al contenedor
COPY . .

# Configurar Go modules
RUN go mod init github.com/bortizf/microservice-app-example/tree/master/auth-api
RUN go mod tidy

# Construir la aplicación
RUN go build -o auth-api

# Establecer las variables de entorno (puedes ajustar los valores por defecto si es necesario)
ENV AUTH_API_PORT=8000
ENV USERS_API_ADDRESS=http://127.0.0.1:8083
ENV JWT_SECRET=PRFT

# Exponer el puerto 8000
EXPOSE 8000

# Comando para ejecutar la aplicación
CMD ["./auth-api"]
