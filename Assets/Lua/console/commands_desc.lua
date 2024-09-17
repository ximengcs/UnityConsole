--- @class commands_desc
commands_desc = {}

function commands_desc.initialize()
    console.addCommandDesc("test-family-wish", "[familyId]", "refresh family wish")
    console.addCommandDesc("test-name", nil, "rand a name")
    console.addCommandDesc("pause", nil, "game pause")
    console.addCommandDesc("continue", nil, "game continue")
    console.addCommandDesc("send", nil, "test send email")
    console.addCommandDesc("level-add", "change value", "add player level")
    console.addCommandDesc("money-add", "change value", "add player money")
    console.addCommandDesc("diamond-add", "change value", "add player diamond")
end
