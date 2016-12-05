local socket = require("socket")
local game = require( "game" );
local composer = require( "composer" );

local scene = composer.newScene();
local gameTimer;
local client;


local function getIP()
  client = socket.udp()
  client:setpeername("74.125.115.104", 80)
  local ip, sock = client:getsockname()
  --ip = "226.192.1.1"
  print("myIP:", ip, sock)
  client:close()
  return ip;
end
local server = assert(socket.bind(getIP(), 20140));
server:settimeout(0)

function waitForMove()
  --print ("Waiting to receive move... ");
  -- client = socket.connect("localhost",20140);
  -- if (client == nil) then
  --   return
  -- end
  client = socket.udp()
  client:setsockname("localhost", 20140)
  client:settimeout(0)
  local line, err = client:receivefrom();
  if not err then 
    local x=tonumber(string.sub(line,1,1));
    local y=tonumber(string.sub(line,3,3));
    print ("Got:",x,y);
    print ("-------------");    
    local marked = game.mark(x,y);
    if( not marked) then
      local sent, msg = client:send("bad move")
    else
      local sent, msg = client:send("good move")
      timer.cancel( gameTimer )
      game.myMove = true;
      game.activate();
    end
  else 
    print ("Error.")
  end
  client:close()
end

function waitForConfirm()
  -- client = socket.connect("localhost", 20140);
  print("waiting for confirm")
  client = socket.udp()
  client:setsockname("localhost", 20140)
  client:settimeout(0)
  local line, ip, port = client:receivefrom();
  if (port == 20140) then 
    print(line)
    if(line == "good move") then 
      game.mark(x,y);
      timer.cancel(gameTimer)
      game.myMove = false;
      gameTimer = timer.performWithDelay(200, waitForMove, -1);

    else 
      print("waiting")
      --game.activate()
    end
  end
  client:close()
end

-- function scene:create(event)
--   -- connect to a TCP server
--   -- local ip = "localhost";
  
--   -- local cip, cport = client:getpeername();
--   -- print ("connected to host at:", cip, ":", cport);
--   -- game.activate()
-- end

-- local buttons = display.newGroup();

-- local sBtn = display.newRect (buttons, 30,0,35,20 );
-- sBtn:setFillColor(0,0.5,0);
-- display.newText(buttons, "Host", 30, 0,native.systemFont,15);

-- local cBtn = display.newRect (buttons, 80,0,40,20 );
-- cBtn:setFillColor(0,0.5,0);
-- display.newText(buttons, "Guest", 80,0,native.systemFont,15);

-- local function gameStart (event)
--   buttons:removeSelf();  -- remove the buttons
--   buttons=nil;


--   --determine: host vs guest
--   if (event.target==sBtn) then --------------- host/server role
--     game.activate ();

--   else  --------------- guest/client role
--     waitForMove();  
--   end
-- end
-- sBtn:addEventListener("tap", gameStart);
-- cBtn:addEventListener("tap", gameStart);



local function sendMove(event)
  
  if(not game.myMove) then
    return
  end
  local ip = server:getsockname()
  print(ip)
  client, why = server:connect("192.168.0.4", 20140)
  if not client then
    print(why)
    return;
  end
  -- repeat
   -- client = server:accept()
  -- until client

  --client = socket.udp()
 -- client:setoption("broadcast", true)
  -- client:setsockname(getIP(), 11111)
  client:settimeout(0)
  --print(client:getsockname())
  --client:setsockname("localhost", 20140)
  local msg = event.x..","..event.y.."\r\n"
  print(msg)
  --client:setoption("broadcast", true)
  --client:setpeername("74.125.115.104", 80)
  --local ip, sock = client:getsockname()

  --print("myIP:", ip, sock)
  local err, line = client:send(msg)
  print(err)
  print(line)
  --client:setoption("broadcast", false)
  --print("I made my move at:", event.x, event.y);
  -- if(client == nil) then
  --   client = socket.connect("localhost",20140);
    -- client:settimeout(0);
  -- end
  --local sent, msg =   client:send(event.x..","..event.y.."\r\n");
  client:close()
  --gameTimer = timer.performWithDelay(200, waitForConfirm, -1);
end

Runtime:addEventListener("moved", sendMove);

-- local composer = require( "composer" );
-- local physics = require("physics");
-- local socket = require("socket")
-- local square = require( "square" );

-- local scene = composer.newScene();

-- function scene:create(event)
--  local sceneGroup = self.view  

--  local mine = square:new({x=35,y=100});
--   mine:spawn();
--   mine.shape:setFillColor (0,1,0);
--   Runtime:addEventListener("touch", mine);

--   -- . . .
--  local g1 = display.newGroup();  
--  local btnConnect = display.newRect(g1,30,0, 30,10);
--   btnConnect:setFillColor(0.5,0.5,0);
--   display.newText(g1,"Connect", 30,0, native.systemFont, 15 );

-- local function SND (event)
 	 
-- 	  if mine.updated then
-- 	      local sent, msg = 
-- 	      client:send(tostring(mine.shape.x)..":"..tostring(mine.shape.y)..";".."\r\n");  
-- 	      mine.updated = false;       
-- 	  end
--  end


--  local ip = "localhost";
--  local function CNT (event)
--     client = socket.connect(ip,20140);
--     client:settimeout(0);
--     g1:removeSelf();
--     g1 = nil;
--     print('connect CNT')
--     timer.performWithDelay(10,SND, -1); -- send @10ms
--   end  
--   btnConnect:addEventListener("tap", CNT);

 

-- end
function scene:show(event)
  local sceneGroup = self.view;
  
   game.activate()
end
scene:addEventListener( "show", scene );

return scene;
