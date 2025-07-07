package main

import (
	"context"
	"fmt"

	"github.com/docker/docker/api/types/container"
	"github.com/docker/docker/api/types/filters"
	"github.com/docker/docker/client"
)

func main() {
	ctx := context.Background()
	cli, err := client.NewClientWithOpts(client.FromEnv, client.WithAPIVersionNegotiation())

	if err != nil {
		panic(err)
	}

	filter := filters.NewArgs()
	filter.Add("status", "exited")

	containers, err := cli.ContainerList(ctx, container.ListOptions{
		Filters: filter,
	})

	if err != nil {
		panic(err)
	}

	for _, c := range containers {
		fmt.Printf("Removing %s...\n", c.Names[0])
		err = cli.ContainerRemove(ctx, c.ID, container.RemoveOptions{})

		if err != nil {
			fmt.Printf("Error removing %s: %v\n", c.Names[0], err)
		}
	}

	fmt.Println("Cleanup completed.")
}
