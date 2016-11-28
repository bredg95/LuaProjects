local beatMap = {beatTable = {}, timeTable = {}, quarterBeat = 0, 
	beatDivisor = 0, bpm = 0, length = 0, pixPerSec = 0, offset = 0,
	songFile = ""}

local distMark = 30;

local function setTimeTable(fileName)
	local tempTable = {}
	local path = system.pathForFile(fileName)
	local tmp = io.input()
	io.input(path)

	local hitTime = io.read("*n")
	local i = 1;
	while (hitTime ~= nil) do
		tempTable[i] = hitTime
		i = i + 1
		hitTime = io.read("*n")
	end
	io.input():close()
	io.input(tmp)
	return tempTable
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function beatMap:setupIndicatorBar()
	local totalMarks = 4*beatMap.beatDivisor*math.ceil((beatMap.length-beatMap.offset)/(beatMap.quarterBeat*4))
	local indicatorGroup = display.newGroup( );
	indicatorGroup.anchorX = 0
	local x,y = distMark*beatMap.offset/(beatMap.quarterBeat/beatMap.beatDivisor),20

	-- Adds tick marks to indicator bar
	for i=1,totalMarks,1
		do
		x = x + distMark
		local mark;
		if(i%(4*beatMap.beatDivisor) == 0) then
			mark = display.newLine(x, y, x, 0)
			mark:setStrokeColor(0,1,0,1)
		elseif (i%beatMap.beatDivisor == 0) then
			mark = display.newLine(x, y, x, y-10)
			mark:setStrokeColor(1,0,0,1)
		else
			mark = display.newLine(x, y, x, y-5)
			mark:setStrokeColor(0,0,1,1)
		end
		indicatorGroup:insert(mark)
	end

	-- Adds beat circles to indicator bar
	for i=1,#beatMap.timeTable,1
		do

		local posX = distMark*((beatMap.timeTable[i])/(beatMap.quarterBeat/beatMap.beatDivisor))
		beatMap.beatTable[round((beatMap.timeTable[i])/(beatMap.quarterBeat/beatMap.beatDivisor), 0)] = true;
		--print(round((beatMap.timeTable[i])/(beatMap.quarterBeat/beatMap.beatDivisor)))
		local beat = display.newCircle(posX, 10, 10)
		beat:setFillColor( 1,0,1,0.5)
		indicatorGroup:insert(beat)
	end
	return indicatorGroup
end

-- Song Number indexes which song to use, i.e. 1 for Ame Michi and 2 for Lean On
function beatMap:setSong(songNum)
	if(songNum == 1) then
		beatMap.timeTable = setTimeTable("timeTable_AmeMichi.txt")
		beatMap.length = 135167
		beatMap.bpm = 95
		beatMap.quarterBeat = 1000*60/95
		beatMap.beatDivisor = 4
		beatMap.offset = 117
		beatMap.songFile = "song_AmeMichi.mp3"
	elseif(songNum == 2) then
		beatMap.timeTable = setTimeTable("timeTable_LeanOn.txt")
		beatMap.length = 176588
		beatMap.bpm = 120
		beatMap.offset = 0
		beatMap.quarterBeat = 1000*60/120
		beatMap.beatDivisor = 6
		distMark = 33
		beatMap.songFile = "song_leanOn.mp3"
	end
	beatMap.pixPerSec = (distMark-2)*1000/(math.ceil(beatMap.quarterBeat)/beatMap.beatDivisor)
end


return beatMap