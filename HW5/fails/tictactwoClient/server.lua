
local socket = require("socket")
local game = require( "game" );
local composer = require( "composer" );

local scene = composer.newScene();
local client;  -- used to communicate via socket
local server;
local gameTimer;
game.myMove = false;
--print(socket.bind("*", 20140))

-- server = assert(socket.bind("*", 20140));
 
-- -- Wait for connection from client
-- local cip, cport = client:getpeername();
-- print ("connected to:", cip, ":", cport);

function waitForMove()
  client = socket.udp() -- server:accept();
  client:setsockname("localhost", 20140)
  client:settimeout(0)
  local line, ip, port = client:receivefrom();
  print(line)
  if (port == 20140) then 
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
  end
  client:close()
end

function waitForConfirm()
  print("waiting for confirm")
  client = server:accept();
  client:settimeout(0)
  local line, err = client:receive();
  if not err then 
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

function scene:show(event)
  local sceneGroup = self.view;
  	
	gameTimer = timer.performWithDelay(100, waitForMove, -1);
end




-- local buttons = display.newGroup();

-- local sBtn = display.newRect (buttons, 30,0,35,20 );
-- sBtn:setFillColor(0,0.5,0);
-- display.newText(buttons, "Host", 30, 0,native.systemFont,15);

-- local cBtn = display.newRect (buttons, 80,0,40,20 );
-- cBtn:setFillColor(0,0.5,0);
-- display.newText(buttons, "Guest", 80,0,native.systemFont,15);

-- sBtn:addEventListener("tap", gameStart);
-- cBtn:addEventListener("tap", gameStart);



local function sendMove(event)
  
  if(not game.myMove) then 
  	return;
  end
  client = socket.udp()
  --client:setsockname("localhost", 20140)
  client:settimeout(0)
  local msg = event.x..","..event.y.."\r\n"
  print(msg)
  client:sendto(msg,"localhost", 20140 )

  print("I made my move at:", event.x, event.y);
  -- if (client == nil) then
  -- 	client = server:accept();

  -- end
  --local sent, msg =   client:send(event.x..","..event.y.."\r\n");
  client:close()
  gameTimer = timer.performWithDelay(200, waitForConfirm, 0);
end

Runtime:addEventListener("moved", sendMove);






-- local composer = require( "composer" );
-- local physics = require("physics");
-- local socket = require("socket")
-- local square = require( "square" );

-- local scene = composer.newScene();

-- function scene:create(event)
--   local sceneGroup = self.view;
--   local server = assert(socket.bind("*", 20140));
  
--   local client;  -- used to communicate via socket
--   local cube;    -- object the guest will control

 

--   local g1 = display.newGroup();  
-- 	local btnConnect = display.newRect(g1,30,0,30,10);
-- 	btnConnect:setFillColor(0.5,0.5,0);
-- 	display.newText(g1,"Wait",30,0, native.systemFont, 15 );
	  
-- local function REC (event)    
		
-- 	  msg, err = client:receive('*l'); 
-- 	    print(msg);   
-- 	  if (not err) then            
-- 	     local i = string.find(msg,":");
-- 	     local j = string.find(msg,";");
-- 	     cube.shape.x=tonumber(string.sub(msg,1,i-1));
-- 	     cube.shape.y=tonumber(string.sub(msg,i+1,j-1));                
-- 	  end
-- 	end

--     local function CON (event)	
-- 	    client = server:accept(); -- accept: BLOCKING call.
-- 	    client:settimeout(0);  -- future use of client will be
-- 	                            --   NON-Blocking from here on
-- 	    g1:removeSelf();  --remove button
-- 	    g1 = nil;
-- 	    --create the object that will mirror the guest’s object.
-- 	    cube = square:new({x=35,y=100});
-- 	    cube:spawn();
-- 	    cube.shape:setFillColor (0,1,0);


-- 	    timer.performWithDelay(10, REC, -1);
  
-- 	end
-- 	btnConnect:addEventListener("tap", CON);

	

	
-- end

-- scene:addEventListener( "create", scene );
-- function scene:destroy(event)
--   server:unbi
scene:addEventListener( "show", scene )
 return scene;
