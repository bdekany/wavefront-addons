package main

import (
    "fmt"
    "log"
    "os"

    wavefront "github.com/WavefrontHQ/go-wavefront-management-api/v2"
)

func main() {
    client, err := wavefront.NewClient(
        &wavefront.Config{
            Address: os.Getenv("WAVEFRONT_ADDRESS"),
            Token:     os.Getenv("WAVEFRONT_TOKEN"),
        },
    )
	if err != nil {
		log.Fatal(err)
	}

	alerts := client.Alerts()

	// Name of alerts to search
	alertsToDelete := [...]string{
		"too many containers not running",
		"too many pods crashing",
	}

	for n := range alertsToDelete {

		// Create a search Struct for each alert name
		sc := []*wavefront.SearchCondition{
			&wavefront.SearchCondition{
				Key: "name",
				Value: alertsToDelete[n],
				MatchingMethod: "CONTAINS",
			},
		}

		// Find and delete alert (uninstall or sent to trash)
		res, err := alerts.Find(sc)
		if err != nil {
			log.Fatal(err)
		}
	
		for _, a := range res {
			fmt.Println("alert to be deleted: ", a.Name, *a.ID)

			err := alerts.Delete(a, false)
			if err != nil {
				log.Fatal(err)
			}
		}

	}

	derivedMetrics := client.DerivedMetrics()

	dm := &wavefront.DerivedMetric{
		Name:    "Pod Running Ratio",
		Query:   "aliasMetric(count(ts(kubernetes.pod.status.phase, phase=\"Running\" or phase=\"Succeeded\"), cluster) / count(ts(kubernetes.pod.status.phase), cluster), \"pod_running_ratio\")",
		Minutes: 5,
		Tags: wavefront.WFTags{
			CustomerTags: []string{"community"},
		},
	}

	// Create the DerivedMetric on Wavefront
	err = derivedMetrics.Create(dm)
	if err != nil {
		log.Fatal(err)
	}

	// The ID field is now set, so we can update/delete the DerivedMetric
	fmt.Println("derived metric ID is", *dm.ID)

	a := &wavefront.Alert{
		Name:                "K8S too many pods crashing - using derived metrics",
		Condition:           "ts(pod_running_ratio) < 0.8",
		DisplayExpression:   "ts(pod_running_ratio)",
		Minutes:             5,
		ResolveAfterMinutes: 5,
		Severity:            "SEVERE",
		Tags:                []string{"community",},
	}

	// Create the alert on Wavefront
	err = alerts.Create(a)
	if err != nil {
		log.Fatal(err)
	}

	// The ID field is now set, so we can update/delete the Alert
	fmt.Println("alert ID is", *a.ID)




}