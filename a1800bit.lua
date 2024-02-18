local function AreaToID(SessionID,IslandID,AreaIndex)
    if SessionID == nil or IslandID == nil or AreaIndex == nil then
        print("Error in AreaToID returning 0")
        return 0
    end
    return ((SessionID << 13)+(IslandID << 6)+AreaIndex)
end

local function IDToArea(AreaID)
    local SessionID = ((AreaID & 0xE000) >> 13)
    local IslandID = ((AreaID & 0x1FC0) >> 6)
    local AreaIndex = (AreaID & 0xF)
    return SessionID, IslandID, AreaIndex
end

local function toOID(...)
    local arg = {...}
    if #arg == 2 then --ObjectID,AreaID
        local SessionID,IslandID,AreaIndex = IDToArea(arg[2])
        print(SessionID,IslandID,AreaIndex, arg[2],IDToArea(arg[2]))
        return ((SessionID << 32) + (arg[1]))
    elseif #arg == 4 then --ObjectID,SessionID,IslandID,AreaIndex
        return ((arg[2] << 32) + (arg[1]))
    else
        print("error in number of args")
        return 0
    end
end

a1800 = {
    convertAIDtoArea = IDToArea,
    convertAreaToAID = AreaToID,
    convertToOID = toOID
}

--test
--print(AreaToID(1,nil,1))
print(IDToArea(8514))
print(toOID(32,8514))
print(toOID(32,2,5,2))