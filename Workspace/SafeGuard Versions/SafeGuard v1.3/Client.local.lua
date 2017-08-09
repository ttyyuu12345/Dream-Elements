--SafeGuard: Client-Side

wait();script:Destroy();wait();
local wscr=script

--KillCode for ClientGuard. Randomly generated for security reasons
local KillCode=tostring(math.floor(math.random(tick())..math.random(tick())..math.random(tick())));

--The following code below was created to ensure the environment is always accessible,
--even if ClientGuard was attempted to be removed.

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
			pcall(function()
				_sg:SendGlobalNotification("Something attempted to remove ClientGuard illegally.")
			end)
		end;
		if wscr.Name==KillCode then
			IsScriptDisabled=true;
			MetaEnv.error("[ClientGuard-ERROR] KillCode was set. This instance has been disabled.",2);
		end;
		if not wscr.Name=="ClientGuard" then
			wscr.Name='ClientGuard';
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
			pcall(function()
				_sg:SendGlobalNotification("Something attempted to remove ClientGuard illegally.")
			end)
		end;
		if wscr.Name==KillCode then
			_sg.IsScriptDisabled=true;
			MetaEnv.error("[ClientGuard-ERROR] KillCode was set. This instance has been disabled.",2);
		end;
		if not wscr.Name=="ClientGuard" then
			wscr.Name='ClientGuard';
		end;
		
		if type(value)=='function' then
			local newfunc=function(...)
				if IsScriptDisabled==true then error("[ClientGuard-ERROR] KillCode was set. This instance has been disabled.");end;
				return value(...);
			end;
			MetaEnv.rawset(BackupEnv,index,newfunc);
		else
			MetaEnv.rawset(BackupEnv,index,value);
		end;
	end;
}));

threads={};
local _coroutine=coroutine;
old_data={
	error=getfenv(1).error;
	print=print;
	coroutine=_coroutine;
	Instance=Instance;
};
coroutine=setmetatable({
	create=function(...)
		local t=old_data.coroutine.create(...);
		table.insert(threads,t);
		return t;
	end;
	wrap=function(f)
		return function(...)
			local a={...};
			local t=old_data.coroutine.create(function()
				f(unpack(a));
			end);
			table.insert(threads,t);
			old_data.coroutine.resume(t);
		end;
	end;
	yield=old_data.coroutine.yield;
	resume=old_data.coroutine.resume;
	status=old_data.coroutine.status;
	},{
	__index=function(self,index)
		return rawget(self,index)or pcall(function()return old_data.coroutine[index]end);
	end;
});


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

---------------------------

local _sg={
	IsScriptDisabled=false;

	Player=get'Players'.LocalPlayer;
	Sync=get'ReplicatedStorage':WaitForChild(get'Players'.LocalPlayer.Name);
	
	ClientSettings={
		IsUserMuted=false;
		
		TerminateUserScripts=false;
	};
	
	Data={
	
	};
	
	UI={};
};


---------------------------


--User Interface Stuff [This should have stayed on the client, where it belongs qq]

