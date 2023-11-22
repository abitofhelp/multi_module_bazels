package main

import (
	"fmt"
	"github.com/abitofhelp/multimod/lib_a"
	"github.com/abitofhelp/multimod/lib_b"
)

func main() {
	fmt.Printf("\nSay '%s' from lib_a", lib_a.Howdy())

	if phx, err := lib_a.GetPhoenixNowAsRfc3339(); err == nil {
		fmt.Printf("\nNow in UTC '%s' and PHX '%s", lib_a.GetUtcNowAsRfc3339(), phx)
	} else {
		panic(fmt.Errorf("failed to get the current, local time in Phoenix: %w", err))
	}

	fmt.Printf("\nUSA Formatted Large Number: %s", lib_a.HumanizedLargeValue())

	fmt.Printf("\nSay '%s' from lib_ab, howdy", lib_b.Howdy())
}
