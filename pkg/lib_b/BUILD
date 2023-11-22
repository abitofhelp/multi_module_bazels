load("@rules_go//go:def.bzl", "go_library")
load("@gazelle//:def.bzl", "gazelle")

# gazelle:prefix github.com/abitofhelp/multimods/pkg/lib_b
gazelle(name = "gazelle")

go_library(
    name = "lib_b",
    srcs = ["lib_b.go"],
    deps = [],
    visibility = ["//visibility:public"],
)

alias(
    name = "go_default_library",
    actual = ":lib_b",
    visibility = ["//visibility:public"],
)