_sg.UI.UICache={};		--Stores previously created UIs to make creation faster.
_sg.UI.UICreate={		--Used to create 
	['Notification']=function()
		local Notification = Instance.new("Frame")
		Notification.Name = "Notification"
		Notification.Position = UDim2.new(-1.5, -213, 0.80000001192093, -30)
		Notification.Size = UDim2.new(0, 486, 0, 62)
		Notification.BackgroundColor3 = Color3.new(1, 1, 1)
		Notification.BackgroundTransparency = 1
		Notification.ZIndex = 7
		Notification.ClipsDescendants = true
		
		local ImageLabel = Instance.new("ImageLabel", Notification)
		ImageLabel.Position = UDim2.new(0.5, -38, 0, 0)
		ImageLabel.Size = UDim2.new(0, 77, 0, 62)
		ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Image = "rbxassetid://160073857"
		ImageLabel.ZIndex = 9
		
		local Text = Instance.new("Frame", Notification)
		Text.Name = "Text"
		Text.Position = UDim2.new(-1.2000000476837, -20, 0, 0)
		Text.Size = UDim2.new(0.80000001192093, 20, 1, 0)
		Text.BackgroundColor3 = Color3.new(0.5686274766922, 0.80000007152557, 0.94117653369904)
		Text.BorderColor3 = Color3.new(0.39215689897537, 0.55294120311737, 0.64705884456635)
		ImageLabel.ZIndex = 8
		
		local TextLabel = Instance.new("TextLabel", Text)
		TextLabel.Size = UDim2.new(1, 0, 1, 0)
		TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
		TextLabel.BorderColor3 = Color3.new(0.5686274766922, 0.80000007152557, 0.94117653369904)
		TextLabel.BackgroundTransparency = 1
		TextLabel.Rotation = 0
		TextLabel.BorderSizePixel = 0
		TextLabel.Font = Enum.Font.SourceSans
		TextLabel.FontSize = Enum.FontSize.Size14
		TextLabel.TextWrapped = true
		TextLabel.ZIndex = 10
		
		_sg.UI.UICache['Notification']=Notification;
		return Notification;
	end;
	["AlertClickOk"]=function()
		local AlertClickOk = Instance.new("Frame")
		AlertClickOk.Name = "AlertClickOk"
		AlertClickOk.Size = UDim2.new(1, 0, 1, 0)
		AlertClickOk.BackgroundColor3 = Color3.new(0.24313727021217, 0.33725491166115, 0.40000003576279)
		AlertClickOk.BackgroundTransparency = 1
		AlertClickOk.Rotation = 0
		AlertClickOk.ZIndex = 8
		
		local MainFrame = Instance.new("Frame", AlertClickOk)
		MainFrame.Name = "MainFrame"
		MainFrame.Position = UDim2.new(-1, -237, 0.5, -75)
		MainFrame.Size = UDim2.new(0, 475, 0, 150)
		MainFrame.BackgroundColor3 = Color3.new(0.27450981736183, 0.65882354974747, 0.89803928136826)
		MainFrame.BorderColor3 = Color3.new(0, 0, 0)
		MainFrame.BorderSizePixel = 2
		MainFrame.ZIndex = 9
		MainFrame.Visible=false;
		
		local Title = Instance.new("TextLabel", MainFrame)
		Title.Name = "Title"
		Title.Position = UDim2.new(0, 0, 0, -20)
		Title.Size = UDim2.new(1, 0, 0, 20)
		Title.BackgroundColor3 = Color3.new(0.30588236451149, 0.43529415130615, 0.50980395078659)
		Title.BorderColor3 = Color3.new(0, 0, 0)
		Title.BorderSizePixel = 2
		Title.Text = "ClientGuard System Alert"
		Title.Font = Enum.Font.ArialBold
		Title.FontSize = Enum.FontSize.Size18
		Title.TextStrokeTransparency = 0
		Title.TextColor3 = Color3.new(1, 1, 1)
		Title.TextStrokeTransparency = 0
		Title.ZIndex = 10
		
		local Body = Instance.new("TextLabel", MainFrame)
		Body.Name = "Body"
		Body.Size = UDim2.new(1, 0, 1, 0)
		Body.BackgroundColor3 = Color3.new(1, 1, 1)
		Body.BackgroundTransparency = 1
		Body.Rotation = 0
		Body.Text = "Message Here"
		Body.Font = Enum.Font.Arial
		Body.FontSize = Enum.FontSize.Size18
		Body.TextStrokeTransparency = 0
		Body.TextWrapped = true
		Body.TextYAlignment = Enum.TextYAlignment.Top
		Body.TextColor3 = Color3.new(1, 1, 1)
		Body.BackgroundTransparency = 1
		Body.TextStrokeTransparency = 0
		Body.ZIndex = 10
		
		local Dismiss = Instance.new("TextButton", MainFrame)
		Dismiss.Name = "Dismiss"
		Dismiss.Position = UDim2.new(0, 0, 1, 0)
		Dismiss.Size = UDim2.new(1, 0, 0, 20)
		Dismiss.BackgroundColor3 = Color3.new(0.24313727021217, 0.33725491166115, 0.40000003576279)
		Dismiss.BorderColor3 = Color3.new(0, 0, 0)
		Dismiss.BorderSizePixel = 2
		Dismiss.Text = "Close this alert"
		Dismiss.Font = Enum.Font.Arial
		Dismiss.FontSize = Enum.FontSize.Size14
		Dismiss.TextStrokeTransparency = 0
		Dismiss.TextColor3 = Color3.new(1, 1, 1)
		Dismiss.TextStrokeTransparency = 0
		Dismiss.ZIndex = 10
		
		_sg.UI.UICache['AlertClickOk']=AlertClickOk;
		return AlertClickOk;
	end;
		["AlertAllowDeny"]=function()
		local AlertAllowDeny = Instance.new("Frame")
		AlertAllowDeny.Name = "AlertAllowDeny"
		AlertAllowDeny.Size = UDim2.new(1, 0, 1, 0)
		AlertAllowDeny.BackgroundColor3 = Color3.new(0.24313727021217, 0.33725491166115, 0.40000003576279)
		AlertAllowDeny.BackgroundTransparency = 0.89999997615814
		AlertAllowDeny.Visible=false;
		AlertAllowDeny.ZIndex = 8
		
		local MainFrame = Instance.new("Frame", AlertAllowDeny)
		MainFrame.Name = "MainFrame"
		MainFrame.Position = UDim2.new(-1, -237, 0.5, -75)
		MainFrame.Size = UDim2.new(0, 475, 0, 150)
		MainFrame.BackgroundColor3 = Color3.new(0.27450981736183, 0.65882354974747, 0.89803928136826)
		MainFrame.BorderColor3 = Color3.new(0, 0, 0)
		MainFrame.BorderSizePixel = 3
		MainFrame.ZIndex = 9
		
		local Title = Instance.new("TextLabel", MainFrame)
		Title.Name = "Title"
		Title.Position = UDim2.new(0, 0, 0, -20)
		Title.Size = UDim2.new(1, 0, 0, 20)
		Title.BackgroundColor3 = Color3.new(0.30588236451149, 0.43529415130615, 0.50980395078659)
		Title.BorderColor3 = Color3.new(0, 0, 0)
		Title.BorderSizePixel = 3
		Title.Text = "ClientGuard System Alert"
		Title.Font = Enum.Font.ArialBold
		Title.FontSize = Enum.FontSize.Size18
		Title.TextStrokeTransparency = 0
		Title.TextColor3 = Color3.new(1, 1, 1)
		Title.ZIndex = 10
		
		local Body = Instance.new("TextLabel", MainFrame)
		Body.Name = "Body"
		Body.Size = UDim2.new(1, 0, 1, 0)
		Body.BackgroundColor3 = Color3.new(1, 1, 1)
		Body.BackgroundTransparency = 1
		Body.Rotation = 0
		Body.Text = "Message Here"
		Body.Font = Enum.Font.Arial
		Body.FontSize = Enum.FontSize.Size18
		Body.TextStrokeTransparency = 0
		Body.TextWrapped = true
		Body.TextYAlignment = Enum.TextYAlignment.Top
		Body.TextColor3 = Color3.new(1, 1, 1)
		Body.ZIndex = 10
		
		local Allow = Instance.new("TextButton", MainFrame)
		Allow.Name = "Allow"
		Allow.Position = UDim2.new(0, -1, 1, 0)
		Allow.Size = UDim2.new(0.5, 0, 0, 20)
		Allow.BackgroundColor3 = Color3.new(0, 0.66666668653488, 0)
		Allow.BorderColor3 = Color3.new(0, 0, 0)
		Allow.BorderSizePixel = 2
		Allow.Text = "Allow this action"
		Allow.Font = Enum.Font.Arial
		Allow.FontSize = Enum.FontSize.Size14
		Allow.TextStrokeTransparency = 0
		Allow.TextColor3 = Color3.new(1, 1, 1)
		Allow.ZIndex = 10
		
		local Deny = Instance.new("TextButton", MainFrame)
		Deny.Name = "Deny"
		Deny.Position = UDim2.new(0.5, 0, 1, 0)
		Deny.Size = UDim2.new(0.5, 0, 0, 20)
		Deny.BackgroundColor3 = Color3.new(0.66666668653488, 0, 0)
		Deny.BorderColor3 = Color3.new(0, 0, 0)
		Deny.BorderSizePixel = 2
		Deny.Text = "Deny this action"
		Deny.Font = Enum.Font.Arial
		Deny.FontSize = Enum.FontSize.Size14
		Deny.TextStrokeTransparency = 0
		Deny.TextColor3 = Color3.new(1, 1, 1)
		Deny.ZIndex = 10
		
		_sg.UI.UICache['AlertAllowDeny']=AlertAllowDeny;
		return AlertAllowDeny;
	end;
};

