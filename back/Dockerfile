FROM gradle:8.7-jdk17 AS build

WORKDIR /src

COPY . .

RUN gradle build -x test --no-daemon

FROM eclipse-temurin:17-jre-jammy AS runtime

WORKDIR /app

COPY --from=build /src/build/libs/microcrm-0.0.1-SNAPSHOT.jar /app/microcrm-0.0.1-SNAPSHOT.jar

EXPOSE 8080

CMD ["java", "-jar", "/app/microcrm-0.0.1-SNAPSHOT.jar"]
