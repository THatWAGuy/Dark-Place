---@class EnemyBattler : EnemyBattler
---@overload fun(...) : EnemyBattler
local EnemyBattler, super = Class(EnemyBattler, true)

function EnemyBattler:onDefeatFatal(damage, battler)
    super.onDefeatFatal(self, damage, battler)

    Game.battle.killed = true
    Game:addFlag("library_kills", 1)
end

function EnemyBattler:freeze()
    super.freeze(self)

    Game.battle.killed = true
    Game:addFlag("library_kills", 1)
end

function EnemyBattler:defeat(reason, violent)
    self.done_state = reason or "DEFEATED"

    if violent then
        Game.battle.used_violence = true
    end

    Game.battle.money = Game.battle.money + self.money
    if self.done_state == "KILLED" then
        Game.battle.xp = Game.battle.xp + self.experience
    elseif self.done_state == "FROZEN" then
        if Kristal.getLibConfig("leveling", "local_freezing") then
            Game.battle.freeze_xp = Game.battle.freeze_xp + self.experience
        else
            Game.battle.xp = Game.battle.xp + self.experience
        end
    end

    Game.battle:removeEnemy(self, true)
end

return EnemyBattler