# multi_module_bazels   

This project demonstrates how to implement a monorepo using bzlmod and Gazelle.

The issue is that Gazelle only permits configuring one go.mod file, which cannot have a path, in the root's MODULE.bazel, as shown below:  

```
# Register the go.mod file with the go_deps extension.
# The go_deps extension parses this file directly, so external tooling such as gazelle update-repos is no longer needed.
go_deps = use_extension("@gazelle//:extensions.bzl", "go_deps")
go_deps.from_file(go_mod = "//:go.mod")
```

So, if there are multiple projects in the monorepo and each one has its own go.mod file, we cannot configure them at the root level.
Each project has to implement it own Bazel & go module.

ISSUES:

Each project builds properly at its level (lib_a, lib_b).  However, when I try to build the entire project from the root, I
receive the following error.  I am still investigating it...

```
(20:18:53) ERROR: <builtin>: fetching local_repository rule //:lib_b~override: java.io.IOException: The repository's path is "./pkg/lib_b" (absolute: "/Users/mike/Go/src/github.com/abitofhelp/multi_module_bazels/pkg/lib_b") but it does not exist or is not a directory.
(20:18:53) ERROR: Error computing the main repository mapping: unknown error during computation of main repo mapping
(20:18:53) Loading:
Fetching https://bcr.bazel.build/modules/gazelle/0.34.0/MODULE.bazel
```

