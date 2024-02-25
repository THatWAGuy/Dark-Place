local GildedGroveAmbient, super = Class("CustomWeatherHandler", "gilded_grove_ambient")

function GildedGroveAmbient:init(sfx, child, intensity, overlay)

    super.init(self, self.id, sfx, child, intensity, overlay)

    self.goldwindtimer = 30 --120
    self.goldwindtimerreset = true
    
end

function GildedGroveAmbient:update()
    super.update(self)

    if not self.pause then
        if self.type == "gilded_grove_ambient" then
            --print("its going to wind in".. self.goldwindtimer)
            if self.goldwindtimerreset == true then
                self.goldwindtimerreset = false
        
                self.goldwindtimer = 30 * math.random(2 - self.intensity, 6 - self.intensity)
            end
        
            if self.goldwindtimer <= 0 then
                self.goldwindtimerreset = true
                --print("WOO OHOOO WIND YESS!! IM SO HAPPY")
                local ammount = math.random(1, 7)
                for i = ammount, 1, -1 do
                    Assets.stopAndPlaySound("wind", 0.8, 1.2)
                    Game.stage.timer:script(function(wait)
                        wait(1.5)
                        local speed = Utils.random(6, 10)
                        local y = math.random(SCREEN_HEIGHT * - 0.5, SCREEN_HEIGHT * 0.25)
                        local x = math.random(40, 60) + (i * 120)
                        local worldx, worldy = self:getRelativePos(SCREEN_WIDTH + x, y, self.addto)
                        local leaf = GildedLeafPiece(worldx, worldy, speed, self)
                        self.addto:addChild(leaf)
        
                    end)
                end
            end
        
            self.goldwindtimer = self.goldwindtimer - 1 * DTMULT
        end
    end
end

return GildedGroveAmbient