# multi_module_bazels   

This project demonstrates how to implement a monorepo using bzlmod and supporting Gazelle.

The issue is that Gazelle only permits configuring one go.mod file, which cannot have a path, in the root's MODULE.bazel, as shown below:  

```
# Register the go.mod file with the go_deps extension.
# The go_deps extension parses this file directly, so external tooling such as gazelle update-repos is no longer needed.
go_deps = use_extension("@gazelle//:extensions.bzl", "go_deps")
go_deps.from_file(go_mod = "//:go.mod")
```

So, if there are multiple projects in the monorepo and each one has its own go.mod file, we cannot configure them at the root level.
Each project has to implement it own Bazel & go module.

I am going to share this project with others to determine whether there is a better way to achieve this goal...
