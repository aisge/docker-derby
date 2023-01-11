FROM eclipse-temurin:19-jre-alpine

ENV DERBY_VERSION=10.16.1.1
ENV DERBY_HOME=/derby
ENV DERBY_LIB=${DERBY_HOME}/lib
ENV CLASSPATH=${DERBY_LIB}/derby.jar:${DERBY_LIB}/derbynet.jar:${DERBY_LIB}/derbytools.jar:${DERBY_LIB}/derbyoptionaltools.jar:${DERBY_LIB}/derbyclient.jar

ADD entrypoint.sh /entrypoint.sh

RUN \
  apk update && apk add wget netcat-openbsd && \
  wget https://dlcdn.apache.org//db/derby/db-derby-${DERBY_VERSION}/db-derby-${DERBY_VERSION}-bin.tar.gz && \
  tar xzf /db-derby-${DERBY_VERSION}-bin.tar.gz && \
  mv /db-derby-${DERBY_VERSION}-bin /derby && \
  chmod +x /entrypoint.sh && \
  rm -Rf /*.tar.gz /derby/demo /derby/test /derby/javadoc && \
  apk del wget 

WORKDIR /data
EXPOSE 1527

HEALTHCHECK --interval=1m --timeout=5s \
   CMD nc -z localhost 1527 || exit 1

CMD ["sh", "-c", "/entrypoint.sh"]   
