load("@rules_go//go:def.bzl", "go_library")
load("@gazelle//:def.bzl", "gazelle")

# gazelle:prefix github.com/abitofhelp/multimods/pkg/lib_a
gazelle(name = "gazelle")

go_library(
    name = "lib_a",
    srcs = ["lib_a.go"],
    deps =  [],
    visibility = ["//visibility:public"],
)

alias(
    name = "go_default_library",
    actual = ":lib_a",
    visibility = ["//visibility:public"],
)