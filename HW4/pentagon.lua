local enemy = require("Enemy")
local pentagon = enemy:new({HP = 3 })

-- Modified spawn function
function pentagon:spawn()
	-- My attempt at making a pentagon
	self.shape= display.newPolygon(self.xPos, self.yPos,
	  	{0,-25, 20,-6, 10,18, -10,18, -20,-6})
	self.shape.pp = self;  -- parent object
	self.shape.tag = self.tag; -- “enemy”
	self.shape:setFillColor (1,1,0);
	-- Changed kinematic to dynamic since kinematic does not detect collision between non-dynamic objects
	physics.addBody(self.shape, "dynamic",
		{shape={0,-25, 20,-6, 10,18, -10,18, -20,-6}}); 
	-- This is so that I can detect collisions between the enemy and the player
	self.shape.isSensor = true
end

-- Modified the forward function. Because of this I did not need to modify move()
function pentagon:forward ()   
	-- The object will go 100 pixels everytime this function is called
   transition.to(self.shape, {y=self.shape.y + 100, 
   time=self.fT,
   onComplete= function (obj) 
   		-- Will remove itself when it reaches the end of the screen
   		if (self.shape.y >= display.contentHeight - 20) then
   			self.shape:removeSelf();
   			self.shape = nil;
   		else
   			self:forward() 
   		end
   	end } );
end

return pentagon