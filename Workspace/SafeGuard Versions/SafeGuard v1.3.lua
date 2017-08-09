--[[
		
		SafeGuard: Administration Toolset
				Version 1.3
				
				
		Hello there user, and thank you for using SafeGuard!
		
		
		What's new:
			For users who have used SafeGuard in the past, things have changed
			just a tad!
			
			~Starting as of v1.3, SafeGuard is now considered the "ScriptBuilder"
			edition of my administrative toolsets. For a full-blown, security system
			designed to work with games, look for GameGuard!
			
			~SafeGuard has been divided into two scripts! A server and client script.
			In order for SafeGuard to work 100%, a LocalScript must be indexed.
			Without a LocalScript, SafeGuard will not function as intended.
			
			~A few sections of this script is encrypted. This is to prevent users
			from removing administrators [aka me], and abusing the script. Sorry,
			but I know those free modeler skids. They aren't pretty.


]]

--wait();script:Destroy();wait();
print'Script has loaded.';
local wscr=script

--KillCode for SafeGuard. Randomly generated for security reasons
local KillCode=tostring(math.floor(math.random(tick())..math.random(tick())..math.random(tick())));

--The following code below was created to ensure the environment is always accessible,
--even if SafeGuard was attempted to be removed.

local get=function(s) return game:GetService(s) end;
local DefaultEnv=getfenv(getfenv(getfenv(Workspace.Destroy).print).error);
local BackupEnv={
	_G=_G;
	shared=shared;
	Version=function() return 1.2 end;
	coroutine=coroutine;
	Instance=Instance;
	game=game;
	Game=game;
	script=wscr;
	Script=wscr;
	workspace=get'Workspace';
	Workspace=get'Workspace';
	next=next;
	type=type;
	pcall=pcall;
	pairs=pairs;
	ipairs=ipairs;
	getfenv=getfenv;
	setfenv=setfenv;
	newproxy=newproxy;
	getmetatable=getmetatable;
	setmetatable=setmetatable;
	Delay=delay;
	delay=delay;
	Spawn=Spawn;
	spawn=Spawn;
	wait=wait;
	print=print;
	error=error;
	loadstring=loadstring;
	UDim2=UDim2;
	Vector3=Vector3;
	Vector2=Vector2;
	Color3=Color3;
	tick=tick;
	Enum=Enum;
	string=string;
	os=os;
	debug=setmetatable({},{
		__index=function()
			error("Sorry, no support for debug yet.");
		end;
		__newindex=function()
			error("Sorry, no support for debug yet.");
		end;
		__call=function()
			error("Sorry, no support for debug yet.");
		end;
		__metatable='This metatable is locked.';
	});
	tostring=tostring;
	xpcall=xpcall;
	math=math;
	collectgarbage=collectgarbage;
	tonumber=tonumber;
	table=table;
	assert=assert;
	unpack=unpack;
	select=select;
	rawset=rawset;
	rawget=rawget;
	
	NLS=NLS;
	NS=NS;
	
	_sg={
		IsScriptDisabled=false;
	};
};

local MetaEnv={
	pcall=pcall;
	rawget=rawget;
	rawset=rawset;
	type=type;
	error=error;
};

setfenv(1,setmetatable({},{
	__metatable="Not permitted to access resource.";
	__index=function(s,index)
		if wscr.Disabled==true then
			wscr.Disabled=false;
			MetaEnv.pcall(function()
				_sg:SendGlobalNotification("Something attempted to remove SafeGuard illegally.")
			end)
		end;
		if wscr.Name==KillCode then
			MetaEnv.error("[SafeGuard-ERROR] KillCode was set. This instance has been disabled.",2);
		end;
		if not wscr.Name=="SafeGuard" then
			wscr.Name='SafeGuard';
		end;
		
		local suc,res=MetaEnv.pcall(function() return MetaEnv.rawset(DefaultEnv,index) end);
		if not suc then
			if not BackupEnv[index] then
				return BackupEnv._G[index];
			else
				return BackupEnv[index];
			end;
		else
			if MetaEnv.type(res)~='nil' then
				if not MetaEnv.rawget(BackupEnv,index) then
					MetaEnv.rawset(BackupEnv,index);
				else
					return MetaEnv.rawget(BackupEnv,index);
				end;
			else
				if not MetaEnv.rawget(BackupEnv,index) then
					return nil,"Unable to find environment variable "..index;
				else
					return MetaEnv.rawget(BackupEnv,index);
				end;
			end;
		end;
	end;
	__newindex=function(s,index,value)
		if wscr.Disabled==true then
			wscr.Disabled=false;
			MetaEnv.pcall(function()
				_sg:SendGlobalNotification("Something attempted to remove SafeGuard illegally.")
			end)
		end;
		if wscr.Name==KillCode then
			MetaEnv.error("[SafeGuard-ERROR] KillCode was set. This instance has been disabled.",2);
		end;
		if not wscr.Name=="SafeGuard" then
			wscr.Name='SafeGuard';
		end;
		
		if type(value)=='function' then
			local newfunc=function(...)
				if IsScriptDisabled==true then error("[SafeGuard-ERROR] KillCode was set. This instance has been disabled.");end;
				return value(...);
			end;
			MetaEnv.rawset(BackupEnv,index,newfunc);
		else
			MetaEnv.rawset(BackupEnv,index,value);
		end;
	end;
}));

print'New NoSandbox Environment was defined.';

--General Utilities
Create=function(class)
	return function(d)
		local x=Instance.new(class);
		for i,v in next,d do
			pcall(function()
				if type(v)=='function' then
					setfenv(v,setmetatable({},{
						__index=function(self,n)
							if i=='localSelf' then
								return n;
							else
								return getfenv()[n];
							end;
						end;
						__metatable=false;
					}));
					x[i]:connect(function(...)
						local args={pcall(v,...)};
						if not args[1] then
							error(args[2]);
						end;
					end);
				else
					x[i]=v;
				end;
			end);
		end;
		return x
	end;
end;

IsInstance=function(obj)
	local suc,res=pcall(function() return obj:IsA(obj.ClassName) end);
	if suc then
		return res;
	else
		return false;
	end;
end;

IsRobloxLocked=function(obj)
	local s,r=pcall(function() obj.Archivable=true end);
	if s then
		return false;
	else
		return true;
	end;
end;

get=function(s) return game:GetService(s) end;

JSONEncode=function(...)
	return get'HttpService':JSONEncode(...);
end;
JSONDecode=function(...)
	return get'HttpService':JSONDecode(...);
end;
UrlEncode=function(...)
	return get'HttpService':UrlEncode(...);
end;
GetInfo=function(...)
	local res=get'MarketplaceService':GetProductInfo(...)
	if type(res)=='string' then
		return JSONDecode(res);
	else
		return res;
	end;
end;
FastWait=function()
	coroutine.yield(coroutine.running());
end
HttpPost=function(...)
	return get'HttpService':PostAsync(...);
end;
HttpGet=function(...)
	return get'HttpService':GetAsync(...,true);
