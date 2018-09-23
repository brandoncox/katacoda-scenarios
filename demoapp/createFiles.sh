#!/bin/bash

export WILDCARD=`grep subdomain: /katacoda/config/master/master-config.yaml | awk '{print $2}'`
export IP=`ip addr show eth0 | grep 'inet\b' | awk '{print $2}' | cut -d/ -f1`

git clone https://github.com/brandoncox/katacoda-scenarios.git

docker pull registry.access.redhat.com/3scale-amp22/system:1.7
docker pull registry.access.redhat.com/3scale-amp22/backend:1.6
docker pull registry.access.redhat.com/3scale-amp22/apicast-gateway:1.8
docker pull registry.access.redhat.com/3scale-amp22/wildcard-router:1.6
docker pull registry.access.redhat.com/rhscl/postgresql-95-rhel7:9.5
docker pull registry.access.redhat.com/3scale-amp22/zync:1.6


mkdir /tmp/01 && mkdir /tmp/02 && mkdir /tmp/03 && mkdir /tmp/04
oc create -f ./katacoda-scenarios/demoapp/assets/pv1.yaml
oc create -f ./katacoda-scenarios/demoapp/assets/pv2.yaml
oc create -f ./katacoda-scenarios/demoapp/assets/pv3.yaml
oc create -f ./katacoda-scenarios/demoapp/assets/pv4.yaml

oc login https://$IP:8443 --username=demo --password=password
oc new-project 3scale
oc new-app -f https://raw.githubusercontent.com/3scale/3scale-amp-openshift-templates/2.2.0.GA/amp/amp.yml -p WILDCARD_DOMAIN=$WILDCARD
