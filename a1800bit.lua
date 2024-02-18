--[[for n = 1,2 do
    for m = 5,26 do
      print((n << 13)+(m << 6)+2)
    end
  end
  _test =8514
  local t= {}
    t[1] = ((_test & 57344)>>13)
    t[2] = ((_test & 8128)>>6)
    t[3] = (_test & 15)
  print(t[1],t[2],t[3])
]]
local function AreaToID(SessionID,IslandID,AreaIndex)
    return ((SessionID << 13)+(IslandID << 6)+AreaIndex)
end

local function IDToArea(AreaID)
    local SessionID = ((AreaID & 57344)>>13)
    local IslandID = ((AreaID & 8128)>>6)
    local AreaIndex = (AreaID & 15)
    return SessionID, IslandID, AreaIndex
end

a1800 = {
    convertAIDtoArea = IDToArea,
    convertAreaToAID = AreaToID
}

--test
--print(AreaToID(1,5,2))
--print(IDToArea(8514))