#!/bin/bash

export WILDCARD=`grep subdomain: /etc/origin/master/master-config.yaml | awk '{print $2}'`
export IP=`ip addr show eth0 | grep 'inet\b' | awk '{print $2}' | cut -d/ -f1`

mkdir /tmp/01 && mkdir /tmp/02 && mkdir /tmp/03 && mkdir /tmp/04
oc create -f assets/pv1.yaml
oc create -f assets/pv2.yaml
oc create -f assets/pv3.yaml
oc create -f assets/pv4.yaml

oc login https://$IP:8443 --username=demo --password=password --certificate-authority=/etc/origin/master/openshift-master.crt --insecure-skip-tls-verify=true
oc new-project 3scale
oc new-app -f https://raw.githubusercontent.com/3scale/3scale-amp-openshift-templates/2.2.0.GA/amp/amp.yml -p WILDCARD_DOMAIN=$WILDCARD
