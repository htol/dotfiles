#!/usr/bin/env bash
JDTL_DIR=$HOME/.local/jdt-ls-1.2.0
JAR=$JDTL_DIR/plugins/org.eclipse.equinox.launcher_*.jar
GRADLE_HOME=$HOME/.local/sdkman/candidates/gradle/current
JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")
JDTLS_CONFIG=$JDTL_DIR/config_linux
WORKSPACE=$HOME/repos

# cmd = { "/usr/lib/jvm/adoptopenjdk-11-hotspot-amd64/bin/java",
# "-Declipse.application=org.eclipse.jdt.ls.core.id1",
# "-Dosgi.bundles.defaultStartLevel=4",
# "-Declipse.product=org.eclipse.jdt.ls.core.product",
# "-Dlog.protocol=true",
# "-Dlog.level=ALL",
# "-Xms1g",
# "-Xmx2G",
# "-jar",
# "vim.NIL",
# "-configuration",
# "vim.NIL",
# "-data",
# "vim.NIL",
# "--add-modules=ALL-SYSTEM",
# "--add-opens java.base/java.util=ALL-UNNAMED",
# "--add-opens java.base/java.lang=ALL-UNNAMED" }

GRADLE_HOME=$GRADLE_HOME $JAVA_HOME/bin/java \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -Xms1g \
  -Xmx2G \
  -jar $(echo "$JAR") \
  -configuration "$JDTLS_CONFIG" \
  -data "$WORKSPACE" \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED
