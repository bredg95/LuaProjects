-- level3.lua

---------------------------------------------------------------------------------
-- Most of the code in level 3 is similar to level 1 and 2
-- The only differences with level 3 is the timing and number of rounds.  
---------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")
local frameData = require("frameData")
local _W = display.contentWidth
local _H = display.contentHeight
 
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
local scoreBoardTitle = display.newText( "Alex: ".."0".. "     Janken: ".."0" .. "    Level 3", _W/2, 200, native.systemFont, 12) 

 
-- local forward references should go here
  local bg = display.newImage (bgSheet, 2);
 local bubble = display.newSprite (alexSheet, bubbleSeqData); 
 local janken = display.newSprite (jankenSheet, seqDataJanken);
 -- The x and y position are tailored to the boss sprite
  local isClicked = false
  local alexWins = 0
  local jankenWins = 0
  local roundCounter = 1
  local jankenHandSelection = math.random(4,6)
  local hand = display.newImage (jankenSheet, jankenHandSelection, -- boss_rock
   display.contentCenterX+41,
   display.contentCenterY+42);
  -- Next Button click event
local function nextButtonClicked ( event ) 
   if(event.phase == "ended") then
   -- Code for going to either the next level or the main menu if user lost
      isClicked = true
      hand:removeSelf( )
      if(alexWins == 3) then 
         composer.removeScene("level3")
         composer.gotoScene( "endScene");
         scoreBoardTitle:removeSelf();
      elseif(jankenWins == 3) then
         composer.removeScene("level3")
         composer.gotoScene( "startScene"); --print game over message
         scoreBoardTitle:removeSelf()
      end
   end
end
 local nextButton = widget.newButton( 
      {
         x = _W/2,
         y = _H/2,
         id = "nextButton",
         label = "YOU WON!!!",
         labelColor = {default ={1,1,1}, over = {0,0,0}},
         textOnly = false,
         shape = "roundedRect",
         fillColor = {default = {0,0,2,0.7}, over={1,0.2,0.5,1}},
         onEvent = nextButtonClicked

      } )
 local function play ()
      alex:setSequence ("alex_shake");
      alex:play();

      janken:setSequence("boss_shake");
      janken:play();
end

local playAgainButton;

