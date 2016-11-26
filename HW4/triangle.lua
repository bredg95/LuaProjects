local enemy = require("Enemy")
local triangle = enemy:new({HP = 1, fT = 500 })
local soundTable=require("soundTable");
function triangle:spawn()
	self.shape = display.newPolygon(self.xPos, self.yPos, 
                      {-15,-15,15,-15,0,15});
  
    self.shape.pp = self;
    self.shape.tag = "enemy";
    self.shape:setFillColor ( 0, 1, 1);
    physics.addBody(self.shape, "dynamic", 
              {shape={-15,-15,15,-15,0,15}});
    self.shape.isSensor = true;
end

-- Modified the forward function
function triangle:forward ()   
   transition.to(self.shape, {y=self.shape.y + 100, 
   time=self.fT,
   onComplete= function (obj) 
         if (self.shape.y >= display.contentHeight - 30) then
            self.shape:removeSelf();
            self.shape = nil;
         else
            self:forward() 
         end
      end } );
end

-- Modified the move function
function triangle:move ()  
   transition.to(self.shape, {x= self.player.x, 
      y=self.player.y, 
   time=2500,
   onComplete= function (obj)
         if (self.timerRef ~= nil) then
            timer.cancel ( self.timerRef );
         end
         self:forward() 
      end } );
end

-- Modified the shoot function
--[[Note: setting the bullet object isSensor to true was also applied to the enemy.lua file. ]]
function triangle:shoot (interval)
  interval = interval or 1500;
  local function createShot(obj)
    if(obj.shape ~= nil) then
      local p = display.newRect (obj.shape.x, obj.shape.y+50, 
                                 10,10);
      p:setFillColor(1,0,0);
      p.anchorY=0;
      physics.addBody (p, "dynamic");

      -- forceX and forceY are my way of making sure the bullet aims at the cube.
      --[[ Couldn't think of a way to make the applied force the same in any direction
            making it seem like the bullet goes faster in certain directions ]]-- 
      local forceX = (obj.player.x - obj.shape.x)/250
      local forceY = (obj.player.y - obj.shape.y)/250
      p:applyForce(forceX, forceY, p.x, p.y);
      --[[ Made isSensor true to make sure when it collides with another 
      dynamic object it won't be treated like a physical collision]]--
      p.isSensor = true;
      audio.play( soundTable["enemyShootSound"] );
      local function shotHandler (event)
        if (event.phase == "began") then
            -- To make sure it will remove itself only when it hits the player object
            if(event.other.tag == "player") then
               audio.play( soundTable["playerhitSound"] );
               event.target:removeSelf();
               event.target = nil;
            end
        end
      end
      p:addEventListener("collision", shotHandler);      
    end
  end
  self.timerRef = timer.performWithDelay(interval, 
   function (event) createShot(self) end, -1);
end

return triangle