#!/bin/bash

printf 'dashboards = [\n' > terraform.tfvars
find . -name "*.json" ! -path "./.*" -exec printf '  "%s",\n' {} \; >> terraform.tfvars
printf ']\n' >> terraform.tfvars