local function shoot ()

   --janken:setSequence("boss_set");
   --hand = display.newImage (jankenSheet, 4, -- boss_rock
   janken:setSequence("boss_set");
   hand.isVisible = true;
   if(toggleCounter   == 0) then
      alex:setSequence("alex_rock");
      print("alex_rock")
      print(toggleCounter)
   end
   if(toggleCounter  == 1) then
      alex:setSequence("alex_scissor");
      print("alex_paper")
      print(toggleCounter)
   end
   if(toggleCounter  == 2) then
      alex:setSequence("alex_paper");
      print("alex_scissor")
      print(toggleCounter)
   end
   -- Add code for determining who won the current round or if it led to a tie

   -- If level is complete, determine if user needs to go back to main menu or continue to the next level
-- If level is complete, determine if user needs to go back to main menu or continue to the next level
   local jankenHand = (jankenHandSelection-1) % 3

   if(toggleCounter == jankenHand) then
      --tie
      print("tie")
      playAgainButton:setLabel("Draw! Play Again")
   elseif(toggleCounter == 0) then
      -- Janken: Scissor
      if(jankenHand == 1) then
         alexWins = alexWins + 1
         print("alex wins")
         playAgainButton:setLabel("Victory! Play Again")
         roundCounter = roundCounter + 1
      else
         jankenWins = jankenWins + 1
         print("janken wins")
         playAgainButton:setLabel("Loss! Play Again")
         roundCounter = roundCounter + 1
      end
   elseif(toggleCounter == 1) then
      -- alex: rock   janken: paper
      -- janken wins
      if(jankenHand == 2) then
         alexWins = alexWins + 1
         print("alex wins")
         playAgainButton:setLabel("Victory! Play Again")
         roundCounter = roundCounter + 1
      else
         jankenWins = jankenWins + 1
         print("janken wins")
         playAgainButton:setLabel("Loss! Play Again")
         roundCounter = roundCounter + 1
      end
   elseif(toggleCounter == 2) then
      if(jankenHand == 0) then
         alexWins = alexWins + 1
         print("alex wins")
         playAgainButton:setLabel("Victory! Play Again")
         roundCounter = roundCounter + 1
      else
         jankenWins = jankenWins + 1
         print("janken wins")
         playAgainButton:setLabel("Loss! Play Again")
         roundCounter = roundCounter + 1
      end
   end
   scoreBoardTitle:removeSelf()
   scoreBoardTitle = display.newText( "Alex: "..alexWins.. "     Janken: "..jankenWins .. "    Level 3", _W/2, 200, native.systemFont, 12 )
   scoreBoardTitle:setFillColor( 1, 1, 1 )
   if(alexWins == 3) then
      --Print level 1 win message
      nextButton.isVisible = true
      nextButton:setLabel("YOU WON!!!")
      return
   elseif(jankenWins == 3) then
      nextButton:setLabel("YOU LOSE")
      nextButton.isVisible = true
   else
      playAgainButton.isVisible = true;
   end

end
local function playAgainButtonClicked ( event ) 
   if(event.phase == "ended") then
      print("playAgainButtonClicked")
      
      --alex:play();
      jankenHandSelection = math.random( 10,12 )
      print("janke" .. jankenHandSelection)
      hand:removeSelf();
      hand = nil;
      hand = display.newImage (jankenSheet, jankenHandSelection, 
         display.contentCenterX+41,
         display.contentCenterY+42);
      hand.isVisible = false;
      bubble:setSequence( "bubble_rock" )
      toggleCounter = 0;
      playAgainButton.isVisible = false;
      play();  
      --Shake for a while before revealing the hand      
      local t = timer.performWithDelay (3000, shoot, 1);
      
   end
end

playAgainButton = widget.newButton( 
      {
         x = _W/2,
         y = _H/2,
         id = "playAgainButton",
         label = "Play Again",
         labelColor = {default ={1,1,1}, over = {0,0,0}},
         textOnly = false,
         shape = "roundedRect",
         fillColor = {default = {0,0,2,0.7}, over={1,0.2,0.5,1}},
         onEvent = playAgainButtonClicked

      } )
playAgainButton.isVisible = false;
---------------------------------------------------------------------------------
 
-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
 
   -- Initialize the scene
   bg.x = display.contentWidth / 2;
   bg.y= display.contentHeight / 2;
   -- Alex sprite
   alex = display.newSprite (alexSheet, alexSeqData); 
   alex.x = display.contentCenterX-80; 
   alex.y = display.contentCenterY+66; 
   alex.anchorX = 0; 
   alex.anchorY = 1; 
   

   bubble.x = display.contentCenterX-90; 
   bubble.y = display.contentCenterY+26; 
   bubble.anchorX = 0; 
   bubble.anchorY = 1; 
   bubble.xScale = 1.2
   bubble.yScale = 1.2
   
   janken.x = display.contentCenterX+80;
   janken.y = display.contentCenterY+66;
   janken.anchorX = 1;
   janken.anchorY = 1;
   
      sceneGroup:insert(bg)
      sceneGroup:insert(alex )
      sceneGroup:insert(bubble)
      sceneGroup:insert(janken)
      sceneGroup:insert(nextButton)
      sceneGroup:insert(playAgainButton)
      sceneGroup:insert(hand)
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
      hand.isVisible = false;
      nextButton.isVisible = false;
      bubble.tap = toggleOptions
      bubble:addEventListener("tap",toggleOptions)
      play();  
      --Shake for a while before revealing the hand
      local t = timer.performWithDelay (3000, shoot, 1);
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   end
end
 
-- "scene:destroy()"
function scene:destroy( event )
 
   local sceneGroup = self.view
 
   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end
 
---------------------------------------------------------------------------------
 
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
---------------------------------------------------------------------------------
 
return scene