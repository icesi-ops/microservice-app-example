# Imagen base
FROM openzipkin/zipkin:latest

# Puerto que usará Zipkin
EXPOSE 9411

# Configuración de Zipkin
COPY zipkin.jar /zipkin.jar
CMD ["java", "-jar", "/zipkin.jar"]
