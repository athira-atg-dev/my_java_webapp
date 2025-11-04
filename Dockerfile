# Use official Tomcat base image with Java
FROM tomcat:9-jdk11

# Maintainer information
LABEL maintainer="athira"

# Copy the WAR file built by Maven into Tomcat's webapps directory
COPY java-web-app/target/java-web-app.war /usr/local/tomcat/webapps/myapp.war

# Expose port 8080 for external access
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]

