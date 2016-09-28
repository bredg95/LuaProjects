--settings
local composer = require("composer")
local scene  = composer.newScene( )
local widget = require("widget")

_W = display.contentWidth
_H = display.contentHeight



local minValue = 500
	local maxValue = 5000

local minPercent = 0
local maxPercent = 100

local function minSliderListener( event )
	isDefaultRadioButton()
	setUserSelectedRadioButton(true)
	minPercent = event.value
    print( "minSlider at " .. event.value .. "%" )
end
local function maxSliderListener( event )
	maxPercent = event.value
    print( "maxSlider at " .. event.value .. "%" )
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


local sliderGroup = display.newGroup()




--Handler that gets notified when the alert closes 
local function onComplete( event ) 
	if ( event.action == "clicked" ) then
		local i = event.index 
	if ( i == 1 ) then 
	-- Do nothing; dialog will simply dismiss 
	end
  end
end



local function backButtonClicked ( event )
	if(event.phase == "ended") then
		print("clicked")
		local range = maxValue - minValue;
		local minval = minValue + range*minPercent/100
		local maxval = minValue + range*maxPercent/100

		if(minval > maxval) then
			--throw error

			local alert = native.showAlert( "Error", "Min Value is Greater than Max value", { "OK" }, onComplete )





		else
			composer.removeScene("settings")
			composer.gotoScene( "menuView")
			composer.setVariable("minPauseTime", minval)
			composer.setVariable("maxPauseTime", maxval)
		end
	end
end


function scene:show(event)
	local sceneGroup = self.view


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

	local defaultRadButton = widget.newSwitch
	{
	   left = _W/2 + 40,
	   top = _H/2 + 170,
	   style = "radio",
	   id = "defaultRadioButtonWidget",
	   initialSwitchState = true,
	   onPress = onSwitchPress
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
	   onPress = onSwitchPress
	}
	-- Text to show the on/off switch state
	userSelectedRadButton.text = display.newText( "User Selected", 0, 0, native.systemFontBold, 18 )
	userSelectedRadButton.text.x = userSelectedRadButton.x
	userSelectedRadButton.text.y = userSelectedRadButton.y - userSelectedRadButton.text.contentHeight - 10



	
	-- Create slider widget
	local minSlider = widget.newSlider(
    {
        top = 200,
        left = 50,
        width = 200,
        value = 0,  -- Start slider at 10% (optional)
        listener = minSliderListener
    })
    local maxSlider = widget.newSlider(
    {
        top = 100,
        left = 50,
        width = 200,
        value = 100,  -- Start slider at 10% (optional)
        listener = maxSliderListener
    })


    sliderGroup:insert(minSlider)
    sliderGroup:insert(maxSlider)

	sceneGroup:insert(backButton)
	sceneGroup:insert(minSlider)
	sceneGroup:insert(maxSlider)

	sceneGroup:insert(defaultRadButton)
	sceneGroup:insert(userSelectedRadButton)
	sceneGroup:insert(defaultRadButton.text)
	sceneGroup:insert(userSelectedRadButton.text)



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




local function onSwitchPress ( event )

	-- Figure this out !!! -eledui
	print("isDefaultRadioButton onSwitchPress: ",isDefaultRadioButton())

	if(isDefaultRadioButton() == false) then
		setDefaultRadioButton(true)
	else
		setDefaultRadioButton(false)
	end

	--minSlider:setValue(10)
	setSliderValues(10)
	print("onSwitchPress")
end






--backButton:addEventListener("touched",backButton)
scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "destroy ", scene )
-- Slider listeners





return scene


