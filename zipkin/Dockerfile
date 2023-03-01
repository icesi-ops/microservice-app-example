# Imagen base
FROM openzipkin/zipkin

# Descargar el archivo zipkin.jar
RUN wget -O /zipkin.jar https://search.maven.org/remote_content?g=io.zipkin.java&a=zipkin-server&v=LATEST&c=exec

# Puerto que usará Zipkin
EXPOSE 9411

# Configuración de Zipkin
COPY zipkin.jar /

CMD ["java", "-jar", "/zipkin.jar"]
