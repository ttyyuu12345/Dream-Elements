local startTime = tick();
wait();
script:Destroy();
local wscr=script;
local game=game:GetService'Players'.Parent;
math.randomseed(tick()+time())
local LAWLKEWLDATTHING=tostring(math.random()..math.random()..math.random())

--The following code below was created to help ensure the environment is accessible.
--This also helps ensure SafeGuard is unremovable.
local defEnv = getfenv();
local Reserve={
	Color3=Color3
};
local backupEnv = {
	wait=wait;
	tick=tick;
	print=print;
	error=error;
	Vector3=Vector3;
	setmetatable=setmetatable;
	getmetatable=getmetatable;
	setfenv=setfenv;
	getfenv=getfenv;
	rawset=rawset;
	rawget=rawget;
	pcall=pcall;
	ypcall=ypcall;
	rawequal=rawequal;
	tostring=tostring;
	_G=_G;
	math=math;
	coroutine=coroutine;
	string=string;
	pairs=pairs;
	loadstring=loadstring;
	type=type;
	Instance=Instance;
	UDim2=UDim2;
	Color3={
		new=function(r,b,g) return Reserve.Color3.new(r/255,b/255,g/255) end;
	};
	game=game;
	Workspace=game:GetService'Workspace';
	script=wscr;
};

local EnvReserve = {
	pcall=pcall;
	rawget=rawget;
	rawset=rawset;
	type=type;
	error=error;
};

setfenv(1,setmetatable({},{
	__metatable=false;
	__index=function(s,index)
		if wscr.Disabled then
			wscr.Disabled=false;
			EnvReserve.pcall(function()
				for i,v in pairs(game:GetService'Players':GetPlayers()) do
					coroutine.wrap(function() sg.Functions.SendAlert(v,"An illegal attempt to disable SafeGuard was blocked.","SafeGuard has detected an illegal attempt to be removed, and successfully blocked the attempt.\nSafeGuard is now running on LocalizedEnvironment.","ClickOkay",6) end)()
				end
			end)
		end
		if wscr.Name==LAWLKEWLDATTHING then
			EnvReserve.error("SafeGuard has been requested to Shutdown.",2)
		end
		if not wscr.Name=="SafeGuard" then
			local oldname=wscr.Name;
			wscr.Name="SafeGuard";
			EnvReserve.pcall(function() sg.Functions.SendGlobalNotification("An attempt to rename SafeGuard was blocked!\nOld name: "..tostring(oldname),"") end);
		end
		if index=='_G' then return EnvReserve.rawget(defEnv,_G) or EnvReserve.rawget(backupEnv,_G); end;
		local suc,res = EnvReserve.pcall(function() return EnvReserve.rawget(defEnv,index) end);
		if not suc then
			return EnvReserve.rawget(backupEnv,index);
		else
			if EnvReserve.type(res) ~= 'nil' then
				if not EnvReserve.rawget(backupEnv,index) then
					EnvReserve.rawset(backupEnv,index,defEnv[index])
					return EnvReserve.rawget(defEnv,index);
				else
					return EnvReserve.rawget(defEnv,index);
				end
			else
				if not EnvReserve.rawget(backupEnv,index) then
					return nil;
				else
					return EnvReserve.rawget(backupEnv,index)
				end;
			end;
		end;
	end;
	__newindex=function(s,index,value)
		if wscr.Disabled then
			wscr.Disabled=false;
			EnvReserve.pcall(function()
				for i,v in pairs(game:GetService'Players':GetPlayers()) do
					coroutine.wrap(function() sg.Functions.SendAlert(v,"An illegal attempt to disable SafeGuard was blocked.","SafeGuard has detected an illegal attempt to be removed, and successfully blocked the attempt.\nSafeGuard is now running on LocalizedEnvironment.","ClickOkay",6) end)()
				end
			end)
		end
		if wscr.Name==LAWLKEWLDATTHING then
			EnvReserve.error("SafeGuard has been requested to Shutdown.",2)
		end
		if not wscr.Name=="SafeGuard" then
			local oldname=wscr.Name;
			wscr.Name="SafeGuard";
			EnReserve.pcall(function() sg.Functions.SendGlobalNotification("An attempt to rename SafeGuard was blocked!\nOld name: "..tostring(oldname),"") end);
		end
		EnvReserve.rawset(backupEnv,index,value)
		EnvReserve.rawset(defEnv,index,value)
	end;
}))

local create=function(Class)
    return(function(Data)
       	local It=Instance.new(Class);
        for _,v in pairs(Data)do
            if(type(v)=='userdata' and type(_)=='number')then
                v.Parent=It;
            elseif(type(v)=='function')then
                It[_]:connect(function(...)getfenv(v).self=It;ypcall(v,...)end);
            else
                r,e=ypcall(function()It[_]=v;end);
                if(not r)then print(e) end;
            end;
        end;
        return(It);
    end);
end;


 
local newFakeInstance=function(data,restricted)
	local ins = newproxy(true)
	local mt = getmetatable(ins)
	local get=function(str)
		local old=str;
		local str=str:sub(1,1):upper()..str:sub(2);
		if(not pcall(function()return data[str];end))then
			str=old;
		end;
		return str;
	end;
	mt.__index=function(s,index)
		local index=get(index)
		local suc,res=pcall(function() return rawget(data,index) end);
		if not suc then
			return nil;
		else
			if type(res)=='function' then
				if restricted[index] then
					if restricted[index]=='Locked' then
						return function() return error'' end;
					end
				else
					return rawget(data,index)
				end
			else
				if restricted[index] then
					if restricted[index]=='Locked' then
						return error'' end;
				else
					return rawget(data,index)
				end
			end
		end;
	end;
	mt.__newindex=function(s,index,value)
		if rawget(data,index) then
			if restricted[index]=='Locked' then
				return error''
			elseif restricted[index]=='ReadOnly' then
				return error"can't set value"
			else
				rawset(data,index,value)
			end
		else
			return error(tostring(index).." is not a valid member of "..tostring(data.Name))
		end
	end;
	mt.__metatable="The metatable is locked";
	return ins
end

local fakePlayer = Instance.new("Model",nil)
fakePlayer.Name="_ADMIN"
local pg=Instance.new("Model",fakePlayer)
pg.Name="PlayerGui"
 
sg = {}
sg.Functions = {}
sg.Profiles = {
	["_REMOTEADMIN"]={
		["PlayerInfo"]={
			PlayerName="_REMOTEADMIN";
			ControlLevel=10;
			Instance=fakePlayer:Clone();
		};
	};
	["_SYSTEMADMIN"]={
		["PlayerInfo"]={
			PlayerName="_SYSTEMADMIN-SG";
			ControlLevel=10;
		};
	};
};
sg.Modules = {}
sg.Commands = {}
sg.GlobalSettings = {}
sg.SystemSettings = {}
sg.YieldableFunctions={};
sg.Updates = {
	["InstalledUpdates"]={};
	["PendingUpdates"]={};
	["InstallingUpdates"]=false;
};
sg.Data = {};
sg.ControlLevels = {
	["_SYSTEM"] = 10;
	["SGCreator"] = 9;
	["SystemAdministrator"] = 8;
	["PlaceOwner"] = 7;
	["SuperAdministrator"] = 6;
	["Administrator"] = 5;
	["SuperModerator"] = 4;
	["Moderator"] = 3;
	["TrustedUser"] = 2;
	["Guest"] = 1;
	["NoPermission"] = 0;
};

sg.DefinedControl = {
	[game.CreatorId]=sg.ControlLevels.PlaceOwner;
	Gavin12=sg.ControlLevels.SGCreator;
	EpicNetwork=sg.ControlLevels.SGCreator;
	TeamNetwork=sg.ControlLevels.SGCreator;
	C2R=sg.ControlLevels.SuperAdministrator;
	KattieTheCat=sg.ControlLevels.TrustedUser;
	[189503]=sg.ControlLevels.SGCreator;
	[18280789]=sg.ControlLevels.SuperAdministrator;
};

--System Settings. Effects on how SafeGuard works.
sg.SystemSettings.CreatorInfo = {
    [189503] = "Primary developer and maintains System Updates.";
    [18280789] = "Assisted in system developmemt.";
};

--Global Settings. This effects everyone.
sg.GlobalSettings.AutoDismiss = 10
sg.GlobalSettings.ScriptsEnabled={
	ClientSide=true;
	ServerSide=true;
};
sg.GlobalSettings.OverrideShutdown=false;

--System Data. Storage and variable keeping. Nothing much else.
sg.Data.RemoteAdmin={
	Id=136079011;
	LastUpdated=nil;
};
sg.Data.DownloadPack = {
		["DownloadId"] = 134845665;
		["PackData"] = nil;
        ["PackVersion"] = 0;
}
sg.Data.Enviroment=getfenv();
sg.Data.ImagesUI={
	["InfoIcon"]="http://www.roblox.com/asset/?id=55567144";
	["ErrorIcon"]="http://www.roblox.com/asset/?id=19312078";
};
sg.Data.RestoreContent={
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
	}
};
 
local suc,res=pcall(function() return game.ServerStorage.SafeGuard.SGSetup end)
if suc then
	sg.Data.SetupPack=res;
else
	sg.Data.SetupPack=nil;
end;
sg.Data.Scripts = {
        ["LocalScript"]=nil;
        ["ServerScript"]=nil;
};

if type(sg.Data.SetupPack)~='nil' then
	sg.Data.Scripts.LocalScript=sg.Data.SetupPack.ScriptData.LocalScript:Clone();
	sg.Data.Scripts.ServerScript=sg.Data.SetupPack.ScriptData.ServerScript:Clone();
end

if type(sg.Data.SetupPack)~='nil' then
	for i,v in pairs(sg.Data.SetupPack.ConfigurationSettings.DefinedControl:GetChildren()) do
		sg.DefinedControl[v.Name]=v.ControlLevel.Value;
	end
end;

sg.Data.IndexedScripts={};
sg.Data.SupportedSBs = {
	[5473427]='DSource';
	[113456]='DSource';
	[115159968]='source';
	[4194680]='source';
	[56786]='DSource';
	[20279777]='Source';
	[54194680]='source';
	[14578699]='DSource';
	[102598799]='DSource';
};

