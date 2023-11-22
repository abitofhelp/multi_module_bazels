load("@rules_go//go:def.bzl", "go_binary", "go_library")
load("@gazelle//:def.bzl", "gazelle")

# gazelle:prefix github.com/abitofhelp/multimods/cmd
gazelle(name = "gazelle")



go_library(
    name = "cmd_lib",
    srcs = ["cmd.go"],
    importpath = "github.com/abitofhelp/multimods/cmd",
    deps = [
         "//pkg/lib_a:go_default_library",
         "//pkg/lib_b:go_default_library",
    ],
    visibility = ["//visibility:private"],
)

go_binary(
    name = "cmd",
    embed = [":cmd_lib"],
    visibility = ["//visibility:public"],
)

