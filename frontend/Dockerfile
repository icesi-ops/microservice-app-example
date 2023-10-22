# Utiliza una imagen base de Node.js
FROM node:8.17.0

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia el archivo package.json y package-lock.json a la imagen
COPY package*.json ./

# Instala las dependencias de Node.js
RUN npm install

# Copia el resto de los archivos de la aplicación a la imagen
COPY . .

# Establece las variables de entorno requeridas
ENV PORT=8080
ENV AUTH_API_ADDRESS=http://127.0.0.1:8000
ENV TODOS_API_ADDRESS=http://127.0.0.1:8082

# Compila la aplicación (asegúrate de que tengas un script "build" definido en tu package.json)
RUN npm run build

# Expone el puerto 8080
EXPOSE 8080

# Comando para iniciar la aplicación
CMD ["npm", "start"]

