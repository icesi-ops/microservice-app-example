# Imagen base
FROM openzipkin/zipkin

# Puerto que usará Zipkin
EXPOSE 9411

# Configuración de Zipkin
COPY zipkin.jar /

CMD ["java", "-jar", "/zipkin.jar"]
