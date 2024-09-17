--- @class commands
commands = {}

function commands.initialize()
    console.addCommand("test-family-wish", function(param)
        local _familyId = console.paramToInt(param, 1)
        if _familyId then
            dataMgr.familyData.memberData:refreshFamilyWish(_familyId)
        end
    end)

    console.addCommand("pause", function()
        gameTools.setRunState(true)
    end)

    console.addCommand("continue", function()
        gameTools.setRunState(false)
    end)

    console.addCommand("send", function(param)
        local _userId = sdkMgr.curChannel.loginSDK.userId
        CNativeBridgeSDK.OpenFeedback(_userId)
    end)

    console.addCommand("level-add", function(param)
        local _num = console.paramToInt(param, 1)
        if _num then
            dataMgr.playerData:setFamous(_num)
        end
    end)

    console.addCommand("money-add", function(param)
        local _num = console.paramToInt(param, 1)
        if _num then
            dataMgr.playerData:setMoney(_num)
        end
    end)

    console.addCommand("diamond-add", function(param)
        local _num = console.paramToInt(param, 1)
        if _num then
            dataMgr.playerData:setDiamond(_num)
        end
    end)

    console.addCommand("test-name", function()
        local _rand = randomBetweenValue(_ENameType.User, _ENameType.Building, true)
        luaLog(configMgr:randName(_rand))
    end)

    console.addCommand("name-set", function()
        uiMgr:openUI(_UI.UIChangeUserName, nil, _ENameType.User)
    end)
    console.addCommand("name-get", function()
        luaLog(dataMgr.playerData:getRoleName())
    end)

    console.addCommand("bubble-trigger", function(param)
        local _param = console.paramToInt(param, 2)
        if _param then
            local _memberId = _param[1]
            local _bubbleType = _param[2]
            local _member = memberMgr:getMemberByCfgId(_memberId)
            _member:triggerBubble(_bubbleType)
        end
    end)

    console.addCommand("test-exp", function(param)
        local _roomGroupId = console.paramToInt(param, 1)
        if _roomGroupId then
            local _data = gameTools.getFamilyItemDataByRoomId(_roomGroupId)
            luaLog("exp " .. tostring(_data.expValue))
        end
    end)

    console.addCommand("camera-follow", function(param)
        local _memberId = console.paramToInt(param, 1)
        if _memberId then
            --- @type FamilyMemberBase
            local _member = memberMgr:getMemberByCfgId(_memberId)
            cameraCtrl:setFollowTarget(_member.renderer.gameObject)
        end
    end)

    console.addCommand("camera-stop-follow", function(param)
        cameraCtrl:setFollowTarget(nil)
    end)

    console.addCommand("main-show", function()
        --- @type UIViewOut
        local _uiViewOut = uiMgr:getUI(_UI.Main).viewOut
        _uiViewOut:show(function()
            luaLog("finish")
        end)
    end)

    console.addCommand("main-hide", function()
        --- @type UIViewOut
        local _uiViewOut = uiMgr:getUI(_UI.Main).viewOut
        _uiViewOut:hide(function()
            luaLog("finish")
        end)
    end)

    console.addCommand("jump-wash-room", function(param)
        uiMgr:closeUI(_UI.RoomManager)
        gameTools.jumpByType(_EGlobalJumpType.JumpWashRoom)
    end)

    console.addCommand("jump-repair-room", function(param)
        uiMgr:closeUI(_UI.RoomManager)
        gameTools.jumpByType(_EGlobalJumpType.JumpRepairRoom)
    end)

    console.addCommand("jump-park", function(param)
        gameTools.jumpByType(_EGlobalJumpType.JumpParkingLot)
    end)

    console.addCommand("add-bubble", function(param)
        local _args = console.paramToInt(param, 3)
        if _args then
            local _memberId = _args[1]
            local _bubbleType = _args[2]
            local _storyId = _args[3]

            --- @type FamilyMemberBase
            local _inst = memberMgr:getMemberByCfgId(_memberId)
            if _inst then
                luaLog("add bubble " .. tostring(_bubbleType))
                _inst:triggerBubble(_bubbleType, _storyId, true)
            end
        end
    end)
    console.addCommand("add-car-bubble", function(param)
        local _args = console.paramToInt(param, 2)
        if _args then
            local _memberId = _args[1]
            local _bubbleType = _args[2]

            --- @type FamilyMemberBase
            local _inst = memberMgr:getMemberByCfgId(_memberId)
            if _inst then
                luaLog("add bubble " .. tostring(_bubbleType))
            end
        end
    end)

    console.addCommand("act", function(param)
        local _args = console.paramToInt(param, 3)
        if _args then
            local _memberId = _args[1]
            local _stateId = _args[2]
            local _behaviourId = _args[3]

            --- @type FamilyMemberBase
            local _member = memberMgr:getMemberByCfgId(_memberId)
            if _member then
                _member.attribute.currentBehaviorId = _behaviourId
                _member.attribute.currentStateId = _stateId
                _member:checkChange()
            end
        end
    end)

    console.addCommand("act-scan-state", function(param)
        for _, _data in pairs(t_characterState) do
            local _content = string.format(" id %d ", _data.id)

            local _typeStr
            if _data.stateCategory == _ECharacterStateType.Idle then
                _typeStr = "Idle"
            elseif _data.stateCategory == _ECharacterStateType.Event then
                _typeStr = "Event"
            elseif _data.stateCategory == _ECharacterStateType.System then
                _typeStr = "System"
            elseif _data.stateCategory == _ECharacterStateType.Double then
                _typeStr = "Double"
            end
            _content = _content .. string.format(", type %s ", _typeStr)

            console.yellow("char-state", _content)
        end
    end)

    console.addCommand("service", function(param)
        local _familyId = console.paramToInt(param, 1)
        if _familyId then
            local _score = gameTools.getFamilyMemberServiceScore(_familyId)
            luaLog(tostring(_score[5]))
        end
    end)

    console.addCommand("room-test", function(param)
        local _roomGroupId = console.paramToInt(param, 1)
        if _roomGroupId then
            --- @type RoomController
            local _room = mainCityCtrl.roomMgr:getRoomInstanceByRoomGroupId(_roomGroupId)
            for _, _facility in ipairs(_room.attribute.facilityList) do
                local _pos = _facility:getComplaintPos()
                if _pos then
                    luaLog(tostring(_pos.pathPoint))
                end
            end
            luaLog("room double pos")
            local _poses = _room.renderer:getDoubleBehaviourPoint()
            for _, _pos in ipairs(_poses) do
                luaLog(tostring(_pos.position))
            end
        end
    end)

    for _, pet in pairs(t_pet) do
        
    end
end
