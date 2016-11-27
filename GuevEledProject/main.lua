-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local physics = require('physics')
_W = display.contentWidth
_H = display.contentHeight

physics.start()

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
local gameBox = display.newRect(  _W/2, _H/2, 200, 200 )
local sound = audio.loadStream(map.songFile)
function boxTapped (object, event)
	local tapTime = system.getTimer()
	local hitTime = round((tapTime - startTime)/(map.quarterBeat/map.beatDivisor))
	print(hitTime)
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
gameBox:setFillColor( 0, 0, 1 )
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