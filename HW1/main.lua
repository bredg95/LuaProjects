-----------------------------------------------------------------------------------------
-- Sprite Matching Game
-- File: main.lua
-- Class: CPE 371
-- Description: Code for sprite matching game
-- Author: Branden Guevara
-----------------------------------------------------------------------------------------
-- Hides the status bar when in app
display.setStatusBar(display.HiddenStatusBar);

-- _W and _H hold the content width and height for the device the application is running on
_W = display.contentWidth;
-- Subtract 25 so that the matchText will be visible during gameplay
_H = display.contentHeight - 25;

-- The following 8 opt variables hold frame data for each sprite sheet
local opt = 
{	
	frames = 
	{
		{x=253,y=0,width=37,height=38},
		{x=290,y=0,width=35,height=38},
		{x=325,y=0,width=35,height=38},
		{x=360,y=0,width=37,height=38}
	}
}
local opt2 = 
{
	frames =
	{
		{x =355,y=0,width = 40,height=50},
		{x = 395,y=0,width = 40,height=50},
		{x = 435,y=0,width = 40,height=50},
		{x = 475,y=0,width = 40,height=50}
	}
}
local opt3 = 
{
	frames = 
	{
		{x=0,y=0,width=110,height=218},
		{x=110,y=0,width=85,height=218},
		{x=195,y=0,width=93,height=218},

		{x=288,y=0,width=110,height=218},
		{x=398,y=0,width=110,height=218},
		{x=508,y=0,width=180,height=218},

		{x=688,y=0,width=217,height=218},		
		{x=905,y=0,width=207,height=218},
		{x=1112,y=0,width=124,height=218},

		{x=1236,y=0,width=117,height=218},
		{x=1353,y=0,width=112,height=218},
		{x=1465,y=0,width=104,height=218},

		{x=1569,y=0,width=101,height=218},
		{x=1670,y=0,width=100,height=218},
		{x=1770,y=0,width=87,height=218},
		{x=1857,y=0,width=103,height=218}
	}
}
local opt4 = 
{
	frames = 
	{
		{x=0,y=0,width=33,height=45},
		{x=33,y=0,width=35,height=45},
		{x=68,y=0,width=33,height=45},

		{x=101,y=0,width=30,height=45},
		{x=131,y=0,width=29,height=45},
		{x=160,y=0,width=22,height=45},

		{x=131,y=0,width=29,height=45},
		{x=101,y=0,width=30,height=45},
		{x=68,y=0,width=33,height=45},
		{x=33,y=0,width=35,height=45},
		{x=0,y=0,width=33,height=45}
	}
}
local opt5 = 
{
	frames = 
	{
		{x=0,y=0,width=23,height=41},
		{x=26,y=0,width=23,height=41},
		{x=54,y=0,width=23,height=41},
		{x=80,y=0,width=23,height=41},
		{x=103,y=0,width=23,height=41},
		{x=131,y=0,width=30,height=41},


		{x=165,y=0,width=65,height=41},
		{x=165,y=0,width=65,height=41}
	}
}
local opt6 = 
{
	frames = 
	{
		{x=73,y=0,width=34,height=50},
		{x=107,y=0,width=36,height=50},
		{x=143,y=0,width=37,height=50},

		{x=180,y=0,width=37,height=50},
		{x=217,y=0,width=39,height=50},
		{x=256,y=0,width=39,height=50},
		{x=295,y=0,width=40,height=50},
		{x=335,y=0,width=41,height=50},

		{x=376,y=0,width=39,height=50},
		{x=415,y=0,width=39,height=50},
		{x=454,y=0,width=37,height=50},
		{x=491,y=0,width=34,height=50},
		{x=525,y=0,width=31,height=50},

		{x=556,y=0,width=30,height=50},
		{x=586,y=0,width=26,height=50},
		{x=612,y=0,width=26,height=50},
		{x=638,y=0,width=28,height=50},
		{x=666,y=0,width=28,height=50},

		{x=694,y=0,width=26,height=50},
		{x=720,y=0,width=28,height=50},
		{x=748,y=0,width=28,height=50},
		{x=776,y=0,width=31,height=50}
	}
}
local opt7 =
{
	frames =
	{
		{x=0,y=0,width=31,height=50},
		{x=31,y=0,width=29,height=50},
		{x=60,y=0,width=29,height=50},

		{x=89,y=0,width=29,height=50},
		{x=118,y=0,width=29,height=50},
		{x=147,y=0,width=29,height=50},
		{x=176,y=0,width=30,height=50},
		{x=206,y=0,width=30,height=50},

		{x=236,y=0,width=30,height=50},
		{x=266,y=0,width=30,height=50},
		{x=296,y=0,width=30,height=50},
		{x=326,y=0,width=31,height=50},
		{x=357,y=0,width=30,height=50},
		{x=387,y=0,width=30,height=50},
		{x=387,y=0,width=30,height=50},
		{x=357,y=0,width=30,height=50},
		{x=326,y=0,width=31,height=50},
		{x=326,y=0,width=31,height=50},
		{x=357,y=0,width=30,height=50},
		{x=387,y=0,width=30,height=50}
	}
}
local opt8 = 
{
	frames = 
	{
		{x=0,y=0,width=92,height=133},
		{x=92,y=0,width=104,height=133},
		{x=196,y=0,width=140,height=133},

		{x=336,y=0,width=160,height=133},
		{x=496,y=0,width=113,height=133},
		{x=609,y=0,width=82,height=133},

		{x=691,y=0,width=105,height=133},		
		{x=796,y=0,width=94,height=133},
		{x=890,y=0,width=82,height=133},

		{x=972,y=0,width=80,height=133},
		{x=1052,y=0,width=119,height=133},
		{x=1171,y=0,width=119,height=133},

		{x=1290,y=0,width=93,height=133},
		{x=1383,y=0,width=96,height=133}
	}
}

-- Each sheet variable will grab the specified frames based on the frame data from each respective option variables
local sheet = graphics.newImageSheet( "anim1.png", opt )
local sheet2 = graphics.newImageSheet("anim2.png", opt2)
local sheet3 = graphics.newImageSheet("anim3.png", opt3)
local sheet4 = graphics.newImageSheet("anim4.png", opt4)
local sheet5 = graphics.newImageSheet("anim5.png", opt5)
local sheet6 = graphics.newImageSheet("anim6.png", opt6)
local sheet7 = graphics.newImageSheet("anim7.png", opt7)
local sheet8 = graphics.newImageSheet("anim8.png", opt8)

-- *** The next 8 blocks of code contain the creation of each sprite as well as the duplicate sprite that will be matched during gameplay
-- Note each sprite will scale differently to be able to fit within each grid space. Some also have different anchor points due to the unique nature of the sprite animation
-- Sequence data that will set the speed, frame start, and frame count of each sprite sheet
local seqData = 
{ 
	{name = "normal", start=1 ,count = 4, time=400} 
} 
-- The two local variables that will hold the original and duplicate sprite objects
local anim_1 = display.newSprite (sheet, seqData); 
local anim_2 = display.newSprite(sheet, seqData);
anim_1.anchorX = 0.5; 
anim_1.anchorY = 0.5; 
anim_1.xScale = 1.5; 
anim_1.yScale = 1.5; 
anim_1:setSequence("normal");
anim_2.anchorX = 0.5; 
anim_2.anchorY = 0.5; 
anim_2.xScale = 1.5; 
anim_2.yScale = 1.5; 
anim_2:setSequence("normal");
-- The myName property will be used to compare two selected sprite objects to check if they match 
anim_1.myName = "anim";
anim_2.myName = "anim"; 


local seqData2 = 
{ 
	{name = "normal", start=1 ,count = 4, time=400} 
} 
local anim2_1 = display.newSprite (sheet2, seqData2); 
local anim2_2 = display.newSprite (sheet2, seqData2); 
anim2_1.anchorX = 0.5; 
anim2_1.anchorY = 0.5; 
anim2_1.xScale = 1.5; 
anim2_1.yScale = 1.5; 
anim2_1:setSequence("normal"); 
anim2_2.anchorX = 0.5; 
anim2_2.anchorY = 0.5; 
anim2_2.xScale = 1.5; 
anim2_2.yScale = 1.5; 
anim2_2:setSequence("normal"); 
anim2_1.myName = "anim2";
anim2_2.myName = "anim2"; 

-- This sprite was relatively large and needed a significant scale decrease
local seqData3 = 
{ 
	{name = "normal", start=1 ,count = 16, time=1300} 
} 
local anim3_1 = display.newSprite (sheet3, seqData3);
local anim3_2 = display.newSprite (sheet3, seqData3); 
anim3_1.anchorX = 0.5; 
anim3_1.anchorY = 0.5; 
anim3_1.xScale = 0.3; 
anim3_1.yScale = 0.3; 
anim3_1:setSequence("normal"); 
anim3_2.anchorX = 0.5; 
anim3_2.anchorY = 0.5; 
anim3_2.xScale = 0.3; 
anim3_2.yScale = 0.3; 
anim3_2:setSequence("normal"); 
anim3_1.myName = "anim3";
anim3_2.myName = "anim3"; 

local seqData4 = 
{ 
	{name = "normal", start=1 ,count = 11, time=1200} 
} 
local anim4_1 = display.newSprite (sheet4, seqData4); 
local anim4_2 = display.newSprite (sheet4, seqData4); 
anim4_1.anchorX = 0.5; 
anim4_1.anchorY = 0.5; 
anim4_1.xScale = 1.5; 
anim4_1.yScale = 1.5; 
anim4_1:setSequence("normal"); 
anim4_2.anchorX = 0.5; 
anim4_2.anchorY = 0.5; 
anim4_2.xScale = 1.5; 
anim4_2.yScale = 1.5; 
anim4_2:setSequence("normal");
anim4_1.myName = "anim4";
anim4_2.myName = "anim4"; 

-- This sprite specifically needed to be anchored to the right to line up each frame correctly
local seqData5 = 
{ 
	{name = "normal", start=1 ,count = 8, time=800} 
} 
local anim5_1 = display.newSprite (sheet5, seqData5); 
local anim5_2 = display.newSprite (sheet5, seqData5); 
anim5_1.anchorX = 1; 
anim5_1.anchorY = 0.5; 
anim5_1.xScale = 0.8; 
anim5_1.yScale = 0.8; 
anim5_1:setSequence("normal"); 
anim5_2.anchorX = 1; 
anim5_2.anchorY = 0.5; 
anim5_2.xScale = 0.8; 
anim5_2.yScale = 0.8; 
anim5_2:setSequence("normal"); 
anim5_1.myName = "anim5";
anim5_2.myName = "anim5"; 

local seqData6 = 
{ 
	{name = "normal", start=1 ,count = 22, time=1500} 
} 
local anim6_1 = display.newSprite (sheet6, seqData6);
local anim6_2 = display.newSprite (sheet6, seqData6); 
anim6_1.anchorX = 0.5; 
anim6_1.anchorY = 0.5; 
anim6_1.xScale = 1.5; 
anim6_1.yScale = 1.5; 
anim6_1:setSequence("normal"); 
anim6_2.anchorX = 0.5; 
anim6_2.anchorY = 0.5; 
anim6_2.xScale = 1.5; 
anim6_2.yScale = 1.5; 
anim6_2:setSequence("normal"); 
anim6_1.myName = "anim6";
anim6_2.myName = "anim6"; 

