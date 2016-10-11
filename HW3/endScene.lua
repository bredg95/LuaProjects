-- endScene.lua

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")
local frameData = require('frameData')
 
local _W = display.contentWidth
local _H = display.contentHeight
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here
 -- Start Button click event
local function returnButtonClicked ( event )
	if(event.phase == "ended") then
		print("clicked")
		composer.removeScene("endScene")
		composer.gotoScene( "startScene");
	end
end

local returnButton = widget.newButton( 
		{
			x = _W/2,
			y = _H/2,
			id = "returnButton",
			label = "Return to Menu",
			labelColor = {default ={1,1,1}, over = {0,0,0}},
			textOnly = false,
			shape = "roundedRect",
			fillColor = {default = {0,0,2,0.7}, over={1,0.2,0.5,1}},
			onEvent = returnButtonClicked

		} )
local winningMessage = display.newText( "Congratulations Kidd!", _W/2, 0, native.systemFont , 10 )
---------------------------------------------------------------------------------
 
-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
   sceneGroup:insert(returnButton)
   sceneGroup:insert(winningMessage)
   alex = display.newSprite( alexSheet, alexSeqData );
   alex.x = _W/2
   alex.y = 3*_H/4 + 40
   local i = math.random(0,1)
   if(i == 0) then
   	alex:setSequence( "alex_eating" )
   else
   	alex:setSequence( "alex_jail" )
   end
   sceneGroup:insert(alex)
   -- Initialize the scene here.
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