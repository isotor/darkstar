-----------------------------------
-- Area: Bastok Markets
--  NPC: Arawn
-- Starts & Finishes Quest: Stamp Hunt
-- !pos -121.492 -4.000 -123.923 235
-----------------------------------
require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/titles");
require("scripts/globals/quests");
local ID = require("scripts/zones/Bastok_Markets/IDs");
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    local StampHunt = player:getQuestStatus(BASTOK,dsp.quest.id.bastok.STAMP_HUNT);
    local WildcatBastok = player:getVar("WildcatBastok");

    if (player:getQuestStatus(BASTOK,dsp.quest.id.bastok.LURE_OF_THE_WILDCAT_BASTOK) == QUEST_ACCEPTED and player:getMaskBit(WildcatBastok,11) == false) then
        player:startEvent(429);
    elseif (StampHunt == QUEST_AVAILABLE) then
        player:startEvent(225);
    elseif (StampHunt == QUEST_ACCEPTED and player:isMaskFull(player:getVar("StampHunt_Mask"),7) == true) then
        player:startEvent(226);
    else
        player:startEvent(114);
    end

end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)

    if (csid == 225 and option == 0) then
        player:addQuest(BASTOK,dsp.quest.id.bastok.STAMP_HUNT);
        player:addKeyItem(dsp.ki.STAMP_SHEET);
        player:messageSpecial(ID.text.KEYITEM_OBTAINED,dsp.ki.STAMP_SHEET);
    elseif (csid == 226) then
        if (player:getFreeSlotsCount(0) >= 1) then
            player:addTitle(dsp.title.STAMPEDER);
            player:addItem(13081);
            player:messageSpecial(ID.text.ITEM_OBTAINED,13081); -- Leather Gorget
            player:delKeyItem(dsp.ki.STAMP_SHEET);
            player:setVar("StampHunt_Mask",0);
            player:addFame(BASTOK,50);
            player:completeQuest(BASTOK,dsp.quest.id.bastok.STAMP_HUNT);
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13081);
        end
    elseif (csid == 429) then
        player:setMaskBit(player:getVar("WildcatBastok"),"WildcatBastok",11,true);
    end

end;