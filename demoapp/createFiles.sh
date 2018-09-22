#!/bin/bash

git clone https://github.com/katacoda/scenario-example
oc new-project 3scale
oc create -f https://raw.githubusercontent.com/3scale/3scale-amp-openshift-templates/2.2.0.GA/amp/amp.yml -p WILDCARD_DOMAIN=${grep subdomain: /etc/origin/master/master-config.yaml | awk '{print $2}'}
