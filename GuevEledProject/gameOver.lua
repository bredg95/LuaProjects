--settings
local composer = require("composer")
local scene  = composer.newScene( )
local widget = require("widget")

_W = display.contentWidth
_H = display.contentHeight



local myText1 = display.newText( "Game Over", 100, 200, native.systemFont, 16 )
myText:setFillColor( 1, 1, 1 )

local myText2 = display.newText( "Score: ", 100, 200, native.systemFont, 16 )
myText:setFillColor( 1, 1, 1 )


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

--Handler that gets notified when the alert closes 
local function onComplete( event ) 
	if ( event.action == "clicked" ) then
		local i = event.index 
	if ( i == 1 ) then 
	-- Do nothing; dialog will simply dismiss 
	end
  end
end

-- Back button click event
local function backButtonClicked ( event )
	if(event.phase == "ended") then
		print("clicked")
		local range = maxValue - minValue;
		-- calculates values using slider's percent values
		local minval = minValue + range*minPercent/100
		local maxval = minValue + range*maxPercent/100

		if(minval > maxval) then
			--throw error

			local alert = native.showAlert( "Error", "Min Value is greater than Max value", { "OK" }, onComplete )
		else
			composer.removeScene("gameOver")
			composer.gotoScene( "mainMenu")
		end
	end
end

local backButton = widget.newButton( 
{
	x = _W/2,
	y = _H/2 + 250,
	id = "backButton",
	label = "Back",
	labelColor = {default ={0,0,0}, over = {0,0,0}},
	textOnly = false,
	shape = "square",
	fillColor = {default = {1,1,1,0.7}, over={1,0.2,0.5,1}},
	onEvent = backButtonClicked

} )

function scene:show(event)
	local sceneGroup = self.view

	sceneGroup:insert(backButton)
	sceneGroup:insert(myText1)
	sceneGroup:insert(myText2)





end
function scene:destroy(event)
	local sceneGroup = self.view
end


scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "destroy ", scene )


return scene


