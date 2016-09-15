#!/bin/bash

gcp-cups-connector-util init --share-scope "$1" --proxy-name="$2" --local-printing-enable --cloud-printing-enable
