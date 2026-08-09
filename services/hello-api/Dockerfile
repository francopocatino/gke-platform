# ---- Build stage ----
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /workspace
COPY app/pom.xml app/pom.xml
RUN mvn -f app/pom.xml -q -DskipTests dependency:go-offline
COPY app app
RUN mvn -f app/pom.xml -q -DskipTests package

# ---- Runtime stage ----
FROM eclipse-temurin:17-jre
RUN useradd -r -u 10001 app
USER app
WORKDIR /app
COPY --from=build /workspace/app/target/*.jar /app/app.jar
ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
