FROM atlassian/bitbucket-server:latest

USER root

# 将代理破解包加入容器
COPY "atlassian-agent.jar" /opt/atlassian/bitbucket/

# 设置启动加载代理包
RUN cp /opt/atlassian/bitbucket/bin/_start-webapp.sh /opt/atlassian/bitbucket/bin/_start-webapp.sh.bk
RUN sed -i 's?^JAVA_OPTS=.*$?JAVA_OPTS="-javaagent:/opt/atlassian/bitbucket/atlassian-agent.jar -classpath $INST_DIR/app $JAVA_OPTS $BITBUCKET_ARGS $JMX_OPTS $JVM_REQUIRED_ARGS $JVM_SUPPORT_RECOMMENDED_ARGS"?g' /opt/atlassian/bitbucket/bin/_start-webapp.sh
