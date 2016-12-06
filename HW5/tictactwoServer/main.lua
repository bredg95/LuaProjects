--[[ changes to main.lua:
For it to be asynchronous, we assumed asynchronous means that when one
game is waiting for the other to make a move, it can still perform
other operations such as moving the GUI around or printing statements.
]]--
local socket = require("socket")
local game = require( "game" );



local server = socket.bind("*", 20140);
--local server = socket.bind("*", 20100);
-- Wait for connection from client
client = server:accept();
local cip, cport = client:getpeername();
print ("connected to:", cip, ":", cport);

-- GameTimer will hold the id of the timer that will poll for messages
local gameTimer;

local buttons = display.newGroup();

local sBtn = display.newRect (buttons, 30,0,35,20 );
sBtn:setFillColor(0,0.5,0);
display.newText(buttons, "Host", 30, 0,native.systemFont,15);

local cBtn = display.newRect (buttons, 80,0,40,20 );
cBtn:setFillColor(0,0.5,0);
display.newText(buttons, "Guest", 80,0,native.systemFont,15);


-- This is the polling function for waiting for messages
function waitForMove()
  -- This will prevent the receive function from hanging up the software
  client:settimeout(0)
  local line, err = client:receive();
  if not err then 
    local x=tonumber(string.sub(line,1,1));
    local y=tonumber(string.sub(line,3,3));
    print ("Got:",x,y);
    print ("-------------");    
    game.mark(x,y);
    game.activate();
    -- Since it got the move from the other game back, now its this instance's turn
    game.myMove = true;
    timer.cancel(gameTimer)
  end
end



local function gameStart (event)
  
  buttons:removeSelf();  -- remove the buttons
  buttons=nil;

  --determine: host vs guest
  if (event.target==sBtn) then --------------- host/server role
  	game.activate ();

  else  --------------- guest/client role
    -- This will poll waitForMove. I chose 200 ms to ensure the software can have time
    -- time to execute any functions before polling again
  	gameTimer = timer.performWithDelay( 200, waitForMove , 0)   
  end
end
sBtn:addEventListener("tap", gameStart);
cBtn:addEventListener("tap", gameStart);



local function sendMove(event)
  -- if its not its move then dont do anything
  if not game.myMove then
    return
  end
  print("I made my move at:", event.x, event.y);
  local sent, msg =   client:send(event.x..","..event.y.."\r\n");
  -- Since it sent its move it now has to wait for the next move
  game.myMove = false
  gameTimer = timer.performWithDelay( 200, waitForMove , 0) 
end

Runtime:addEventListener("moved", sendMove);