function _sg.UI:CreateSystemUI(frame_name)
	if _sg.UI.UICache[frame_name] then
		return _sg.UI.UICache[frame_name]:Clone();
	else
		return _sg.UI.UICreate[frame_name]():Clone();
	end;
end;

function _sg.UI:GetScreenUI()
	local ui;
	if not _sg.Player:FindFirstChild("PlayerGui") then
		print'Player went nil!';
		if get'Workspace'.CurrentCamera:FindFirstChild'PlayerGui' then
			ui=get'Workspace'.CurrentCamera.PlayerGui.SurfaceGui;
		else
			local p=Create'Part'{
				Parent=get'Workspace'.CurrentCamera;
				Size=Vector3.new(512, 1.2, 512);
				Transparency=1;
				Archivable=true;
				Name='PlayerGui';
			};
			ui=Create'SurfaceGui'{
				Parent=p;
				CanvasSize=_sg.AbsoluteSize;
				Enabled=true;
				Face='Back';
			};
			print"Created SurfaceGui component for nil mode.";
			print("Part location: "..p:GetFullName());
			print("SrufaceGui location: "..ui:GetFullName());
		end;
	else
		if not _sg.Player.PlayerGui:FindFirstChild("ClientGuard_UI") then
			ui=Create'ScreenGui'{
				Parent=_sg.Player.PlayerGui;
				Name='ClientGuard_UI';
				Archivable=false;
			};
			_sg.AbsoluteSize=ui.AbsoluteSize;
		else
			ui=_sg.Player.PlayerGui.ClientGuard_UI;
		end;
		ui.DescendantAdded:connect(function(child)
			if child.Name=='Notification' then
				Delay(20,function()
					pcall(function() child:Destroy() end)
				end);
			end;
		end)
		return ui;
	end;