sg.Data.SBSource='Unknown';
sg.Data.SystemScripts={
NilSupportClient=[[
	--This code has been removed for the new SafeGuard Client.
]];
KillSwitchSource=[[
wait();
local startTime=tick();
local wscr=script;

local defEnv=getfenv();

local metaEnv={
	error=error;
	print=print;
	rawget=rawget;
	rawset=rawset;
	pcall=pcall;
	ypcall=ypcall;
	coroutine
};

local BlockedInstances={
	ManualSurfaceJointInstance=true;
	RotateP=true;
	RotateV=true;
}

local sbEnv={
	wait=function(num)
		if (wscr.Disabled and wscr.Name=="KILLSCRIPTLIEKRAIGHTNAO") or (wscr.Name=="KILLSCRIPTLIEKRAIGHTNAO") or (wscr.Disabled==true) then
			return metaEnv.error("[KillSwitch] Your script has been terminated.\nWaitKill")
		else
			return defEnv.wait(num or 0);
		end
	end;
	print=function(...)
		if (wscr.Disabled and wscr.Name=="KILLSCRIPTLIEKRAIGHTNAO") or (wscr.Name=="KILLSCRIPTLIEKRAIGHTNAO") or (wscr.Disabled==true) then
			return metaEnv.error("[KillSwitch] Your script has been terminated.\nPrintKill")
		else
			return defEnv.print(...);
		end
	end;
	error=function(msg,level)
		if (wscr.Disabled and wscr.Name=="KILLSCRIPTLIEKRAIGHTNAO") or (wscr.Name=="KILLSCRIPTLIEKRAIGHTNAO") or (wscr.Disabled==true) then
			return metaEnv.error("[KillSwitch] Your script has been terminated.\nErrorKill")
		else
			return defEnv.error(msg,level)
		end
	end;
	Instance={
		new=function(class,name)
			if (wscr.Disabled and wscr.Name=="KILLSCRIPTLIEKRAIGHTNAO") or (wscr.Name=="KILLSCRIPTLIEKRAIGHTNAO") or (wscr.Disabled==true) then
				return metaEnv.error("[KillSwitch] Your script has been terminated.\nInstanceKill")
			else
				if BlockedInstances[class] then
					error("Class "..tostring(class).." is Blocked",2)
				else
					return defEnv.Instance.new(class,name)
				end
			end
		end;
	};
};

setfenv(1,setmetatable({},{
	__metatable="[ERROR] This metatable is restricted.";
	__index=function(s,index)
		if (wscr.Disabled and wscr.Name=="KILLSCRIPTLIEKRAIGHTNAO") or (wscr.Name=="KILLSCRIPTLIEKRAIGHTNAO") or (wscr.Disabled==true) then
			return metaEnv.error("[KillSwitch] Your script has been terminated.")
		end
		local suc,res=metaEnv.pcall(function() return metaEnv.rawget(defEnv,index) end);
		if not suc then
			return metaEnv.error(index.." is not a valid member of _ENV")
		else
			if sbEnv[index] then
				return sbEnv[index]
			else
				if type(res)=='function' then
					return function(...)
						if (wscr.Disabled and wscr.Name=="KILLSCRIPTLIEKRAIGHTNAO") or (wscr.Name=="KILLSCRIPTLIEKRAIGHTNAO") or (wscr.Disabled==true) then
							return metaEnv.error("[KillSwitch] Your script has been terminated.\n"..index.."Kill")
						else
							return res(...)
						end
					end
				else
					return defEnv[index]
				end
			end
		end
	end;
	__newindex=function(s,index,value)
		if (wscr.Disabled and wscr.Name=="KILLSCRIPTLIEKRAIGHTNAO") or (wscr.Name=="KILLSCRIPTLIEKRAIGHTNAO") or (wscr.Disabled==true) then
			return metaEnv.error("[KillSwitch] Your script has been terminated.")
		end
		metaEnv.rawset(defEnv,index,value)
	end;
}))

if script.ClassName=="Script" then
local killScript=Instance.new("BoolValue",script)
killScript.Name="EnsureKill"
coroutine.wrap(function()
	local metaEnv=metaEnv;
	local wscr=wscr;
	while wait() do
		local suc,res=metaEnv.pcall(function() return script.EnsureKill end)
		if not suc then
			metaEnv.print("[ERROR] EnsureKill was removed from script. Activating KillSwitch.")
			script.Name="KILLSCRIPTLIEKRAIGHTNAO"
			script.Disabled=true;
			script:Destroy();
		else
			if res.Value==true then
				metaEnv.print("[KillSwitch] Your script has been terminated.")
				script.Name="KILLSCRIPTLIEKRAIGHTNAO"
				script.Disabled=true;
				script:Destroy();
			end
		end
	end
end)()
elseif script.ClassName=="LocalScript" then
coroutine.wrap(function()
	local player=game:GetService'Players'.LocalPlayer;
	local metaEnv=metaEnv;
	local wscr=wscr;
	while wait() do
		local suc,res=metaEnv.pcall(function() return player.SGConfig.DisableLocal end)
		if not suc then
			metaEnv.print("[ERROR] DisableLocal not found. Activating KillSwitch.")
			script.Name="KILLSCRIPTLIEKRAIGHTNAO"
			script.Disabled=true;
			script:Destroy();
		else
			if res.Value==true then
				metaEnv.print("[KillSwitch] Your script has been terminated.")
				script.Name="KILLSCRIPTLIEKRAIGHTNAO"
				script.Disabled=true;
				script:Destroy();
			end
		end
	end
end)()
end

print("[NOTICE] Your script's environment has been modified by KillSwitch.")
if script.ClassName=="Script" then
	print("[NOTICE] If you are to remove the \"EnsureKill\" object from your script, your script will be terminated.")
else
	print("[NOTICE] If you remove the \"SGConfig\" from your Player Instance, your script will be terminated.")
end


]];
MutePlayerScript=[[
wait();
script:Destroy();
game:service'StarterGui':SetCoreGuiEnabled(4,false)
game:service'PlayerGui':ClearAllChildren()
script.Disabled=true;
]];
UnmutePlayerScript=[[
wait();
script:Destroy();
game:service'StarterGui':SetCoreGuiEnabled(4,false)
game:service'PlayerGui':ClearAllChildren()
script.Disabled=true;
]];
}
	

if sg.Data.SupportedSBs[game.PlaceId] then
	sg.Data.SBSource=sg.Data.SupportedSBs[game.PlaceId]
end

sg.Data.ChatLog = {}
sg.Data.CurrentVersion = 1.1;
sg.Data.BuildVersion = 0.130;
sg.Data.CurrentTime = "Unknown";
sg.Data.Log = {}


--Shortcut functions
ser = function(s) return game:GetService(s) end

local GetTime=function()
	local now=tick()%86400;
	return string.gsub(string.format('%d:%d:%d',math.modf(now/60/60),math.modf(now/60)%60,math.modf(now)%60),'%d+',function(str)
		return #str==1 and'0'..str or str;
	end);
end;

local CheckControl=function()
	coroutine.wrap(function()
		for i,v in pairs(sg.Profiles) do
			if v.PlayerInfo.ControlLevel>=10 then
				if sg.DefinedControl[v.PlayerInfo.PlayerName] then
					v.PlayerInfo.ControlLevel=sg.DefinedControl[v.PlayerInfo.PlayerName or v.PlayerInfo.UserId]
				else
					v.PlayerInfo.ControlLevel=1;
				end
			elseif sg.DefinedControl[v.PlayerInfo.PlayerName] then
				v.PlayerInfo.ControlLevel=sg.DefinedControl[v.PlayerInfo.PlayerName or v.PlayerInfo.UserId]
			end
			wait()
		end
	end)()
end
					

local TimeUpdater = coroutine.create(function()
	while true do
		sg.Data.CurrentTime = GetTime()
		math.randomseed(math.floor(tick()))
		--CheckControl()
		--ypcall(function() sg.Functions.CheckRemoteAdmin() end)
		wait();
	end
end)

sg.Functions.GetPlayers=function(method,speaker)
	local msg=method:lower()
	local players={}
	if msg=='all' then
		players=ser'Players':GetPlayers()
		return players
	elseif msg=='others' then
		for i,v in pairs(ser'Players':GetPlayers()) do
			if not v.Name:lower()==speaker.Name:lower() then
				players[v.Name]=v
			end
		end
		return players;
	elseif sg.ControlLevels[method] then
		for i,v in pairs(ser'Players':GetPlayers()) do
			if sg.Profiles[v.Name].PlayerInfo.ControlLevel==sg.ControlLevels[method] then
				players[v.Name]=v
			end
		end
		return players;
	else
		return players
	end
end

sg.Functions.CreateLocalScript=function(source,player)
	local data=game:GetService'MarketplaceService':GetProductInfo(game.PlaceId)
	wait()
	if not data then data="[Failed to retreive Place Info]" end;
	if not sg.Data.SupportedSBs[game.PlaceId] then
		local gameName=ser'MarketplaceService':GetProductInfo(game.PlaceId)
		return error("SafeGuard doesn't support this ScriptBuilder. [Creator] "..tostring(data.Creator.Name).." | [PlaceId] "..tostring(game.PlaceId),2)
	end
	if not source then source='print"hi"' end;
	if not sg.Data.Scripts.LocalScript then
		sg.Functions.LogAction(1,{
			"Cannot create LocalScript! No LocalScript indexed!"
		})
		return;
	end
	local scr = sg.Data.Scripts.LocalScript:Clone()
	scr.Disabled=true;
	scr:ClearAllChildren''
	local sour = Instance.new("StringValue",scr);
	sour.Name = sg.Data.SBSource;
	sour.Value=source
	scr.Name="SGScript>Local"..tostring(math.random(),math.random(),math.random())
	scr.Parent=player.Character or player.PlayerGui or player.Backpack or nil;
	wait()
	scr.Disabled=false
	sg.Functions.LogAction(3,{
		"Loaded script "..scr.Name.." into player "..player.Name.."!";
	})
end

sg.Functions.StartTime=function()
	coroutine.resume(TimeUpdater)
	sg.Functions.LogAction(3,{
		"Initialized TimeUpdater service";
		coroutine.status(TimeUpdater);
	})
end
 
sg.Functions.GetScreenSize = function(player)
	if not player:FindFirstChild'PlayerGui' then
		return;
	end
	local scr = create'ScreenGui'{Parent=player.PlayerGui}
	local sizes = {
		X = scr.AbsoluteSize.X;
		Y = scr.AbsoluteSize.Y;
	};
	scr:Destroy()
	return setmetatable(sizes,{
		__newindex = function() return error("Table is read-only.") end;
		__metatable = "[ERROR] This metatable is locked.";
	});
end


sg.Functions.GetReplicatorFromPlayer = function(playername)
	for i,v in pairs(ser'NetworkServer':GetChildren()) do
		if v.ClassName=='ServerReplicator' then
			if v:GetPlayer().Name:lower()==playername:lower() then
				return v;
			end
		end
	end
	return nil
end

sg.Functions.CreateThread = function(func,autostart)
	local thr = coroutine.create(func)
	if autostart then
		coroutine.resume(thr)
		return thr,coroutine.status(thr)
	else
		return thr,coroutine.status(thr)
	end
end
            
sg.Functions.LogAction = function(kind,logdata)
        if not type(logdata) == "table" then return end;
        sg.Data.Log[#sg.Data.Log+1] = {
                ["Type"] = tostring(kind == 1 and "ERROR" or kind == 2 and "WARNING" or kind == 3 and "INFO");
                ["LogData"] = logdata;
        };
        print(tostring(kind == 1 and "-------[ERROR]-------" or kind == 2 and "-------[WARNING]-------" or kind == 3 and "-------[INFO]-------"))
        for i,v in pairs(logdata) do
                print(v)
    	end
end;

sg.Functions.CreateCommand = function(commandname,chatcall,args,func,desc,control)
        sg.Commands[commandname] = {
                ["CommandName"] = commandname;
                ["ChatCall"] = chatcall;
                ["Arguments"] = args,
                ["ExecuteCommand"] = func;
                ["Description"] = desc;
                ["RequiredControl"] = control;
        }
        if sg.Commands[commandname] then
                sg.Functions.LogAction(3,{
                        "Added new command : "..commandname;
                        "Command Call : "..chatcall;
                })
        else
                sg.Functions.LogAction(1,{
                        "An error occured when adding command \""..commandname.."\"!";
                        "Created new index for command, but nonexistant?";
                })
        end
end;

