local Lib2, super = Class()

function Lib2:init()
end

Utils.hook(Actor, "init", function(orig, self)
    orig(self)
    self.taunt_sprites = {}
end)

Utils.hook(WorldCutscene, 'startEncounter', function(orig, self, encounter, transition, enemy, options)
    if Game:isLight() then
    else
        Game:setFlag("current_battle_system#", "deltarune")
    end
    options = options or {}
    transition = transition ~= false
    Game:encounter(encounter, transition, enemy)
    if options.on_start then
        if transition and (type(transition) == "boolean" or transition == "TRANSITION") then
            Game.battle.timer:script(function(wait)
                while Game.battle.state == "TRANSITION" do
                    wait()
                end
                options.on_start()
            end)
        else
            options.on_start()
        end
    end

    local battle_encounter = Game.battle.encounter
    local function waitForEncounter(self) return (Game.battle == nil), battle_encounter end

    if options.wait == false then
        return waitForEncounter, battle_encounter
    else
        return self:wait(waitForEncounter)
    end
end)

return Lib2 