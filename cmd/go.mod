module github.com/abitofhelp/multimod/cmd

go 1.21

require (
	github.com/abitofhelp/multimod/lib_a v0.0.1
	github.com/abitofhelp/multimod/lib_b v0.0.1
	github.com/dustin/go-humanize v1.0.1
)

replace (
	"github.com/abitofhelp/multimod/lib_a" => ".//lib_a"
	"github.com/abitofhelp/multimod/lib_b" => ".//lib_b"
)