-- mainMenu

local composer = require("composer")
local scene  = composer.newScene( )

_W = display.contentWidth
_H = display.contentHeight

local newScene = display.newRect(100, 100, 100, 100)

--[[
function scene:create(event)
	local sceneGroup = self.view
	local options = {
			effect = "fade",
			time = 500,
			isModal = false
	}
	composer.showOverlay( "pauseOverlay",  options )
	
end

function scene:show(event)
	local sceneGroup = self.view

	local phase = event.phase
	if(phase == "will") then
		
	elseif(phase == "did") then
		
	end
end

function scene:hide(event)
	local sceneGroup = self.view
	if(phase == "will") then

	elseif(phase == "did") then

	end
end

function scene:destroy(event)
	local sceneGroup = self.view
end

--listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide ", scene )
scene:addEventListener( "destroy ", scene )
return scene

]]--