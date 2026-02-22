<div align="center">
<h1>vfox-emsdk</h1>
<span><a href="https://emscripten.org">Emscripten SDK</a> plugin for <a href="https://vfox.dev">vfox</a> / <a href="https://mise.jdx.dev">mise</a></span>
</div>
<hr />

[![License](https://img.shields.io/github/license/rektide/vfox-emsdk?style=flat-square&color=brightgreen)](https://github.com/rektide/vfox-emsdk/blob/main/LICENSE)

## Prerequisites

- [git](https://git-scm.com)
- [python3](https://www.python.org) - required by emsdk
- [cmake](https://cmake.org) - required for building from source

## Installation

### With vfox

```bash
vfox add emsdk --source https://github.com/rektide/vfox-emsdk/archive/refs/tags/v1.0.0.zip
vfox install emsdk@latest
vfox use emsdk@latest
```

### With mise

```bash
mise plugin install emsdk https://github.com/rektide/vfox-emsdk
mise install emsdk@latest
```

Or add to your `.mise.toml`:

```toml
[tools]
emsdk = "latest"
```

### Using a local checkout (development)

To use a locally checked out copy of this plugin with mise:

```bash
# Add the local plugin
mise plugin install emsdk file:///path/to/vfox-emsdk

# Or using a relative path from your project
mise plugin install emsdk file://../vfox-emsdk
```

Alternatively, set it in `.mise.toml`:

```toml
[plugins]
emsdk = "file:///path/to/vfox-emsdk"

[tools]
emsdk = "latest"
```

To update after making changes to the plugin:

```bash
mise plugin uninstall emsdk
mise plugin install emsdk file:///path/to/vfox-emsdk
```

## Usage

```bash
emsdk --help
emcc --version
em++ --version
```

## Environment Variables

This plugin sets the following environment variables:

- `EMSDK` - Path to emsdk installation
- `EM_CONFIG` - Path to .emscripten config
- `EMSCRIPTEN_ROOT` - Path to emscripten directory
- `EMCC_CACHE` - Path to emscripten cache
- `LLVM` / `LLVM_ROOT` / `EM_LLVM_ROOT` - Path to LLVM binaries
- `BINARYEN` / `BINARYEN_ROOT` / `EM_BINARYEN_ROOT` - Path to binaryen

## Notes

- First installation may take several minutes as emsdk compiles tools from source
- The `emsdk install` and `emsdk activate` commands are run automatically during installation

## License

Licensed under the [Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0).
