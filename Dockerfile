# Etapa 1: Construcción
FROM openjdk:25-ea-jdk-slim AS build
WORKDIR /app
COPY . .
# Damos permisos al wrapper y compilamos
RUN chmod +x ./mvnw
RUN ./mvnw clean package -DskipTests

# Etapa 2: Ejecución
FROM openjdk:25-ea-jdk-slim
WORKDIR /app
# Copiamos el .jar generado en la etapa anterior
COPY --from=build /app/target/*.jar app.jar
# Exponemos el puerto de Tomcat
EXPOSE 8080
# Comando para arrancar la app
ENTRYPOINT ["java", "-jar", "app.jar"]