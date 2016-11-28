--settings
local composer = require("composer")
local scene  = composer.newScene( )
local widget = require("widget")

_W = display.contentWidth
_H = display.contentHeight

-- Holds the min/max interval values
local minValue = 500
local maxValue = 5000
-- Holds the min/max percents for use in the sliders
local minPercent = 0
local maxPercent = 100

-- Both labels will be updated based on sliders
local minLabel = display.newText(  "500", _W/2, _H/4 - 25, native.systemFont , 15 )
minLabel.anchorX = 0
local maxLabel = display.newText(  "5000", _W/2, _H/4 + 75, native.systemFont , 15 )
maxLabel.anchorX = 0

--Listener event for min slider
local function minSliderListener( event )
	minPercent = event.value
	minLabel.text = minValue + (maxValue - minValue)*minPercent/100
end
--Listener event for max slider
local function maxSliderListener( event )
	maxPercent = event.value
	maxLabel.text = minValue + (maxValue - minValue)*maxPercent/100
end

local label1 = display.newText(  "Minimum Value (ms): ", _W/2, _H/4 - 25, native.systemFont , 15 )
label1.anchorX = 1
local label2 = display.newText(  "Maximum Value (ms): ", _W/2, _H/4 + 75, native.systemFont , 15 )
label2.anchorX = 1

-- Create slider widgets
local minSlider = widget.newSlider(
{
    x = _W/2,
    y = _H/4,
    width = 200,
    value = minPercent,  
    listener = minSliderListener
})
local maxSlider = widget.newSlider(
{
    x = _W/2,
    y = _H/4 + 100,
    width = 200,
    value = maxPercent, 
    listener = maxSliderListener
})
minSlider.isVisible = false
maxSlider.isVisible = false

-- When default radio button is pressed perform this event
local function onDefaultPress ( event )
	minSlider:setValue(0);
	minPercent = 0
	minLabel.text = 500
	maxSlider:setValue(100)
	maxLabel.text = 5000
	maxPercent = 100
	minSlider.isVisible = false
	maxSlider.isVisible = false
end
-- when user radio button is pressed perform this event
local function onUserPress ( event )
	minSlider.isVisible = true
	maxSlider.isVisible = true
end


local defaultRadButton = widget.newSwitch
{
   left = _W/2 + 40,
   top = _H/2 + 170,
   style = "radio",
   id = "defaultRadioButtonWidget",
   initialSwitchState = true,
   onPress = onDefaultPress
}
-- Text to show the on/off switch state
--defaultRadButton.text = display.newText( tostring( defaultRadButton.isOn ), 0, 0, native.systemFontBold, 18 )
defaultRadButton.text = display.newText( "Default", 0, 0, native.systemFontBold, 18 )
defaultRadButton.text.x = defaultRadButton.x
defaultRadButton.text.y = defaultRadButton.y - defaultRadButton.text.contentHeight - 10

local userSelectedRadButton = widget.newSwitch
{
   left = _W/2 - 90,
   top = _H/2 + 170,
   style = "radio",
   id = "userSelectedRadioButtonWidget",
   initialSwitchState = false,
   onPress = onUserPress
}
-- Text to show the on/off switch state
userSelectedRadButton.text = display.newText( "User Selected", 0, 0, native.systemFontBold, 18 )
userSelectedRadButton.text.x = userSelectedRadButton.x
userSelectedRadButton.text.y = userSelectedRadButton.y - userSelectedRadButton.text.contentHeight - 10

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
			composer.removeScene("settings")
			composer.gotoScene( "menuView")
			composer.setVariable("minPauseTime", minval)
			composer.setVariable("maxPauseTime", maxval)
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
	sceneGroup:insert(minSlider)
	sceneGroup:insert(maxSlider)

	sceneGroup:insert(defaultRadButton)
	sceneGroup:insert(userSelectedRadButton)
	sceneGroup:insert(defaultRadButton.text)
	sceneGroup:insert(userSelectedRadButton.text)
	sceneGroup:insert(minLabel)
	sceneGroup:insert(maxLabel)
	sceneGroup:insert(label1)
	sceneGroup:insert(label2)



	function setSliderValues( value )
		minSlider:setValue(value)
		maxSlider:setValue(value)
		print("setMinSlider", minSlider.value)
	end



	function isDefaultRadioButton( event )
		print("isDefaultRadioButton: ",defaultRadButton.initialSwitchState)
		return defaultRadButton.initialSwitchState
	end
	
	function setDefaultRadioButton( bool )
		defaultRadButton.initialSwitchState = bool

	end

	function setUserSelectedRadioButton(bool)
		userSelectedRadButton.initialSwitchState = true
		defaultRadButton.initialSwitchState = false
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


