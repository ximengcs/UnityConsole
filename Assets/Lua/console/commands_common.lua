--- @class commands_common
commands_common = {}

function commands_common.initialize()
    console.addCommand("time-scale", function(param)
        local _args = console.paramToInt(param, 1)
        if _args then
            CS.UnityEngine.Time.timeScale = _args
        end
    end)
    console.addCommand("close", function (param)
        console.close()
    end)
end
