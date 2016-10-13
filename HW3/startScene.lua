-- startScene.lua

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require('widget')
local frameData = require('frameData')

local _W = display.contentWidth
local _H = display.contentHeight
 
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here
local gameTitle = display.newImage(tsSheet, 1, _W/2, -25 ) --(  "Alex Kidd Janken", _W/2, 0, native.systemFont, 15 )
local namesTitle = display.newText(  "By: Branden Guevara\nGarrett Eledui", _W/2, 3*_H/4 + 40, native.systemFont, 15 )
-- Start Button click event
local function startButtonClicked ( event )
	if(event.phase == "ended") then
		print("clicked")
		composer.removeScene("startScene")
		composer.gotoScene( "level1");
      --composer.gotoScene( "level3");
	end
end

local startButton = widget.newButton( 
		{
			x = _W/2,
			y = _H/2 - 10,
			id = "startButton",
			label = "Start Game",
			labelColor = {default ={1,1,1}, over = {0,0,0}},
			textOnly = false,
			shape = "roundedRect",
			fillColor = {default = {0,0,2,0.7}, over={1,0.2,0.5,1}},
			onEvent = startButtonClicked

		} )
---------------------------------------------------------------------------------
 
-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
 
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
   sceneGroup:insert(gameTitle)
   sceneGroup:insert(namesTitle)
   sceneGroup:insert(startButton)
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