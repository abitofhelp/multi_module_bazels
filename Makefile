# Makefile

PROJECT_NAME=multimods
MODULE_NAME=github.com/abitofhelp/$(PROJECT_NAME)
PROJECT_DIR=$(GOPATH)/src/$(MODULE_NAME)

BZLPKG=bazel
BAZEL_BUILD_OPTS:=--verbose_failures --sandbox_debug
GOCMD=$(BZLPKG) run @rules_go//go
PKG_DIR=$(PROJECT_DIR)/pkg

LIB_A_DIR=$(PKG_DIR)/lib_a
LIB_A_WORKSPACE=//pkg/lib_a
LIB_A_TARGET=//pkg/lib_a:lib_a

LIB_B_DIR=$(PKG_DIR)/lib_b
LIB_B_WORKSPACE=//pkg/lib_b
LIB_B_TARGET=//pkg/lib_b:lib_b

CMD_DIR=$(PROJECT_DIR)/cmd
CMD_WORKSPACE=//cmd
CMD_TARGET=//cmd:cmd

build_lib_a:
	$(BZLPKG) build $(BAZEL_BUILD_OPTS) $(LIB_A_TARGET)

build_lib_b:
	$(BZLPKG) build $(BAZEL_BUILD_OPTS) $(LIB_B_TARGET)

build_cmd:
	$(BZLPKG) build $(BAZEL_BUILD_OPTS) $(CMD_TARGET)

clean:
	# Removes bazel-created output, including all object files, and bazel metadata.
	pushd $(LIB_A_DIR) && \
	$(BZLPKG) clean --async && \
	popd;

	pushd $(LIB_B_DIR) && \
	$(BZLPKG) clean --async && \
	popd;

	pushd $(CMD_DIR) && \
	$(BZLPKG) clean --async && \
	popd;

clean_deep:
	# The entire working tree will be removed and the server stopped.
	pushd $(LIB_A_DIR) && \
	$(BZLPKG) clean --expunge --async && \
	popd;

	pushd $(LIB_B_DIR) && \
	$(BZLPKG) clean --expunge --async && \
	popd;

	pushd $(CMD_DIR) && \
	$(BZLPKG) clean --expunge --async && \
	popd;

expand_golang_build:
	$(BZLPKG) query $(LIB_A_TARGET) --output=build

gazelle_generate_build_bazel:
#	 This will generate new BUILD.bazel files for your project. You can run the same command in the future to update existing BUILD.bazel files to include new source files or options.
	$(BZLPKG) run $(BAZEL_BUILD_OPTS) //:gazelle

gazelle_update_deps:
	# Import repositories from go.mod and update Bazel's macro and rules.
	pushd $(LIB_A_DIR) && \
	$(BZLPKG) run $(BAZEL_BUILD_OPTS) //:gazelle -- update-repos -from_file="go.mod" -to_macro="deps.bzl%go_dependencies" -prune && \
	popd;

	pushd $(LIB_B_DIR) && \
	$(BZLPKG) run $(BAZEL_BUILD_OPTS) //:gazelle -- update-repos -from_file="go.mod" -to_macro="deps.bzl%go_dependencies" -prune && \
	popd;

	pushd $(CMD_DIR) && \
	$(BZLPKG) run $(BAZEL_BUILD_OPTS) //:gazelle -- update-repos -from_file="go.mod" -to_macro="deps.bzl%go_dependencies" -prune && \
	popd;

go_mod_download:
	pushd $(LIB_A_DIR) && \
	$(GOCMD) -- mod download && \
	popd;

	pushd $(LIB_B_DIR) && \
	$(GOCMD) -- mod download && \
	popd;

	pushd $(CMD_DIR) && \
	$(GOCMD) -- mod download && \
	popd;

go_mod_tidy:
	pushd $(LIB_A_DIR) && \
	$(GOCMD) -- mod tidy && \
	popd;

	pushd $(LIB_B_DIR) && \
	$(GOCMD) -- mod tidy && \
	popd;

	pushd $(CMD_DIR) && \
	$(GOCMD) -- mod tidy && \
	popd;

go_mod_vendor:
	pushd $(LIB_A_DIR) && \
	$(GOCMD) -- mod vendor -v && \
	popd;

	pushd $(LIB_B_DIR) && \
	$(GOCMD) -- mod vendor -v && \
	popd;

	pushd $(CMD_DIR) && \
	$(GOCMD) -- mod vendor -v && \
	popd;

go_mod_verify:
	## Verify that the go.sum file matches what was downloaded to prevent someone “git push — force” over a tag being used.
	pushd $(LIB_A_DIR) && \
	$(GOCMD) -- mod verify && \
	popd;

	pushd $(LIB_B_DIR) && \
	$(GOCMD) -- mod verify && \
	popd;

	pushd $(CMD_DIR) && \
	$(GOCMD) -- mod verify && \
	popd;

go_targets:
	$(BZLPKG) query "@io_bazel_rules_go//go:*"

list_targets:
	$(BZLPKG) query //...

set_golang_version:
	sed -E -i '.org' 's/go 1.21.3/go 1.21.4/g' "$(PROJECT_DIR)/go.work" && rm "$(PROJECT_DIR)/go.work.org" && \
	sed -E -i '.org' 's/go 1.21.3/go 1.21.4/g' "$(LIB_A_DIR)/go.mod" && rm "$(LIB_A_DIR)/go.mod.org" && \
  	sed -E -i '.org' 's/go 1.21.3/go 1.21.4/g' "$(LIB_A_DIR)/MODULE.bazel" && rm "$(LIB_A_DIR)/MODULE.bazel.org" && \
    sed -E -i '.org' 's/go 1.21.3/go 1.21.4/g' "$(LIB_B_DIR)/go.mod" && rm "$(LIB_B_DIR)/go.mod.org" && \
  	sed -E -i '.org' 's/go 1.21.3/go 1.21.4/g' "$(LIB_B_DIR)/MODULE.bazel" && rm "$(LIB_B_DIR)/MODULE.bazel.org" && \
	sed -E -i '.org' 's/go 1.21.3/go 1.21.4/g' "$(CMD_DIR)/go.mod" && rm "$(CMD_DIR)/go.mod.org" && \\
	sed -E -i '.org' 's/go 1.21.3/go 1.21.4/g' "$(CMD_DIR)/MODULE.bazel" && rm "$(CMD_DIR)/MODULE.bazel.org" && \\
	#sed -E -i '.org' 's/GO_VERSION = "1.21.3"/GO_VERSION = "1.21.4"/g' "$(PROJECT_DIR)/WORKSPACE" && rm "$(PROJECT_DIR)/WORKSPACE.org" ;

## The generate_repos at the end of the command string is not an error.
## Verify the BUILD.bazel files that have been changed.  It is possible that duplicate targets were created.
sync_from_gomod: go_mod_download go_mod_tidy go_mod_vendor go_mod_verify gazelle_update_deps

sync_from_gomod_force: go_mod_download go_mod_tidy go_mod_vendor go_mod_verify gazelle_generate_build_bazel gazelle_update_deps gazelle_generate_build_bazel

tidy: clean
	@rm -rf vendor
	go mod tidy
	go mod vendor -v

zap: clean
	@rm go.sum
	@rm -rf vendor
	go clean -modcache -cache
	go mod download
	go mod tidy
	go mod vendor -v