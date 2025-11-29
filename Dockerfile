FROM eclipse-temurin:21-jdk-alpine AS builder

WORKDIR /app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src /app/src

RUN --mount=type=cache,target=/root/.m2 ./mvnw package -DskipTests

ARG JAR_FILE=/app/target/bank-cards-management-system-1.0.jar

FROM eclipse-temurin:21-jre-alpine

COPY --from=builder ${JAR_FILE} bank-cards-management-system-1.0.jar

ENTRYPOINT ["java", "-jar", "/bank-cards-management-system-1.0.jar"]