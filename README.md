# wavefront-dashboards

Collection of dashboards in JSON format for Tanzu Observability by Wavefront

## Getting started

Create a new dashboard and import JSON Code

![import json as code](images/import-json.png)

## Dashboards

### Harbor
Based on [Grafana Dashboard](https://github.com/goharbor/harbor/tree/main/contrib/grafana-dashborad)

Works with: 
 - Harbor Community Helm Chart
 - Tanzu Package

![Harbor Dashboard preview](images/harbor-community.png)

### Confluent Cloud (kafka)
Based on [Prometheus Exporter for Confluent Cloud](https://www.confluent.io/fr-fr/blog/bring-your-own-monitoring-with-confluent-cloud/#prometheus)

> metrics prefix need to be `prometheus`or to be change in JSON

![Confluent Cloud Dashboard preview](images/confluent-cloud.png)