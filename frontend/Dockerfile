# Dockerfile - frontend

# Usar la imagen oficial de Node.js
FROM node:8.17.0

# Establecer un directorio de trabajo
WORKDIR /app

# Copiar el archivo package.json y package-lock.json al directorio de trabajo
COPY package*.json ./

# Instalar las dependencias
RUN npm install

# Copiar el resto de los archivos del directorio actual al contenedor
COPY . .

# Construir la aplicación
RUN npm run build

# Establecer las variables de entorno (puedes ajustar los valores por defecto si es necesario)
ENV PORT=8080
ENV AUTH_API_ADDRESS=http://127.0.0.1:8000
ENV TODOS_API_ADDRESS=http://127.0.0.1:8082

# Exponer el puerto 8080
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["npm", "start"]
