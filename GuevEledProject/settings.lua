--settings
local composer = require("composer")
local scene  = composer.newScene( )
local widget = require("widget")

_W = display.contentWidth
_H = display.contentHeight

local maxVolume = 1
local volPercent = 50

-- Volume label will be updated based on sliders
local volLabel = display.newText(  "0.5", _W/2, _H/4 - 25, native.systemFont , 15 )
volLabel.anchorX = 0
-- local maxLabel = display.newText(  "5000", _W/2, _H/4 + 75, native.systemFont , 15 )
-- maxLabel.anchorX = 0

--Listener event for volume slider
local function volSliderListener( event )
	volPercent = event.value
	volLabel.text = maxVolume*volPercent/100
end

local label1 = display.newText(  "Music Volume: ", _W/2, _H/4 - 25, native.systemFont , 15 )
label1.anchorX = 1

-- Create slider widgets
local volSlider = widget.newSlider(
{
    x = _W/2,
    y = _H/4,
    width = 200,
    value = volPercent,  
    listener = volSliderListener
})

function scene:create(event)
	local sceneGroup = self.view
	if(composer.getVariable("volume") ~=nil) then
		volLabel.text = composer.getVariable("volume")
		volPercent = 100 * composer.getVariable("volume")
		volSlider:setValue(volPercent)
	end

end
function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase
	local parent = event.parent
	if(phase == "will" ) then

	end
end

-- Back button click event
local function backButtonClicked ( event )
	if(event.phase == "ended") then
		composer.setVariable("volume", volLabel.text)
		composer.removeScene("settings")
		composer.gotoScene( "mainMenu")
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
	sceneGroup:insert(volSlider)
	sceneGroup:insert(volLabel)
	sceneGroup:insert(label1)

	function setSliderValues( value )
		volSlider:setValue(value)
	end

end
function scene:destroy(event)
	local sceneGroup = self.view
end

--backButton:addEventListener("touched",backButton)
scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "destroy ", scene )
-- Slider listeners

return scene


