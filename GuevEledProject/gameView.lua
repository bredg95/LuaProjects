-----------------------------------------------------------------------------------------
--
-- gameView.lua
--
-----------------------------------------------------------------------------------------
local composer = require("composer")
local scene  = composer.newScene( )
local physics = require('physics')
_W = display.contentWidth
_H = display.contentHeight

local map = require("songs")
local indicatorGroup, indicatorCircle, sound, soundOptions;

physics.start()
physics.setGravity( 0, 600 )


local topBar = display.newRect(0,25,_W+400,5)
physics.addBody(topBar, "static")

-- local indicatorBG = display.newRect(0,0,_W,20)
-- 	indicatorBG.anchorX = 0
-- 	indicatorBG.anchorY = 0

local testParticleSystem = physics.newParticleSystem(
  {
  filename = "image.png",
  radius = 3,
  imageRadius = 4
  }
)



local function onTapped( event )

    testParticleSystem:createParticle(
      {
      	--[[
         flags = "powder",
         velocityX = math.random(-1000,1000),
         velocityY = math.random(-1000,1000),
         color = { 1, 1, 1, 1 },
         x = _W/2,
         y = _H/2,
         lifetime = 32.0
         ]]--
          flags = { "water" },
	      x = _W/2,
	      y = _H/2,
	      velocityX = math.random(),
	      velocityY = math.random(),
	      --velocityX = 256,
	      --velocityY = 480,
	      color = { math.random(), math.random(), math.random(), 1 },
	      lifetime = 32.0,
      }
    )
    end

--timer.performWithDelay( 100, onTimer, 0 )


local startTime = 0;
local beatTable = {};

local missScore = display.newText("Miss: ", 10, _H-20, native.systemFont, 20 )
local hitScore = display.newText("Hit: ", 100, _H -20, native.systemFont, 20 )
missScore.anchorX = 0
hitScore.anchorX = 0
local miss = 0
local hit = 0
function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end



local counter = 0
local doubleCounter = 0
local morphWithSpinsCounter = 0
local morphWithSpinsDoubleCounter = 0



local gameBox = display.newRoundedRect(_W/2,_H/2,100,100,20)
gameBox:setFillColor(0.3,0.5,0.7)
gameBox.path.radius = 200


local doubleRects1 = display.newRoundedRect(_W/2,_H/2 - 150,80,80,20)
doubleRects1:setFillColor(0,0.7,0.3)
doubleRects1.alpha = 0

local doubleRects2 = display.newRoundedRect(_W/2,_H/2 + 150 ,80,80,20)
doubleRects2:setFillColor(0,0.7,0.3)
doubleRects2.alpha = 0





function boxTapped (object, event)
	local tapTime = system.getTimer()
	local hitTime = round((tapTime - startTime)/(map.quarterBeat/map.beatDivisor))
	print(hitTime)
	print("taptTime: ", tapTime)

	onTapped()

	if(tapTime < 33000) then
		morphBasic()
	elseif(tapTime >= 33000 and tapTime < 52000) then
		morphBasic2()
	elseif(tapTime >= 52000 and tapTime < 73000) then
		morphWithSpins()
	elseif(tapTime >= 73000 and tapTime < 83000) then
		morphBasic()
		morphSideEffect()
	elseif(tapTime >= 83000 and tapTime < 93000) then
		morphBasic2()
		rectFallFunction()
	elseif(tapTime >= 93000 and tapTime < 136000) then
		morphWithSpins()
	elseif(tapTime >= 136000 and tapTime < 156000) then
		morph4()
	elseif(tapTime >= 156000 ) then
		morphBasic2()
		morph4()
		morph5()
	end



	--[[
	if(counter < 20 ) then
		morphBasic()
	elseif(counter > 20 and counter < 100) then
		morphBasic2()
	elseif(counter > 10 and counter < 150) then
		morphWithSpins()
	elseif(counter > 150 and counter < 200) then
		morph4()
	end
	]]--
	counter = counter + 1





	if(map.beatTable[hitTime] ) then
		hit = hit + 1
		hitScore.text = "Hit: " .. hit;
		map.beatTable[hitTime] = nil
	elseif(map.beatTable[hitTime - 1] or map.beatTable[hitTime + 1]) then
		hit = hit + 1
		hitScore.text = "Hit: " .. hit;
		map.beatTable[hitTime-1] = nil
		map.beatTable[hitTime+1] = nil
	elseif(map.beatTable[hitTime - 2] or map.beatTable[hitTime + 2]) then
		hit = hit + 1
		hitScore.text = "Hit: " .. hit;
		map.beatTable[hitTime-2] = nil
		map.beatTable[hitTime+2] = nil
	else
		miss = miss + 1;
	  	missScore.text = "Miss: " .. miss
	end
end

gameBox.tap = boxTapped

gameBox:addEventListener( "tap", gameBox )

function scene:create(event)
	local sceneGroup = self.view
	songNum = composer.getVariable("songNum")
	map:setSong(songNum)
	indicatorGroup = map:setupIndicatorBar()
	sound = audio.loadStream(map.songFile)

	soundOptions = 
	{
		channel = 1,
		duration = map.length
	}

	physics.setGravity( 0, 0 )
	physics.addBody( indicatorGroup, "dynamic")
	 
	indicatorGroup.x = 20 

	indicatorCircle = display.newCircle(20, 10, 10 )
	indicatorCircle.anchorX = 0
	indicatorCircle:setFillColor( 0,1,0, 0.5)
	sceneGroup:insert(indicatorGroup)
	sceneGroup:insert(testParticleSystem)
	sceneGroup:insert(indicatorCircle)
	sceneGroup:insert(gameBox)
	sceneGroup:insert(topBar)

	--sceneGroup:insert(indicatorBG)
end

local function beginIndicator()
	audio.setVolume(0.5)
	audio.play(sound, soundOptions )
	indicatorGroup:setLinearVelocity( -map.pixPerSec, 0 )
	startTime = system.getTimer()
end

local songNum = 0;

function scene:show(event)
	local sceneGroup = self.view
	if(event.phase == "will") then
		timer.performWithDelay( 2000, beginIndicator, 1 )
	end
end


-- Graphic Effect 1

local _W = display.contentWidth
local _H = display.contentHeight

local width = 200
local height = 100
local angle = 60




--local gameBox = display.newRoundedRect(_W/2,_H/2,width/2,height,20)
--gameBox:setFillColor(0.3,0.5,0.7)
----gameBox.alpha = 0
--gameBox.path.radius = 200






--local counter = 0
--local doubleCounter = 0

function morphWithSpins( event )

	print("morphWithSpinsInside")
		
	morphWithSpinsCounter = morphWithSpinsCounter + 1

	angle = angle + 30
	print(morphWithSpinsCounter)

	if(morphWithSpinsCounter == 1) then
		transition.to( gameBox, { time=300, color = {math.random(), math.random(), math.random()},width=100, height=200, onComplete=listener1 } )
	elseif(morphWithSpinsCounter == 2) then
		transition.to( gameBox, { time=300, color = {1, 0,0.7},width=200, height=100, onComplete=listener1 } )
	elseif(morphWithSpinsCounter == 3) then
		transition.to( gameBox, { time=300, rotation = angle , width=100, height=100, onComplete=listener1 } )
		morphWithSpinsCounter = 0
		

		if(morphWithSpinsDoubleCounter == 3) then
			transition.to( doubleRects1, { time=1, alpha = 0 , x=_W/2 - 100, height=_H/2, onComplete=listener1 } )
			transition.to( doubleRects2, { time=1, alpha = 0 , x=_W/2 + 100, height=_H/2, onComplete=listener1 } )
		end
		if(morphWithSpinsDoubleCounter == 6) then
			transition.to( doubleRects1, { time=1, alpha = 0 , x=_W/2 + 100, height=_H/2, onComplete=listener1 } )
			transition.to( doubleRects2, { time=1, alpha = 0 , x=_W/2 - 100, height=_H/2, onComplete=listener1 } )
		end
		if(morphWithSpinsDoubleCounter == 6) then
			doubleRects1:setFillColor(math.random(), math.random(), math.random())
			doubleRects2:setFillColor(math.random(), math.random(), math.random())
			morphWithSpinsDoubleCounter = 0
			morphBasic2()
		end
		morphWithSpinsDoubleCounter = morphWithSpinsDoubleCounter + 1


		doubleRects1.alpha = 1
		doubleRects2.alpha = 1
		transition.to( doubleRects1, { time=700, alpha = 0 , width=100, height=100, onComplete=listener1 } )
		transition.to( doubleRects2, { time=700, alpha = 0 , width=100, height=100, onComplete=listener1 } )
	end

	
end








function morphBasic( event )
	transition.to( gameBox.path, { time=500 , width=120, height=120 } )
	transition.to( gameBox.path, { time=100 , width=100, height=100 } )
end





local x1 = _W/2
local x2 = _W/2+100
local y1 = 100
local y2 = _H/2+15
local y3 = _H/2


