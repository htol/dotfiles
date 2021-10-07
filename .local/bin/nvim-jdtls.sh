#!/usr/bin/env bash
#
# for nvim-jdtls
#
JDTL_DIR=$HOME/.local/jdt-ls
JAR=$JDTL_DIR/plugins/org.eclipse.equinox.launcher_*.jar
export GRADLE_HOME=$HOME/.local/sdkman/candidates/gradle/current
#export GRADLE_USER_HOME=$HOME/.local/gradle
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")
JDTLS_CONFIG=$JDTL_DIR/config_linux
WORKSPACE=$HOME/repos

$JAVA_HOME/bin/java \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -Xms1g \
  -Xmx2G \
  -jar $(echo "$JAR") \
  -configuration "$JDTLS_CONFIG" \
  -data "$1" \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED
