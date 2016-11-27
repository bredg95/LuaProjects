-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Garrett Eledui
--  CS 371 midterm

local physics = require( "physics" )

physics.start()
physics.setGravity(0,9.8)

--local bottom = display.newRect(0,display.contentHeight-20, display.contentWidth, 20);
--bottom.anchorX = 0;
--bottom.anchorY = 0;

--physics.addBody( bottom, "static" );

local name = display.newText( "Garrett Eledui", 50, 0, native.systemFontBold, 12 )
name:setFillColor( 1, 1, 1 )

local scoreBoard = display.newText( "Correct Taps: ", 160, 0, native.systemFontBold, 12 )
scoreBoard:setFillColor( 1, 1, 1 )

local scoreBoard2 = display.newText( "Incorrect Taps: ", 260, 0, native.systemFontBold, 12 )
scoreBoard2:setFillColor( 1, 1, 1 )

local gameOverMessage = display.newText( "Game Over", 150, 110, native.systemFontBold, 20 )
gameOverMessage:setFillColor( 1, 1, 1 )
gameOverMessage.isVisible = false

local numOfHits = 0
local numOfMiss = 0
local objectCounter = 0

local function generateObject( switch )

	objectCounter = objectCounter + 1


	if(switch == 1) then
		--local circle = display.newCircle (display.contentCenterX,display.contentCenterY-200, 20);
		local circle = display.newCircle (math.random(0,400),5, 20);
		physics.addBody (circle, "dynamic") 
		circle:applyForce(0,math.random(),circle.x,circle.y)
		circle:setFillColor(math.random(),math.random(),math.random())
		
		function circle:touch( event )
	    if event.phase == "began" then
	        print( "You touched the circle!" )
	        numOfMiss = numOfMiss + 1 
			scoreBoard2.text = "Incorrect Taps: " .. numOfMiss
			local audio1 = audio.loadSound( "badSound1.wav" )
			local audio1Channel = audio.play( audio1 )
	        circle:removeSelf()
	        return true
		    end
		end
		circle:addEventListener( "touch", circle )

	elseif(switch == 2) then
		local square = display.newRect (math.random(0,400),5, 20,20);
		physics.addBody (square, "dynamic")
		square:applyForce(0,math.random(),square.x,square.y)
		square:setFillColor(math.random(),math.random(),math.random())

		function square:touch( event )
	    if event.phase == "began" then
	        print( "You touched the square!" )
	        numOfMiss = numOfMiss + 1 
			scoreBoard2.text = "Incorrect Taps: " .. numOfMiss
			local audio1 = audio.loadSound( "badSound1.wav" )
			local audio1Channel = audio.play( audio1 )
	        square:removeSelf()
	        return true
		    end
		end
		square:addEventListener( "touch", square )

	elseif(switch == 3) then
		local roundedRect = display.newRoundedRect (math.random(0,400),5, 20,20,5);
		physics.addBody (roundedRect, "dynamic")
		roundedRect:applyForce(0,math.random(),roundedRect.x,roundedRect.y)
		roundedRect:setFillColor(math.random(),math.random(),math.random())

		function roundedRect:touch( event )
	    if event.phase == "began" then
	        print( "You touched the roundedRect!" )
			numOfHits = numOfHits + 1 
			scoreBoard.text = "Correct Taps: " .. numOfHits
			local audio1 = audio.loadSound( "goodSound.wav" )
			local audio1Channel = audio.play( audio1 )
	        roundedRect:removeSelf()
	        return true
		    end
		end
		roundedRect:addEventListener( "touch", roundedRect )

	elseif(switch == 4) then
		local W =   540 
		local H = 700
		local r =  20
		local r_x = math.sqrt(math.pow(r,2)-math.pow((r/2),2))
		local vertices = { 0,-r, r_x , r/2 , -r_x , r/2  }
		local triangle = display.newPolygon( math.random(0,400),5, vertices )
		physics.addBody (triangle, "dynamic")
		triangle:applyForce(0,math.random(),triangle.x,triangle.y)
		triangle:setFillColor(math.random(),math.random(),math.random())

		function triangle:touch( event )
	    if event.phase == "began" then
	        print( "You touched the triangle!" )
	        numOfMiss = numOfMiss + 1 
			scoreBoard2.text = "Incorrect Taps: " .. numOfMiss
			local audio1 = audio.loadSound( "badSound1.wav" )
			local audio1Channel = audio.play( audio1 )
	        triangle:removeSelf()
	        return true
		    end
		end
		triangle:addEventListener( "touch", triangle )

	end	
	if(objectCounter >= 50) then
		gameOverMessage.isVisible = true
	end

end



local myClosure = function() return generateObject( math.random(1,4) )  end
timer.performWithDelay( 1000, myClosure, 50)