local square1 = display.newRect(_W/2,100,20,80)
local square2 = display.newRect(_W/2,100,20,80)
local square3 = display.newRect(_W/2,_H/2+150,20,80)
local square4 = display.newRect(_W/2,_H/2+150,20,80)
local square5 = display.newRect(_W/2+100,_H/2,20,80)
local square6 = display.newRect(_W/2+100,_H/2,20,80)
local square7 = display.newRect(_W/2-100,_H/2,20,80)
local square8 = display.newRect(_W/2-100,_H/2,20,80)
square1.alpha = 0
square2.alpha = 0
square3.alpha = 0
square4.alpha = 0
square5.alpha = 0
square6.alpha = 0
square7.alpha = 0
square8.alpha = 0
local rotateAngle = 45
local rotateAngle2 = 45

function morph4( event )
	square1.alpha = 1
	square2.alpha = 1
	square3.alpha = 1
	square4.alpha = 1
	square5.alpha = 1
	square6.alpha = 1
	square7.alpha = 1
	square8.alpha = 1
	transition.to( square1, { rotation=-rotateAngle, time=200, transition=easing.inOutCubic } )	
	transition.to( square2, { rotation= rotateAngle, time=200, transition=easing.inOutCubic } )	
	transition.to( square3, { rotation=-rotateAngle, time=200, transition=easing.inOutCubic } )	
	transition.to( square4, { rotation= rotateAngle, time=200, transition=easing.inOutCubic } )	

	transition.to( square5, { rotation=-rotateAngle2, time=200, transition=easing.inOutCubic } )	
	transition.to( square6, { rotation= rotateAngle2, time=200, transition=easing.inOutCubic } )	
	transition.to( square7, { rotation=-rotateAngle2, time=200, transition=easing.inOutCubic } )	
	transition.to( square8, { rotation= rotateAngle2, time=200, transition=easing.inOutCubic } )

	transition.to( gameBox.path, { time=150 , width=110, height=110 } )
	transition.to( gameBox.path, { time=100 , width=100, height=100 } )
	gameBox:setFillColor(math.random(), math.random(), math.random())

	--[[
	transition.to( square1, { rotation=-rotateAngle, time=200, x=x2,y=y2,transition=easing.inOutCubic } )	
	transition.to( square2, { rotation= rotateAngle, time=200, x=x2,y=y2,transition=easing.inOutCubic } )	
	transition.to( square3, { rotation=-rotateAngle, time=200, x=x1,y=y1,transition=easing.inOutCubic } )	
	transition.to( square4, { rotation= rotateAngle, time=200, x=x1,y=y1,transition=easing.inOutCubic } )	

	transition.to( square5, { rotation=-rotateAngle2, time=200, x=x1,y=y2,transition=easing.inOutCubic } )	
	transition.to( square6, { rotation= rotateAngle2, time=200, x=x1,y=y2,transition=easing.inOutCubic } )	
	transition.to( square7, { rotation=-rotateAngle2, time=200, x=x1,y=y3,transition=easing.inOutCubic } )	
	transition.to( square8, { rotation= rotateAngle2, time=200, x=x1,y=y3,transition=easing.inOutCubic } )

	]]--
	

	
	rotateAngle = rotateAngle + 45
	rotateAngle2 = rotateAngle2 + 30
	square1:setFillColor(math.random(), math.random(), math.random())
	square2:setFillColor(math.random(), math.random(), math.random())
	square3:setFillColor(math.random(), math.random(), math.random())
	square4:setFillColor(math.random(), math.random(), math.random())
	square5:setFillColor(math.random(), math.random(), math.random())
	square6:setFillColor(math.random(), math.random(), math.random())
	square7:setFillColor(math.random(), math.random(), math.random())
	square8:setFillColor(math.random(), math.random(), math.random())

	
end






function morphBasic2( event )
	print("morphBasic2")
	counter = counter + 1
	print(counter)
	square1.alpha = 0
	square2.alpha = 0
	square3.alpha = 0
	square4.alpha = 0
	square5.alpha = 0
	square6.alpha = 0
	square7.alpha = 0
	square8.alpha = 0

	gameBox:setFillColor(math.random(), math.random(), math.random())
	transition.to( gameBox.path, { time=500 , width=200, height=200, radius=220,onComplete=listener1 } )
	transition.to( gameBox.path, { time=100 , width=100, height=100, radius=20,onComplete=listener1 } )
end








local x = 50
local x2 = 50
local y = 100

local rects = {}

