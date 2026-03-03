
# Build Stage
FROM maven:3.8.6-openjdk-8-slim AS builder
WORKDIR /app

# Point to the correct folder in your repo
COPY EcommerceApp/pom.xml .
RUN mvn dependency:go-offline

COPY EcommerceApp/src ./src
RUN mvn clean package -DskipTests

# Run Stage
FROM tomcat:9.0-jdk8-openjdk-slim
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
