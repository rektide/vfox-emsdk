function PLUGIN:EnvKeys(ctx)
    local mainPath = ctx.path
    local result = {}

    table.insert(result, { key = "EMSDK", value = mainPath })

    local em_config = mainPath .. "/.emscripten"
    local em_config_f = io.open(em_config, "r")
    if em_config_f then
        em_config_f:close()
        table.insert(result, { key = "EM_CONFIG", value = em_config })
    end

    local emscripten_root = mainPath .. "/upstream/emscripten"
    local emscripten_f = io.open(emscripten_root, "r")
    if emscripten_f then
        emscripten_f:close()
        table.insert(result, { key = "EMSCRIPTEN_ROOT", value = emscripten_root })
        table.insert(result, { key = "EMCC_CACHE", value = emscripten_root .. "/cache" })
    end

    local llvm_bin = mainPath .. "/upstream/bin"
    local llvm_f = io.open(llvm_bin, "r")
    if llvm_f then
        llvm_f:close()
        table.insert(result, { key = "LLVM", value = llvm_bin })
        table.insert(result, { key = "LLVM_ROOT", value = llvm_bin })
        table.insert(result, { key = "EM_LLVM_ROOT", value = llvm_bin })
    end

    local binaryen_root = mainPath .. "/upstream"
    local binaryen_f = io.open(binaryen_root, "r")
    if binaryen_f then
        binaryen_f:close()
        table.insert(result, { key = "BINARYEN", value = binaryen_root })
        table.insert(result, { key = "BINARYEN_ROOT", value = binaryen_root })
        table.insert(result, { key = "EM_BINARYEN_ROOT", value = binaryen_root })
    end

    if RUNTIME.osType == "windows" then
        table.insert(result, { key = "PATH", value = mainPath })
        table.insert(result, { key = "PATH", value = mainPath .. "\\upstream\\bin" })
        table.insert(result, { key = "PATH", value = mainPath .. "\\upstream\\emscripten" })
    else
        table.insert(result, { key = "PATH", value = mainPath .. "/upstream/bin" })
        table.insert(result, { key = "PATH", value = mainPath .. "/upstream/emscripten" })
    end

    return result
end
