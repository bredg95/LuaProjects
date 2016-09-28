-- pauseOverlay.lua

local composer = require( "composer" )
local scene = composer.newScene(  )
local widget = require("widget")

_W = display.contentWidth
_H = display.contentHeight

-- Button click event for the ready button
local function readyButtonClicked ( event )
	if(event.phase == "ended") then
		-- Hides "Im ready" overlay
		composer.hideOverlay("fade", 500)
	end
end


function scene:create(event)
	local sceneGroup = self.view
	
	
end
function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase
	local parent = event.parent
	if(phase == "will" ) then
		parent:prepareGame()
	end
end

function scene:show(event)
	local sceneGroup = self.view
	local button1 = widget.newButton( 
		{
			x = _W/2,
			y = _H/2,
			id = "button1",
			label = "I'm Ready",
			labelColor = {default ={0,0,0}, over = {0,0,0}},
			textOnly = false,
			shape = "roundedRect",
			fillColor = {default = {2,0.2,0.5,0.7}, over={1,0.2,0.5,1}},
			onEvent = readyButtonClicked

		} )
	sceneGroup:insert(button1)
end
function scene:destroy(event)
	local sceneGroup = self.view
end



scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "destroy ", scene )

return scene