--settings
local composer = require("composer")
local scene  = composer.newScene( )
local widget = require("widget")

_W = display.contentWidth
_H = display.contentHeight



local myText1 = display.newText( "Game Over", _W/2, 150, native.systemFont, 16 )
myText1:setFillColor( 1, 1, 1 )

local myText2 = display.newText( "Score: "..composer.getVariable( "hitTotal" ),  _W/2, 200, native.systemFont, 16 )
myText2:setFillColor( 1, 1, 1 )
local myText3 = display.newText( "missTotal: "..composer.getVariable( "missTotal" ),  _W/2, 250, native.systemFont, 16 )
myText3:setFillColor( 1, 1, 1 )
local myText4 = display.newText( "totalBeats: "..composer.getVariable( "totalBeats" ),  _W/2, 300, native.systemFont, 16 )
myText3:setFillColor( 1, 1, 1 )
local myText5 = display.newText( "totalScore: "..composer.getVariable( "totalScore" ),  _W/2, 350, native.systemFont, 16 )
myText5:setFillColor( 1, 1, 1 )


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
		myText1.text = ""
		myText2.text = ""
		myText3.text = ""
		myText4.text = ""
		myText5.text = ""
		composer.removeScene("gameOver")
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