local seqData7 = 
{ 
	{name = "normal", start=1 ,count = 20, time=2000} 
} 
local anim7_1 = display.newSprite (sheet7, seqData7); 
local anim7_2 = display.newSprite (sheet7, seqData7); 
anim7_1.anchorX = 0.5; 
anim7_1.anchorY = 0.5; 
anim7_1.xScale = 1.5; 
anim7_1.yScale = 1.5; 
anim7_1:setSequence("normal"); 
anim7_2.anchorX = 0.5; 
anim7_2.anchorY = 0.5; 
anim7_2.xScale = 1.5; 
anim7_2.yScale = 1.5; 
anim7_2:setSequence("normal"); 
anim7_1.myName = "anim7";
anim7_2.myName = "anim7"; 

-- This sprite needed to be anchored to the left to line up each frame correctly
local seqData8 = 
{ 
	{name = "normal", start=1 ,count = 14, time=1200} 
} 
local anim8_1 = display.newSprite (sheet8, seqData8); 
local anim8_2 = display.newSprite (sheet8, seqData8);
anim8_1.anchorX = 0; 
anim8_1.anchorY = 0.5; 
anim8_1.xScale = 0.3; 
anim8_1.yScale = 0.3; 
anim8_1:setSequence("normal"); 
anim8_2.anchorX = 0; 
anim8_2.anchorY = 0.5; 
anim8_2.xScale = 0.3; 
anim8_2.yScale = 0.3; 
anim8_2:setSequence("normal"); 
anim8_1.myName = "anim8";
anim8_2.myName = "anim8"; 

-- These two variable will specify the size of each grid space
local buttonW = _W/4;
local buttonH = _H/4;

-- totalButtons will be used both in the setup of the grid to create each buttonCover and during gameplay to tell when the game has been completed
local totalButtons = 0;

-- This variable will signal when a second selection has occurred
local secondSelect = 0;
-- This variable will signal when a matching pair has been revealed
local checkForMatch = false;

-- This table will hold all 16 sprites that have been created
local anims = {anim_1, anim_2, anim2_1, anim2_2, anim3_1, anim3_2, anim4_1, anim4_2, anim5_1, anim5_2, anim6_1, anim6_2, anim7_1, anim7_2, anim8_1, anim8_2}
-- This table will hold each index of the above table. It is depended on to be able to randomize the grid properly
local buttonTable = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16};
-- This table will hold buttonCovers for each grid space
local buttonCover = {}

-- LastButton will hold the last selected sprite. 
local lastButton = anim_1;

-- Text object that will notify when a match has occurred or not
local matchText = display.newText(" ", 0, 0, native.systemFont, 26)
matchText.anchorX = 0.5
matchText.anchorY = 0
matchText:setTextColor( 1, 1, 1 )
matchText.x = _W/2

-- The game function that will play the game
function game(object, event)
	-- The object variable will contain a buttonCover that includes the index of the sprite it is covering
	local sprite = anims[object.indexOfSprite];
	if (event.phase == "began") then
		if(checkForMatch == false and secondSelect == 0) then
			--flip over first button. Will simply set the covers fill color opacity to 0 and increase its border length
			buttonCover[sprite.number]:setFillColor( 0,0,0,0);
			buttonCover[sprite.number].strokeWidth = 5;
			lastButton = sprite
			checkForMatch = true
			-- begins the sprite animation
			sprite:play();
		elseif(checkForMatch == true) then
			if(secondSelect == 0) then
				--flip over second button
				buttonCover[sprite.number]:setFillColor( 0,0,0,0);
				buttonCover[sprite.number].strokeWidth = 5;
				secondSelect = 1;
				sprite:play();
				--if buttons do not match flip back over
				if(lastButton.myName ~= sprite.myName) then
					matchText.text = "Match Not Found!";
					timer.performWithDelay( 1500, function()
						sprite:pause();
						lastButton:pause();
						matchText.text = " ";
						checkForMatch = false;
						secondSelect = 0;
						-- Will return the buttonCover to its covered display with smaller borders
						buttonCover[lastButton.number]:setFillColor( 0.5,0.5,0.5,1);
						buttonCover[lastButton.number].strokeWidth = 1;
						buttonCover[sprite.number]:setFillColor( 0.5,0.5,0.5,1);
						buttonCover[sprite.number].strokeWidth = 1;
						end, 1)
				--if buttons do match remove covers completely, leaving the sprites to be shown
				elseif(lastButton.myName == sprite.myName) then
					totalButtons = totalButtons - 2;
					if(totalButtons == 0) then
						matchText.text = "Congratulations! You Won!";
					else
						matchText.text = "Match Found!";
					end
					timer.performWithDelay(1500, function()
						matchText.text = " ";
						checkForMatch = false;
						secondSelect = 0;
						buttonCover[lastButton.number]:removeSelf();
						buttonCover[sprite.number]:removeSelf();
						-- Return to the start menu when totalButtons has reached 0
						if(totalButtons == 0) then
							startMenu.isVisible = true;	
						end
						end, 1)
				end
			end
		end
	end	
