--- @class commands_common_desc
commands_common_desc = {}

function commands_common_desc.initialize()
    console.addCommandDesc("time-scale", "[scale value]", "unity time speed")
    console.addCommandDesc("close", nil, "close console")
end
