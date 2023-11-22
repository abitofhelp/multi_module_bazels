module github.com/abitofhelp/multimods/pkg/lib_a

go 1.21

require github.com/dustin/go-humanize v1.0.1

require (
	github.com/abitofhelp/multimods/pkg/lib_a v0.0.1
	github.com/abitofhelp/multimods/pkg/lib_b v0.0.1
)

replace (
	github.com/abitofhelp/multimods/pkg/lib_a => /Users/mike/Go/src/github.com/abitofhelp/multimods/pkg/lib_a
	github.com/abitofhelp/multimods/pkg/lib_b => /Users/mike/Go/src/github.com/abitofhelp/multimods/pkg/lib_b
)