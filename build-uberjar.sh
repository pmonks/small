#!/bin/bash

mkdir -p ./uberjar/etc

cp etc/config-openshift.edn ./uberjar/etc/config.edn
cp etc/log4j-openshift.properties ./uberjar/etc/log4j.properties

mv "$(lein uberjar | sed -n 's/^Created \(.*standalone\.jar\)/\1/p')" uberjar/bot-unfurl-standalone.jar
