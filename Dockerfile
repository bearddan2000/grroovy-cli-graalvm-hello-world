FROM gradle AS builder

WORKDIR /workspace

COPY bin .

RUN gradle clean assemble shadowJar

FROM ghcr.io/graalvm/graalvm-ce:ol8-java11-22.3.3

ENV APP Main

WORKDIR /workspace

RUN gu install native-image

WORKDIR /code

COPY bin .

COPY --from=builder /workspace .

RUN native-image -cp build/libs/workspace-all.jar example.Main $APP

# Use  this if there is reflection
# https://e.printstacktrace.blog/graalvm-and-groovy-how-to-start/
# RUN native-image -cp build/libs/workspace-all.jar example.Main Main \
#     --allow-incomplete-classpath \
#     --report-unsupported-elements-at-runtime \
#     --initialize-at-build-time \
#     --initialize-at-run-time=org.codehaus.groovy.vmplugin.v8.CacheableCallSite \
#     --no-fallback \
#     --no-server \
#     -H:ReflectionConfigurationFiles=reflections.json

CMD "./${APP}"