# Usamos una imagen base de OpenJDK 8
FROM openjdk:8-jdk

# Establecemos el directorio de trabajo en el contenedor
WORKDIR /app

# Copiamos todos los archivos del proyecto al directorio de trabajo
COPY . .

# Construimos el proyecto con Maven
RUN ./mvnw clean install

# Exponemos el puerto que utiliza Users API (modificar si es necesario)
EXPOSE 8083

# Comando para correr el servicio
ENTRYPOINT ["java", "-jar", "target/users-api-0.0.1-SNAPSHOT.jar"]
