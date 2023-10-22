# Use the official Node.js image as the base image
FROM node:8.17.0

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia el archivo package.json y package-lock.json al directorio de trabajo
COPY package*.json ./

# Instala las dependencias de la aplicación
RUN npm install

# Copia todo el contenido del directorio actual al directorio de trabajo
COPY . .

# Define las variables de entorno
ENV JWT_SECRET=PRFT
ENV TODO_API_PORT=8082

# Expone el puerto 8082 (puede ser diferente al puerto de escucha de tu aplicación)
EXPOSE 8082

# Inicia la aplicación
CMD ["npm", "start"]

