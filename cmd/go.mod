module github.com/abitofhelp/multimod/cmd

go 1.21

require (
	github.com/abitofhelp/multimod/pkg/lib_a v0.0.1
	github.com/abitofhelp/multimod/pkg/lib_b v0.0.1
)

require github.com/dustin/go-humanize v1.0.1 // indirect

replace (
	github.com/abitofhelp/multimod/pkg/lib_a => /Users/mike/Go/src/github.com/abitofhelp/multi_module_bazels/pkg/lib_a
	github.com/abitofhelp/multimod/pkg/lib_b => /Users/mike/Go/src/github.com/abitofhelp/multi_module_bazels/pkg/lib_b
)