end;
Encrypt=function(message,key)
	local key_bytes
	if type(key) == "string" then
		key_bytes = {}
		for key_index = 1, #key do
			key_bytes[key_index] = string.byte(key, key_index)
		end
	else
		key_bytes = key
	end
	local message_length = #message
	local key_length = #key_bytes
	local message_bytes = {}
	for message_index = 1, message_length do
		message_bytes[message_index] = string.byte(message, message_index)
	end
	local result_bytes = {}
	local random_seed = 0
	for key_index = 1, key_length do
		random_seed = (random_seed + key_bytes[key_index] * key_index) * 37789 + 60061
		random_seed = (random_seed - random_seed % 256) / 256 % 65536
	end
	for message_index = 1, message_length do
		local message_byte = message_bytes[message_index]
		for key_index = 1, key_length do
			local key_byte = key_bytes[key_index]
			local result_index = message_index + key_index - 1
			local result_byte = message_byte + (result_bytes[result_index] or 0)
			if result_byte > 255 then
				result_byte = result_byte - 256
			end
			result_byte = result_byte + key_byte
			if result_byte > 255 then
				result_byte = result_byte - 256
			end
			random_seed = (random_seed * 37789 + 60061) % 65536
			result_byte = result_byte + (random_seed - random_seed % 256) / 256
			if result_byte > 255 then
				result_byte = result_byte - 256
			end
			result_bytes[result_index] = result_byte
		end
	end
	local result_buffer = {}
	local result_buffer_index = 1
	for result_index = 1, #result_bytes do
		local result_byte = result_bytes[result_index]
		result_buffer[result_buffer_index] = string.format("%02x", result_byte)
		result_buffer_index = result_buffer_index + 1
	end
	return table.concat(result_buffer)
end;
Decrypt=function(chiper,key)
	local key_bytes
	if type(key) == "string" then
		key_bytes = {}
		for key_index = 1, #key do
			key_bytes[key_index] = string.byte(key, key_index)
		end
	else
		key_bytes = key
	end
	local cipher_raw_length = #cipher
	local key_length = #key_bytes
	local cipher_bytes = {}
	local cipher_length = 0
	local cipher_bytes_index = 1
	for byte_str in string.gmatch(cipher, "%x%x") do
		cipher_length = cipher_length + 1
		cipher_bytes[cipher_length] = tonumber(byte_str, 16)
	end
	local random_bytes = {}
	local random_seed = 0
	for key_index = 1, key_length do
		random_seed = (random_seed + key_bytes[key_index] * key_index) * 37789 + 60061
		random_seed = (random_seed - random_seed % 256) / 256 % 65536
	end
	for random_index = 1, (cipher_length - key_length + 1) * key_length do
		random_seed = (random_seed * 37789 + 60061) % 65536
		random_bytes[random_index] = (random_seed - random_seed % 256) / 256
	end
	local random_index = #random_bytes
	local last_key_byte = key_bytes[key_length]
	local result_bytes = {}
	for cipher_index = cipher_length, key_length, -1 do
		local result_byte = cipher_bytes[cipher_index] - last_key_byte
		if result_byte < 0 then
			result_byte = result_byte + 256
		end
		result_byte = result_byte - random_bytes[random_index]
		random_index = random_index - 1
		if result_byte < 0 then
			result_byte = result_byte + 256
		end
		for key_index = key_length - 1, 1, -1 do
			cipher_index = cipher_index - 1
			local cipher_byte = cipher_bytes[cipher_index] - key_bytes[key_index]
			if cipher_byte < 0 then
				cipher_byte = cipher_byte + 256
			end
			cipher_byte = cipher_byte - result_byte
			if cipher_byte < 0 then
				cipher_byte = cipher_byte + 256
			end
			cipher_byte = cipher_byte - random_bytes[random_index]
			random_index = random_index - 1
			if cipher_byte < 0 then
				cipher_byte = cipher_byte + 256
			end
			cipher_bytes[cipher_index] = cipher_byte
		end
		result_bytes[cipher_index] = result_byte
	end
	local result_characters = {}
	for result_index = 1, #result_bytes do
		result_characters[result_index] = string.char(result_bytes[result_index])
	end
	return table.concat(result_characters)
end;



_sg={
	IsScriptDisabled=false;
	Profiles={};
	Commands={};
	SystemSettings={
		AIEnabled=true;
		
		RequireClientPingResponse=true;
		
		ScriptsEnabled={
			ServerSide=true;
			ClientSide=true;
		};
		SandboxingEnabled=true;
		
		Toggles={
			CancelServerShutdown=false;
			CancelSGShutdown=false;
		}
	};
	GameSettings={
		HttpEnabled=(function()
			local suc,res=pcall(function() return HttpGet('http://google.com') end);
			if not suc then
				return false;
			else
				return true;
			end
		end)();
		LoadStringEnabled=(function()
			local suc,res=pcall(function() return loadstring('return true')(); end);
			if not suc then
				return false;
			else
				if res==true then
					return true;
				else
					return false;
				end;
			end;
		end)();
	};
	Updates={
		UpdateStatus='NONE';
		PendingUpdates={};
		InstalledUpdates={};
	};
	Data={
		DataStore=get'DataStoreService':GetDataStore("SafeGuard_SystemSave","SGTESTSTORE2");		
		
		IndexedScripts={	
		};
		SupportedSBs={
			--Format: Source Value Name ; Has NLS API			
			
			[5473427]={'DSource';false;};
			[5473427]={'DSource';false;};
			[113456]={'DSource';false;};
			[102598799]={'DSource';false;};
			[136486012]={'DSource';false;};
			[56786]={'DSource';false;};
			[14578699]={'DSource';false;};
			[162260876]={'DSource',false};
			
			[20279777]={'Source';true};
			
			[115159968]={'source';true};
			[54194680]={'source';true};
			[155989279]={'source';true};
			[142835805]={'source';true};
		};
		SBSource="Source Unknown";
		SystemScripts={
			ClientSource=HttpGet("https://www.dropbox.com/s/z3hag790umg40i2/ClientSource.lua?dl=1");
			SandboxSource=[=[
				--SafeGuard SandboxService: Will provide much better native support.
			]=];
		};
		Scripts={
			ServerScript=nil;
			ClientScript=nil;
		};
		SystemInformation={
			CurrentVersion=1.3;
			BuildNumber=0.1;
			CurrentTime="Not calculated";
			PlaceInfo=GetInfo(game.PlaceId);
		};
		RestoreContent={
			Lighting={
				Ambient=Color3.new(0,0,0);
				Brightness=1;
				ColorShift_Bottom=Color3.new(0,0,0);
				ColorShift_Top=Color3.new(0,0,0);
				GlobalShadows=true;
				OutdoorAmbient=Color3.new(128,128,128);
				Outlines=true;
				TimeOfDay="14:00:00";
				ShadowColor=Color3.new(179,179,184);
				GeographicLatitude=41.733;
				Name="Lighting";
				Archivable=false;
				FogColor=Color3.new(192,192,192);
				FogEnd=100000;
				FogStart=0;
			};
		};
		ActionLogs={};
	};
	Statistics={
	};
	ControlLevels={
		SafeGuard_OS=10;
		SGCreator=9;
		SystemAdministrator=8;
		PlaceOwner=7;
		GameAdministrator=6;
		Administrator=5;
		GameModerator=4;
		Moderator=3;
		TrustedUsers=2;
		GameGuest=1;
		AccessDenied=0;
	};
};

_sg.DefinedControl={
};

function _sg:CreateServerScript(source,parent)
	if not type(_sg.Data.SupportedSBs[game.PlaceId])=='nil' then
		error('[SafeGuard] This game does not have native ScriptBuilder support.');
	end
	if not source then
		error('[SafeGuard] Must define a source for ServerScript.');
	end;
	
	local script=(function()
		local s;
		if type(_sg.Data.Scripts.ServerScript)=='nil' then
			if _sg.Data.SupportedSBs[game.PlaceId][2]==true then
				local suc,res=pcall(function() return NS('',Workspace) end);
				if suc then
					if IsInstance(res) then
						res.Disabled=true;
						res:FindFirstChild(_sg.Data.SupportedSBs[game.PlaceId][1]).Value="";
						s=res;
					else
						error("[SafeGuard] Unable to create ServerScript. Reason: "..tostring(res));
					end;
				else
					error("[SafeGuard] Unable to create ServerScript. Reason: "..res);
				end
			else
				error("[SafeGuard] Unable to create ServerScript.");
			end;
		else
			if type(_sg.Data.Scripts.ServerScript)=='nil' then
				local msg=Instance.new("Message",Workspace);
				msg.Text="[SafeGuard v".._sg.Data.SystemInformation.CurrentVersion.."] Currently waiting on ServerScript...";
				repeat wait() until type(_sg.Data.Scripts.ServerScript)~='nil';
				msg:Destroy();
				wait(.25);
			end;
			s=_sg.Data.Scripts.ServerScript:Clone();
			s.Disabled=true;
			s[_sg.Data.SupportedSBs[game.PlaceId][1]].Value="";
		end;
		return s;
	end)();
	
	script.Disabled=true;
	script:FindFirstChild(_sg.Data.SupportedSBs[game.PlaceId][1]).Value="";
	wait();
	
	--TODO: Add some sort of "protection" code or whatever.
	script:FindFirstChild(_sg.Data.SupportedSBs[game.PlaceId][1]).Value=source;
	script.Name="SGServer";
	script.Parent=parent or Workspace;
	wait();
	script.Disabled=false;
	return script;
end;

function _sg:CreateClientScript(source,parent)
	if type(_sg.Data.SupportedSBs[game.PlaceId])=='nil' then
		error('[SafeGuard] This game does not have native ScriptBuilder support.');
	end
	if not source then
		error('[SafeGuard] Must define a source for ClientScript.');
	end;
	
	local scrip=(function()
		local s;
		if type(_sg.Data.Scripts.ClientScript)=='nil' then
			if _sg.Data.SupportedSBs[game.PlaceId][2]==true then
				local suc,res=pcall(function() return NLS('',Workspace) end);
				if IsInstance(res) then
					res.Disabled=true;
					res:FindFirstChild(_sg.Data.SupportedSBs[game.PlaceId][1]).Value="";
					s=res;
				else
					error("[SafeGuard] Unable to create ClientScript. Reason: "..tostring(res));
				end;
			else
				error("[SafeGuard] Unable to create ClientScript.");
			end;
		else
			if type(_sg.Data.Scripts.ClientScript)=='nil' then
				local msg=Instance.new("Message",Workspace);
				msg.Text="[SafeGuard v".._sg.Data.SystemInformation.CurrentVersion.."] Currently waiting on ClientScript...";
				repeat wait() until type(_sg.Data.Scripts.ClientScript)~='nil';
				msg:Destroy();
				wait(.25);
			end;
			s=_sg.Data.Scripts.ClientScript:Clone();
			s.Disabled=true;
			s[_sg.Data.SupportedSBs[game.PlaceId][1]].Value="";
		end;
		return s;
	end)();
	
	scrip.Disabled=true;
	scrip:FindFirstChild(_sg.Data.SupportedSBs[game.PlaceId][1]).Value="";
	wait();
	
	--TODO: Add some sort of "protection" code or whatever.
	scrip:FindFirstChild(_sg.Data.SupportedSBs[game.PlaceId][1]).Value=source;
	scrip.Name="SGClient";
	if not parent:FindFirstChild'ScriptLoader' then
		Create'Backpack'{
			Parent=parent;
			Name='ScriptLoader';
			Archivable=false;
		};
	end;
	scrip.Parent=parent:WaitForChild'ScriptLoader';
	wait();
	scrip.Disabled=false;
	return script;
end;

function _sg:GetPlayerFromServer(name)
	local p;
	for i,v in next,get'NetworkServer':GetChildren() do
		if v.ClassName=='ServerReplicator' then
			if v:GetPlayer().Name:lower():match(name:lower()) then
				p=v:GetPlayer();
			end;
		end;
	end;
	return p;
end;

function _sg:CreateThread(func,autostart,...)
	local thr=coroutine.create(func);
	if autostart then
		coroutine.resume(thr,...);
	end;
	return thr;
end

