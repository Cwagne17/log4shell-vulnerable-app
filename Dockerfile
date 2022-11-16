# ----------------------------------------------
# Build Stage
# ----------------------------------------------
FROM gradle:7.3.1-jdk17 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle bootJar --no-daemon

# ----------------------------------------------
# Serve Stage
# ----------------------------------------------
FROM openjdk:8u181-jdk-alpine
EXPOSE 8080
WORKDIR /home/app
COPY --from=build /home/gradle/src/build/libs/*.jar /home/app/spring-boot-application.jar
CMD ["java", "-jar", "/home/app/spring-boot-application.jar"]
