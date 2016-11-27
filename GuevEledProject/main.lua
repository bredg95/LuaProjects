-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local physics = require('physics')
_W = display.contentWidth
_H = display.contentHeight

physics.start()
physics.setGravity( 0, 600 )


local topBar = display.newRect(0,20,_W+400,5)
physics.addBody(topBar, "static")



local testParticleSystem = physics.newParticleSystem(
  {
  filename = "image.png",
  radius = 3,
  imageRadius = 4
  }
)



local function onTimer( event )

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
local map = require("songs")
map:setSong(2)
local indicatorGroup = map:setupIndicatorBar()
local index = 0;
local sound = audio.loadStream(map.songFile)



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

	onTimer()

	if(tapTime < 31000) then
		morphBasic()
	elseif(tapTime >= 31000 and tapTime < 50000) then
		morphBasic2()
	elseif(tapTime >= 50000 and tapTime < 71000) then
		morphWithSpins()
	elseif(tapTime >= 71000 and tapTime < 81000) then
		morphBasic()
	elseif(tapTime >= 81000 and tapTime < 91000) then
		morphBasic2()
	elseif(tapTime >= 91000 and tapTime < 134000) then
		morphWithSpins()
	elseif(tapTime >= 134000 and tapTime < 154000) then
		morph4()
	elseif(tapTime >= 154000 ) then
		morphBasic2()
		morph4()
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
local options = 
{
	channel = 1,
	duration = map.length
}

physics.setGravity( 0, 0 )
physics.addBody( indicatorGroup, "dynamic")
 
indicatorGroup.x = 20 

local indicatorCircle = display.newCircle(20, 10, 10 )
indicatorCircle.anchorX = 0
indicatorCircle:setFillColor( 0,1,0, 0.5)


local function beginIndicator()
	audio.setVolume(0.5)
	audio.play(sound, options )
	indicatorGroup:setLinearVelocity( -map.pixPerSec, 0 )
	startTime = system.getTimer()
end
timer.performWithDelay( 2000, beginIndicator, 1 )







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
	transition.to( gameBox.path, { time=150 , width=120, height=120 } )
	transition.to( gameBox.path, { time=100 , width=100, height=100 } )
end





local x1 = _W/2
local x2 = _W/2+100
local y1 = 100
local y2 = _H/2+15
local y3 = _H/2


local square1 = display.newRect(_W/2,100,20,100)
local square2 = display.newRect(_W/2,100,20,100)
local square3 = display.newRect(_W/2,_H/2+150,20,100)
local square4 = display.newRect(_W/2,_H/2+150,20,100)
local square5 = display.newRect(_W/2+100,_H/2,20,100)
local square6 = display.newRect(_W/2+100,_H/2,20,100)
local square7 = display.newRect(_W/2-100,_H/2,20,100)
local square8 = display.newRect(_W/2-100,_H/2,20,100)
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
    table.insert(rects, rect)
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
		createRects(x2,210,10,100)
		x2 = x2 + 20
	elseif(i > 20) then
		print("rectDanceFunction")
		
		--rectDanceFunction()
	end

	i = i+1

	--transition.to( o.path, { time=500 , vertices={100,-110, 27,-35, 105,-35, 43,16, 65,90, 0,45, -65,90, -43,15, -105,-35, -27,-35,},onComplete=listener1 } )
end






function morph5( event )
	-- body
	transition.to( gameBox.path, { time=500 , width=200, height=200, radius=220,onComplete=listener1 } )
	transition.to( gameBox.path, { time=100 , width=100, height=100, radius=20,onComplete=listener1 } )
end



--addEventListener need this to listen for a particular beat and then displays graphics
--[[if(tapTime == 141000) then
			doubleRects1.alpha = 1
			doubleRects2.alpha = 1
			transition.to( doubleRects1, { time=300, alpha = 0 , width=100, height=100, onComplete=listener1 } )
			transition.to( doubleRects2, { time=300, alpha = 0 , width=100, height=100, onComplete=listener1 } )
		end
		if(tapTime == 141500) then
			doubleRects1.alpha = 1
			doubleRects2.alpha = 1
			transition.to( doubleRects1, { time=300, alpha = 0 , width=100, height=100, onComplete=listener1 } )
			transition.to( doubleRects2, { time=300, alpha = 0 , width=100, height=100, onComplete=listener1 } )
		end
		if(tapTime == 142000) then
			doubleRects1.alpha = 1
			doubleRects2.alpha = 1
			transition.to( doubleRects1, { time=300, alpha = 0 , width=100, height=100, onComplete=listener1 } )
			transition.to( doubleRects2, { time=300, alpha = 0 , width=100, height=100, onComplete=listener1 } )
		end
		if(tapTime == 142500) then
			doubleRects1.alpha = 1
			doubleRects2.alpha = 1
			transition.to( doubleRects1, { time=300, alpha = 0 , width=100, height=100, onComplete=listener1 } )
			transition.to( doubleRects2, { time=300, alpha = 0 , width=100, height=100, onComplete=listener1 } )
		end
		if(tapTime == 14000) then
			doubleRects1.alpha = 1
			doubleRects2.alpha = 1
			transition.to( doubleRects1, { time=300, alpha = 0 , width=100, height=100, onComplete=listener1 } )
			transition.to( doubleRects2, { time=300, alpha = 0 , width=100, height=100, onComplete=listener1 } )
		end]]--