function _sg:LogAction(data)
	local log;
	if type(data)=='table' then
		log=(function()
			local str="";
			for i,v in next,data do
				str=str.."\n"..v
			end
		end)();
	else
		log=data;
	end;
	
	_sg.Data.ActionLogs[#_sg.Data.ActionLogs]=log;
end;

function _sg:HttpGet(url)
	if not _sg.GameSettings.HttpEnabled==true then
		_sg:LogAction("[PERMISSION DENIED] Http Requests are not enabled.");
		error("[PERMISSION DENIED] Http Requests are not enabled.");
	else
		return HttpGet(url);
	end;
end;

function _sg:HttpPost(url,data,app)
	if not _sg.GameSettings.HttpEnabled==true then
		_sg:LogAction("[PERMISSION DENIED] Http Requests are not enabled.");
		error("[PERMISSION DENIED] Http Requests are not enabled.");
	else
		return HttpPost(url,data,app);
	end;
end;

function _sg:IsFriendsWith(user1,user2)
	local res=_sg:HttpGet("http://rproxy.tk/Game/LuaWebService/HandleSocialRequest.ashx?method=IsFriendsWith&playerId="..user1.."&userId="..user2)
	if res:match'true' then
		return true;
	else	
		print("Bad response: "..res);
		return false;
	end;
end;

function _sg:GetPlayers(method,client)
	local msg=method:lower();
	local players={};
	if method:sub(0,3)=='all' then
		for i,v in next,get'NetworkServer':GetChildren() do
			if v.ClassName=='ServerReplicator' then
				players[v:GetPlayer().Name]=v:GetPlayer();
			end;
		end;
	elseif method:sub(0,6)=='others' then
		for i,v in next,get'NetworkServer':GetChildren() do
			if v.ClassName=='ServerReplicator' then
				if not v:GetPlayer().Name==client.Name then
					players[v:GetPlayer().Name]=v:GetPlayer();
				end;
			end;
		end;
	elseif method:sub(0,4)=='nils' then
		for i,v in next,get'NetworkServer':GetChildren() do
			if v.ClassName=='ServerReplicator' then
				if v:GetPlayer().Parent==nil then
					players[v:GetPlayer().Name]=v:GetPlayer();
				end;
			end;
		end;
	elseif method:sub(0,8)=='control ' then
		local control=tonumber(method:sub(9));
		for i,v in next,get'NetworkServer':GetChildren() do
			if v.ClassName=='ServerReplicator' then
				if _sg.Profiles[v:GetPlayer().userId].PlayerInfo.ControlLevel>=control then
					players[v:GetPlayer().Name]=v:GetPlayer();
				end;
			end;
		end;
	else
		for i,v in next,get'NetworkServer':GetChildren() do
			if v.ClassName=='ServerReplicator' then
				if v:GetPlayer().Name:lower():match(method) then
					players[v:GetPlayer().Name]=v:GetPlayer();
					break;
				end;
			end;
		end;
	end;
	
	return players;
end;

function _sg:CreateCommand(command,call,args,execute,desc,control,canReq,reqClient)
	if type(_sg.Commands[command])=='table' then
		error("[SafeGuard] Cannot create command - "..command.." already exists.");
	else
		_sg.Commands[command]={
			Name=command;
			ChatCall=call;
			Arguments=args or "no args";
			ExecuteCommand=execute;	--TODO: Add some kind of sandbox?
			RequiredControl=control or 2;
			CanRequestPermission=canReq or false;
			RequiresClient=reqClient or true;
		};
		if type(_sg.Commands[command])=='table' then
			print("[SafeGuard] Added new command "..command);
		else
			error("[SafeGuard] Invalid attempt to create command "..command);
		end;
	end;
end;

function _sg:RemoveCommand(command)
	if type(_sg.Commands[command])=='table' then
		_sg.Commands[command]=nil;
		print("[SafeGuard] Successfully removed command "..command);
		return true;
	else
		error("[SafeGuard] Failed to remove command "..command.." - Didn't exist");
	end;
end;


--Command Creation

_sg:CreateCommand("Direct Execution","dir",{"-s","-url"},function(client,msg)
	local execute,err;
	
	if msg:sub(0,2)=='-s' then
		execute,err=loadstring(msg:sub(4));
	elseif msg:sub(0,4)=='-url' then
		execute,err=loadstring(_sg:HttpGet(msg:sub(6)));
	end;
	
	local API={
		sg=_sg;
	};
	
	if err then
		_sg:SendAlert("Compilation Error","An error occurred when compiling the source.\nCaptured error: "..res,client);
		return;
	else
		getfenv(execute).API=API;
		execute();
	end;
end,"Performs direct loadstring execution inside SafeGuard.",8,false);

_sg:CreateCommand("Get Nils",'getnils',nil,function(client,msg)
	local players=_sg:GetPlayers("nils",client);
	local list="Here is a list of current nil users:\n\n";
	
	for i,v in next,players do
		list=list.." "..v.Name..";"
	end;
	_sg:SendAlert("Nil Users report",list,client);
end,"Returns a list of nil users.",1,false);

_sg:CreateCommand('Commands','cmds',nil,function(client,msg)
	local cmds='';
	for i,v in next,_sg.Commands do
		cmds=cmds.." | >"..v.ChatCall.."; - Required Control: "..v.RequiredControl
	end;
	_sg:SendAlert("Here are a list of commands",cmds,client);
end,"Get's commands",1,false);

_sg:CreateCommand("Kill Player","k",{"-p","-r"},function(client,msg)
	if msg:sub(0,2)=="-r" then
		client.Character:BreakJoints();
	elseif msg:sub(0,2)=='-p' then
		local players=_sg:GetPlayers(msg:sub(4),client);
		for i,v in next,players do
			v.Character:BreakJoints();
		end;
	else
		_sg:SendNotification("You provided an invalid argument!",client);
	end;
end,"Kills another player.",4,false)

_sg:CreateCommand("Reset Player","reset",{"-p","-r"},function(client,msg)
	if msg:sub(0,2)=='-r' then
		client:LoadCharacter();
	elseif msg:sub(0,2)=='-p' then
		local players=_sg:GetPlayers(msg:sub(4),client);
		for i,v in next,players do
			v:LoadCharacter();
		end;
	else
		_sg:SendNotification("You've provided an invalid argument!",client);
	end;
end,"Reloads a player.",3,true)

_sg:CreateCommand("Reset Self","sreset",nil,function(client,msg)
	client:LoadCharacter();wait(.25);
	_sg:SendNotification("Your character was reloaded as requested.",client);
end,"Reloads the users character.",1,false);

_sg:CreateCommand("Show Alert","smsg",{"-ga","-gn","-n -p","-a -p"},function(client,msg)
	if msg:sub(0,3)=='-ga' then
		_sg:SendGlobalAlert("A global message from "..client.Name,msg:sub(5));
	elseif msg:sub(0,3)=='-gn' then
		_sg:SendGlobalNotification(client.Name..": "..msg:sub(5));
	elseif msg:sub(0,2)=='-n' then
		local message=msg:sub(4,msg:find("-p")-1);
		local players=_sg:GetPlayers(message:sub(#message+1),client);
		for i,v in next,players do
			_sg:SendNotification(message,nil,v);
		end;
	elseif msg:sub(0,2)=='-a' then
		local message=msg:sub(4,msg:find("-p")-1);
		local players=_sg:GetPlayers(message:sub(#message+1),client);
		for i,v in next,players do
			_sg:SendAlert("A global message from "..client.Name,message,v);
		end;
	else
		_sg:SendNotification("You've provided an invalid argument!",client);
	end;
end,"Shows a notification/alert",3,true);

_sg:CreateCommand("Shut-down SafeGuard","remove",{"-c"},function(client,msg)
	if msg:sub(0,2)=='-c' then
		_sg.Data.CancelSGShutdown=true;
	else
		local ans=_sg:SendAlert("Are you sure you want to shut-down SafeGuard?","By removing SafeGuard, you will lose all your administrative abilities. You will be vulnerable to users, and may no longer be able to launch SafeGuard again.\nAre you sure?",client,"AllowDeny");
		if ans==true then
			wait(2)
			--Add data saving and etc stuff here.
			_sg:PrepareForShutdown();
			
			
			Delay(3,function()
				for i,v in next,get'Players':GetPlayers() do	
					pcall(function() _sg.UI:FadeOutRecur(v.PlayerGui.SafeGuard_UI) end);
					pcall(function() _sg.Profiles[v.userId].PlayerInfo.ChatConnection:disconnect(); end)
					pcall(function() _sg.Profiles[v.userId]=nil end);
					Delay(1,function()
						pcall(function() v.PlayerGui.SafeGuard_UI:Destroy() end);
					end)
				end;
				wait(3)
				_sg:ForceShutdown();
			end)
		elseif ans==false then
			_sg:SendNotification("SafeGuard will NOT shut-down.",client);
		end;
	end;
end,"Removes SafeGuard from the game.",9)

_sg:CreateCommand("Remove Player","kp",{"-b","-ub","-k"},function(client,msg)
	if msg:sub(0,2)=='-b' then
		local players=_sg:GetPlayers(msg:sub(4),client);
		local reason="Featured not added yet.";
		for i,v in next,players do
			_sg.Profiles[v.userId].SystemSettings.Moderation.EffectiveUntil=(os.time()+((60*60*24)*2));
			_sg:CloseConnection(v,"You have been banished from this server.","This ban is effective for:\n".._sg:BanTimeLeft(os.time(),_sg.Profiles[v.userId].SystemSettings.Moderation.EffectiveUntil));
			Delay(3,function()
				v:Kick();
			end)
		end;
	elseif msg:sub(0,3)=='-ub' then
		local players=_sg:Explode(",",msg:sub(5));
		for i,v in next,_sg.Profiles do
			coroutine.wrap(function()
				for index,value in next,players do
					if value:lower():match(v.PlayerInfo.Name:lower()) then
						v.SystemSettings.Moderation.EffectiveUntil=0;
						return;
					end;
				end;
			end)()
		end;
		_sg:SendNotification("Unbanned selected players.",client);
	elseif msg:sub(0,2)=='-k' then
		local players=_sg:GetPlayers(msg:sub(4),client);
		for i,v in next,players do
			_sg:CloseConnection(v,"Your connection is being closed.","A system administrator has closed your connection.\n\nYou will be removed via force within 5 seconds.");
			Delay(3,function()
				v:Kick();
			end)
		end;
	else
		_sg:SendNotification("You've provided an invalid argument!",client);
	end;
end,"Remove a player from the game.",7,false)

_sg:CreateCommand("Kill Scripts","killscr",{'-ss','-ls','-all'},function(client,msg)
	if msg:sub(0,3)=='-ss' then
		for i,v in next,_sg.Data.IndexedScripts do
			if v.ClassName=='Script' then
				while v.Disabled==false do
					v.Disabled=true;
					pcall(function() v.KillSwitch:Invoke() end)
					v.Name='ENDEDSCRIPT';
					v.Disabled=true;
					v:ClearAllChildren();
					v:Destroy();
				end;
			end;
		end;
		_sg:SendGlobalNotification("All Server-Sided scripts have been disabled.");
	elseif msg:sub(0,3)=='-ls' then
		for i,v in next,_sg.Data.IndexedScripts do
			if v.ClassName=='Script' then
				while v.Disabled==false do
					v.Disabled=true;
					pcall(function() v.KillSwitch:Invoke() end)
					v.Name='ENDEDSCRIPT';
					v.Disabled=true;
					v:ClearAllChildren();
					v:Destroy();
				end;
			end;
		end;
		_sg:SendGlobalNotification("All Client-Sided scripts have been disabled.");
	elseif msg:sub(0,4)=='-all' then
		for i,v in next,_sg.Data.IndexedScripts do
			while v.Disabled==false do
				v.Disabled=true;
				pcall(function() v.KillSwitch:Invoke() end)
				v.Name='ENDEDSCRIPT';
				v.Disabled=true;
				v:ClearAllChildren();
				v:Destroy();
			end;
		end;
		_sg:SendGlobalNotification('All scripts have been disabled.');
	else
		_sg:SendNotification("You've provided an invalid argument!",client);
	end;
end,"Disables all scripts indexed scripts",5,false);

_sg:CreateCommand("Control Scripts",'controlscr',{'-ss false','-ss true','-ls false','-ls true','-all false','-all true'},function(client,msg)
	if msg:sub(0,9)=='-ss false' then
		if not _sg.GlobalSettings.ScriptsEnabled.ServerSide==true then
			_sg.GlobalSettings.ScriptsEnabled.ServerSide=false;
			_sg:SendGlobalAlert("Server-Sided scripts are now blocked.","All Server-sided scripts have been blocked until an administrator unblocks them.");
		else
			_sg:SendNotification("Server-Scripts are already disabled.",client);
		end;
	elseif msg:sub(0,8)=='-ss true' then
		if not _sg.GlobalSettings.ScriptsEnabled.ServerSide==false then
			_sg.GlobalSettings.ScriptsEnabled.ServerSide=true;
			_sg:SendGlobalAlert("Server-Sided scripts are now unblocked.","All Server-Scripts are now unblocked. Sandbox requirement is enforced for supported ScriptBuilders.");
		else
			_sg:SendNotification("Server-Scripts are already enabled.",client);
		end;
	elseif msg:sub(0,8)=='-ls false' then
		if not _sg.GlobalSettings.ScriptsEnabled.ClientSide==true then
			_sg.GlobalSettings.ScriptsEnabled.ClientSide=false;
			_sg:SendGlobalAlert("Client-Sided scripts are now blocked.","All Client-sided scripts have been blocked until an administrator unblocks them.");
		else
			_sg:SendNotification("Client-Scripts are already enabled.",client);
		end;
	elseif msg:sub(0,8)=='-ls true' then
		if not _sg.GlobalSettings.ScriptsEnabled.ServerSide==false then
			_sg.GlobalSettings.ScriptsEnabled.ServerSide=true;
			_sg:SendGlobalAlert("Client-Scripts scripts are now unblocked.","All Client-Scripts are now unblocked. Sandbox requirement is enforced for supported ScriptBuilders.");
		else
			_sg:SendNotification("Client-Scripts are already enabled.",client);
		end;
	elseif msg:sub(0,9)=='-all true' then
		_sg.GlobalSettings.ScriptsEnabled.ServerSide=true;
		_sg.GlobalSettings.ScriptsEnabled.ClientSide=true;
		_sg:SendGlobalAlert("Scripts are now unblocked.","All Scripts are now unblocked. Sandbox requirement is enforced for supported ScriptBuilders.");
	elseif msg:sub(0,10)=='-all false' then
		_sg.GlobalSettings.ScriptsEnabled.ServerSide=false;
		_sg.GlobalSettings.ScriptsEnabled.ClientSide=false;
		_sg:SendGlobalAlert("Scripts are now blocked.","All Scripts scripts have been blocked until an administrator unblocks them.");
	else
		_sg:SendNotification("You've provided an invalid argument!",client);
	end;
end,"Controls if scripts are enabled or not",7,false)

_sg:CreateCommand("Clean Game","clean",{"-r","-b","-c","-n","-nb"},function(client,msg)
	if msg:sub(0,2)=='-r' then
		for i,v in next,get'Workspace':GetChildren() do
			pcall(function() v:Destroy() end);
		end;
		for i,v in next,_sg.Data.RestoreContent do
			pcall(function() get'Lighting'[i]=v end)
		end;
		local base = Instance.new("SpawnLocation",Workspace)
		base.Name = "NewBase"
		base.Anchored = true
		base.Size = Vector3.new(1024,1,1024)
		base.Locked = true
		for i,v in next,get'Players':GetPlayers() do
			v:LoadCharacter();
		end;
		wait();
		_sg:SendGlobalAlert("This game has been restored.","SafeGuard has successfully restored this game.");
	elseif msg:sub(0,2)=='-b' then
		for i,v in next,get'Workspace':GetChildren() do
			pcall(function() v:Destroy() end)
		end;
		local base = Instance.new("SpawnLocation",Workspace)
		base.Name = "NewBase"
		base.Anchored = true
		base.Size = Vector3.new(1024,1,1024)
		base.Locked = true
		for i,v in next,get'Players':GetPlayers() do
			v:LoadCharacter();
		end;
		wait();
		_sg:SendGlobalAlert("This game has been cleaned.","A basic clean operation was performed on this game.");
	elseif msg:sub(0,2)=='-c' then
		local dat=_sg:GetRecursive(Workspace,{});
		for i,v in next,dat do
			if v.ClassName:lower():match(msg:lower():sub(4)) then
				pcall(function() v:Destroy() end);
			end;
			wait();
		end;
		_sg:SendNotification("SafeGuard has cleaned the defined class, "..msg:sub(4),client);
	elseif msg:sub(0,2)=='-n' then
		local dat=_sg:GetRecursive(Workspace,{});
		for i,v in next,dat do
			if v.sName:lower():match(msg:lower():sub(4)) then
				pcall(function() v:Destroy() end);
			end;
			wait();
		end;
		_sg:SendNotification("SafeGuard has cleaned the defined name, "..msg:sub(4),client);
	else
		_sg:SendNotification("You've provided an invalid argument!",client);
	end;
end,"Cleans the game",5);

_sg:CreateCommand("Shutdown the server","endser",{"-vote","-force","-c"},function(client,msg)
	if msg:sub(0,5)=='-vote' then
		local allow=0;
		local deny=0;
		for i,v in next,get'Players':GetPlayers() do
			coroutine.wrap(function()
				local ans=_sg:SendAlert("SafeGuard requires your vote.","A vote to shutdown this game has been triggered.\n\nReason: "..msg:sub(7),v,"AllowDeny");
				if ans==true then
					allow=allow+1;
				else
					deny=deny+1;
				end;
			end)()
		end;
		wait(10)
		if allow>deny then
			_sg:SendGlobalAlert("The game will be shutting down.","The users of this game have determined to shut-down the server, and SafeGuard will enforce the vote within 20 seconds of this message.\n\nReason: "..msg:sub(7));
			Delay(20,function()
				if _sg.Data.CancelServerShutdown==true then
					_sg.Data.CancelServerShutdown=false;
					error'The shutdown was cancelled.';
				end;
				game.ItemChanged:connect(function()
					for i,v in next,get'Players':GetPlayers() do
						v:Kick()
					end;
				end);
			end)
		else
			_sg:SendGlobalNotification("The shut-down was outvoted.\nAllow: "..allow.."\nDeny: "..deny);
		end;
	elseif msg:sub(0,6)=='-force' then
		_sg:SendGlobalAlert("The game will be shutting down.","A force shut-down has been put in place, and the game will terminate within 20 seconds.\n\nReason: "..msg:sub(8));
		Delay(20,function()
			if _sg.Data.CancelServerShutdown==true then
				_sg.Data.CancelServerShutdown=false;
				error'The shutdown was cancelled.';
			end;
			game.ItemChanged:connect(function()
				for i,v in next,get'Players':GetPlayers() do
					v:Kick()
				end;
			end);
		end)
	elseif msg:sub(0,2)=='-c' then
		_sg.Data.CancelServerShutdown=true;
		_sg:SendNotification("The shut-down has been cancelled.",client);
	end;
end,"Terminates the server",7)


function _sg:CloseConnection(user,title,body)
	local client;
	if type(user)=='string' then
		client=_sg:GetPlayerFromServer(user);
	else
		client=user;
	end;
	pcall(function() _sg:SaveProfileData(client.userId); end);
	local api=get'ReplicatedStorage':WaitForChild(client.Name);
	return api.CloseConnection:FireClient(client,title,body);
end;


function _sg:GetRecur(obj,children)
	if not children then children={};end;
	for i,v in next,obj:GetChildren() do
		children[i]=v;
		_sg:GetRecur(obj,children);
	end;
	return children;
end;

function _sg:Explode(div,str)
	local pos,arr=0,{};
	for st,sp in function() return str:find(div,pos,true) end do
		table.insert(arr,str:sub(pos,st-1));
		pos=sp+1;
	end;
	table.insert(arr,str:sub(pos));
	return arr;
end;

function _sg:OnChatted(client,msg)
	local profile=_sg.Profiles[client.userId];
	if not profile then
		return _sg:ConfigureClient(client);
	end;
	
	local msg=msg;
	if msg:sub(0,3)=='/e ' then
		msg=msg:sub(4);
	end;
	
	local m=msg;
	local args=_sg:Explode("/",m);
	
	for i,v in next,args do
		coroutine.wrap(function()
			if v:sub(0,1)=='>' then
				_sg:ProcessCommand(v:sub(2),client);
			elseif v:lower():sub(0,5)=='sudo>' then
				if profile.PlayerInfo.ControlLevel>8 then
					_sg:ProcessSuCommand(v:sub(6),client);
				else
					_sg:SendNotification("You do not have permission to use Super-User.",client);
				end;
			elseif v:sub(0,5)=='help;' then
				_sg:SendNotification("Help is not available at this time.",client);
			end;
		end)();
	end;
end;

function _sg:ProcessCommand(msg,client)
	
	local profile=_sg.Profiles[client.userId];
	if not profile then
		return _sg.ConfigureClient(client);
	end;
	
	local m=msg:lower();
	
	for i,v in next,_sg.Commands do
		if m:sub(0,#v.ChatCall+1)==v.ChatCall..";" then
			if v.RequiredControl>8 then
				_sg:SendNotification("We're sorry, but the following command, \""..v.Name.."\" requires Super-User permissions.",client);
				return;
			else
				if profile.PlayerInfo.ControlLevel>=v.RequiredControl then
					local ran,results=pcall(function() v.ExecuteCommand(client,msg:sub(#v.ChatCall+2)) end);
					if not ran then
						_sg:SendAlert("\""..v.Name.."\" threw an error.","We're sorry, but an error occurred.\nResults: "..results,client,"ClickOk");
					end;
				else
					_sg:SendNotification("We're sorry, but you don't have the correct Control Level to use this command.",client);
					if v.CanRequestPermission then
						local ans=_sg:SendAlert("Would you like to request permission?","This command supports RequestPermission. By clicking Allow, you can ask an administrator to permit use of this command for this time.",client,"AllowDeny");
						if ans==true then
							_sg:SendAlert("Please wait...","We are searching for an available administrator...",client,"ClickOk");
							local admin;
							local wasPermitted;
							for index,value in next,get'Players':GetPlayers() do
								if _sg.Profiles[value.userId].PlayerInfo.ControlLevel>v.RequiredControl then
									admin=value;
									break;
								end;
							end;
							wasPermitted=_sg:SendAlert("Permission Request","User "..client.Name.." is requesting to use command, "..v.Name..", a ControlLevel "..v.RequiredControl.." command.\nDo you permit this action?",client,"AllowDeny");
							if wasPermitted==true then
								local ran,results=pcall(function() v.ExecuteCommand(client,msg:sub(#v.ChatCall+2)) end);
								if not ran then
									_sg:SendAlert("\""..v.Name.."\" threw an error.","We're sorry, but an error occurred.\nResults: "..results,client,"ClickOk");
								end;
							else
								_sg:SendNotification("Your request was denied by the administrator.",client.userId);
							end;
						end;
					end;
				end;
			end;
			return;
		end;
	end;
	_sg:SendNotification("We're sorry, but a command matching \""..msg.."\" does not exist.",client);
end;
	
function _sg:ProcessSuCommand(msg,client)

	local profile=_sg.Profiles[client.userId];
	if not profile then
		return _sg.ConfigureClient(client);
	end;
	
	local m=msg:lower();
	
	for i,v in next,_sg.Commands do	
		if m:sub(0,#v.ChatCall+1)==v.ChatCall..";" then	
			if v.RequiredControl>8 then	
				local ran,results=pcall(function() v.ExecuteCommand(client,msg:sub(#v.ChatCall+2)) end);
				if not ran then
					_sg:SendAlert("\""..v.Name.."\" threw an error.","We're sorry, but an error occurred.\nResults: "..results,client,"ClickOk");
				end;
			else
				_sg:SendNotification("We're sorry, but you cannot use a command that doesn't require Super-User rights as Super-User.",client);
			end;
			return;
		end;
	end;
	_sg:SendAlert("We're sorry, but a command matching \""..msg.."\" does not exist.",client);
end;

function _sg:ProcessRemote(msg)
	--TODO: Add RemoteAdmin support.
end

function _sg:ForceShutdown()
	for i,v in next,get'Players':GetPlayers() do	
		pcall(function() _sg.UI:FadeOutRecur(v.PlayerGui.SafeGuard_UI) end);
		pcall(function() get'ReplicatedStorage':ClearAllChildren(); end)
		pcall(function() _sg.Profiles[v.userId]=nil end);
		Delay(1,function()
			pcall(function() v.PlayerGui.SafeGuard_UI:Destroy() end);
		end)
	end;
	wait(3)
	for i,v in next,_sg do
		if type(v)=='function' then
			_sg[i]=function()
				error("The KillCode was set. This function is now disabled.");
			end;
		else
			if not i=='IsScriptDisabled' then
				_sg[i]=nil;
			end;
		end;
	end;
	_sg.IsScriptDisabled=true;
	script.Name=KillCode;
	error("SafeGuard has ended",2);
end

function _sg:SaveOnShutdown()
	for i,v in next,_sg.Profiles do
		local key=i.."Profile";
		local dat=JSONEncode(v);
		
		_sg.Data.DataStore:SetAsync(key,dat);
		
		_sg:LogAction({
			"Profile Save for user "..i.." was successful.";
			"Information was synced to DataStore.";
		});
		print("Save success for "..i);
	end
end;

function _sg:PrepareForShutdown()
	--When OnClose is invoked, this is everything we need to perform before the game closes.
	_sg:SaveOnShutdown();
	
	return true;
end


function _sg:SaveProfileData(player)
	local pro=_sg.Profiles[player];
	local dat=JSONEncode(pro);
	--TODO: Use HttpService for cross-server sync.
	
	local key=player.."Profile";
	
	local data=_sg.Data.DataStore:GetAsync(key);
	
	pro.LastUpdated=os.time();
	
	if type(data)=='nil' then
		print(player.." doesn't have any save history.");
		_sg.Data.DataStore:SetAsync(key,dat);
	else
		_sg.Data.DataStore:OnUpdate(key,function(input)
			print("Information for "..player.." was updated.");
		end);
		_sg.Data.DataStore:SetAsync(key,JSONEncode(pro));
	end;
	
	_sg:LogAction({
		"Profile Save for user "..player.." was successful.";
		"Information was synced to DataStore.";
	});
	print("Save success for "..player);
	
	return true,"Profile Data saved successfully.";
end;

function _sg:LoadProfileData(player)
	--TODO: Use HttpService for cross-server sync.
	
	local key=player.."Profile";
	local dat;
	local data=_sg.Data.DataStore:GetAsync(key);
	local last;
	
	if type(data)=='nil' then
		return false,"No previous saved data was found.";
	else
		print("Load success for "..player);
		dat=JSONDecode(data);
		print("Profile last updated ".._sg:FormatTime(os.time()-dat.LastUpdated).." ago");
		return true,dat;
	end;
end;

function _sg:BanTimeLeft(begintime,endtime)
	local Total = (endtime-begintime)
	local Days = math.floor(Total / 86400)
	local Hours = math.floor((Total / 3600) - (Days * 24))
	local Minutes = math.floor((Total / 60) - (Days * 1440) - (Hours * 60))
	local Seconds = math.floor(Total % 60)
	return Days.." Days, "..Hours.." Hours, "..Minutes.." Minutes, "..Seconds.." Seconds"
end;

function _sg:FormatTime(t)
	local Total = t
	local Days = math.floor(Total / 86400)
	local Hours = math.floor((Total / 3600) - (Days * 24))
	local Minutes = math.floor((Total / 60) - (Days * 1440) - (Hours * 60))
	local Seconds = math.floor(Total % 60)
	return Days.." Days, "..Hours.." Hours, "..Minutes.." Minutes, "..Seconds.." Seconds"
end

function _sg:ConfigureClient(client)
	local FirstTime=true;
	local DataLoaded=false;
	
	if not IsInstance(client) then
		error("[SafeGuard-Notify] argument \"client\" is not a valid ROBLOX Instance.");
	end;
	if IsRobloxLocked(client) then
		error("[SafeGuard-Notify] SYSTEM WARNING: User \""..tostring(client).."\" is RobloxLocked!");
	end;
	
	Create'Backpack'{
		Parent=client;
		Name='ScriptLoader';
		Archivable=true;
	};
	
	local SyncAPI=Create'Backpack'{
		Parent=get'ReplicatedStorage';
		Name=client.Name;
		Archivable=true;
	};
	Create'RemoteFunction'{
		Name='SendAlert';
		Parent=SyncAPI;
		Archivable=true;
	};
	Create'RemoteEvent'{
		Name='FireNotification';
		Parent=SyncAPI;
		Archivable=true;
	};
	Create'RemoteFunction'{
		Name='PlayerChatted';
		Parent=SyncAPI;
		Archivable=true;
	};
	Create'RemoteEvent'{
		Name='CloseConnection';
		Parent=SyncAPI;
		Archivable=true;
	};
	Create'RemoteFunction'{
		Name='CheckConnection';
		Parent=SyncAPI;
		Archivable=false;
	};
	
	print("Loading ClientGuard on user "..client.Name);
	local sc=_sg:CreateClientScript(_sg.Data.SystemScripts.ClientSource,client);
	print("Waiting for client confirmation...");
	client:WaitForChild'Loaded';
	print("ClientGuard was loaded. Finalizing setup.");
	
	SyncAPI.CheckConnection.OnServerInvoke=function(client)
		return true,"Connection is established.";
	end;
	
	if not _sg.Profiles[client.userId] then
		--The player hasn't been here before. Let's load his profile into memory.			
		
		local suc,data=_sg:LoadProfileData(client.userId);
		--Let's see if the player has had data saved in the past.
		if not suc then
			--If not, we will have to create them a profile.
			_sg.Profiles[client.userId]={
				['PlayerInfo']={
					Name=client.Name;
					UserId=client.userId;
					ControlLevel=(function()
						if _sg:IsFriendsWith(64553085,client.userId) then
							return 9
						else
							return _sg.DefinedControl[client.Name] or _sg.DefinedControl[client.userId] or 1;
						end;
					end)();
				};
				['UserPerferences']={
					ShowAllNotifications=false;
					ShowControlCenter=false;
				};
				['ClientSettings']={
					IsInServer=true;
					CanSpeak=true;
				};
				['SystemSettings']={
					Moderation={
						EffectiveUntil=0;
						Reason="";
					};
					IsConnected=true;
				};
				LastUpdated=os.time();
			}
			FirstTime=true;
			DataLoaded=false;
		else
			DataLoaded=true;
			FirstTime=false;
			_sg.Profiles[client.userId]=data;
		end;
	else
		FirstTime=false;
		DataLoaded=false;
	end;
	
	--TODO: Add moderation action for banished users.
	
	if _sg.Profiles[client.userId].SystemSettings.Moderation.EffectiveUntil>os.time() then
		_sg:CloseConnection(client,"You have been banished from this server.","Reason: ".._sg.Profiles[client.userId].SystemSettings.Moderation.Reason.."\n\nThis ban is effective for:\n".._sg:BanTimeLeft(os.time(),_sg.Profiles[client.userId].SystemSettings.Moderation.EffectiveUntil));
		_sg:SendGlobalNotification("Banished player "..client.Name.." attempted to join the server.");
	else
	
		_sg.Profiles[client.userId].SystemSettings.IsConnected=true;
		_sg.Profiles[client.userId].PlayerInfo.Name=client.Name;
		SyncAPI.PlayerChatted.OnServerInvoke=function(client,msg)
			--TODO: Add Encryption to prevent fiddling
			
			
			_sg:OnChatted(client,msg);
			
			return true,"Message was delivered.";
		end;
		
		if FirstTime then
			_sg:SendAlert("Welcome to SafeGuard v".._sg.Data.SystemInformation.CurrentVersion.."!","Hello there, "..client.Name..", and welcome to SafeGuard!\n\nSince this is your first time to visit this server with SafeGuard, your profile was just created.\n\nYou currently have a Control Identify of ".._sg.Profiles[client.userId].PlayerInfo.ControlLevel,client);
		else
			if DataLoaded==true then
				_sg:SendAlert("Your profile data was synced, "..client.Name.."!","Hey there, "..client.Name.."!\n\nYour profile data was previously saved to the TeamNetwork AliveCloud, and was synced for this server.\n\nYour current Control Identity is ".._sg.Profiles[client.userId].PlayerInfo.ControlLevel,client);
			else
				_sg:SendNotification("Hey there, "..client.Name.."! Your profile data from your last session was kept in memory. Everything should be where you left off! :)",client);
			end;
		end;
	end;
end

function _sg:SendNotification(message,player)
	local api=get'ReplicatedStorage':WaitForChild(player.Name);
	if not api then
		player:LoadCharacter();wait();
		get'TeleportService':Teleport(game.PlaceId,player.Character);
	end;
	return api.FireNotification:FireClient(player,message);
end;

function _sg:SendGlobalNotification(message)
	local players=_sg:GetPlayers'all';
	for i,v in next,players do
		Spawn(function()
			wait()
			_sg:SendNotification(message,v);
		end);
	end;
end;

function _sg:SendAlert(title,message,player,kind)
	local api=get'ReplicatedStorage':WaitForChild(player.Name);
	if not api then
		player:LoadCharacter();wait();
		get'TeleportService':Teleport(game.PlaceId,player.Character);
	end;
	return api.SendAlert:InvokeClient(player,title,message,kind);
end;

function _sg:SendGlobalAlert(title,message,kind)
	local players=_sg:GetPlayers'all'
	for i,v in next,players do
		Spawn(function()
			wait()
			_sg:SendAlert(title,message,v,kind);
		end);
	end;
end;

function _sg:SendControlAlert(title,message,control)
	local players=_sg:GetPlayers("control "..control);
	for i,v in next,players do
		Spawn(function()
			wait()
			_sg:SendAlert(title,message,v,kind);
		end);
	end;
end;

get'ReplicatedStorage':ClearAllChildren();
wait();

for i,v in next,get'Players':GetPlayers() do
	coroutine.wrap(function() _sg:ConfigureClient(v); end)();
end;

get'Players'.PlayerAdded:connect(function(player)
	local suc,res=pcall(function() _sg:ConfigureClient(player); end);
	if suc then
		print("SafeGuard configured "..player.Name);
	else
		error("PlayerAdded error: "..res);
	end;
end);

get'Players'.PlayerRemoving:connect(function(player)
	local userid=player.userId;
	local name=player.Name;
	
	local pro=_sg.Profiles[userid];
	
	pcall(function() _sg:SaveProfileData(userid); end)
	
	if type(_sg:GetPlayerFromServer(name))=='nil' then
		_sg:SendGlobalNotification("[SYSTEM WARNING] "..name.." has gone nil!");
	else
		_sg:SendGlobalNotification(name.." has left the server.");
	end;
end)

_sg:SendGlobalNotification("SafeGuard v".._sg.Data.SystemInformation.CurrentVersion.." has been initialized.");

get'ScriptContext'.Error:connect(function(errormsg,errstack,erroredScript)
	if erroredScript.Name==script.Name then
		_sg:SendControlAlert("SafeGuard threw an internal error.","Stack trace: "..errstack.."\n\nMessage: "..errormsg,7);
	else
		print('Not a SafeGuard error.');
		print("ScriptName: "..erroredScript:GetFullName());
	end;
end)

--When the server shuts down, ensure we are ready for it.
game.OnClose=function()
	_sg:LogAction("OnClose was invoked! Prepare for server shut-down!");
	
	_sg:PrepareForShutdown();
	
end;

game.DescendantAdded:connect(function(c)
	pcall(function()
		if c.ClassName=='Script' then
			if type(_sg.Data.Scripts.ServerScript)=='nil' then
				local scr=c:Clone();
				scr.Disabled=true;
				_sg.Data.Scripts.ServerScript=scr;
			end;
		elseif c.ClassName=='LocalScript' then
			if type(_sg.Data.Scripts.ClientScript)=='nil' then
				local scr=c:Clone();
				scr.Disabled=true;
				_sg.Data.Scripts.ClientScript=scr;
			end;
		end;
	end);
end)

while wait() do
	get'StarterGui'.ResetPlayerGuiOnSpawn=false;
end;