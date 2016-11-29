local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

_W = display.contentWidth
_H = display.contentHeight



-- Start Button click event
local function startButtonClicked ( event )
	if(event.phase == "ended") then
		composer.removeScene("mainMenu")
		composer.gotoScene( "songSelection");
	end
end
-- Settings button click event
local function settingsButtonClicked ( event )
	if(event.phase == "ended") then
		composer.removeScene("mainMenu")
		composer.gotoScene( "settings");
	end
end

function scene:create(event)
	local sceneGroup = self.view
end
function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase
	if(phase == "will" ) then

	end
end

function scene:show(event)
	local sceneGroup = self.view
	local startButton = widget.newButton( 
		{
			x = _W/2,
			y = _H/2 - 30,
			id = "startButton",
			label = "Start Game",
			labelColor = {default ={1,1,1}, over = {0,0,0}},
			textOnly = false,
			shape = "roundedRect",
			fillColor = {default = {0,0,2,0.7}, over={1,0.2,0.5,1}},
			onEvent = startButtonClicked

		} )
	local settingsButton = widget.newButton( 
		{
			x = _W/2,
			y = _H/2 + 30,
			id = "settingsButton",
			label = "Settings",
			labelColor = {default ={1,1,1}, over = {0,0,0}},
			textOnly = false,
			shape = "roundedRect",
			fillColor = {default = {0,1,0,0.7}, over={1,0.2,0.5,1}},
			onEvent = settingsButtonClicked

		} )
	local title = display.newText( "Brosu!\nBy: Garrett Eledui\nBranden Guevara", _W/2, 50, native.systemFont, 16 )
		-- minTime = composer.getVariable("minPauseTime")
		-- maxTime = composer.getVariable("maxPauseTime")
	sceneGroup:insert(startButton)
	sceneGroup:insert(settingsButton)
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