-----------------------------------
-- Area: Dangruf Wadi
--  MOB: Goblin Ambusher
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    dsp.regime.checkRegime(player, mob, 640, 1, dsp.regime.type.GROUNDS)
end;
