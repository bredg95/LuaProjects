local physics = require("physics");
local widget = require("widget")
display.setStatusBar( display.HiddenStatusBar )
physics.start();

-- Will be used to tell when 3 minutes has passed
local startTime = {}
local endTime = {}
-- Timer will be used to create enemies 
local gameTimerRef = {}

local bg = display.newImage("sky.png", 0, 0)
bg.anchorX = 0
bg.anchorY = 0


---Score
local scoreText = 
    display.newEmbossedText( "Hit: 0", 200, 50,
                             native.systemFont, 40 );

scoreText:setFillColor( 0,0.5,0 );

local color = 
{
	highlight = {0,1,1},   
	shadow = {0,1,1}  
}
scoreText:setEmbossColor( color );
-- Holds the amount of hits on enemies
scoreText.hit = 0;

-- Sets the score text
local function setScore()
	scoreText.text = "Hit: " .. scoreText.hit;
end

physics.setGravity(0,0);
local Enemy = require ("Enemy");
local soundTable=require("soundTable");

local pentagon = require("pentagon")
local triangle = require("triangle")

display.setStatusBar( display.HiddenStatusBar )

local name = display.newText( "Branden Guevara's", display.contentWidth/2, 0, native.systemFont, 15 )
local title = display.newText( "Space Shooter", display.contentWidth/2, 15, native.systemFont, 15 )

local controlBar = display.newRect (display.contentCenterX, display.contentHeight-65, display.contentWidth, 70);
controlBar:setFillColor(1,1,1,0.2);

---- Main Player
local cube = display.newCircle (display.contentCenterX, display.contentHeight-150, 15);
cube.tag = "player"
-- Gave cube 5 hp
cube.HP = 5;

--Made cube dynamic and set isSensor to true to be able to detect collisions
physics.addBody (cube, "dynamic");
cube.isSensor = true

local function move ( event )
	 if event.phase == "began" then		
		cube.markX = cube.x 
	 elseif event.phase == "moved" then	 
	 	if(cube.markX == nil) then
	 		cube.markX = cube.x	
	 	end
	 	local x = (event.x - event.xStart) + cube.markX	 	
	 	
	 	if (x <= 20 + cube.width/2) then
		   cube.x = 20+cube.width/2;
		elseif (x >= display.contentWidth-20-cube.width/2) then
		   cube.x = display.contentWidth-20-cube.width/2;
		else
		   cube.x = x;		
		end

	 end
end
controlBar:addEventListener("touch", move);

-- Projectile 
local cnt = 0;
local function fire (event) 
  --if (cnt < 3) then
    cnt = cnt+1;
	local p = display.newCircle (cube.x, cube.y-16, 5);
	p.anchorY = 1;
	p:setFillColor(0,1,0);
	physics.addBody (p, "dynamic", {radius=5} );
	p:applyForce(0, -0.4, p.x, p.y);
	p.isSensor = true;
	audio.play( soundTable["shootSound"] );

	local function removeProjectile (event)
      if (event.phase=="began") then
	   	if (event.other.tag == "enemy") then
         	event.target:removeSelf();
         	event.target=nil;
         	--cnt = cnt - 1;
         	event.other.pp:hit();
         	scoreText.hit = scoreText.hit + 1;
         	setScore()
         	
         end
      end
    end
    
    p:addEventListener("collision", removeProjectile);
  --end
end
Runtime:addEventListener("tap", fire)

local startButton = {}

-- The handler for when the player collides with other objects
local function objectHandler (event) 
	if (event.phase == "began") then
		if(event.other.tag == "enemy") then
			event.other.pp:hit();
		end
		event.target.HP = event.target.HP - 1;
		print("HP" .. event.target.HP)
		if(event.target.HP == 0) then
			timer.cancel(gameTimerRef);
			startButton:setLabel("Game Over. Play Again")
			startButton.isVisible = true;
		end
	end 
end 
cube:addEventListener( "collision", objectHandler )

-- Creates enemies on a time loop
local function createEnemies()
	endTime = system.getTimer()/1000;
	print(endTime-startTime)
	-- Ends at 3 minutes or 180 seconds
	if(endTime-startTime >= 180) then
		timer.cancel(gameTimerRef);
		startButton:setLabel("You Won! Play Again")
		startButton.isVisible = true;
	else
		if(math.random(1,2) == 1) then
			p = pentagon:new({xPos=math.random(20, (display.contentWidth-20)), yPos = 0})
			p:spawn()
			p:move()
			p:shoot(math.random(800, 2000))
		else
			tr = triangle:new({player=cube,xPos=math.random(20, (display.contentWidth-20)), yPos = 0})
			tr:spawn()
			tr:move()
			tr:shoot(math.random(800, 2000))
		end
	end
end

-- Starts the game as well as initialize all values
local function startButtonClicked(event)
	if(event.phase == "ended") then
		startTime = system.getTimer( )/1000;
		cube.HP = 5
		scoreText.hit = 0
		setScore();
		startButton.isVisible = false
		gameTimerRef = timer.performWithDelay(2000, 
			createEnemies, -1)
	end
end

startButton = widget.newButton( {
		x = display.contentWidth/2,
		y = display.contentHeight/2 - 10,
		id = "startButton",
		label = "Start Game",
		labelColor = {default ={1,1,1}, over = {0,0,0}},
		textOnly = false,
		shape = "roundedRect",
		fillColor = {default = {0,0,2,0.7}, over={1,0.2,0.5,1}},
		onEvent = startButtonClicked
	} )