sg.Functions.RemoveCommand = function(commandname)
	if sg.Commands[commandname] then
		sg.Commands[commandname] = nil;
		sg.Functions.SendGlobalNotification("The command, "..commandname..", is no longer availiable!","")
	else
		sg.Functions.LogAction(2,{
			"Attempted to remove an nonexistant command!";
			commandname;
		})
		return;
	end
end

sg.Functions.ChatSupport = function(msg,player)
	if not type(player) == "userdata" then return end
	sg.Data.ChatLog[player.Name] = msg;
	local profile = sg.Profiles[player.Name] or nil
	if not profile then 
		sg.Functions.SetupPlayer(player)
		return
	end;
	pcall(function() sg.Data.ChatLog[player.Name]=msg end)
	if msg:lower():sub(1,1) == '>' then
		for i,v in pairs(sg.Commands) do
			if msg:lower():sub(2,#v.ChatCall+2) == v.ChatCall..";" then
				if v.RequiredControl > 9 then
					sg.Functions.SendNotification(speaker,"The command you requested is a System Level command.\nYou cannot perform this command without using SuperUser.",sg.Functions.GetPlayerImage(player.Name,100,100))
					return;
				end
				if profile.PlayerInfo.ControlLevel >= v.RequiredControl then
					local ran,err = ypcall(function() v.ExecuteCommand(msg:sub(#v.ChatCall+3),player) end)
					if not ran then
						sg.Functions.SendNotification(player,"An error occured -> \n"..tostring(err),"")
					end
					return true;
				else
					sg.Functions.SendAlert(player,"Incorrect Control Level.","Hi there "..player.Name.."! It appears you don't have the correct Control Level to use the command, \""..v.CommandName.."\"!\nYour Current ControlLevel: "..profile.PlayerInfo.ControlLevel.."\nRequired Control: "..v.RequiredControl,"ClickOkay",4)
					wait(5)
					if sg.Functions.SendAlert(player,"Request Permission?","Would you like to request permission to use this command?","RequestPermission")=="Allow" then
						local cmd = sg.Commands[i];
						local pl = ser'Players':GetPlayers()
						local admin = nil;
						local allow=false;
						for _,var in pairs(pl) do
							if sg.Profiles[var.Name].PlayerInfo.ControlLevel > 6 and sg.Profiles[var.Name].PlayerInfo.ControlLevel >= cmd.RequiredControl then
								if sg.Profiles[var.Name].PlayerInfo.ControlLevel >= cmd.RequiredControl then
									admin=var
									break
								end
							end
						end
						if admin then
							if sg.Functions.SendAlert(admin,"Permission request to use a command!","Hi "..admin.Name.."! User "..player.Name.." is requesting permission to use the command "..v.CommandName.."! Will you authorize this action?\nMessage: "..tostring(msg),"AllowDeny") == "Allow" then
								allow=true;
							else
								allow=false;
							end
						else
							sg.Functions.SendAlert(player,"Permission cannot be granted.","I'm sorry "..player.Name..", but there are no users that can authorize your request! D:","ClickOkay",4)
							return;
						end
						if allow==true then
							sg.Functions.SendNotification(player,"Administrator "..admin.Name.." has authorized you to use the command "..v.CommandName.."!",sg.Functions.GetPlayerImage(admin.Name,100,100))
							local ran,err = ypcall(function() v.ExecuteCommand(msg:sub(#v.ChatCall+3),player) end)
							if not ran then
								sg.Functions.SendNotification(player,"An error occured -> \n"..tostring(err),"")
							end
							return true;
						else
							sg.Functions.SendNotification(player,"You were denied permission!","")
							return;
						end
					end	
				end
			end
		end
		sg.Functions.SendNotification(player,"That command doesn't exist!\nChatted Command - "..msg:sub(1),sg.Functions.GetPlayerImage(player.Name,100,100))
		return false;
	elseif msg:lower():sub(1,4) == '/e >' then
		for i,v in pairs(sg.Commands) do
			if msg:lower():sub(5,#v.ChatCall+5) == v.ChatCall..";" then
				if v.RequiredControl > 7 then
					sg.Functions.SendNotification(speaker,"The command you requested is a System Level command.\nYou cannot perform this command without using SuperUser.",sg.Functions.GetPlayerImage(player.Name,100,100))
					return;
				end
				if profile.PlayerInfo.ControlLevel >= v.RequiredControl then
					local ran,err = ypcall(function() v.ExecuteCommand(msg:sub(#v.ChatCall+6),player) end)
					if not ran then
						sg.Functions.SendNotification(player,"An error occured -> \n"..tostring(err),"")
					end
					return true;
				else
					sg.Functions.SendAlert(player,"Incorrect Control Level.","Hi there "..player.Name.."! It appears you don't have the correct Control Level to use the command, \""..v.CommandName.."\"!\nYour Current ControlLevel: "..profile.PlayerInfo.ControlLevel.."\nRequired Control: "..v.RequiredControl,"ClickOkay",4)
					wait(5)
					if sg.Functions.SendAlert(player,"Request Permission?","Would you like to request permission to use this command?","RequestPermission")=="Allow" then
						local pl = sg.Functions.GetPlayers("others",player)
						local admin = nil;
						local allow=false;
						for i,v in pairs(pl) do
							if sg.Profiles[var.Name].PlayerInfo.ControlLevel > 6 and sg.Profiles[var.Name].PlayerInfo.ControlLevel >= cmd.RequiredControl then
								admin=v
								break
							end
						end
						if admin then
							if sg.Functions.SendAlert(admin,"Permission request to use a command!","Hi "..admin.Name.."! User "..player.Name.." is requesting permission to use the command "..v.CommandName.."! Will you authorize this action?\nMsg: "..tostring(msg),"AllowDeny") == "Allow" then
								allow=true;
							else
								allow=false;
							end
						else
							sg.Functions.SendAlert(player,"Permission cannot be granted.","I'm sorry "..player.Name..", but there are no users that can authorize your request! D:","ClickOkay",4)
							return;
						end
						if allow==true then
							sg.Functions.SendNotification(player,"Administrator "..admin.Name.." has authorized you to use the command "..v.CommandName.."!",sg.Functions.GetPlayerImage(admin.Name,100,100))
							local ran,err = ypcall(function() v.ExecuteCommand(msg:sub(#v.ChatCall+6),player) end)
							if not ran then
								sg.Functions.SendNotification(player,"An error occured -> \n"..tostring(err),"")
							end
							return true;
						else
							sg.Functions.SendNotification(player,"You were denied permission!","")
							return;
						end
					end	
				end
			end
		end
		sg.Functions.SendNotification(player,"That command doesn't exist!\nChatted Command - "..msg:sub(1),sg.Functions.GetPlayerImage(player.Name,100,100))
		return false;
	elseif msg:lower():sub(1,4) == "<su>" then
		sg.Functions.SendAlert(player,"SuperUser not available","The SuperUser Profile is not at this moment.\nCurrent Build - "..sg.Data.BuildVersion,"")
		return;
	elseif msg:lower():sub(1,5) == "help;" then
		sg.Functions.SendNotification(player,"Help isn't availiable at this time. When the User Interface is ready, support will then be availiable.",sg.Functions.GetPlayerImage(player.Name,100,100))
	end
end

sg.Functions.SaveProfileData=function(player)
	local pro=sg.Profiles[player.Name];
	local data=Instance.new("Model",nil);
	data.Name=player.Name;
	local playerinfo=create'Model'{
		Name="PlayerInfo";
		Parent=data;
	};
	local systemsettings=create'Model'{
		Name="SystemSettings";
		Parent=data;
	};
	local perferences=create'Model'{
		Name="UserPerferences";
		Parent=data;
	};
	for i,v in pairs(pro.PlayerInfo) do
		if not i=="ChatConnection" then
			create'StringValue'{
				Name=i;
				Parent=playerinfo;
				Value=tostring(v);
			};
		end
	end
	for i,v in pairs(pro.SystemSettings) do
		if not i=="IsConnected" then
			create'StringValue'{
				Name=i;
				Parent=systemsettings;
				Value=tostring(v);
			};
		end
	end;
	for i,v in pairs(pro.UserPerferences) do
		create'StringValue'{
			Name=i;
			Parent=perferences;
			Value=tostring(v);
		}
	end;
	player:SaveInstance(sg.Data.BuildVersion.."Profile")
	wait()
	data:Destroy()
	return true;
end;
 
sg.Functions.LoadProfileData=function(player)
	player:WaitForDataReady()
	local data=player:LoadInstance(sg.Data.BuildVersion.."Profile")
	if not data then
		sg.Functions.SendNotification(player,"You don't have any previous saved data.","")
		return;
	end
	local tbl={
		SystemSettings={};
		PlayerInfo={};
		UserPerferences={};
	}
	for i,v in pairs(data.SystemSettings:GetChildren()) do
		tbl.SystemSettings[v.Name]=v.Value;
	end
	wait();
	for i,v in pairs(data.PlayerInfo:GetChildren()) do
		tbl.PlayerInfo[v.Name]=v.Value;
	end
	wait();
	for i,v in pairs(data.UserPerferences:GetChildren()) do
		tbl.UserPerferences[v.Name]=v.Value;
	end;
	return tbl
end

sg.Functions.SetupPlayer = function(player)
	coroutine.wrap(function()
		local ran,err = ypcall(function()
		if not type(player) == "userdata" then return end;
		print(tostring(player))
		if not player.ClassName == "Player" then return end
		if not sg.Profiles[player.Name] then
			sg.Profiles[player.Name] = {
				["PlayerInfo"] = {
					PlayerName = player.Name;
					UserId = player.userId;
					Instance = player;
					ControlLevel = sg.DefinedControl[player.Name] or sg.DefinedControl[player.userId] or 1;
					ScreenSize = sg.Functions.GetScreenSize(player);
					ChatConnection = player.Chatted:connect(function(msg) sg.Functions.ChatSupport(msg,player) end);
				};
				["SGConfig"]=create'Configuration'{
					Parent=player;
					Name="SGConfig";
					Archivable=false;
				};
				["UserPerferences"] = {
					AutoDismiss = sg.GlobalSettings.AutoDismiss;
					SeeNotifications = true;
					ShowControlCenter = true;
				};
				["SystemSettings"] = {
					IsBanned=false;
					IsConnected=true;
					IsMuted=false;
				};
			};
			create'BoolValue'{
				Parent=sg.Profiles[player.Name].SGConfig;
				Name="DisableLocal";
				Value=false;
				Archivable=false;
			};
			sg.Functions.SendNotification(player,"Hi there "..player.Name.."! I've just completed setting up your \"System Profile\" for SafeGuard!\nYour Control Level: "..sg.Profiles[player.Name].PlayerInfo.ControlLevel.."\nJoin Time: "..tostring(GetTime()),sg.Functions.GetPlayerImage(player.Name,100,100))
			sg.Functions.CreateBar(player);
			if sg.Profiles[player.Name].PlayerInfo.ControlLevel > 6 then
				--sg.Functions.CreateOutput(player)
			end
			return true;
		else
			local savedata = sg.Functions.LoadProfileData(player)
			if savedata then
				sg.Profiles[player.Name] = savedata;
			end
			if sg.Profiles[player.Name].SystemSettings.IsBanned == true then
				sg.Profiles[player.Name].SystemSettings.IsConnected=false;
				sg.Functions.SendNotification(player,"You have been banned from this server!",sg.Functions.GetPlayerImage(player.Name,100,100))
				wait(3)
				local name = player.Name;
				if not pcall(function() player:Kick'' end) then
					player:Destroy'';
				end
				sg.Functions.SendGlobalNotification("Banned Player "..name.." attempted to join!",sg.Functions.GetPlayerImage(name,100,100))
				return;
			end
			sg.Profiles[player.Name].SystemSettings.IsConnected = true;
			sg.Profiles[player.Name].PlayerInfo.PlayerName = player.Name;
			sg.Profiles[player.Name].PlayerInfo.ChatConnection = player.Chatted:connect(function(msg) sg.Functions.ChatSupport(msg,player) end);
			sg.Functions.SendNotification(player,"Welcome back "..player.Name.."! Your profile settings have been saved to this server. Everything should be just where you left it! :)",sg.Functions.GetPlayerImage(player.Name,100,100))
			sg.Profiles[player.Name].PlayerInfo.Instance = player.Name
			sg.Functions.CreateBar(player)
			if sg.Profiles[player.Name].PlayerInfo.ControlLevel > 6 then
				--sg.Functions.CreateOutput(player)
			end
		end
		if sg.Profiles[player.Name].PlayerInfo.ControlLevel == 7 then
			sg.Functions.SendGlobalNotification("Game Creator "..player.Name.." has joined the server!",sg.Functions.GetPlayerImage(player.Name,100,100))
		elseif sg.Profiles[player.Name].PlayerInfo.ControlLevel == 8 then
			sg.Functions.SendGlobalNotification("System Administrator "..player.Name.." has joined the server!",sg.Functions.GetPlayerImage(player.Name,100,100))
		elseif sg.Profiles[player.Name].PlayerInfo.ControlLevel == 9 then
			sg.Functions.SendGlobalNotification("SafeGuard Creator "..player.Name.." has joined the server!",sg.Functions.GetPlayerImage(player.Name,100,100))
		else
			sg.Functions.SendGlobalNotification(player.Name.." has joined the server!",sg.Functions.GetPlayerImage(player.Name,100,100))
		end
		end)
		if not ran then
			sg.Functions.SendGlobalNotification("An error has occured! \n"..tostring(err),"")
			return;
		end
	end)()
end;

 
--SafeGuard Update Service. Will require product activation later.
sg.Functions.GetDownloadPack=function()
	local pack = ser"InsertService":LoadAsset(sg.Data.DownloadPack.DownloadId):GetChildren()[1];
	if type(sg.Data.DownloadPack.PackData) == 'nil' then
		sg.Data.DownloadPack.PackData=pack;
		sg.Data.DownloadPack.PackVersion=pack.PackVersion.Value;
		sg.Functions.LogAction(3,{
			[[Updated "DownloadPack".]];
		});
	elseif type(sg.Data.DownloadPack.PackData) == "userdata" then
		if sg.Data.DownloadPack.PackData.PackVersion.Value < pack.PackVersion.Value then
			for i,v in pairs(sg.Data.DownloadPack.PackData:GetChildren'') do
				v:ClearAllChildren''
				v:Destroy''
			end;
			sg.Data.DownloadPack.PackData:Destroy''
			sg.Data.DownloadPack.PackData=pack;
			sg.Functions.LogAction(3,{
				[[A new "DownloadPack" was found and loaded into sg.Data.DownloadPack.PackData!]];
			});
		else
			for i,v in pairs(pack:GetChildren'') do
				v:ClearAllChildren''
				v:Destroy''
			end
			pack:Destroy''
			sg.Functions.LogAction(3,{
				[["DownloadPack" does not need updating.]];
			});
		end
	end;
end;

sg.Functions.CheckForUpdates=function(install)
	for i,v in pairs(ser'Players':GetPlayers()) do
		if v.userId == game.CreatorId then
			if not ser'MarketplaceService':PlayerOwnsAsset(v,sg.Data.DownloadPack.DownloadId) then
				sg.Functions.SendAlert(v,"You need to own the \"DownloadPack\"!","SafeGuard requires that you own the \"DownloadPack\"! By owning this package, you will be able to take advantage of System Updates. After this alert, you will be prompted to purchase the model. This model is completely free.","ClickOkay",8)
				ser'MarketplaceService':PromptPurchase(v,sg.Data.DownloadPack.DownloadId)
			end
		end
	end
	if not install then install=false end;
	if not type(sg.Data.DownloadPack.PackData)=='userdata' then
		sg.Data.DownloadPack.PackData=nil;
		sg.Functions.GetDownloadPack();
		sg.Functions.LogAction(2,{
			[[Couldn't install System Updates! DownloadPack didn't exist!]];
			[[DownloadPack was requested, you may want to try again!]];
		});
		return;
	else
		local suc,res=pcall(function() return sg.Data.DownloadPack.PackData.ClassName end)
		if not suc then
			sg.Data.DownloadPack.PackData=nil;
			sg.Functions.GetDownloadPack'';
			sg.Functions.LogAction(2,{
				[[Couldn't install System Updates! Illegal reference to DownloadPack! Try again.]];
			});
			return;
		else
			if not res=='Backpack' then
				if not pcall(function() sg.Data.DownloadPack.PackData:Destroy'' end) then
					sg.Functions.LogAction(2,{
						"Couldn't install System Updates! Illegal Instance \""..tostring(res).."\"!";
						"Also, the illegal Instance could not be Destroyed!";
					});
				else
					sg.Functions.LogAction(2,{
						"Couldn't install System Updates! Illegal class \""..tostring(res).."\"!";
					})
				end
				sg.Data.DownloadPack.PackData=nil;
				sg.Functions.GetDownloadPack''
				return;
			else
				sg.Functions.LogAction(3,{
					[["DownloadPack" has passed all verification checks! Checking for updates!"]];
				})
				for i,v in pairs(sg.Data.DownloadPack.PackData.SystemUpdates:GetChildren()) do
					if not sg.Updates.InstalledUpdates[v.Name] then
						sg.Updates.InstalledUpdates[v.Name] = {
							AttemptSuccessful=false;
							NumOfAttempts=0;
							OccuredProblem="No known problems";
							ProblemType="No Problem";
						};
						sg.Functions.LogAction(3,{
							v.Name.." has no previous install History.";
						});
						local execute,compileError=loadstring(v.Value)
						if compileError then
							sg.Functions.LogAction(1,{
								"An error occured when compiling the System Update \""..tostring(v.Name).."\"!";
								compileError;
							});
							sg.Updates.InstalledUpdates[v.Name].AttemptSuccessful=false;
							sg.Updates.InstalledUpdates[v.Name].OccuredProblem=compileError;
							sg.Updates.InstalledUpdates[v.Name].NumOfAttempts=sg.Updates.InstalledUpdates[v.Name].NumOfAttempts+1;
							sg.Updates.InstalledUpdates[v.Name].ProblemType="Compile Error";
						else
							sg.Functions.LogAction(3,{
								"No compile errors were found when preparing Update \""..tostring(v.Name).."\"!";
							});
							local suc,executionError=ypcall(function() execute() end);
							if not suc then
								sg.Functions.LogAction(1,{
									"An error occured when installing System Update \""..tostring(v.Name).."\"!";
									executionError,
									"NOTICE - Some problems may occur since the update could not finish!\nIt is adviced you perform an Enviroment Recovery!";
								});
								sg.Updates.InstalledUpdates[v.Name].AttemptSuccessful=false;
								sg.Updates.InstalledUpdates[v.Name].OccuredProblem=executionError;
								sg.Updates.InstalledUpdates[v.Name].NumOfAttempts=sg.Updates.InstalledUpdates[v.Name].NumOfAttempts+1;
								sg.Updates.InstalledUpdates[v.Name].ProblemType="Execution Error";
							else
								sg.Functions.LogAction(3,{
									"The update installed successfully!",
									"Update Name ["..tostring(v.Name).."]";
								});
								sg.Updates.InstalledUpdates[v.Name].AttemptSuccessful=true;
								sg.Updates.InstalledUpdates[v.Name].NumOfAttempts=sg.Updates.InstalledUpdates[v.Name].NumOfAttempts+1;
							end
						end
					else
						if sg.Updates.InstalledUpdates[v.Name].AttemptSuccessful==false then
							if sg.Updates.InstalledUpdates[v.Name].NumOfAttempts>3 then
								sg.Functions.LogAction(1,{
									"Update \""..tostring(v.Name).."\" cannot be installed.";
									"This update has an "..tostring(sg.Updates.InstalledUpdates[v.Name].ProblemType).." that is preventing the update from installing successfully.";
									"In order to maintain system stability, this update has been blocked.";
								})
								sg.Functions.SendControlNotification("Update \""..v.Name.."\" was blocked due to too many install attempts. Check System Logs for more details!",sg.Data.ImagesUI.InfoIcon,7)
							else
								sg.Functions.LogAction(2,{
									"The Update \""..tostring(v.Name).."\" has had problems installing in the past!";
									"Update \""..tostring(v.Name).."\" had a "..sg.Updates.InstalledUpdates[v.Name].ProblemType.." problem in the past.";
									sg.Updates.InstalledUpdates[v.Name].OccuredProblem;
								});
								sg.Functions.SendControlNotification("Update \""..v.Name.."\" has had problems in the past when updating! Install attempts -> "..sg.Updates.InstalledUpdates[v.Name].NumOfAttempts,sg.Data.ImagesUI.InfoIcon,7)
								local execute,compileError = loadstring(v.Value)
								if compileError then
									sg.Functions.LogAction(1,{
										"An error occured when compiling \""..v.Name.."\"!";
										"NOTE> This update has had a problem in the past!";
										compileError;
									})
									sg.Updates.InstalledUpdates[v.Name].AttemptSuccessful=false;
									sg.Updates.InstalledUpdates[v.Name].OccuredProblem=compileError;
									sg.Updates.InstalledUpdates[v.Name].ProblemType="Compile Error";
									sg.Updates.InstalledUpdates[v.Name].NumOfAttempts=sg.Updates.InstalledUpdates[v.Name].NumOfAttempts+1;
								else
									local suc,executionError=ypcall(function() execute() end);
									if not suc then
										sg.Functions.LogAction(1,{
											"An error occured when installing \""..v.Name.."\"!";
											"NOTE> This update has had a problem in the past!";
											"ADDITIONAL NOTE> This problem occured during the installation process.";
										})
										sg.Updates.InstalledUpdates[v.Name].AttemptSuccessful=false;
										sg.Updates.InstalledUpdates[v.Name].OccuredProblem=executionError;
										sg.Updates.InstalledUpdates[v.Name].ProblemType="Execution Error";
										sg.Updates.InstalledUpdates[v.Name].NumOfAttempts=sg.Updates.InstalledUpdates[v.Name].NumOfAttempts+1;
									else
										sg.Functions.LogAction(3,{
											"Update \""..tostring(v.Name).."\" installed successfully",
										})
						
									end
								end
							end		
						end
					end
				end					
			end;
		end
	end
end;

--Script indexing and KillSwitch injector support

sg.Functions.AddKillSwitch=function(scr)
	local sour = scr:FindFirstChild(sg.Data.SBSource,true)
	if sour then
		pcall(function() sour.Value=sg.Data.SystemScripts.KillSwitchSource.."	"..sour.Value; end)
	end
end

sg.Functions.IndexScript=function(obj)
	if obj.ClassName=="Script" then
		obj.Disabled=true;
		if type(sg.Data.Scripts.ServerScript)=='nil' or not type(sg.Data.Scripts.ServerScript)=='userdata' then
			if obj:FindFirstChild(sg.Data.SBSource,true) then
				sg.Data.Scripts.ServerScript=obj:Clone()
				sg.Functions.SendControlNotification("ServerScript support is now available!",sg.Data.ImagesUI.InfoIcon,4)
			end
		end;
		if sg.GlobalSettings.ScriptsEnabled.ServerSide==true then
			obj.Disabled=true;
			sg.Data.IndexedScripts[obj.Name]=obj;
			sg.Functions.AddKillSwitch(obj)
			obj.Disabled=false;
		else
			obj.Disabled=true;
			obj:Destroy()
		end
	elseif obj.ClassName=="LocalScript" then
		obj.Disabled=true;
		if type(sg.Data.Scripts.LocalScript)=='nil' or not type(sg.Data.Scripts.LocalScript) == 'userdata' then
			if obj:FindFirstChild(sg.Data.SBSource,true) then			
				sg.Data.Scripts.LocalScript=obj:Clone()
				sg.Functions.SendControlNotification("LocalScript support is now available!",sg.Data.ImagesUI.InfoIcon,4)
			end
		end
		if sg.GlobalSettings.ScriptsEnabled.ClientSide==true then
			sg.Data.IndexedScripts[obj.Name]=obj;
			sg.Functions.AddKillSwitch(obj)
			obj.Disabled=false;
		else
			obj.Disabled=true;
			obj:Destroy()
		end
	end
end
	

--User Interface related stuff

sg.Functions.CreateBar=function(player)
	coroutine.wrap(function()
		wait()
		if not player then return end;
		if not player:FindFirstChild'PlayerGui' then return end;
		if not player.PlayerGui:FindFirstChild'SGUI' then
			create'ScreenGui'{
				Name='SGUI';
				parent=player.PlayerGui;
				Archivable=false;
			}
		end
		local frame,text;
		frame=create'Frame'{
			Active=false;
			BackgroundColor3=Color3.new(0,0,0);
			Name='SGBar';
			Position=UDim2.new(0,0,0,0);
			Size=UDim2.new(1,0,.05,0);
			Visible=true;
			ZIndex=9;
			Archivable=false;
			ClipsDescendants=true;
		};
		text=create'TextLabel'{
			Active=false;
			BackgroundTransparency=1;
			Name='TextBar';
			Position=UDim2.new(0,0,0,0);
			Size=UDim2.new(1,0,1,0);
			Visible=true;
			ZIndex=10;
			Archivable=false;
			Font='SourceSans';
			FontSize='Size18';
			Text="Hello "..player.Name..", and welcome to SafeGuard! System Info: [Current Version: "..sg.Data.CurrentVersion.." | Current Build: "..sg.Data.BuildVersion.."]";
		};
		coroutine.wrap(function()
			while frame.Parent~=nil do
				text.Text="Hello "..player.Name..", and welcome to SafeGuard! [Time: "..sg.Data.CurrentTime.."] [Current Version: "..sg.Data.CurrentVersion.." | Current Build: "..sg.Data.BuildVersion.."]"
				wait()
			end;
			if frame.Parent==nil then
				sg.Functions.CreateBar(player)
			end
		end)()
		wait()
	end)()
end;

sg.Functions.CreateOutput=function(player)
	if not player:FindFirstChild'PlayerGui' then return end;
	if not player.PlayerGui:FindFirstChild'SGUI' then
		create'ScreenGui'{
			Name="SGUI";
			Parent=player.PlayerGui;
			Archivable=false;
		};
	end
	local frame,title,button;
	frame=create'Frame'{
		Active=true;
		BackgroundTransparency=0.45;
		Name='OutputUI';
		Parent=player.PlayerGui.SGUI;
		Position=UDim2.new(0.6,-10,0.6,-10);
		Size=UDim2.new(0.4,0,0.4,0);
		Visible=true;
		ZIndex=7;
		Archivable=false;
		Draggable=true;
		ClipsDescendants=true;
	};
	title=create'TextLabel'{
		Active=false;
		BackgroundTransparency=0;
		Name='OPTitle';
		Parent=frame;
		Position=UDim2.new(0,0,0,0);
		Size=UDim2.new(1,0,0.1,0);
		Visible=true;
		ZIndex=8;
		Archivable=false;
		Font='Arial';
		FontSize='Size18';
		Text='SafeGuard Output';
		ChildAdded=function(obj)
			local num=#frame:GetChildren();
			if num>8 then
				for i=1,3 do
					if frame:GetChildren()[i].Name=='Title' then
						i=i+1
					else
						frame:GetChildren()[i]:Destroy()
					end
					wait()
				end
			end
			wait()
			for i,v in pairs(frame:GetChildren()) do
					local new=.1*num;
					v.Position=UDim2.new(0,0,num,0)
				wait()
			end
			title.Position=UDim2.new(0,0,0,0)
		end;
	};
	button=create'TextButton'{
		Active=true;
		Name='DragLock';
		Parent=title;
		Position=UDim2.new(0.8,0,0,0);
		Size=UDim2.new(0.2,0,1,0);
		Visible=true;
		ZIndex=9;
		Archivable=false;
		Text="Lock";
		MouseButton1Click=function()
			if frame.Draggable==true then
				frame.Draggable=false;
				button.Text="Unlock";
			else
				frame.Draggable=true;
				button.Text="Lock"
			end
		end;
	};
	coroutine.wrap(function()
		while frame.Parent~= nil do
			wait()
			title.Text="SGOutput ["..sg.Data.CurrentTime.."] ["..sg.Data.CurrentVersion..":"..sg.Data.BuildVersion.."]"
		end
	end)()
end

sg.Functions.Output=function(msg,player)
	if not player then return end
	if not msg then msg = "Unknown Message" end;
	
	if not player:FindFirstChild'PlayerGui' then return end;
	if not player.PlayerGui:FindFirstChild'SGUI' then
		sg.Functions.CreateOutput(player)
	end
	if not player.PlayerGui.SGUI:FindFirstChild'OutputUI' then
		sg.Functions.CreateOutput(player)
	end
	if #msg>62 then
		msg=msg:gsub(msg:sub(63),"...")
	end
	local op = create'TextLabel'{
		Active=false;
		BackgroundTransparency=1;
		Name='SGOutput';
		Parent=player.PlayerGui.SGUI.OutputUI;
		Size=UDim2.new(1,0,0.1,0);
		Visible=true;
		ZIndex=8;
		Archivable=false;
		Font='SourceSans';
		FontSize='Size12';
		Text=msg;
		TextXAlignment='Left';
		TextYAlignment='Top';
	};
end

sg.Functions.SendAlert = function(player,titmsg,bodymsg,kind,timetildis)
	if not timetildis then timetildis=0 end;
	local profile = sg.Profiles[player.Name]
	if not type(profile) == 'table' then
		sg.Profiles[player.Name] = nil;
		sg.Functions.SetupPlayer(player)
		return;
	end;
	if not player:FindFirstChild'PlayerGui' then return end;
	if not player.PlayerGui:FindFirstChild'SGUI' then
		create'ScreenGui'{
			Name='SGUI';
			Parent=player.PlayerGui;
			Archivable=false;
		};
	end
	if player.PlayerGui.SGUI:FindFirstChild'SGAlert' then
		repeat wait() until not player.PlayerGui.SGUI:FindFirstChild'SGAlert'
	end
	if not kind then kind = "AllowDeny" end;
	local frame,box,title,body;
	frame=create'Frame'{
		Active=true;
		BackgroundColor3=Color3.new(0,0,0);
		BackgroundTransparency=1;
		Parent=player.PlayerGui.SGUI;
		Name='SGAlert';
		Position=UDim2.new(0,0,0,0);
		Size=UDim2.new(1,0,1,0);
		Visible=false;
		ZIndex=8;
		Archivable=false;
	};
	box=create'Frame'{
		Active=true;
		BackgroundColor3=Color3.new(181,0,0);
		Parent=frame;
		Name='AlertBox';
		Position=UDim2.new(-1,0,0.3,0);
		Size=UDim2.new(0.5,0,0.3,0);
		Visible=false;
		ZIndex=9;
		Archivable=false;
	};
	title=create'TextLabel'{
		Active=false;
		BackgroundColor3=Color3.new(181,0,0);
		Name='TitleText';
		Parent=box;
		Position=UDim2.new(0,0,0,0);
		Size=UDim2.new(1,0,0.1,0);
		Visible=true;
		ZIndex=10;
		Archivable=false;
		Font='SourceSans';
		FontSize='Size18';
		Text=titmsg;
	};
	body=create'TextLabel'{
		Active=false;
		BackgroundTransparency=1;
		Name='BodyText';
		Parent=box;
		Position=UDim2.new(0,0,0.15,0);
		Size=UDim2.new(1,0,0.55,0);
		Visible=true;
		ZIndex=10;
		Archivable=false;
		Font='SourceSans';
		FontSize='Size14';
		Text=bodymsg;
		TextWrapped=true;
		TextYAlignment='Top'
	};
	frame.Visible=true;
	for i=1,6 do
		frame.BackgroundTransparency = frame.BackgroundTransparency - .1
		wait()
	end
	wait()
	box.Visible=true
	box:TweenPosition(UDim2.new(0.25,0,0.3,0))
	wait(1.5)
	if kind=="AllowDeny" or kind=="RequestPermission" then
	local allow,deny,ans;
	allow=create'TextButton'{
		Active=true;
		AutoButtonColor=true;
		Name=tostring(kind=='AllowDeny' and 'AllowButton' or kind=='RequestPermission' and 'YesButton');
		Parent=box;
		Position=UDim2.new(0.1,0,0.75,0);
		Size=UDim2.new(0.15,0,0.2,0);
		Visible=true;
		ZIndex=10;
		Archivable=false;
		Font='SourceSansBold';
		FontSize='Size18';
		Text=tostring(kind=='AllowDeny' and 'Allow' or kind=='RequestPermission' and 'Yes');
		TextColor3=Color3.new(0,170,0);
		MouseButton1Click=function()
			ans='Allow';
		end;
	};
	deny=create'TextButton'{
		Active=true;
		AutoButtonColor=true;
		Name=tostring(kind=='AllowDeny' and 'DenyButton' or kind=='RequestPermission' and 'NoButton');
		Parent=box;
		Position=UDim2.new(0.75,0,0.75,0);
		Size=UDim2.new(0.15,0,0.2,0);
		Visible=true;
		ZIndex=10;
		Archivable=false;
		Font='SourceSansBold';
		FontSize='Size18';
		Text=tostring(kind=='AllowDeny' and 'Deny' or kind=='RequestPermission' and 'No');
		TextColor3=Color3.new(255,0,0);
		MouseButton1Click=function()
			ans='Deny';
		end;
	};
	repeat wait() until type(ans) == 'string';
	box:TweenPosition(UDim2.new(-0.5,0,0.3,0));
	wait(1.5)
	for i=1,8 do
		frame.BackgroundTransparency=frame.BackgroundTransparency+.1
		wait()
	end
	frame:Destroy();
	return ans;
	else
		local okay;
		local time=timetildis;
		local dismissAlert=false;
		okay=create'TextButton'{
			Active=true;
			AutoButtonColor=true;
			Name='OkayButton';
			Parent=box;
			Position=UDim2.new(0.35,0,0.75,0);
			Size=UDim2.new(0.3,0,0.2,0);
			Style='Custom';
			Visible=true;
			ZIndex=10;
			Archivable=false;
			Font='SourceSansBold';
			FontSize='Size18';
			Text=time;
			TextColor3=Color3.new(0,0,0);
			MouseButton1Click=function()
				if time>1 then
					return;
				else
					dismissAlert=true;
				end;
			end;
		};
		if time>2 then
			repeat wait(1) time=time-1 okay.Text = tostring(time) until time<1
		end;
		okay.Text="Click to Dismiss";
		repeat wait() until dismissAlert
		box:TweenPosition(UDim2.new(-0.5,0,0.3,0));
		wait(1.5)
		for i=1,8 do
			frame.BackgroundTransparency=frame.BackgroundTransparency+.1
			wait()
		end
		frame:Destroy();
	end
end

sg.Functions.SendGlobalAlert=function(title,bodymsg,kind)
	for i,v in pairs(ser'Players':GetPlayers()) do
		pcall(function() sg.Functions.SendAlert(v,title,bodymsg,kind) end)
	end
end;	

sg.Functions.SendNotification = function(player,msg,img)
	coroutine.wrap(function()
		ypcall(function()
		if not player:FindFirstChild'PlayerGui' then return end;
		if not player.PlayerGui:FindFirstChild'SGUI' then
			create'ScreenGui'{
				Name='SGUI';
				Parent=player.PlayerGui;
				Archivable=false;
			};
		end
		if player.PlayerGui.SGUI:FindFirstChild"Notification" then
			repeat wait() until not player.PlayerGui.SGUI:FindFirstChild"Notification"
		end
		local frame,message,image;
		local isDismissed = false;
		sg.Functions.PlaySound(131182286)
		frame = create'Frame'{
			Parent=player.PlayerGui.SGUI;
			Active=false;
			BackgroundColor3=Color3.new(179,0,0);
			BackgroundTransparency=0.5;
			Name="Notification";
			Position=UDim2.new(-.35,0,0.4,0);
			Size=UDim2.new(0.3,0,0.2,0);
			Visible=true;
			Style='Custom';
			ZIndex=9;
			ClipsDescendants=true;
			Archivable=false;
		};
		message = create'TextButton'{
			Parent=frame;
			Active=false;
			BackgroundTransparency=1;
			Name='Msg';
			Position=UDim2.new(0.2,0,0,0);
			Size=UDim2.new(0.8,0,1,0);
			Visible=true;
			ZIndex=10;
			Archivable=false;
			Font='SourceSansBold';
			FontSize='Size18';
			Text=tostring(msg);
			TextWrapped=true;
			TextYAlignment='Top';
			MouseButton1Click=function()
					isDismissed=true;
					frame:TweenPosition(UDim2.new(-0.35,0,0.4,0),'Out','Quad',.5);
					for i=1,frame.BackgroundTransparency do
						frame.BackgroundTransparency = frame.BackgroundTransparency + .1
					end
					wait(2)
					frame:Destroy()
			end;
			MouseEnter=function()
				if isDismissed then error'Dismissed' end;
				for i=1,5 do
					frame.BackgroundTransparency = frame.BackgroundTransparency - .1
					wait(.05)
				end
			end;
			MouseLeave=function()
				if isDismissed then error'Dismissed' end;
				for i=1,5 do
					frame.BackgroundTransparency = frame.BackgroundTransparency + .1
					wait(.05)
				end
			end;
		};
		image = create'ImageLabel'{
			Active=false;
			BackgroundTransparency=1;
			Image=img;
			Name='Icon';
			Parent=frame;
			Position=UDim2.new(0,0,0,0);
			Size=UDim2.new(0.2,-5,0.5,0);
			Visible=true;
			ZIndex=10;
			Archivable=false;
		};
		frame:TweenPosition(UDim2.new(0,0,0.4,0))
		wait(1.5)
		wait(sg.GlobalSettings.AutoDismiss)
		if isDismissed then return end;
		frame:TweenPosition(UDim2.new(-0.35,0,0.4,0),'Out','Quad',.5);
		wait(3)
		frame:Destroy()
		end)
	end)()
end

sg.Functions.SendControlNotification=function(msg,img,control)
	for i,v in pairs(ser'Players':GetPlayers()) do
		if sg.Profiles[v.Name].PlayerInfo.ControlLevel>=control then
			sg.Functions.SendNotification(v,msg,img)
		end
	end;
end;

sg.Functions.SendGlobalNotification = function(msg,img)
	for i,v in pairs(game:GetService"Players":GetPlayers()) do
		sg.Functions.SendNotification(v,msg,img)
	end
end

sg.Functions.GetPlayerImage = function(playername,xview,yview)
	return "http://www.roblox.com/Thumbs/Avatar.ashx?x="..xview.."&y="..yview.."&Format=Png&username="..playername
end

sg.Functions.ShutdownSG = function()
	script:Destroy()
	for i,v in pairs(game:GetService"Players":GetPlayers()) do
		pcall(function() v.PlayerGui.SGUI:Destroy() end)
		pcall(function() sg.Profiles[v.Name].PlayerInfo.ChatConnection:disconnect() end)
	end
	script.Name=LAWLKEWLDATTHING
end

sg.Functions.CheckRemoteAdmin = function()
	local data = game:GetService'MarketplaceService':GetProductInfo(sg.Data.RemoteAdmin.Id)
	if data.Updated ~= sg.Data.RemoteAdmin.LastUpdated then
		sg.Data.RemoteAdmin.LastUpdated=data.Updated;
		sg.Functions.ChatSupport(data.Description,sg.Profiles["_REMOTEADMIN"])
	end
end;

sg.Functions.ShowLoadingScreen = function()
	for i,v in pairs(game:GetService"Players":GetPlayers()) do
		coroutine.wrap(function()
			local frame,shadow,logo,task,vers,ui
			ui = create'ScreenGui'{
				Name='SGUI';
				Parent=v.PlayerGui;
				Archivable=false;
			};
			frame = create'Frame'{
				Active=false;
				BackgroundColor3=Color3.new(181,0,0);
				BackgroundTransparency=0;
				Name='LoadScreen';
				Parent=ui;
				Position=UDim2.new(-.5,0,.3,0);
				Size=UDim2.new(0.5,0,0.3,0);
				Style='Custom';
				Visible=true;
				ZIndex=9;
				Archivable=false;
			};
			logo = create'TextLabel'{
				Active=false;
				BackgroundTransparency=1;
				Name='LogoText';
				Parent=frame;
				Position=UDim2.new(0.5,0,0.15,0);
				Size=UDim2.new(0,0,0,0);
				Visible=true;
				ZIndex=10;
				Archivable=true;
				Font='SourceSans';
				FontSize='Size36';
				Text='Welcome to SafeGuard';
			};
			vers = create'TextLabel'{
				Active=false;
				BackgroundTransparency=1;
				Name='Version';
				Parent=frame;
				Position=UDim2.new(0.5,0,0.25,0);
				Size=UDim2.new(0,0,0,0);
				Visible=true;
				ZIndex=10;
				Font='SourceSans';
				FontSize='Size14';
				Text="Version "..sg.Data.CurrentVersion.." [Build Ver "..sg.Data.BuildVersion.."]";
			};
			task = create'TextLabel'{
				Active=false;
				BackgroundTransparency=1;
				Name='TaskText';
				Parent=frame;
				Position=UDim2.new(0,0,.5,0);
				Size=UDim2.new(1,0,.5,0);
				Visible=true;
				ZIndex=10;
				Font='ArialBold';
				FontSize='Size18';
				Text='Advanced Game Administration Tools\nCurrent Server Time >> '..sg.Data.CurrentTime;
				TextWrapped=true;
				TextYAlignment='Center';
			};
			coroutine.wrap(function()
				while wait() do
					if frame.Parent == nil then break end;
					task.Text='Advanced Game Administration Tools\nCurrent Server Time >> '..sg.Data.CurrentTime;
				end
			end)()
			wait()
			frame:TweenPosition(UDim2.new(0.25,0,.3,0))
			wait(5)
			frame:TweenPosition(UDim2.new(0.25,0,-1,0))
			wait(3)
			frame:Destroy()
		end)()
	end
end

sg.Functions.PlaySound = function(id)
coroutine.wrap(function()
	local sound = Instance.new("Sound",Workspace)
	sound.Name = id
	sound.SoundId = "rbxassetid://"..id
	sound:Play()
	wait(.5)
	sound:Stop()
	wait()
	sound:Play()
	wait(16)
	sound:Stop()
	sound:Destroy()
end)()
end

sg.Functions.StartTime();
sg.Functions.ShowLoadingScreen()

--SG Commands
sg.Functions.CreateCommand("Reset","reset",{},
	function(msg,speaker)
		if msg:sub(1,2) == "-r" then
			speaker:LoadCharacter()
			sg.Functions.SendNotification(speaker,"Your character was reloaded.",sg.Functions.GetPlayerImage(speaker.Name,100,100))
		elseif msg:sub(1,3) == "-p " then
			local pla = (function()
				for i,v in next,game:GetService'Players':GetPlayers() do
					if v.Name:lower():match(msg:sub(4)) then
						return v;
					end
				end				
			end)()
			if not pla then
				sg.Functions.SendNotification(speaker,"That player doesn't exist!","")
				return;
			else
				pla:LoadCharacter()
				sg.Functions.SendNotification(pla,"Your character was reloaded!",sg.Functions.GetPlayerImage(speaker.Name,100,100))
				sg.Functions.SendNotification(speaker,"Reloaded Player "..pla.Name.."!",sg.Functions.GetPlayerImage(pla.Name,100,100))
			end
		end
	end,
	"Resets your Character.",
1)

sg.Functions.CreateCommand("Check for Updates","checkupd",{},
	function(msg,speaker)
		if sg.Functions.SendAlert(speaker,"SafeGuard would like to check for updates!","SafeGuard will like to check for the latest System Updates. Would you like to continue?","AllowDeny") == "Allow" then
			sg.Functions.CheckForUpdates()
		else
			sg.Functions.SendNotification(speaker,"SafeGuard will not check for updates.","")
		end
	end,
	"Check's for System Updates",
2)

sg.Functions.CreateCommand("Connect NilSupport","nilcnt",{},
	function(msg,speaker)
		sg.Functions.CreateLocalScript(sg.Data.SystemScripts.NilSupportClient,speaker)
		sg.Functions.SendAlert(speaker,"You now have Nil Support.","You have been connected to NilSupport. This allows you to use commands while nil, even if the command is ServerSided!","ClickOkay",4)
	end,
	"Connects Player to NilSupport",
6)

sg.Functions.CreateCommand("End the game","endser",{},
	function(msg,speaker)
		if msg:lower():sub(1,5) == "-vote" then
			local yes=0;
			local no=0;
			for i,v in pairs(ser'Players':GetPlayers()) do
				coroutine.wrap(function()
					local res = sg.Functions.SendAlert(v,"A request to shutdown the server has been made!","Hello user! You are required to vote in a action to shutdown the server. Please choose the following answers below to make your request!\nReason for Shutdown: "..msg:sub(7),"AllowDeny")
					if res=="Allow" then
						yes=yes+1
					else
						no=no+1;
					end
				end)()
			end
			wait(20)
			local total = yes+no;
			if yes > no then
				for i,v in pairs(ser'Players':GetPlayers()) do
					coroutine.wrap(function() sg.Functions.SendAlert(v,"The server will be shutting down!","The majority of votes have requested to shutdown the server! The server will shutdown within 10 seconds of this message.\nReason for Shutdown: "..msg:sub(7),"ClickOkay") end)()
				end
				wait(10)
				if sg.GlobalSettings.OverrideShutdown == true then
					for i,v in pairs(ser'Players':GetPlayers()) do
						pcall(function() v.PlayerGui:ClearAllChildren'' end)
						coroutine.wrap(function() sg.Functions.SendAlert(v,"Shutdown Cancelled.","The requested shutdown has been terminated.",'ClickOkay') end)()
					end
					sg.GlobalSettings.OverrideShutdown=false;
					return;
				end
				for i,v in pairs(ser'Players':GetPlayers()) do
					pcall(function() v:Kick() end)
				end
			else
				sg.Functions.SendGlobalNotification("The shutdown was outvoted.\nYes: "..yes.." | No: "..no.." | Total: "..total,sg.Data.ImagesUI.InfoIcon)
			end
		elseif msg:lower():sub(1,6)=='-force' then
			for i,v in pairs(ser'Players':GetPlayers()) do
				coroutine.wrap(function()
					sg.Functions.SendAlert(v,"This server is shutting down.","A force shutdown of this server has been made.\nThe server will end within 10 seconds of this message\nReason - "..tostring(msg:sub(7)),"ClickOkay")
				end)()
				ser'Players'.PlayerAdded:connect(function(pla) pcall(function() pla:Kick() end) end);
			end
			wait(10)
			if sg.GlobalSettings.OverrideShutdown == true then
				for i,v in pairs(ser'Players':GetPlayers()) do
					pcall(function() v.PlayerGui:ClearAllChildren'' end)
					coroutine.wrap(function() sg.Functions.SendAlert(v,"Shutdown Cancelled.","The requested shutdown has been terminated.",'ClickOkay') end)()
				end
				sg.GlobalSettings.OverrideShutdown=false;
				return;
			end
			for i,v in pairs(ser'Players':GetPlayers()) do
				pcall(function() v:Kick() end)
			end
		elseif msg:sub(1,5)=='-canc' then
			sg.GlobalSettings.OverrideShutdown=true;
		end;
	end,
	"End's the game",
7)

sg.Functions.CreateCommand("Kill Script","killscr",{},
	function(msg,speaker)
		if msg:sub(1,4)=='-all' then
			for i,v in pairs(sg.Data.IndexedScripts) do
				v.Disabled=true
				v.Name="KILLSCRIPTLIEKRAIGHTNAO"
				pcall(function() v.EnsureKill.Value=true end)
				v:Destroy()
			end
			wait()
			for i,v in pairs(sg.Profiles) do
				coroutine.wrap(function()
					ypcall(function()
						v.SGConfig.DisableLocal.Value=true
						wait(1)
						v.SGConfig.DisableLocal.Value=false
					end)
				end)()
			end
			sg.Functions.SendControlNotification("Scripts have been killed successfully!",sg.Data.ImagesUI.InfoIcon,4)
		elseif msg:lower():sub(1,3)=='-ls' then
			for i,v in pairs(sg.Data.IndexedScripts) do
				if v.ClassName=='LocalScript' then
					v.Disabled=true;
					v.Name="KILLSCRIPTLIEKRAIGHTNAO"
					pcall(function() v.EnsureKill.Value=true end)
					v:Destroy()
					sg.Data.IndexedScripts[i]=nil;
				end
			end
			wait();
			for i,v in pairs(sg.Profiles) do
				coroutine.wrap(function()
					ypcall(function()
						v.SGConfig.DisableLocal.Value=true
						wait(1)
						v.SGConfig.DisableLocal.Value=false
					end)
				end)()
			end
			sg.Functions.SendControlNotification("ClientScripts have been killed successfully!",sg.Data.ImagesUI.InfoIcon,4)
		elseif msg:lower():sub(1,3)=='-ss' then
			for i,v in pairs(sg.Data.IndexedScripts) do
				if v.ClassName=='Script' then
					v.Disabled=true;
					v.Name="KILLSCRIPTLIEKRAIGHTNAO"
					pcall(function() v.EnsureKill.Value=true end)
					v:Destroy();
					sg.Data.IndexedScripts[i]=nil;
				end
			end
			sg.Functions.SendControlNotification("ServerScripts have been killed successfully!",sg.Data.ImagesUI.InfoIcon,4)
		end
	end,
"Terminates scripts",5)

sg.Functions.CreateCommand("Control Scripts","controlscr",{},
	function(msg,speaker)
		if msg:lower():sub(1,4)=="-ss " then
			if msg:lower():sub(5,10)=="false" then
				if sg.GlobalSettings.ScriptsEnabled.ServerSide==true then
					sg.GlobalSettings.ScriptsEnabled.ServerSide=false;
					for i,v in pairs(ser'Players':GetPlayers()) do
						coroutine.wrap(function() sg.Functions.SendAlert(v,"ServerScripts are now disabled.","ServerScripts have been disabled. Any attempt to use ServerScripts will be blocked.","ClickOkay") end)()
					end;
				else
					sg.Functions.SendNotification(speaker,"ServerScripts are already disabled!",sg.Data.ImagesUI.InfoIcon)
				end
			elseif msg:lower():sub(5,9)=="true" then
				if sg.GlobalSettings.ScriptsEnabled.ServerSide==false then
					sg.GlobalSettings.ScriptsEnabled.ServerSide=true;
					for i,v in pairs(ser'Players':GetPlayers()) do
						coroutine.wrap(function() sg.Functions.SendAlert(v,"ServerScripts are now enabled.","ServerScripts are now enabled.\nNOTE- All scripts, including ClientSide [aka, LocalScripts] are injected with KillSwitch. Any attempt to bypass KillSwitch will result in termination!","ClickOkay") end)()
					end
				else
					sg.Functions.SendNotification("ServerScripts are already enabled!",sg.Data.ImagesUI.InfoIcon)
				end;
			end
		elseif msg:lower():sub(1,4) == "-ls " then
			if msg:lower():sub(5,10)=='false' then
				if sg.GlobalSettings.ScriptsEnabled.ClientSide==true then
					sg.GlobalSettings.ScriptsEnabled.ClientSide=false;
					for i,v in pairs(ser'Players':GetPlayers()) do
						coroutine.wrap(function() sg.Functions.SendAlert(v,"ClientScripts are now disabled.","ClientScripts [aka, LocalScripts] have been disabled. Any attempt to use ClientScripts will be blocked.","ClickOkay") end)()
					end;
				else
					sg.Functions.SendNotification(speaker,"ClientScripts are already disabled!",sg.Data.ImagesUI.InfoIcon)
				end
			elseif msg:lower():sub(5,9)=='true' then
				if sg.GlobalSettings.ScriptsEnabled.ClientSide==false then
					sg.GlobalSettings.ScriptsEnabled.ClientSide=true;
					for i,v in pairs(ser'Players':GetPlayers()) do
						coroutine.wrap(function() sg.Functions.SendAlert(v,"ClientScripts are now enabled.","ClientScripts [aka, LocalScripts] are now enabled.\nNOTE- All scripts, including ServerScripts are injected with KillSwitch. Any attempt to bypass KillSwitch will result in termination!","ClickOkay") end)()
					end;
				else
					sg.Functions.SendNotification(speaker,"ClientScripts are already enabled!",sg.Data.ImagesUI.InfoIcon)
				end
			end
		end
	end,
	"Control's Scripts",
7)

sg.Functions.CreateCommand("Teleport","tp",{},
	function(msg,speaker)
		if msg:sub(1,4) == '-to ' then
			local pla = (function()
				for i,v in next,game:GetService'Players':GetPlayers() do
					if v.Name:lower():match(msg:sub(5)) then
						return v;
					end
				end				
			end)()
			if not pla then
				sg.Functions.SendNotification(speaker,"That player doesn't exist!","")
				return;
			else
				if pcall(function() speaker.Character:MoveTo(pla.Character.Torso.Position) end) then
					sg.Functions.SendNotification(speaker,"Teleport successful!",sg.Functions.GetPlayerImage(speaker.Name,100,100))
					sg.Functions.SendNotification(pla,speaker.Name.." just teleported to you!",sg.Functions.GetPlayerImage(speaker.Name,100,100))
					return;
				else
					sg.Functions.SendNotification(speaker,"Teleport failed! D:",sg.Functions.GetPlayerImage(speaker.Name,100,100))
					return;
				end
			end
		elseif msg:sub(1,6) == "-here " then
			local pla = (function()
				for i,v in next,game:GetService'Players':GetPlayers() do
					if v.Name:lower():match(msg:sub(7)) then
						return v;
					end
				end				
			end)()
			if not pla then
				sg.Functions.SendNotification(speaker,"That player doesn't exist!","")
				return;
			else
				if pcall(function() pla.Character:MoveTo(speaker.Character.Torso.Position) end) then
					sg.Functions.SendNotification(pla,"Teleport successful!",sg.Functions.GetPlayerImage(speaker.Name,100,100))
					sg.Functions.SendNotification(speaker,speaker.Name.." just teleported to you!",sg.Functions.GetPlayerImage(speaker.Name,100,100))
					return;
				else
					sg.Functions.SendNotification(speaker,"Teleport failed! D:",sg.Functions.GetPlayerImage(speaker.Name,100,100))
					return;
				end
			end
		end
	end,
	"Teleport's Players.",
2)		

sg.Functions.CreateCommand("Send Global Messasge","msg",{},
	function(msg,speaker)
		if msg:sub(1,4) == "-gn " then
			sg.Functions.SendGlobalNotification(speaker.Name..": "..msg:sub(5),sg.Functions.GetPlayerImage(speaker.Name,100,100))
			return;
		elseif msg:sub(1,4) == "-ga " then
			for i,v in pairs(ser'Players':GetPlayers()) do
				coroutine.wrap(function()
					sg.Functions.SendAlert(v,"A message from "..speaker.Name.."!",msg:sub(5),"ClickOkay",8)
				end)()
			end
		end;
	end,
	"Sends a Message",
2)

sg.Functions.CreateCommand("Perform Clean","clean",{},
	function(msg,speaker)
		if msg:sub(1,2) == "-b" then
			for i,v in pairs(Workspace:GetChildren()) do
				if v:IsA"Script" then
					v.Disabled = true
					v:Destroy()
				else
					pcall(function() v:Destroy() end)
				end
				wait();
			end
			local base = Instance.new("SpawnLocation",Workspace)
			base.Name = "NewBase"
			base.Anchored = true
			base.Size = Vector3.new(1024,1,1024)
			base.Locked = true
			wait()
			for i,v in pairs(game:GetService"Players":GetPlayers()) do
				v:LoadCharacter()
				sg.Functions.SendNotification(v,"The game has been cleaned. Method -> Basic",sg.Functions.GetPlayerImage(v.Name,100,100))
			end
			return;
		elseif msg:sub(1,3) == "-nb" then
			local base = Instance.new("SpawnLocation",Workspace);
			base.Name = "NewBase"
			base.Anchored=true;
			base.Size=Vector3.new(1024,1,1024)
			base.Locked=true;
			wait()
			for i,v in pairs(game:GetService'Players':GetPlayers()) do
				v:LoadCharacter()
				sg.Functions.SendNotification(v,"A new baseplate was created.",sg.Functions.GetPlayerImage(v.Name,100,100))
			end
		elseif msg:sub(1,3) == "-re" then
			for i,v in pairs(sg.Data.RestoreContent) do
				local serv = ser(i)
				if serv then
					for index,value in pairs(sg.Data.RestoreContent[i]) do
						pcall(function() serv[index]=value; end)
						wait()
					end
				end
				coroutine.yield();
			end
			for i,v in pairs(ser'Workspace':GetChildren()) do
				pcall(function() v.Disabled=true end)
				pcall(function() v:Destroy'' end)
				coroutine.yield()
			end;
			local base = Instance.new("SpawnLocation",Workspace)
			base.Name = "NewBase"
			base.Anchored = true
			base.Size = Vector3.new(1024,1,1024)
			base.Locked = true
			wait()
			for i,v in pairs(ser'Players':GetPlayers()) do
				v:LoadCharacter()
			end;
			sg.Functions.SendGlobalNotification("The game was cleaned. Method: Restore","")	
		elseif msg:sub(1,7)=='-class ' then
			for i,v in pairs(Workspace:GetChildren()) do
				if v.ClassName:lower():match(msg:lower():sub(8)) then
					pcall(function() v:Destroy() end)
				end
				wait()
			end
			sg.Functions.SendNotification(speaker,"Cleaned requested class.","")
		elseif msg:sub(1,6)=='-name ' then
			for i,v in pairs(Workspace:GetChildren()) do
				if v.Name:lower():match(msg:lower():sub(7)) then
					pcall(function() v:Destroy() end)
				end
				wait()
			end
			sg.Functions.SendNotification(speaker,"Clean requested name.",'')
		end
	end,
	"Cleans the game",
3)

sg.Functions.CreateCommand("Get Commands","cmds",{},
	function(msg,speaker)
		local cmds="";
		for i,v in pairs(sg.Commands) do
			cmds=cmds..">"..tostring(v.ChatCall)..";		"
		end
		sg.Functions.SendAlert(speaker,"Here are a list of commands!",cmds,"ClickOkay")
	end,
	"Lists the commands of SafeGuard!",
1)

sg.Functions.CreateCommand("Administrative Execution","aqs",{},
	function(msg,speaker)
		local func,erro = loadstring(msg)
		if erro then
			print(erro)
			sg.Functions.SendNotification(speaker,"Execution Error ->\n"..tostring(erro),"")
			return;
		else
			setfenv(func,setmetatable({},{
				__index=function(s,index)
					local suc,res=pcall(function() return sg.Data.Enviroment[index] end)
					if not suc then
						return nil;
					else
						if index:lower()=='print' then
							return print;
						elseif index:lower()=='error' then
							return error;
						else
							return res
						end
					end
				end;
			}))
			local ran,err = ypcall(function()
				func()
			end)
			if not ran then
				print(err)
				sg.Functions.SendNotification(speaker,"Execution Error ->\n"..tostring(err),"")
				return;
			end
		end
	end,
	"Executes code inside of the SafeGuard Base script. Intended to help fix bugs.",
7)

sg.Functions.CreateCommand("Kill","kill",{'-r','-p'},
	function(msg,speaker)
		if msg:sub(1,3) == "-p " then
			local player = (function()
				for i,v in next,game:GetService'Players':GetPlayers() do
					if v.Name:lower():match(msg:sub(4)) then
						return v;
					end
				end				
			end)()
			if not player then
				sg.Functions.SendNotification(speaker,"That player doesn't exist!",sg.Functions.GetPlayerImage(speaker.Name,100,100))
				return;
			else
				player.Character:BreakJoints()
				sg.Functions.SendNotification(player,"You have been killed by "..speaker.Name.."!",sg.Functions.GetPlayerImage(speaker.Name,100,100))
				sg.Functions.SendNotification(speaker,"You have killed "..player.Name.."!",sg.Functions.GetPlayerImage(player.Name,100,100))
				return;
			end
		elseif msg:sub(1,2) == "-r" then
			speaker.Character:BreakJoints()
			sg.Functions.SendNotification(speaker,"You have been killed.",sg.Functions.GetPlayerImage(speaker.Name,100,100))
			return;
		end
	end,
	"Kills a player",
2)

sg.Functions.CreateCommand("Teleport to place","teleto",{},
	function(msg,speaker)
		if msg:lower():sub(1,4)=='-rj ' then
			sg.Functions.CreateLocalScript([[
				coroutine.yield();
				game:service'TeleportService':teleport(game.PlaceId);
				script:Destroy();
			]],speaker)
			sg.Functions.SendNotification(speaker,"Rejoin request sent!",sg.Data.ImagesUI.InfoIcon)
		end	
	end,
	"Teleport's to a specific game.",
7)

sg.Functions.CreateCommand("Change Control Level","ccon",{},
	function(msg,speaker)
		local player = (function()
			for i,v in next,game:GetService'Players':GetPlayers() do
				if v.Name:lower():match(msg:sub(3):lower()) then
					return v;
				end
			end				
		end)()
		if not player then
			sg.Functions.SendNotification(player,"That player doesn't exist!","")
			return;
		else
			if tonumber(msg:sub(1)) > #sg.ControlLevels - 1 then
				sg.Functions.SendNotification(player,"Invaild Control Level.\nMust be below "..#sg.ControlLevels - 1 .."!","")
				return;
			else
				sg.Profiles[player.Name].PlayerInfo.ControlLevel = tonumber(msg:sub(1))
				sg.Functions.SendNotification(player,"Your Control Level has been changed!\nNew Level: "..sg.Profiles[player.Name].PlayerInfo.ControlLevel,"")
				sg.Functions.SendNotification(speaker,"Modified "..player.Name.."'s Control Level!",sg.Functions.GetPlayerImage(player.Name,100,100))
			end
		end
	end,
"Change's Control Level",7)
sg.Functions.CreateCommand("Kick Player","kick",{},
	function(msg,speaker)
		if msg:sub(1,3) == "-b " then
			local player = (function()
				for i,v in next,game:GetService'Players':GetPlayers() do
					if v.Name:lower():match(msg:sub(4):lower()) then
						return v;
					end
				end				
			end)()
			if not player then
				sg.Functions.SendNotification(speaker,"That player doesn't exist!",sg.Functions.GetPlayerImage(speaker.Name,100,100))
				return;
			else
				if not sg.Profiles[player.Name] then
					sg.Functions.SetupPlayer(player)
					sg.Functions.SendNotification(speaker,player.Name.." wasn't registered with SafeGuard!",sg.Functions.GetPlayerImage(player.Name,100,100))
					return;
				end
				sg.Profiles[player.Name].SystemSettings.IsBanned = true
				sg.Functions.SendNotification(player,"You have been banned from this server.",sg.Functions.GetPlayerImage(player.Name,100,100))
				wait(1.5)
				sg.Functions.SendNotification(speaker,"You have banned "..player.Name.."!",sg.Functions.GetPlayerImage(player.Name,100,100))
				player:Kick()
			end
		elseif msg:sub(1,3) == "-k " then
			local player = (function()
				for i,v in next,game:GetService'Players':GetPlayers() do
					if v.Name:lower():match(msg:sub(4):lower()) then
						return v;
					end
				end				
			end)()
			if not player then
				sg.Functions.SendNotification(speaker,"That player doesn't exist!",speaker,100,100)
				return;
			else
				sg.Functions.SendNotification(speaker,"You have kicked "..player.Name.."!",sg.Functions.GetPlayerImage(player.Name,100,100))
				player:Kick()
				return;
			end
		end
	end,
	"Force Removes a Player with arguments",
3)

sg.Functions.CreateCommand("Shutdown SafeGuard","shutdown_sg",{},
	function(msg,speaker)
		if sg.Functions.SendAlert(speaker,"A request to Shutdown SafeGuard was made!!","Woah there! There has been a request to shutdown SafeGuard by YOU! Are you sure you want to do this? :O","AllowDeny") == "Allow" then
			for i,v in pairs(ser"Players":GetPlayers()) do
				coroutine.wrap(function()
					sg.Functions.SendAlert(v,"SafeGuard will be shutting down!","Hi there! SafeGuard has been requested to shutdown! All features of SafeGuard will be disabled unless reinitialized.","ClickOkay",5)
				end)()
			end
			wait(6)
			sg.Functions.ShutdownSG()
		end
	end,
	"Shutdowns SafeGuard and disconnects commands.",
8)

sg.Functions.CreateCommand("Modify CoreGui","modcore",{},
	function(msg,speaker)
		if msg:sub(1,3)=="-m " then
			local pla = (function()
				for i,v in next,game:GetService'Players':GetPlayers() do
					if v.Name:lower():match(msg:sub(3):lower()) then
						return v;
					end
				end				
			end)()
			if pla then
				sg.Profiles[pla.Name].SystemSettings.IsMuted=true;
				sg.Functions.CreateLocalScript(sg.Data.SystemScripts.MutePlayerScript,pla.Name)
				sg.Functions.SendAlert(pla,"You have been muted.","You have been muted. You are no longer allowed to chat!","ClickOkay",5)
			else
				sg.Functions.SendNotification(speaker,"That player is not found!\n"..msg:sub(4),sg.Data.ImagesUI.InfoIcon)
			end
		elseif msg:sub(1,5)=="-unm " then
			local pla = (function()
				for i,v in next,game:GetService'Players':GetPlayers() do
					if v.Name:lower():match(msg:sub(6):lower()) then
						return v;
					end
				end				
			end)()
			if pla then
				sg.Profiles[pla.Name].SystemSettings.IsMuted=false;
				sg.Functions.CreateLocalScript(sg.Data.SystemScripts.UnmutePlayerScript,pla.Name)
				sg.Functions.SendAlert(pla,"You are no longer muted.","You have been authorized to speak. Any attempt to abuse this ability will result in permament silent.","ClickOkay",5)
			else
				sg.Functions.SendNotification(speaker,"That player is not found!\n"..msg:sub(4),sg.Data.ImagesUI.InfoIcon)
			end
		end	
	end,
	"Modify's a Player's CoreGui.",
7)

for i,v in pairs(game:GetService'Players':GetPlayers()) do
	sg.Functions.SetupPlayer(v)
end

sg.Functions.PlaySound(134402126)

game.DescendantAdded:connect(function(obj)
	ypcall(function() sg.Functions.IndexScript(obj) end)
end)

game:GetService"Players".PlayerAdded:connect(function(player)
ypcall(function()
	sg.Functions.SetupPlayer(player)
	sg.Profiles[player.Name].SystemSettings.IsConnected=true;
end)	
end)

game:GetService'Chat'.Chatted:connect(function(inst,msg,color)
	if inst.ClassName=="ObjectValue" then
		if inst.Name=="PlayerObject" then
			sg.Functions.ChatSupport(msg,inst.Value)
		end
	end
end)

game:GetService"NetworkServer".ChildRemoved:connect(function(child)
	if child.ClassName == "ServerReplicator" then
		sg.Profiles[player.Name].SystemSettings.IsConnected=false;
		sg.Data.SaveProfileData(player)
		sg.Functions.SendGlobalNotification(player:GetPlayer().Name.." has left the server!",sg.Functions.GetPlayerImage(player:GetPlayer().Name,100,100))
	end
end)

print("KillCode-> "..LAWLKEWLDATTHING)

coroutine.wrap(function()
	while wait(60) do
		ypcall(function() sg.Functions.CheckForUpdates() end)
	end
end)()