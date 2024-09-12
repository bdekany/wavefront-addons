# Description

Observing Many k8s clusters can generate a very high number of metrics and high cardinality.

In order to deal with the large amount of data points the usage of derived metrics is the best solution.

## Actions

- Create a new Derived Metric (pod_running_ratio)
- Create a new Alert using the Derived metric
- Interactively delete previous alerts

## Usage

```shell
docker run --rm -it -v $PWD:/go/src -w /go/src  golang bash
```

```shell
root@0ee70638900d:/go/src# export WAVEFRONT_ADDRESS=CLUSTER.wavefront.com
root@0ee70638900d:/go/src# export WAVEFRONT_TOKEN=xxx-yyy-zzz
root@0ee70638900d:/go/src# go run wfcli.go 
derived metric ID is 1726149891800
alert ID is 1726149892185
Do you want to delete:  K8s too many pods crashing 1717016892865
Using query: count(ts(kubernetes.pod.status.phase, phase="Running" or phase="Succeeded"), cluster, type, namespace_name, sources) / count(ts(kubernetes.pod.status.phase), cluster, type, namespace_name, sources)
[Y/n]: y
````
