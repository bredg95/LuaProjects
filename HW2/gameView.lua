-- gameView.lua code

-- Required setup for gameView scene
local composer = require("composer")
local scene  = composer.newScene( )

_W = display.contentWidth
_H = display.contentHeight

-- Min/Max interval values in ms
local minPauseTime = 500
local maxPauseTime = 5000

local visibleTimer = system.getTimer( )

-- Table to hold the response time for correct taps. Will reset after each game
local responseTimeTable = {}

-- Holds the number of correct taps
local correctCount = 0
-- Holds the number of incorrect taps
local incorrectCount = 0
-- Holds average response time for correct taps, disregarding missed blue boxes or incorrect taps on red boxes
local avgResponse = 0.0
-- Holds the current round. Will stop at 10
local numOfRounds = 0

local startTime = 0.0
local stopTime = 0.0

-- Will hold the components for the score board
local scoreGroup = display.newGroup( )
scoreGroup.anchorY = 0

-- Event handler for box
function boxTapped (object, event)
	timer.cancel( visibleTimer )
	stopTime = system.getTimer() - startTime
	print("Response Time: " .. stopTime .. " ms")
	if(object.isCorrectColor) then
		correctCount = correctCount + 1
		responseTimeTable[correctCount] = stopTime
		
		-- Should reference the numCorrectLabel
		scoreGroup[3].text = correctCount
		
		-- The following will update avg response time
		local temp = 0.0
		local count = 0
		for i = #responseTimeTable, 1, -1 do
			temp = temp + responseTimeTable[i]
			count = count + 1
		end
		print("count" .. count)
		if(count ~= 0) then
			temp = temp/count
		end
		scoreGroup[7].text = string.format("%4.1f ms", temp )
		object.isVisible = false
	else
		incorrectCount = incorrectCount + 1
		-- Should reference the numIncorrectLabel
		scoreGroup[5].text = incorrectCount
		object.isVisible = false
	end
	numOfRounds = numOfRounds + 1
	if (numOfRounds < 10) then
		print("Round: " .. numOfRounds .. " WON!")
		startPause()
	else
		scoreGroup.y = _H/2
		scoreGroup:toFront()
		timer.performWithDelay( 2000, function () 

			scoreGroup.y = 0
			composer.showOverlay( "pauseOverlay",  options )
		end)
	end
end

-- The box object that will be different colored
local gameBox = display.newRect(  _W/2, _H/2, 200, 200 )
gameBox.isCorrectColor = false
gameBox.isVisible = false
gameBox.tap = boxTapped
gameBox:addEventListener( "tap", gameBox )

-- Scoreboard object that will hold total amounts for both correct and incorrect taps. Will also include average response time for correct taps.
local scoreBoard = display.newRect(_W/2,0,_W, 40)
scoreBoard.anchorY = 0
scoreBoard:setFillColor( 0.2,0.6,0.8 )
local label1 = display.newText(  "Correct: ", 0, 0, native.systemFont , 15 )
label1.anchorX = 0
label1.anchorY = 0
local numCorrectlabel = display.newText("0", label1.contentWidth + 5, 0, native.systemFont, 15)
numCorrectlabel.anchorX = 0
numCorrectlabel.anchorY = 0
local numIncorrectlabel = display.newText("0", scoreBoard.contentWidth, 0, native.systemFont, 15)
numIncorrectlabel.anchorX = 1
numIncorrectlabel.anchorY = 0
local label2 = display.newText(  "Incorrect: ", scoreBoard.contentWidth - numIncorrectlabel.contentWidth - 5, 0, native.systemFont , 15 )
label2.anchorX = 1
label2.anchorY = 0 
local label3 = display.newText(  "Avg Response Time: ", 0, 20, native.systemFont , 15 )
label3.anchorX = 0
label3.anchorY = 0
local avgTimeLabel = display.newText("0", label3.contentWidth + 5, 20, native.systemFont, 15)
avgTimeLabel.anchorX = 0
avgTimeLabel.anchorY = 0
scoreGroup:insert(scoreBoard)
scoreGroup:insert( label1)
scoreGroup:insert(numCorrectlabel)
scoreGroup:insert(label2)
scoreGroup:insert(numIncorrectlabel)
scoreGroup:insert(label3)
scoreGroup:insert(avgTimeLabel)

function scene:prepareGame()
	-- The following resets each variable and label to its initial values
	correctCount = 0
	incorrectCount = 0
	avgResponse = 0.0
	numOfRounds = 0
	-- Empties table
	for i = #responseTimeTable, 1, -1 do
		table.remove(responseTimeTable, i)
	end
	scoreGroup[3].text = 0
	scoreGroup[5].text = 0
	scoreGroup[7].text = 0.0

	local int = 2
	local text = display.newText(  "3", _W/2, _H/2 , native.systemFont, 20 )
	-- Gives 3 second delay before
	timer.performWithDelay( 1000, function()
		if(int == 0) then
 			text:removeSelf( )
 			startPause()
 		end
		text.text = int
		int = int - 1		
	end, 
	4)
end

function startPause()
	local pauseTime = math.random(minPauseTime, maxPauseTime)
	print("Pause Time: " .. pauseTime .. " ms")
	timer.performWithDelay(pauseTime, configureBox)
end

function configureBox()
	-- Decides which color to give the box. Of course if red is chosen then set the isCorrectColor variable to false
	local isBlue = math.random(0,1)
	if(isBlue == 1) then
		gameBox:setFillColor( 0, 0, 1 )
		gameBox.isCorrectColor = true
	else
		gameBox:setFillColor( 1, 0, 0 )
		gameBox.isCorrectColor = false
	end
	gameBox.isVisible = true;
	startTime = system.getTimer( )

	-- Will wait two seconds before going to next round
	visibleTimer = timer.performWithDelay(2000, function ()
			numOfRounds = numOfRounds + 1
			gameBox.isVisible = false
			if (numOfRounds < 10) then
				print("Round: " .. numOfRounds)
				startPause()
			else
				composer.showOverlay( "pauseOverlay",  options )
			end
		end
		)
end

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