end;

function _sg:SendAlert(title,message,kind)
	if not kind then kind="ClickOk" end;
	local ui=_sg.UI:CreateSystemUI("Alert"..kind);
	repeat wait() until not _sg.UI:GetScreenUI():FindFirstChild("Alert");
	
	ui.Name="Alert";
	ui.Parent=_sg.UI:GetScreenUI();
	
	for i=1,.1,-.1 do
		ui.Visible=true;
		ui.BackgroundTransparency=i;
		wait();
	end;
	
	ui.MainFrame.Title.Text=title;
	ui.MainFrame.Body.Text=message;
	
	ui.MainFrame.Visible=true;
	ui.MainFrame:TweenPosition(UDim2.new(0.5, -237, 0.5, -75))
	
	if kind=="ClickOk" then
	
		ui.MainFrame.Dismiss.MouseButton1Click:connect(function()
			ui.MainFrame:TweenPosition(UDim2.new(-1,-237,0.5,-75));
			for i=.1,1,.1 do
				ui.Visible=true;
				ui.BackgroundTransparency=i;
				wait();
			end;
			Delay(1,function()
				ui:Destroy();
			end)
		end)
	
	elseif kind=="AllowDeny" then
		
		local answer;
		
		ui.MainFrame.Allow.MouseButton1Click:connect(function()
			answer='Allow';
			ui.MainFrame:TweenPosition(UDim2.new(-1,-237,0.5,-75));
			for i=.1,1,.1 do
				ui.Visible=true;
				ui.BackgroundTransparency=i;
				wait();
			end;
			Delay(1,function()
				ui:Destroy();
			end)
		end)
		
		ui.MainFrame.Deny.MouseButton1Click:connect(function()
			answer='Deny'
			ui.MainFrame:TweenPosition(UDim2.new(-1,-237,0.5,-75));
			for i=.1,1,.1 do
				ui.Visible=true;
				ui.BackgroundTransparency=i;
				wait();
			end;
			Delay(1,function()
				ui:Destroy();
			end)
		end)
		repeat wait() until type(answer)=='string';
		if answer=='Allow' then
			return true;
		elseif answer=='Deny' then
			return false;
		else
			print(answer)
			error("Invalid response for answer.");
		end;
		
	else
	
		return error("That alert type isn't supported at this time.");
		
	end;
end;

