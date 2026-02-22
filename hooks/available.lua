local http = require("http")
local json = require("json")

local available_result = nil

function PLUGIN:Available(ctx)
    if available_result then
        return available_result
    end

    local resp, err = http.get({
        url = "https://api.github.com/repos/emscripten-core/emsdk/releases?per_page=100"
    })

    if err ~= nil or resp.status_code ~= 200 then
        local resp2, err2 = http.get({
            url = "https://raw.githubusercontent.com/emscripten-core/emsdk/main/emscripten-releases-tags.json"
        })
        if err2 == nil and resp2.status_code == 200 then
            local body = json.decode(resp2.body)
            local result = {}
            if body.releases then
                for version, _ in pairs(body.releases) do
                    table.insert(result, {
                        version = version,
                        note = ""
                    })
                end
            end
            table.sort(result, compare_versions)
            available_result = result
            return result
        end
        return {}
    end

    local body = json.decode(resp.body)
    local result = {}
    local seen = {}

    for _, release in ipairs(body) do
        local tag = release.tag_name
        if string.match(tag, "^%d+%.%d+%.%d+$") and not seen[tag] then
            seen[tag] = true
            table.insert(result, {
                version = tag,
                note = release.prerelease and "pre-release" or ""
            })
        end
    end

    table.sort(result, compare_versions)

    if #result == 0 then
        table.insert(result, { version = "latest", note = "Latest stable" })
        table.insert(result, { version = "tot", note = "Tip of tree" })
    end

    available_result = result
    return result
end

function compare_versions(a, b)
    local v1 = type(a) == "table" and a.version or a
    local v2 = type(b) == "table" and b.version or b

    if v1 == "latest" or v1 == "tot" then return true end
    if v2 == "latest" or v2 == "tot" then return false end

    local v1_parts = {}
    for part in string.gmatch(v1, "[^.]+") do
        table.insert(v1_parts, tonumber(part) or 0)
    end

    local v2_parts = {}
    for part in string.gmatch(v2, "[^.]+") do
        table.insert(v2_parts, tonumber(part) or 0)
    end

    for i = 1, math.max(#v1_parts, #v2_parts) do
        local v1_part = v1_parts[i] or 0
        local v2_part = v2_parts[i] or 0
        if v1_part > v2_part then
            return true
        elseif v1_part < v2_part then
            return false
        end
    end

    return false
end
