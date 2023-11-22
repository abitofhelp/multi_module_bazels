load("@rules_go//go:def.bzl", "go_library")
load("@gazelle//:def.bzl", "gazelle")

# gazelle:prefix github.com/abitofhelp/multi_module_bazels/lib_a
gazelle(name = "gazelle")

go_library(
    name = "lib_a",
    srcs = ["lib_a.go"],
    deps = [],
    visibility = ["//visibility:public"],
)