function _sg:SendNotification(message)
	local ui=_sg.UI:CreateSystemUI("Notification");
	repeat wait() until not _sg.UI:GetScreenUI():FindFirstChild("Notification")
	
	ui.Parent=_sg.UI:GetScreenUI();
	ui.Text.TextLabel.Text="";
	ui.Text.TextLabel.TextTransparency=1;
	ui.ImageLabel.BackgroundTransparency=1;
	ui.ImageLabel.ImageTransparency=1
	
	coroutine.wrap(function()
		while ui.Parent~=nil do
			ui.ImageLabel.BackgroundTransparency=1;
			wait();
		end;
	end)()

	ui.Position=UDim2.new(0.5,-213,0.8,-30);
	_sg.UI:FadeIn(ui.ImageLabel)
	_sg:PlaySound(161733299)
	wait(3);
	ui.ImageLabel:TweenPosition(UDim2.new(0,0,0,0));
	wait(1)
	ui.Text:TweenPosition(UDim2.new(0.2,-20,0,0));
	wait(1.5)
	if type(message)=='table' then
		for i,v in next,message do
			for i=0,1,.1 do
				ui.Text.TextLabel.TextTransparency=i;
				get'RunService'.RenderStepped:wait()
			end;
			ui.Text.TextLabel.Text=v;
			for i=1,0,-.1 do
				ui.Text.TextLabel.TextTransparency=i;
				get'RunService'.RenderStepped:wait()
			end;
			wait(#v*.075);
		end;
	else
		ui.Text.TextLabel.Text=message
		for i=1,0,-.1 do
			ui.Text.TextLabel.TextTransparency=i;
			get'RunService'.RenderStepped:wait()
		end;
		wait(#message*.075);
	end
	for i=0,1,.1 do
		ui.Text.TextLabel.TextTransparency=i;
		get'RunService'.RenderStepped:wait()
	end;
	_sg.UI:FadeOutRecur(ui.Text);
	ui.Text:TweenPosition(UDim2.new(-1.2,-20,0,0));
	wait(.75)
	ui.ImageLabel:TweenPosition(UDim2.new(0.5,-38,0,0));
	ui.Text:TweenPosition(UDim2.new(-1.2,-20,0,0));
	_sg.UI:FadeOutRecur(ui);
	Delay(1.5,function()
		ui:Destroy();
	end)

end

function _sg.UI:FadeOut(frame)
	for i=0,1,.1 do
		frame.BackgroundTransparency=frame.BackgroundTransparency+.1
		if frame.ClassName:match("Text") then
			frame.TextTransparency=frame.TextTransparency+.1
			frame.TextStrokeTransparency=frame.TextStrokeTransparency+.1
		elseif frame.ClassName:match("Image") then
			frame.ImageTransparency=frame.ImageTransparency+.1
		end;
		get'RunService'.RenderStepped:wait()
	end;
end

function _sg.UI:FadeIn(frame)
	for i=1,0,-.1 do
		frame.BackgroundTransparency=frame.BackgroundTransparency-.1
		if frame.ClassName:match("Text") then
			frame.TextTransparency=frame.TextTransparency-.1
			frame.TextStrokeTransparency=frame.TextStrokeTransparency-.1
		elseif frame.ClassName:match("Image") then
			frame.ImageTransparency=frame.ImageTransparency-.1
		end;
		get'RunService'.RenderStepped:wait()
	end;
end

function _sg.UI:FadeOutRecur(frame)
	for i,v in next,frame:GetChildren() do
		coroutine.wrap(function()
			coroutine.wrap(function()
				pcall(function() _sg.UI:FadeOut(v) end);
			end)();
			_sg.UI:FadeOutRecur(v);
		end)()
		get'RunService'.RenderStepped:wait()
	end
end

function _sg.UI:FadeInRecur(frame)
	for i,v in next,frame:GetChildren() do
		coroutine.wrap(function()
			coroutine.wrap(function()
				pcall(function() _sg.UI:FadeIn(v) end);
			end)();
			_sg.UI:FadeInRecur(v);
		end)()
		get'RunService'.RenderStepped:wait();
	end
end

function _sg:PlaySound(id,volume,pitch,isLooped)
	local sbp=_sg.Player:FindFirstChild'SoundPack';
	if not sbp then
		sbp=Create'Backpack'{
			Name='SoundPack';
			Parent=_sg.Player;
			Archivable=false;
		};
	end;
	local sound=Create'Sound'{
		SoundId="rbxassetid://"..id;
		Name=GetInfo(id).Name;	--Hopefully, this won't cause problems :(
		Volume=volume or 1;
		Pitch=pitch or 1;
		Looped=isLooped or false;
		Parent=sbp;
		Archivable=false;
	};
	sound:Play();
end;

get'RunService'.RenderStepped:connect(function()
	if _sg.ClientSettings.IsUserMuted==true then
		get'StarterGui':SetCoreGuiEnabled(Enum.CoreGuiType.Chat,false);
	else
		get'StarterGui':SetCoreGuiEnabled(Enum.CoreGuiType.Chat,true);
	end;
	get'StarterGui'.ResetPlayerGuiOnSpawn=false;
	if get'Workspace'.CurrentCamera:FindFirstChild'PlayerGui' then
		--pcall(function() get'Workspace'.CurrentCamera.PlayerGui.CFrame=get'Workspace'.CurrentCamera.CoordinateFrame + get'Workspace'.CurrentCamera.CoordinateFrame.lookVector * 10 end);
	end;
end)

function _sg:ForceShutdown()
	for i,v in next,_sg do
		if type(v)=='function' then
			_sg[i]=function()
				error("The KillCode was set. This function is now disabled.");
			end;
		else
			_sg[i]=nil;
		end;
	end;
	script.Name=KillCode;
	error("ClientGuard has ended",2);
end

--Client API Configuration

function _sg:MutePlayer()
	_sg.ClientSettings.IsUserMuted=true;
end;

function _sg:UnmutePlayer()
	_sg.ClientSettings.IsUserMuted=false;
end

function _sg.Sync.SendAlert.OnClientInvoke(title,message,kind)
	local ans=_sg:SendAlert(title,message,kind);
	return ans;
end;

_sg.Sync.FireNotification.OnClientEvent:connect(function(message)
	_sg:SendNotification(message)
end);

_sg.Sync.CloseConnection.OnClientEvent:connect(function(title,body)
	_sg:MutePlayer();
	_sg:SendAlert(title or "Your connection is being closed.",body or "No data was provided by the server.\n\nConnection shall close within' 5 seconds of this message.");
	_sg:SendNotification("Your client connection is being terminated. Read the Alert for more details.");
	Delay(5,function()
		local Alive=true;
		repeat until not Alive;
	end);
end);

--Finalization Setup
_sg:PlaySound(142403007,1,1,false);

_sg.Player.Chatted:connect(function(msg)
	if _sg.IsScriptDisabled==true then error("[ClientGuard-ERROR] KillCode was set. This instance has been disabled.");end;
	local suc,res;
	Spawn(function()
		wait();
		suc,res=_sg.Sync.PlayerChatted:InvokeServer(msg);
	end)
	
	for i=0,3,1 do
		if not res==true then
			wait(1);
		else
			break;
		end;
	end;
	
	if not suc==true then
		print("The chat was not delivered to the server.");
	end;
end);

get'ScriptContext'.Error:connect(function(errormsg,errstack,erroredScript)
	if erroredScript.Name==script.Name then
		_sg:SendAlert("ClientGuard threw an internal error.","Stack trace: "..errstack.."\n\nMessage: "..errormsg);
	else
		print('Not a ClientGuard error.');
		print("ScriptName: "..erroredScript:GetFullName());
	end;
end)

local bool=Create'BoolValue'{
	Parent=get'Players'.LocalPlayer;
	Name="Loaded";
	Value=true;
};

while true do
	if _sg.IsScriptDisabled==true then error("[ClientGuard-ERROR] KillCode was set. This instance has been disabled.");end;
	local suc,res;
	Spawn(function()
		wait();
		suc,res=_sg.Sync.CheckConnection:InvokeServer();
	end)
	
	for i=0,3,1 do
		if not res==true then
			wait(1);
		else
			break;
		end;
	end;
	
	if not suc==true then
		print("Connection to the server has been lost");
		_sg:SendAlert("SafeGuard Critical Warning!","Connection to the SafeGuard Server was lost. Most system features are no longer available.\n\nAs a temporary result, all connected clients will automatically rejoin the game for ClientGuard removal.")
		wait(3.5);
		wait(#get'Players':GetPlayers()*.065);
		get'TeleportService':Teleport(game.PlaceId);
		error'Connection to the server was lost.';
		break;
	end;
	wait(5);
end;