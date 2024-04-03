# Primera etapa: construir la aplicación
FROM node:8.17.0 AS build

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia el archivo package.json y package-lock.json al directorio de trabajo
COPY package*.json ./

# Instala las dependencias del proyecto
RUN npm install

# Copia el resto del código de la aplicación al directorio de trabajo
COPY . .

# Construye la aplicación
RUN npm run build

EXPOSE 8080

ENTRYPOINT ["npm", "run", "start"]

