-- level2.lua

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
 
local scoreBoardTitle = display.newText( "", 60, 200, native.systemFont, 12 )


-- local forward references should go here
  local bg = display.newImage (bgSheet, 3);
 local bubble = display.newSprite (alexSheet, bubbleSeqData); 
 local janken = display.newSprite (jankenSheet, seqDataJanken);
 -- This x and y layout should work for the two enemies before the boss
local isClicked = false
local alexWins = 0
local jankenWins = 0
local roundCounter = 1
local jankenHandSelection = math.random(16,18)
local hand = display.newImage (jankenSheet, jankenHandSelection, 
   display.contentCenterX+57,
   display.contentCenterY+50);
 -- Next Button click event
local function nextButtonClicked ( event ) 
   if(event.phase == "ended") then
   -- Code for going to either the next level or the main menu if user lost
      composer.removeScene("level2")
      composer.gotoScene( "level3");
      timer:removeSelf();
   end
end
local function playAgainButtonClicked ( event ) 
   if(event.phase == "ended") then
      print("playAgainButtonClicked")
      --play();
      composer.gotoScene( "level2");
   end
end
 local nextButton = widget.newButton( 
      {
         x = _W/2,
         y = _H/2,
         id = "nextButton",
         label = "Go to Level 3",
         labelColor = {default ={1,1,1}, over = {0,0,0}},
         textOnly = false,
         shape = "roundedRect",
         fillColor = {default = {0,0,2,0.7}, over={1,0.2,0.5,1}},
         onEvent = nextButtonClicked

      } )
 local playAgainButton = widget.newButton( 
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
 local function play ()
   
      --nextButton.isVisible = true; -- only for debugging

      playAgainButton.isVisible = false;


      scoreBoardTitle:removeSelf()
      scoreBoardTitle = display.newText( "Alex: "..alexWins.. "     Janken: "..jankenWins, 60, 200, native.systemFont, 12 )
      scoreBoardTitle:setFillColor( 1, 1, 1 )

      if(alexWins == 2) then
         --Print level 2 win message
         nextButton.isVisible = true
         return
      elseif(jankenWins == 2) then
         composer.gotoScene( "endScene"); --print game over message
         scoreBoardTitle:removeSelf()
         timer:removeSelf();
      end


      




      bubble.tap = toggleOptions
      bubble:addEventListener("tap",toggleOptions)

      alex:setSequence ("alex_shake");
      alex:play();

      janken:setSequence("enemy2_shake");
      janken:play();
end

local function shoot ()

   --janken:setSequence("boss_set");
   --hand = display.newImage (jankenSheet, 4, -- boss_rock
   janken:setSequence("enemy2_set");
   --hand = display.newImage (jankenSheet, 4, -- boss_rock
   
   hand.isVisible = true;
   if(toggleCounter   == 0) then
      alex:setSequence("alex_rock");
      print("alex_rock")
      print(toggleCounter)
   end
   if(toggleCounter  == 1) then
      alex:setSequence("alex_paper");
      print("alex_paper")
      print(toggleCounter)
   end
   if(toggleCounter  == 2) then
      alex:setSequence("alex_scissor");
      print("alex_scissor")
      print(toggleCounter)
   end

   -- Add code for determining who won the current round or if it led to a tie

   -- If level is complete, determine if user needs to go back to main menu or continue to the next level


   print("toggleCounter: ",toggleCounter)
   print("jankenHandSelection: ", jankenHandSelection)
   if(toggleCounter == 0 and jankenHandSelection == 16) then
      --tie
      print("tie")
      playAgainButton.isVisible = true;
   elseif(toggleCounter == 1 and jankenHandSelection == 18) then
      --tie
      print("tie")
      playAgainButton.isVisible = true;
   elseif(toggleCounter == 2 and jankenHandSelection == 17) then
      --tie
      print("tie")
      playAgainButton.isVisible = true;
   elseif(toggleCounter == 0 and jankenHandSelection == 17) then
      --alex: rock    janken:  scissor
      --alex wins
      alexWins = alexWins + 1
      print("alex wins")
      roundCounter = roundCounter + 1
      playAgainButton.isVisible = true;
   elseif(toggleCounter == 0 and jankenHandSelection == 18) then
      -- alex: rock   janken: paper
      -- janken wins
      jankenWins = jankenWins + 1
      print("janken wins")
      roundCounter = roundCounter + 1
      playAgainButton.isVisible = true;
   elseif(toggleCounter == 1 and jankenHandSelection == 16) then
      -- alex: paper     janken: rock
      -- alex wins
      alexWins = alexWins + 1
      print("alex wins")
      roundCounter = roundCounter + 1
      playAgainButton.isVisible = true;
   elseif(toggleCounter == 1 and jankenHandSelection == 17) then
      --alex: paper    janken: scissors
      --janken wins
      jankenWins = jankenWins + 1
      print("janken wins")
      roundCounter = roundCounter + 1
      playAgainButton.isVisible = true;
   elseif(toggleCounter == 2 and jankenHandSelection == 16) then
      --alex: scissors  janken: rock
      -- janken wins
      jankenWins = jankenWins + 1
      print("janken wins")
      roundCounter = roundCounter + 1
      playAgainButton.isVisible = true;
   elseif(toggleCounter == 2 and jankenHandSelection == 18) then
      --alex: scissors  janken: paper
      --alex wins
      alexWins = alexWins + 1
      print("alex wins")
      roundCounter = roundCounter + 1
      playAgainButton.isVisible = true;
   end



   -- reset toggle counter
   toggleCounter = 0;
   --nextButton.isVisible = true;

end
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
      alex:play();
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