load("@rules_go//go:def.bzl", "go_library")
load("@gazelle//:def.bzl", "gazelle")

# gazelle:prefix github.com/abitofhelp/multimod/pkg/lib_a
gazelle(name = "gazelle")

go_library(
    name = "lib_a",
    srcs = ["lib_a.go"],
    deps = ["@com_github_dustin_go_humanize//:go-humanize"],
    visibility = ["//visibility:public"],
)
