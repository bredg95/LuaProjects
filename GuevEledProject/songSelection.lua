local composer = require("composer")
local scene  = composer.newScene( )
local widget = require("widget")

local map = require("songs")

-- Song 1 selection click event
local function song1Clicked ( event )
	if(event.phase == "ended") then
		composer.removeScene("songSelection")
		composer.setVariable("songNum", 1)
		composer.gotoScene( "gameView");
	end
end
-- Song 2 selection click event
local function song2Clicked ( event )
	if(event.phase == "ended") then
		composer.removeScene("songSelection")
		composer.setVariable("songNum", 2)
		composer.gotoScene( "gameView");
	end
end

function scene:create(event)
	local sceneGroup = self.view
	-- composer.setVariable("minPauseTime", minTime)
	-- composer.setVariable("maxPauseTime", maxTime)
	
end
function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase
	if(phase == "will" ) then
		
	end
end

function scene:show(event)
	local sceneGroup = self.view
	local song1Button = widget.newButton( 
		{
			x = _W/2,
			y = _H/2 - 30,
			id = "song1Button",
			label = "Ame Michi",
			labelColor = {default ={1,1,1}, over = {0,0,0}},
			textOnly = false,
			shape = "roundedRect",
			fillColor = {default = {0,0,2,0.7}, over={1,0.2,0.5,1}},
			onEvent = song1Clicked

		} )
	local song2Button = widget.newButton( 
		{
			x = _W/2,
			y = _H/2 + 30,
			id = "song2Button",
			label = "Lean On",
			labelColor = {default ={1,1,1}, over = {0,0,0}},
			textOnly = false,
			shape = "roundedRect",
			fillColor = {default = {0,1,0,0.7}, over={1,0.2,0.5,1}},
			onEvent = song2Clicked

		} )
	local title = display.newText( "Song Selection", _W/2, 100, native.systemFont, 16 )
		-- minTime = composer.getVariable("minPauseTime")
		-- maxTime = composer.getVariable("maxPauseTime")
	sceneGroup:insert(song1Button)
	sceneGroup:insert(song2Button)
	sceneGroup:insert(title)
end
function scene:destroy(event)
	local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "destroy ", scene )

return scene