--- @class console
console = {}
CSConsole = CS.Console.Inst

require "console/buttons"
require "console/commands"
require "console/commands_desc"
require "console/commands_common"
require "console/commands_common_desc"

--- @param cmd string
--- @param handler fun(param:string):void
function console.addCommand(cmd, handler)
    CSConsole:AddCommand(cmd, handler)
end

--- @param cmd string
--- @param param string
--- @param desc string
function console.addCommandDesc(cmd, param, desc)
    CSConsole:AddCommandDesc(cmd, param, desc)
end

--- @param menu string
--- @param btn string
--- @param handler fun():void
function console.addButton(menu, btn, handler)
    CSConsole:AddButton(menu, btn, handler)
end

--- @param btn string
--- @param handler fun():void
function console.add(btn, handler)
    console.addButton(nil, btn, handler)
end

function console.close()
    CSConsole:Close()
end

--- @param param string
--- @param count integer
--- @return integer[]
function console.paramToInt(param, count)
    local _args = string.split(param, ' ')
    local _length = #_args
    if _length < 2 or (count and _length ~= count + 1) then
        return nil
    end

    if _length == 2 then
        return tonumber(_args[1])
    else
        local _result = {}
        for i = 1, count do
            table.insert(_result, tonumber(_args[i]))
        end
        return _result
    end
end

--- @param prefix string
--- @param content string
function console.green(prefix, content)
    luaLog("<color=#00D9FF>[" .. prefix .. "]</color><color=#00FF4C>" .. content .. "</color>")
end

--- @param prefix string
--- @param content string
function console.blue(prefix, content)
    luaLog("<color=#00D9FF>[" .. prefix .. "]</color><color=#1B74EF>" .. content .. "</color>")
end

--- @param prefix string
--- @param content string
function console.yellow(prefix, content)
    luaLog("<color=#00D9FF>[" .. prefix .. "]</color><color=#E4EF1B>" .. content .. "</color>")
end

function console.initialize()
    commands.initialize()
    commands_desc.initialize()
    commands_common.initialize()
    commands_common_desc.initialize()
    buttons.initialize()
end