function createRects(x, y, width, height)
	print("createRects")
	
    local rect = display.newRect(x, y, width, height);
    rect:setFillColor(math.random(),math.random(),math.random())
    table.insert(rects, rect)
    physics.addBody(rect)
    return rect
end

local i = 0

function morphSideEffect( event )
	-- This function should provide simultanous side effects to supplement the main subject in the animation
	print("morphSideEffect")
	
		

	if(i<10) then
		createRects(x,y,10,100)
		x = x + 20
	elseif(10 < i) then
		createRects(x2,310,10,100)
		x2 = x2 + 20
	elseif(i > 20) then
		print("rectDanceFunction")		
		rectFallFunction()
		
	end

	i = i+1

	--transition.to( o.path, { time=500 , vertices={100,-110, 27,-35, 105,-35, 43,16, 65,90, 0,45, -65,90, -43,15, -105,-35, -27,-35,},onComplete=listener1 } )
end

function rectFallFunction( event )
	-- body
	print("\n\n\n\n\n\nrectFallFunction\n\n\n\n\n\n")
	for i=0,20 do
		transition.to( rects[i], { time=800, y = 700, transition=easing.inOutCubic,onComplete=listener1 } )
	end
end





function morph5( event )
	-- body
	--transition.to( gameBox.path, { time=500 , width=200, height=200, radius=220,onComplete=listener1 } )
	--transition.to( gameBox.path, { time=100 , width=100, height=100, radius=20,onComplete=listener1 } )
	doubleRects1.alpha = 1
	doubleRects2.alpha = 1
	transition.to( doubleRects1, { time=300, alpha = 0 , onComplete=listener1 } )
	transition.to( doubleRects2, { time=300, alpha = 0 , onComplete=listener1 } )
end



--addEventListener need this to listen for a particular beat and then displays graphics

function onTimer( event )

	

	local tapTime = system.getTimer()
	local hitTime = round((tapTime - startTime)/(map.quarterBeat/map.beatDivisor))
	if(tapTime >= 143500 and tapTime < 144000 ) then
		doubleRects1.alpha = 1
		doubleRects2.alpha = 1
		transition.to( doubleRects1, { time=300, alpha = 0 , onComplete=listener1 } )
		transition.to( doubleRects2, { time=300, alpha = 0 , onComplete=listener1 } )

	end
	if(tapTime >= 144000 and tapTime < 144500) then
	--if(tapTime >= 4000 and tapTime < 4500 ) then
		doubleRects1.alpha = 1
		doubleRects2.alpha = 1
		transition.to( doubleRects1, { time=300, alpha = 0 , onComplete=listener1 } )
		transition.to( doubleRects2, { time=300, alpha = 0 , onComplete=listener1 } )
		
	end
	if(tapTime >= 145000 and tapTime < 145500) then
	--if(tapTime >= 5000 and tapTime < 5500 ) then
		doubleRects1.alpha = 1
		doubleRects2.alpha = 1
		transition.to( doubleRects1, { time=300, alpha = 0 , onComplete=listener1 } )
		transition.to( doubleRects2, { time=300, alpha = 0 ,  onComplete=listener1 } )
		
	end
	if(tapTime == 146000 and tapTime < 146500) then
	--if(tapTime >= 6000 and tapTime < 6500 ) then
		doubleRects1.alpha = 1
		doubleRects2.alpha = 1
		transition.to( doubleRects1, { time=300, alpha = 0 , onComplete=listener1 } )
		transition.to( doubleRects2, { time=300, alpha = 0 , onComplete=listener1 } )
		
		
	end
	if(tapTime == 147000 and tapTime < 147500) then
	--if(tapTime >= 7000 and tapTime < 7500 ) then
		doubleRects1.alpha = 1
		doubleRects2.alpha = 1
		transition.to( doubleRects1, { time=300, alpha = 0 , onComplete=listener1 } )
		transition.to( doubleRects2, { time=300, alpha = 0 ,  onComplete=listener1 } )
	end

end

--[[
local red = 0
local green = 0
local blue = 0
function onTimer2( event )

	if(red == 1) then
		red = 0
	end
	if(green == 1) then
		green = 0
	end
	if(blue == 1) then
		blue = 0
	end

	red = (red + 0.1)
	green = (green + 0.2)
	blue = (blue + 0.3)

	backGround:setFillColor(red, green, blue)

end
]]--
timer.performWithDelay( 100, onTimer, 0 )
--timer.performWithDelay(1000,onTimer2,0)





function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase
	if(phase == "will" ) then
		
	end
end

function scene:destroy(event)
	local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "destroy ", scene )

return scene