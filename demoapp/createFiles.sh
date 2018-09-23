#!/bin/bash

WILDCARD=`grep subdomain: /etc/origin/master/master-config.yaml | awk '{print $2}'`
oc login https://master:8443 --username=demo --password=password --certificate-authority=/etc/origin/master/openshift-master.crt --insecure-skip-tls-verify=true
oc new-project 3scale
oc new-app -f https://raw.githubusercontent.com/3scale/3scale-amp-openshift-templates/2.2.0.GA/amp/amp.yml -p WILDCARD_DOMAIN=$WILDCARD
