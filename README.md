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


### Kubernetes Deprecated API
Based on [K8S Blog about deprecation](https://kubernetes.io/blog/2020/09/03/warnings/#metrics)

Requirements: collect apiServer Metrics `collector.apiServerMetrics=true`

![Kube Deprecated API Dashboard preview](images/kube-deprecated-api.png)


## Terraform

```sh
$ export TF_VAR_WAVEFRONT_ADDRESS="cluster.wavefront.com"
$ export TF_VAR_WAVEFRONT_TOKEN="your-wf-token-secret"
$ terraform plan
```
