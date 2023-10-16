# Usamos una imagen base de Node 8.17.0
FROM node:8.17.0

# Establecemos el directorio de trabajo en el contenedor
WORKDIR /app

# Copiamos el package.json y package-lock.json (si está presente)
COPY package*.json ./

# Instalamos las dependencias del proyecto
RUN npm install

# Copiamos el resto de los archivos del proyecto al directorio de trabajo
COPY . .

# Exponemos el puerto que utiliza TODOs API (modificar si es necesario)
EXPOSE 8082

# Comando para correr el servicio
CMD ["npm", "start"]