end

--Place buttons on screen.
function setupGame()
	x = -buttonW/2 --set starting point
	-- Hide start menu
	startMenu.isVisible = false;

	-- This table will be a copy of the buttonTable
	local buttonIndexes = {};
	-- This will hold the current table length
	local tableLength = 0;
	for k,v in pairs(buttonTable) do
		tableLength = tableLength + 1;
		buttonIndexes[k] = v;
	end
	for count = 1,4 do
		-- Set position of each button
	    x = x + buttonW;
	    y = 25 + buttonH/2;

	    for insideCount = 1,4 do
	    	-- Grabs a random index value from the buttonIndexes table
	        local temp = math.random(1, tableLength)
	        -- decrement tableLength since the randomized index will be removed from the table copy
	        tableLength = tableLength - 1;
	        -- Get the specified index
	        local index = buttonIndexes[temp];

	        -- As mentioned above, some sprites have different x anchor points. This will compensate for the different anchor points when positioning each sprite
	        if(anims[index].anchorX == 0) then
	        	anims[index].x = x - buttonW/2 + 10;
	        elseif(anims[index].anchorX == 1) then
	        	anims[index].x = x + buttonW/2 - 10;
	        else
	        	anims[index].x = x;
	        end
	        anims[index].y = y;
	        -- The number property will hold the index that will point to the button cover for this sprite object
	        anims[index].number = totalButtons
	         
	        --Remove button from buttonIndexes table
	        table.remove(buttonIndexes, temp)
	         
			--Set a cover to hide the button image     
			local temp = display.newRect(x,y,buttonW -5 ,buttonH - 5);
			temp.strokeWidth = 1;
			temp:setStrokeColor(1,0,0); 
			temp:setFillColor(0.5,0.5,0.5,1);
			-- This will tie each button cover to the sprite they are covering
			temp.indexOfSprite = index;
	        
	        --Attach listener event to each buttonCover.
	        temp.touch = game      
	        temp:addEventListener( "touch", temp);
	        buttonCover[totalButtons] = temp;
	        totalButtons = totalButtons + 1
	        --Setup y position for next button
	        y = y + buttonH;
	    end
	end
end

-- The startMenu group that will hold all of the objects in the start menu
startMenu = display.newGroup();
-- Added 25 since this will cover the matchText
menuBG = display.newRect(0,0,_W,_H + 25);
menuBG:setFillColor( 0,0,0)
menuBG.anchorX = 0;
menuBG.anchorY = 0;
title = display.newText( "Branden Guevara\nSprite Matching Game", _W/2, _H/8, native.systemFont, 26)

startButton = display.newRect(_W/2, _H/4, 100,20);
startButton:setFillColor( 0.5);
startButton.strokeWidth = 1;
startButton:setStrokeColor( 0,0.5,0);
startButton.touch = setupGame;
startButton:addEventListener( "touch", startButton )

startLabel = display.newText( "Start",_W/2, _H/4, native.systemFont, 20)

startMenu:insert(menuBG);
startMenu:insert(title);
startMenu:insert(startButton);
startMenu:insert(startLabel);