-- level1.lua

local composer = require( "composer" )
local scene = composer.newScene()
local frameData = require("frameData")
 
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here
 local bg = display.newImage (bgSheet, 1);
 local bubble = display.newSprite (alexSheet, bubbleSeqData); 
 local janken = display.newSprite (jankenSheet, seqDataJanken);
 local function play ()
	
		bubble.tap = toggleOptions
		bubble:addEventListener("tap",toggleOptions)

		alex:setSequence ("shake");
		alex:play();

		janken:setSequence("enemy1_shake");
		janken:play();
end

local function shoot ()

	--janken:setSequence("boss_set");
	--hand = display.newImage (jankenSheet, 4, -- boss_rock
	janken:setSequence("enemy1_set");
	--hand = display.newImage (jankenSheet, 4, -- boss_rock
	-- This x and y layout should work for the two enemies before the boss
	hand = display.newImage (jankenSheet,math.random(10,12), -- boss_rock
	display.contentCenterX+57,
	display.contentCenterY+50);
	
	-- The x and y position are tailored to the boss sprite
	-- hand = display.newImage (jankenSheet, 4, -- boss_rock
	-- display.contentCenterX+41,
	-- display.contentCenterY+42);

	if(toggleCounter   == 0) then
		alex:setSequence("alex_scissor");
		print("alex_rock")
		print(toggleCounter)
	end
	if(toggleCounter  == 1) then
		alex:setSequence("alex_rock");
		print("alex_paper")
		print(toggleCounter)
	end
	if(toggleCounter  == 2) then
		alex:setSequence("alex_paper");
		print("alex_scissor")
		print(toggleCounter)
	end
	--alex:setSequence("alex_paper"); -- just show rock for now

end
---------------------------------------------------------------------------------
 
-- "scene:create()"
function scene:create( event )
	local sceneGroup = self.view
	-- Initialize the scene
	bg.x = display.contentWidth / 2;
	bg.y= display.contentHeight / 2;
	-- Alex sprite
	alex = display.newSprite (alexSheet, alexSeqData); 
	alex.x = display.contentCenterX-80; 
	alex.y = display.contentCenterY+66; 
	alex.anchorX = 0; 
	alex.anchorY = 1; 
	alex:setSequence("alex_shake");
	

	bubble.x = display.contentCenterX-90; 
	bubble.y = display.contentCenterY+26; 
	bubble.anchorX = 0; 
	bubble.anchorY = 1; 
	bubble.xScale = 1.2
	bubble.yScale = 1.2
	
	janken.x = display.contentCenterX+80;
	janken.y = display.contentCenterY+66;
	janken.anchorX = 1;
	janken.anchorY = 1;
   
   	sceneGroup:insert(bg)
   	sceneGroup:insert(alex )
   	sceneGroup:insert(bubble)
   	sceneGroup:insert(janken)
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
	  	-- Called when the scene is now on screen.
	  	-- Insert code here to make the scene come alive.
	  	-- Example: start timers, begin animation, play audio, etc.
	  	alex:play();
	 	play();	
		--Shake for a while before revealing the hand
		local t = timer.performWithDelay (3000, shoot, 1);

   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   end
end
 
-- "scene:destroy()"
function scene:destroy( event )
 
   local sceneGroup = self.view
 
   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end
 
---------------------------------------------------------------------------------
 
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
---------------------------------------------------------------------------------
 
return scene