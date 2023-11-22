load("@rules_go//go:def.bzl", "go_binary", "go_library")
load("@gazelle//:def.bzl", "gazelle")

# gazelle:prefix github.com/abitofhelp/multimods/cmd
gazelle(name = "gazelle")

go_library(
    name = "cmd_lib",
    srcs = ["cmd.go"],
    importpath = "github.com/abitofhelp/multimods/cmd",
    deps = [
        "@com_github_dustin_go_humanize//:go-humanize",
        "//vendor/github.com/abitofhelp/multimods/pkg/lib_a:lib_a",
        "//vendor/github.com/abitofhelp/multimods/pkg/lib_b:lib_b",
    ],
    visibility = ["//visibility:private"],
)

go_binary(
    name = "cmd",
    embed = [":cmd_lib"],
    visibility = ["//visibility:public"],
)
