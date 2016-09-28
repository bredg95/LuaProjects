-- mainMenu

local composer = require("composer")
local scene  = composer.newScene( )
local widget = require("widget")

_W = display.contentWidth
_H = display.contentHeight

local minTime = 500
local maxTime = 5000

local function startButtonClicked ( event )
	if(event.phase == "ended") then
		print("clicked")
		composer.removeScene("menuView")
		
		composer.gotoScene( "gameView");
	end
end
local function settingsButtonClicked ( event )
	if(event.phase == "ended") then
		print("Settingsclicked")
		composer.removeScene("menuView")

		composer.gotoScene( "settings");
		--composer.hideOverlay("fade", 500)
	end
end


function scene:create(event)
	local sceneGroup = self.view
	composer.setVariable("minPauseTime", minTime)
	composer.setVariable("maxPauseTime", maxTime)
	
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
		minTime = composer.getVariable("minPauseTime")
		maxTime = composer.getVariable("maxPauseTime")
	sceneGroup:insert(startButton)
	sceneGroup:insert(settingsButton)
end
function scene:destroy(event)
	local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "destroy ", scene )




return scene