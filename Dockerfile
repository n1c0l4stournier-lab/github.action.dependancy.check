FROM registry.access.redhat.com/ubi8/ubi-minimal:8.3 

ARG JAVA_PACKAGE=java-1.8.0-openjdk

ARG RUN_JAVA_VERSION=1.3.8

ENV \
    LANG='en_US.UTF-8' \
    LANGUAGE='en_US:en' \
    JAVA_OPTIONS=""
    
RUN microdnf install curl ca-certificates ${JAVA_PACKAGE} \
    && microdnf update \
    && microdnf clean all \
    && mkdir /deployments \
    && chown 1001 /deployments \
    && chmod "g+rwX" /deployments \
    && chown 1001:root /deployments \
    && curl https://repo1.maven.org/maven2/io/fabric8/run-java-sh/${RUN_JAVA_VERSION}/run-java-sh-${RUN_JAVA_VERSION}-sh.sh -o /deployments/run-java.sh \
    && chown 1001 /deployments/run-java.sh \
    && chmod 540 /deployments/run-java.sh \
    && echo "securerandom.source=file:/dev/urandom" >> /etc/alternatives/jre/lib/security/java.security
    
#COPY target/lib/* /deployments/lib/

COPY target/*.jar /deployments/app.jar

EXPOSE 8080

USER 1001

ENTRYPOINT [ "/deployments/run-java.sh" ]
