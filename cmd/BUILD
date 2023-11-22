load("@rules_go//go:def.bzl", "go_binary", "go_library")
load("@gazelle//:def.bzl", "gazelle")

# gazelle:prefix github.com/abitofhelp/multimod/cmd
gazelle(name = "gazelle")

go_library(
    name = "cmd_lib",
    srcs = ["cmd.go"],
    importpath = "github.com/abitofhelp/multimod/cmd",
    deps = [
        "@com_github_dustin_go_humanize//:go-humanize",
        "//vendor/github.com/abitofhelp/multimod/pkg/lib_a:lib_a",
        "//vendor/github.com/abitofhelp/multimod/pkg/lib_b:lib_b",
    ],
    visibility = ["//visibility:private"],
)

go_binary(
    name = "cmd",
    embed = [":cmd_lib"],
    visibility = ["//visibility:public"],
)
