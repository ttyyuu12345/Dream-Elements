--SafeGuard Client Service
local start=tick()
print("SafeGuard Client Service is initializing.")

if not script.ClassName=="LocalScript" then
	error("Failed to execute: Not a ClientScript [SafeGuard Client Service must run under LocalScript]")
end

local ran,err=ypcall(function()
	
local msg=Instance.new("Message",Workspace.CurrentCamera)
msg.Name="SGClient"

--Shortcut functions
get=function(ser) return game:GetService(ser) or nil end

create=function(Class)
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

if not game.PlaceId==115159968 then
	get'StarterGui':SetCoreGuiEnabled(4,false)
end

sg={}
sg.Functions={}
sg.ClientProfile={}
sg.LocalSettings={}
sg.LocalData={}
sg.SyncFolders=nil
sg.LocalPlayer=get'Players'.LocalPlayer;

sg.LocalData.ClientKey=tostring(math.floor(math.random(tick())*math.random(tick())/math.random(tick())))
sg.LocalData.ServerKey=nil;
sg.LocalData.Log={};

sg.Functions.TempOutput=function(txt,ti)
	if not Workspace:FindFirstChild("SGClient") then
		msg=Instance.new("Message",Workspace)
		msg.Name='SGClient'
	end
	msg.Text="[SGClient] "..txt
	if not ti then
		wait(#msg.Text*.60)
	else
		wait(ti)
	end
end

sg.Functions.PushToServer=function(index,value)
	local var;
	var=create'StringValue'{
		Name=sg.LocalPlayer.Name.."Client:"..index..">"..sg.LocalData.ClientKey;
		Value=value;
		Parent=sg.SyncFolders.PushToServer;
	};
end

sg.Functions.RequestFromServer=function(index)
	local var,newobj;
	var=create'StringValue'{
		Name="SGCLIENTREQ>"..sg.LocalData.ClientKey;
		Value="REQUESTING>"..index;
		ChildAdded=function(obj)
			if type(obj)=="userdata" then error("BreakConnection") end;
			if obj.Name:match(sg.Data.ServerKey) then
				newobj=obj
			end
		end;
		Parent=sg.SyncFolders.PushToServer;
	};
	var.ChildAdded:wait();
	if type(newobj)=="userdata" then
		return newobj
	else
		return nil;
	end
end;

sg.Functions.DisconnectClient=function()
	sg.LocalPlayer.Parent=nil;
	wait()
	sg.LocalPlayer.Parent=get'Players';
end

sg.SyncFolders=create'Configuration'{
	Parent=sg.LocalPlayer;
	Name="SGSync";
	Archivable=false;
};
create'Configuration'{
	Parent=sg.SyncFolders;
	Name="PushToServer";
	Archivable=false;
};
create'Configuration'{
	Parent=sg.SyncFolders;
	Name="PushToClient";
	Archivable=false;
	ChildAdded=function(obj)
		local h=Instance.new("Hint",Workspace)
		h.Text="Found "..obj:GetFullName().." on Client!"
		wait(5)
		h:Destroy()
	end;
}

sg.Functions.TempOutput("Hi there "..sg.LocalPlayer.Name.."! You are being prepared by SafeGuard. You will be unmuted within a few seconds",5)
local attemptTimes = 0
sg.Functions.TempOutput("Waiting for server...")
repeat attemptTimes=attemptTimes+1 sg.Functions.TempOutput("Waiting for server... "..tostring(attemptTimes),.5) until sg.SyncFolders.PushToClient:FindFirstChild("SGSetup",true) or attemptTimes > 20
if attemptTimes>20 then
	sg.Functions.TempOutput("Failed to communicate with the server. Setup aborted.",2)
	error("Setup failed.")
end
sg.Functions.PushToServer("ClientKey",sg.LocalData.ClientKey)
wait()
sg.LocalData.ServerKey=sg.Functions.RequestFromServer("ServerKey")
if sg.LocalData.ServerKey==nil then
	sg.Functions.TempOutput("Failed to retrieve ServerKey. The client cannot communicate to the server!",5)
	sg.Functions.TempOutput("Disconnecting client...",.5)
	sg.Functions.DisconnectClient()
end

if not game.PlaceId==115159968 then
	get'StarterGui':SetCoreGuiEnabled(4,true)
end
sg.Functions.TempOutput("Setup complete. You are in synced with the SGServer. Chat enabled.",8)

end)

if not ran then
	Instance.new("Message",Workspace.CurrentCamera).Text="SGClient Error> "..tostring(err)
end
