-- gameView.lua code

-- Required setup for gameView scene
local composer = require("composer")
local scene  = composer.newScene( )

_W = display.contentWidth
_H = display.contentHeight

function scene:create(event)
	local sceneGroup = self.view
end

function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	if(phase == "will") then
		-- Create start game button
		local startGroup = display.newGroup( )
		local text = display.newText( "I'm Ready", _W/2, _H/2, native.systemFont, 25 )
		local startGameButton = display.newRect( _W/2, _H/2, text.contentWidth + 5, text.contentHeight + 5 )
		startGameButton:setFillColor( 0.5 )
		startGroup:insert( startGameButton)
		startGroup:insert(text)
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