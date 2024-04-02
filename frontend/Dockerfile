#FROM node:20-alpine
#WORKDIR /app
#COPY . .
#ENV AUTH_API_ADDRESS=http://127.0.0.1:8000
#ENV TODOS_API_ADDRESS=http://127.0.0.1:8082
#ENV PORT=8080
#RUN npm install node-sass@9.0
#RUN npm run build
#CMD [ "npm start" ]
FROM node:8.17.0

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el archivo package.json y package-lock.json (si existe)
COPY . .

# Instalar las dependencias
RUN npm install
# Compilar la aplicación
RUN npm run build

ENV PORT=8080
ENV AUTH_API_ADDRESS=http://auth-api:8000
ENV TODOS_API_ADDRESS=http://todos-api:8082

CMD ["npm", "start"]