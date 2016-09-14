#!/bin/bash

# sync time because of ssl certificate validation
ntpdate -B -q pool.ntp.org

gcp-cups-connector-util init --share-scope "$1" --proxy-name="$2" --local-printing-enable --cloud-printing-enable
