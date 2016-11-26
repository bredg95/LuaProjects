-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local physics = require('physics')
_W = display.contentWidth
_H = display.contentHeight

physics.start()
physics.setDrawMode( "hybrid" )

local hitTimer = system.getTimer( )

local missScore = display.newText("Miss: ", 10, _H-20, native.systemFont, 20 )
local hitScore = display.newText("Hit: ", 100, _H -20, native.systemFont, 20 )
missScore.anchorX = 0
hitScore.anchorX = 0
local miss = 0
local hit = 0
local timetable = {}
local path = system.pathForFile( "timeTableAmeMichi.txt")
local tmp = io.input()
io.input(path)

local hitTime = io.read("*n")
local i = 1;
while (hitTime ~= nil) do
	timetable[i] = hitTime
	i = i + 1
	hitTime = io.read("*n")
end
print(#timetable)
io.input():close()
io.input(tmp)
local offset = 117
local bpm = 95
local quarterBeat = 1000*60/bpm
local wholeBeat = quarterBeat*4
local eighthBeat = quarterBeat/2
local sixteenthBeat = quarterBeat/4
local length = 135167
--local timetable = {2490, 2790, 3240, 3390, 3690, 4140, 4290, 4440, 4590, 4890, 5190, 5640, 5790, 6090, 6390, 6690 }
local usertable = {}
local distMark = 30; --distance between sixteenth beat marks
local totalMarks = math.ceil((length-offset)/wholeBeat)*16
local indicatorBG = display.newRect(0,0,_W,20)
indicatorBG.anchorX = 0
indicatorBG.anchorY = 0
local indicatorGroup = display.newGroup( );
indicatorGroup.anchorX = 0
--local indicatorBar = display.newRect(0, 0, distMark*(16*length/wholeBeat), 20 )
--indicatorBar.anchorY = 0
--indicatorBar.anchorX = 0
--indicatorGroup:insert(indicatorBar)
local x,y = distMark*offset/sixteenthBeat,20
for i=1,totalMarks,1
	do
	x = x + distMark
	local mark; -- = display.newLine(x, y, x, y-10)
	if(i%16 == 0) then
		mark = display.newLine(x, y, x, 0)
		mark:setStrokeColor(0,1,0,1)
	elseif (i%4 == 0) then
		mark = display.newLine(x, y, x, y-10)
		mark:setStrokeColor(1,0,0,1)
	else
		mark = display.newLine(x, y, x, y-5)
		mark:setStrokeColor(0,0,1,1)
	end
	indicatorGroup:insert(mark)
end
local offsetMark = distMark*offset/sixteenthBeat
--local displayCircle = display.newCircle(20, 10, 10 )
local indicatorCircle = display.newCircle(20, 10, 10 )
indicatorCircle.anchorX = 0
--displayCircle.anchorX = 0
indicatorCircle:setFillColor( 0,1,0, 0.5)
physics.addBody(indicatorCircle, "dynamic")
indicatorCircle.isSensor = true;
local function startBeatWindow (event)
  if (event.phase == "began") then
  	hitTimer = timer.performWithDelay( sixteenthBeat, function ()
  		miss = miss + 1;
  		missScore.text = "Miss: " .. miss
  		end
  	)
  end
end
indicatorCircle:addEventListener("collision", startBeatWindow);

function setupIndicatorBar()
	for i=1,#timetable,1
		do
		local posX = distMark*((timetable[i])/sixteenthBeat)
		local beat = display.newCircle(posX, 10, 10)
		beat:setFillColor( 1,0,1,0.5)
		physics.addBody(beat, "kinematic")
		beat.isSensor = true;
		indicatorGroup:insert(beat)
	end
end

--system.getTimer()
local index = 0;
local gameBox = display.newRect(  _W/2, _H/2, 200, 200 )
local sound = audio.loadStream( "-insturmental version- Otokaze.mp3")
function boxTapped (object, event)
	timer.cancel(hitTimer)
	hit = hit + 1
	hitScore.text = "Hit: " .. hit;
end

gameBox.tap = boxTapped
gameBox:setFillColor( 0, 0, 1 )
gameBox:addEventListener( "tap", gameBox )
local options = 
{
	channel = 1,
	duration = 135167
}
setupIndicatorBar()

physics.setGravity( 0, 0 )
physics.addBody( indicatorGroup, "kinematic")

local pixpersec = distMark/(sixteenthBeat/1000)
print(eighthBeat/1000)
print(distMark)
 print(pixpersec)
local function moveIndicatorBar()
	indicatorGroup:setLinearVelocity( -pixpersec, 0 )
end
local function beginIndicator()
	audio.setVolume(0.5)
	--timer.performWithDelay( 100, moveIndicatorBar, 1 )
	audio.play(sound, options )
	indicatorGroup:setLinearVelocity( -pixpersec, 0 )
	--indicatorCircle.bodyType = "dynamic"
end
indicatorGroup.x = indicatorCircle.x + 2*offsetMark
timer.performWithDelay( 2000, beginIndicator, 1 )