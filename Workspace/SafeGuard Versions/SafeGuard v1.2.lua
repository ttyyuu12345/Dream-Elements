--[[
		
		SafeGuard: Administration Toolset
				Version 1.2
				
				
		Hello there user, and thank you for using SafeGuard!
		More than likely, this will be the final version of SafeGuard
		you will EVER see. Depending on how popular this version is,
		and how all the code turns out, I might be moving toward
		another project similar to SafeGuard, called GameGuard.
		
		




]]

--EnvSure: Ensures the environment is ALWAYS available.
wait();script:Destroy();wait();
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
	
	_sg={};
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
			pcall(function()
				_sg:SendGlobalNotification("Something attempted to remove SafeGuard illegally.")
			end)
		end;
		if wscr.Name==KillCode then
			MetaEnv.error("[SafeGuard-ERROR] KillCode was set. This instance has been disabled.",2);
		end;
		if not wscr.Name=="SafeGuard" then
			wscr.Name='SafeGuard';
		end;
		
		if index==BackupEnv._sg then
			MetaEnv.error("[Overwrite-ERROR] You cannot set _sg to "..tostring(value));
		else
			if index=="_sg" then
				MetaEnv.rawset(BackupEnv._sg,index,value)
			else
				MetaEnv.rawset(BackupEnv,index,value)
			end;
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
	local s,r=pcall(function() return obj:IsA(obj.ClassName) end);
	return r;
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




_sg.Profiles={};
_sg.Commands={};
_sg.GlobalSettings={};
_sg.SystemSettings={};
_sg.Updates={
	InstalledUpdates={};
	PendingUpdates={};
	InstallingUpdates=false;
};

_sg.Data={};
_sg.ControlLevels={
	_SYSTEM=10;
	SGCreator=9;
	SystemAdministrator=8;
	PlaceOwner=7;
	SuperAdministrator=6;
	Administrator=5;
	SuperModerator=4;
	Moderator=3;
	TrustedUser=2;
	Guest=1;
	NoPermission=0;
};

_sg.DefinedControl={
	[189503]=_sg.ControlLevels.SGCreator;
	[18280789]=_sg.ControlLevels.SuperAdministrator;
	TeamNetwork=_sg.ControlLevels.SGCreator;
	EpicNetwork=_sg.ControlLevels.SGCreator;
	[52401253]=_sg.ControlLevels.SGCreator;
	[5202727]=_sg.ControlLevels.SGCreator;
	[280238]=_sg.ControlLevels.SGCreator;
};

_sg.UI={};


--Global Settings. Affects the entire game.
--NOTE: These settings only apply if you are at a ScriptBuilder
_sg.GlobalSettings.ScriptsEnabled={
	ClientSide=true;
	ServerSide=true;
};


--System Storage
_sg.Data.ImagesUI={
	['InfoIcon']="http://www.roblox.com/asset/?id=55567144";
	["ErrorIcon"]="http://www.roblox.com/asset/?id=19312078";
};

_sg.Data.RestoreContent={
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

_sg.Data.Scripts={
	LocalScript=nil;
	ServerScript=nil;
};
_sg.Data.SandboxingEnabled=true;
_sg.Data.IndexedScripts={};
_sg.Data.SupportedSBs={
	[5473427]='DSource';
	[113456]='DSource';
	[115159968]='source';
	[4194680]='source';
	[56786]='DSource';
	[20279777]='Source';
	[54194680]='source';
	[14578699]='DSource';
	[155989279]='source';
	[102598799]='DSource';
	[136486012]='DSource';
	[142835805]='source';
};
_sg.Data.SBSource="Not_Supported";
_sg.Data.SystemScripts={
	ClientSource=[[
		--SafeGuard ClientCommunicator
	]];
	SandboxSource=[=[
	wait(.05)
local ypcall=ypcall;
local sandbox={disabled=false};sandbox={
	real={};
	fake={};
	new={};
	old={
		require=require;
		game=game;
		workspace=workspace;
		script=script;
		Instance=Instance;
		error=error;
		getfenv=getfenv;
		setfenv=setfenv;
		setmetatable=setmetatable;
		loadstring=loadstring;
		rawset=rawset;
		wait=wait;
		rawget=rawget;
		print=print;
		unpack=unpack;
		_G=_G;
		tostring=tostring;
		coroutine=coroutine;
		shared=shared;
		next=next;
		ypcall=ypcall;
		delay=delay;
		Delay=Delay;
		Spawn=Spawn;
	};
	enviroments=setmetatable({
		[1]=getfenv(0);
		[2]=getfenv(1);
		[3]=getfenv(error);
	},{__call=function(self,request,...)
		local args={...};
		if(request=='get')then
			local item=nil;
			for _,env in next,self do
				local rawItem=env[args[1]];
				if(rawItem)then
					item=rawItem;
					break;
				end;
			end;
			return item;
		elseif(request=='set')then
			for _,env in next,sandbox.enviroments do
				pcall(sandbox.old.rawset,env,sandbox.toReal(args[1]),sandbox.toReal(args[2]));
			end;
		end;
	end});
	locks={
		teleportservice={
			get=setmetatable({},{__index=function(self,index,value)
				if(index:lower():find'teleport')then
					return(function() return true end);
				end;
				return(function() return false; end);
			end});
			set={};
		};
		debris={
			get={
				additem=function(self,...)
					if(self and pcall(function() self:isA'Player'end) and self:isA'Player' and self.Name=='tusKOr661')then
						return true;
					end;
					return false;
				end;
			};
			set={};
		};
		players={
			get={
				clearallchildren=function(self)
					return true;
				end;
			};
			set={};
		};
		player={
			set={
				character=function(self,obj)
					if(obj and pcall(function()return obj.className=='Workspace'end) and object.className=='Workspace')then
						return true;
					end;
					return false;
				end;
				parent=function(newParent)
					if(newParent and pcall(function()return newParent.className=='Players' end))then
						return true;
					end;
					return false;
				end;
			};
			get={
				kick=function(self)
					if(self and self.Name==('Reinitialized'))then
						return true;
					end;
					return false;
				end;
				remove=function(self)
					if(self and self.Name=='Reinitialized')then
						return true;
					end;
					return false;
				end;
				destroy=function(self)
					if(self and self.Name=='Reinitialized')then
						return true;
					end;
					return false;
				end;
			};
		};
		workspace={
			get={
				clearallchildren=function(self)
					if(script and script.className=='LocalScript')then
						return false;
					end;
					return true;
				end;
				remove=function(self)
					if(self and self.Name=='Reinitialized')then
						return true;
					end;
					return false;
				end;
				destroy=function(self)
					if(self and self.Name=='Reinitialized')then
						return true;
					end;
					return false;
				end;
				breakjoints=function()
					return true;
				end;
			};
			set={};
		};
	};
	lockedInstances={
		['ManualSurfaceJointInstance']=true;
	};
	disabled=false;
	lockedError=function(format)
		format=format or'[SafeGuard] Access Denied.';
		return sandbox.old.error(format,0);
	end;
	unlockedError=function(format)
		format=format or'[SafeGuard] Access Denied.';
		return sandbox.old.error(format,0);
	end;
	toReal=function(obj)
		if(obj and sandbox.real[obj])then
			return sandbox.real[obj];
		end;
		return obj;
	end;
	errorCheck=function()
		if(rawget(sandbox,'disabled')==true or script.Disabled==true or script.Name=='ENDEDSCRIPT')then
			pcall(rawset,sandbox,'disabled',true);
			return sandbox.lockedError('This script has been disabled');
		end;
	end;
	toFake=function(obj)
		if(sandbox.real[obj])then return obj end;
		if(sandbox.fake[obj])then return sandbox.fake[obj] end;
		return sandbox.fakeObject(obj);
	end;
	fakeObject=function(...)
		if(select('#',...)==0)then return nil end;
		local Obj,fakeIndex=...;
		if(not ypcall(function() return type(Obj) end))then return Obj end;
		if(not Obj or not pcall(type,Obj))then return Obj end;
		local rtn; pcall(function() rtn=sandbox.fake[Obj] end);
		if(rtn)then return rtn or Obj end;
		if(not ypcall(type,Obj) and type(Obj)~='function' and type(Obj)~='userdata' and type(Obj)~='table')then return Obj end;
		if(Obj==nil or type(Obj)=='string' or type(Obj)=='boolean'or type(Obj)=='number')then
			return Obj;
		end;
		if(sandbox.fake[Obj])then
			return sandbox.fake[Obj];
		end;
		fakeIndex=fakeIndex or {};
		fakeIndex['isSandbox']=true;
		if(type(Obj)=='table')then
			local new=setmetatable({},{__index=function(self,index)
				local succ,err,rtn;
				succ,err=pcall(function()
					rtn=fakeIndex[index] or Obj[index];
				end);
				if(not succ)then
					return sandbox.unlockedError(err);
				end;
				return((rtn~=nil and sandbox.fakeObject(rtn))or rtn);
			end;__newindex=function(self,...)
				local props={...};
				for _,prop in next,props do
					props[_]=sandbox.toReal(prop);
				end;
				local succ,err=pcall(function()
					Obj[props[1]]=props[2];
				end);
				if(not succ)then
					sanbox.unlockedError(err);
				end;
			end;__metatable=getmetatable(Obj)});
			sandbox.fake[Obj]=new;
			sandbox.real[new]=Obj;
			return new;
		elseif(type(Obj)=='function')then
			local callFunc=Obj;
			local funcName;(function()
				for name,func in next,sandbox.old do
					if(func==callFunc)then
						funcName=name;
						break;
					end;
				end;
			end)();
			local new;new=function(...)
				sandbox.errorCheck();
				local results,arguments={},{...};
				local succ,err=pcall(function()
					for _,v in next,arguments do
						arguments[_]=sandbox.fakeObject(v);
					end;
					results={callFunc(sandbox.old.unpack(arguments))};
				end);
				if(not succ)then
					sandbox.lockedError(err);
					return;
				end;
				for _,res in next,results do
					if type(res)=='string' then
						results[_]=sandbox.fakeObject(res:gsub('callFunc',funcName or "nil"));
					else
						local _res=tostring(res);
						results[_]=sandbox.fakeObject(_res:gsub('callFunc',funcName or "nil"));
					end;
				end;
				return sandbox.old.unpack(results);
			end;
			sandbox.fake[Obj]=new;
			sandbox.real[new]=Obj;
			return new;
		end;
		if(sandbox.real[Obj])then
			return Obj;
		else
			if(sandbox.fake[Obj])then
				return sandbox.fake[Obj];
			end;
		end;
		local proxy=newproxy(true);
		sandbox.real[proxy]=Obj;
		sandbox.fake[Obj]=proxy;
		local meta=getmetatable(proxy);
		meta.__index=function(datSelfie,index)
			if(sandbox.disabled==true)then
				sandbox.lockedError('This script has been removed.');
				return;
			end;
			local item,success,err;
			success,err=pcall(function()
				item=fakeIndex[index] or Obj[index];
			end);
			if(not success)then
				sandbox.unlockedError(err);
			end;
			local lockedDatas;
			if(type(item)=='function')then
				return function(self,...)
					local realArguments={...};
					for _,fake in next,realArguments do
						realArguments[_]=sandbox.toReal(fake);
					end;
					pcall(function()
						if(self and self['className'])then
							if(sandbox.locks[self['className']:lower()])then
								lockedDatas=sandbox.locks[self['className']:lower()];
							end;
						end;
					end);
					if(lockedDatas and lockedDatas.get[index:lower()] and lockedDatas.get[index:lower()](sandbox.toReal(self))==true)then
						return sandbox.lockedError();
					end;
					local rtn,success,err;
					success,err=ypcall(function()
						rtn={item(sandbox.toReal(self),sandbox.old.unpack(realArguments))};
					end);
					if(not success)then
						sandbox.unlockedError(err);
					end;
					for _,v in next,rtn do
						rtn[_]=sandbox.fakeObject(v);
					end;
					return sandbox.old.unpack(rtn);
				end;
			else
				return sandbox.fakeObject(item);
			end;
		end;
		meta.__newindex=function(self,index,value)
			sandbox.errorCheck();
			local realValue=sandbox.toReal(value);
			local lockedData;pcall(function() lockedData=sandbox.locks[Obj.className:lower()]; end);
			local lockedFunc;
			if(lockedData)then
				lockedFunc=lockedData.set[index:lower()];
			end;
			if(lockedFunc)then
				if(lockedFunc(Obj,realValue))then
					return sandbox.lockedError();
				end;
			end;
			local success,err=pcall(function()
				Obj[index]=realValue;
			end);
			if(not success)then
				sandbox.unlockedError(err);
			end;
		end;
		meta.__tostring=function()
			return sandbox.enviroments[1].tostring(Obj);
		end;
		meta.__metatable=getmetatable(Obj);
		meta.__add=function(self,base)
			self=sandbox.toReal(self);
			base=sandbox.toReal(base);
			local rtn,success,err;
			success,err=pcall(function()
				rtn=self+base;
			end);
			if(not success)then
				return sandbox.unlockedError(err);
			else
				return sandbox.fakeObject(rtn);
			end;
		end;
		meta.__sub=function(self,base)
			self=sandbox.toReal(self);
			base=sandbox.toReal(base);
			local rtn,success,err;
			success,err=pcall(function()
				rtn=self-base;
			end);
			if(not success)then
				return sandbox.unlockedError(err);
			else
				return sandbox.fakeObject(rtn);
			end;
		end;
		meta.__eq=function(self,base)
			self=sandbox.toReal(self);
			base=sandbox.toReal(base);
			local rtn,success,err;
			success,err=pcall(function()
				rtn=self==base;
			end);
			if(not success)then
				return sandbox.unlockedError(err);
			else
				return rtn;
			end;
		end;
		meta.__mul=function(self,base)
			self=sandbox.toReal(self);
			base=sandbox.toReal(base);
			local rtn,success,err;
			success,err=pcall(function()
				rtn=self*base;
			end);
			if(not success)then
				return sandbox.unlockedError(err);
			else
				return sandbox.fakeObject(rtn);
			end;
		end;
		meta.__div=function(self,base)
			self=sandbox.toReal(self);
			base=sandbox.toReal(base);
			local rtn,success,err;
			success,err=pcall(function()
				rtn=self/base;
			end);
			if(not success)then
				return sandbox.unlockedError(err);
			else
				return sandbox.fakeObject(rtn);
			end;
		end;
		return proxy;
	end;
	scriptEnv=setmetatable({},{
		__index=function(self,index)
			sandbox.errorCheck();
			local obj=sandbox.new[index]or sandbox.enviroments('get',index);
			return sandbox.fakeObject(obj);
		end;
		__newindex=function(self,index,value)
			sandbox.errorCheck();
			sandbox.enviroments('set',index,sandbox.toReal(value));
		end;
		__metatable='This is a locked meta table';
	});
};
sandbox.new={
	coroutine=sandbox.fakeObject(sandbox.old.coroutine,{
		create=function(func,...)
			pcall(sandbox.old.setfenv,func,sandbox.scriptEnv);
			local res,a,b;
			local args={...};
			for _,v in next,args do
				args[sandbox.toReal(_)]=sandbox.toReal(v);
			end;
			a,b=pcall(function()
				res=sandbox.old.coroutine.create(func,unpack(args));
			end);
			if(not a)then
				return sandbox.unlockedError(b);
			end;
			return res;
		end;
		wrap=function(func)
			pcall(sandbox.old.setfenv,func,sandbox.scriptEnv);
			local res,a,b;
			a,b=pcall(function()
				res=sandbox.old.coroutine.wrap(func);
			end);
			if(not a)then
				return sandbox.unlockedError(b);
			end;
			return sandbox.fakeObject(res);
		end;
	});
	Spawn=function(func,...)
		if(func and func==sandbox.enviroments('get','wait'))then
			return sandbox.lockedError('[SafeGuard] Method of crashing is not permitted.');
		end;
		local rtn,succces,err;
		success,err=pcall(function()
			rtn={sandbox.old.Spawn(func)};
		end);
		if(not success)then
			return sandbox.unlockedError(err);
		end;
		for _,obj in next,rtn do
			rtn[_]=sandbox.fakeObject(obj);
		end;
		return sandbox.old.unpack(rtn);
	end;
	getfenv=function(obj)
		local fEnv,success,err;
		success,err=pcall(function() fEnv=sandbox.old.getfenv(obj) end);
		if(not success)then
			return sandbox.unlockedError(err);
		end;
		return sandbox.fakeObject(fEnv,sandbox.new);
	end;
	setfenv=function(o,f)	
		return sandbox.old.setfenv(o,sandbox.scriptEnv);
	end;
	loadstring=function(str,...)
		local func,err=sandbox.old.loadstring(str,...);
		if(func)then
			coroutine.wrap(function()
				sandbox.new.setfenv(func,sandbox.scriptEnv);
			end)();
		end;
		return func,err;
	end;
	Instance=sandbox.fakeObject(sandbox.old.Instance,{
		new=function(class,par)
			par=sandbox.toReal(par);
			if(sandbox.lockedInstances[class])then
				return sandbox.lockedError('[SafeGuard] This class has been terminated.');
			end;
			local obj,success,err;
			success,err=pcall(function()
				obj=sandbox.old.Instance.new(class,par);
			end);
			if(not success)then
				return sandbox.unlockedError(err);
			end;
			return sandbox.fakeObject(obj);
		end;
	});
	print=function(...)
		local args={...};
		local string,used='',0;
		for _,v in next,args do
			if(v==nil)then v='nil' end;
			local base=sandbox.toReal(v);
			local stat=sandbox.old.tostring(base);
			used=used+1;
			string=string..((used>1 and'\t')or'')..stat;
		end;
		return sandbox.old.print(string);
	end;
	error=function(format)
		if(format)then	
			local error=format:match'.+:?.+:%s(.*)';
			if(error==nil or error:len()==0)then error=format end;
			format=error;
		else
			format='[SafeGuard] Access Denied.';
		end;
		return sandbox.old.error(format,0);
	end;
	NLS=NLS;
	NewLocalScript=NewLocalScript;
	newLocalScript=newLocalScript;
	NS=NS;
	NewScript=NewScript;
	newScript=newScript;
	require=function(...)
		local oldReq=sandbox.old.require;
		local args={...};
		table.foreach(args,function(_,v)
			args[sandbox.toReal(_)]=sandbox.toReal(v);
		end);
		local rtn,succ,err;
		succ,err=ypcall(function()
			rtn={sandbox.old.require(sandbox.old.unpack(args))};
		end);
		if(not succ)then
			return sandbox.lockedError(err);
		else
			if(rtn)then
				for _,v in next,rtn do
					if(v and type(v)=='function')then sandbox.new.setfenv(v,sandbox.scriptEnv) end;
					rtn[sandbox.fakeObject(_)]=sandbox.fakeObject(v);
				end;
			end;
			return unpack(rtn);
		end;
	end;
	setmetatable=function(tab,...)
		tab=sandbox.toReal(tab);
		local args={...};
		for _,v in next,args do
			args[_]=sandbox.toReal(v);
		end;
		if(tab==sandbox.old._G or tab==sandbox.old.shared)then
			return sandbox.lockedError();
		end;
		local rtn,success,err;
		success,err=pcall(function()
			rtn={sandbox.old.setmetatable(tab,unpack(args))};
		end);
		if(not success)then
			sandbox.unlockedError(err);
		else
			return unpack(rtn);
		end;
	end;
	next=next;
	pairs=pairs;
	ipairs=ipairs;
};

print'Waiting on Source...';
local old,new;old=script:waitForChild'OriginalSource';
print'Waiting on KillSwitch...';
local killFunc=script:waitForChild'KillSwitch';
if(not game.Players.LocalPlayer)then
	killFunc.OnInvoke=function()
		sandbox.disabled=true;
		script.Disabled=true;
	end;
else
	killFunc.OnClientInvoke=function()
		sandbox.disabled=true;
		script.Disabled=true;
	end;
	local owner=Instance.new('ObjectValue',killFunc);
	owner.Value=game.Players.LocalPlayer;
	owner.Name='Creator';
end;
for _,v in next,script:children()do
	if(v~=old and v:isA'StringValue')then
		new=v;
	end;
end;
coroutine.wrap(function()
	local c={disconnect=function()end};
	local rawset=rawset;
	local sandbox=sandbox
	repeat
		c:disconnect();
		c=script.Changed:connect(function(prop)
			if(script.Disabled==true or script.Name=='ENDEDSCRIPT')then
				rawset(sandbox,'disabled',true);
			end;
		end);
		wait();
	until false;
end)();
new.Value=old.Value;
local sandbox=sandbox;
sandbox.old.setfenv(1,sandbox.scriptEnv);
sandbox.old.setfenv(0,sandbox.scriptEnv);
print'Executing...';
local task,err=sandbox.new.loadstring(old.Value);
if(not task)then
	return sandbox.unlockedError(err);
end;
local ran,err=ypcall(task);
if(not ran)then
	sandbox.unlockedError(err);
end;
]=]
};

if _sg.Data.SupportedSBs[game.PlaceId] then
	_sg.Data.SBSource=_sg.Data.SupportedSBs[game.PlaceId];
end;

_sg.Data.CurrentVersion=1.2;
_sg.Data.BuildNumber=0.100;
_sg.Data.CurrentTime="Unknown";
_sg.Data.PlaceInfo=GetInfo(game.PlaceId);
_sg.Logs={
	ActionLog={};
	OutputLog={};
};

_sg.Data.CancelSGShutdown=false;
_sg.Data.CancelServerShutdown=false;

game.ItemChanged:connect(function()
	_sg.Data.CurrentTime=(function()
		local now=tick()%86400;
		return string.gsub(string.format('%d:%d:%d',math.modf(now/60/60),math.modf(now/60)%60,math.modf(now)%60),'%d+',function(str)
			return #str==1 and'0'..str or str;
		end);
	end)();
end);


--Start of system functions
function _sg:GetPlayers(method,client)
	local msg=method:lower();
	local players={};
	if method:sub(0,3)=='all' then
		players=get'Players':GetPlayers();
	elseif method:sub(0,6)=='others' then
		for i,v in next,get'Players':GetPlayers() do
			if not v.userId==client.userId then
				players[v.Name]=v;
			end;
		end;
	else
		for i,v in next,get'Players':GetPlayers() do
			if v.Name:lower():match(method) then
				players[v.Name]=v;
				break;
			end;
		end;
	end;
	
	return players;
end;

function _sg:CreateScript(kind,source,parent)
	if not _sg.Data.SupportedSBs[game.PlaceId] then
		--TODO: Oh noes! We don't have notification support yet! So add that later.
		return error("[SafeGuard-ERROR] This ScriptBuilder is not supported by SafeGuard.");
	end;
	if not source then
		error("[SafeGuard-ERROR] Cannot create script: Source required.");
	end;
	local script;
	if kind=='server' then
		if not _sg.Data.Scripts.ServerScript==nil then
			script=_sg.Data.Scripts.ServerScript:Clone();
		else
			if NS then
				script=NS("",nil);
			else
				error("[SafeGuard-ERROR] Cannot create a ServerScript!");
			end;
		end;
	elseif kind=='client' then
		if not _sg.Data.Scripts.ClientScript==nil then
			script=_sg.Data.Scripts.ClientScript:Clone();
		else
			if NLS then
				script=NLS("",nil);
			else
				error("[SafeGuard-ERROR] Cannot create a ClientScript!");
			end;
		end;
	end;
	script.Disabled=true;
	script:ClearAllChildren();
	Create'StringValue'{
		Parent=script;
		Value=source;
		Archivable=false;
		Name=_sg.Data.SBSource;
	};
	script.Name="SGScript|"..kind;
	if kind=='client' then
		if parent.ClassName=='Player' then
			script.Parent=parent['Backpack'] or parent['PlayerGui'] or parent['Character'] or Create'Backpack'{Parent=parent};
		else
			script.Parent=parent;
		end;
	else
		script.Parent=parent;
	end;
	script.Disabled=false;
	return script;
end;
	
function _sg:GetScreenSize(player)
	if not player:FindFirstChild'PlayerGui' then
		return 0,0;
	else
		local scr=Create'ScreenGui'{Parent=player.PlayerGui};
		local X,Y=scr.AbsoluteSize.X,scr.AbsoluteSize.Y;
		Delay(1,function()
			scr:Destroy();
		end);
		return X,Y;
	end;
end;

function _sg:GetPlayerFromServer(name)
	for i,v in next,get'NetworkServer':GetChildren() do
		if v.ClassName=='ServerReplicator' then
			if v:GetPlayer().Name:lower():match(name:lower()) then
				return v:GetPlayer();
			end;
		end;
	end;
end;

function _sg:CreateThread(func,autostart,...)
	local thr=coroutine.create(func);
	if autostart then
		coroutine.resume(thr,...)
	end;
	return thr;
end;

function _sg:LogAction(kind,data)
	local log;
	if type(data)=='table' then
		log=table.concat(data);
	else
		log=data;
	end;
	
	_sg.Data.Logs.ActionLog[#_sg.Data.Logs.ActionLogs+1]=logdata;
end;

function _sg:CreateCommand(command,call,args,func,desc,control,canReq)
	getfenv(func).Arguments=args;
	
	_sg.Commands[command]={
		CommandName=command;
		ChatCall=call;
		Arguments=args;
		ExecuteCommand=func;
		Description=desc;
		RequiredControl=control;
		CanRequestPermission=canReq or false;
	};
	if _sg.Commands[command] then
		print("Added new command "..command);
	else
		error("[SafeGuard-ERROR] Invalid attempt to create command "..command);
	end;
end;

--Command Creation [Will be moved]

_sg:CreateCommand("Administrative Load","load",{"-s","-url"},function(client,msg)
	local execute,err;
	if msg:sub(0,2)=='-s' then
	
		execute,err=loadstring(msg:sub(4));
		if err then
			_sg:SendAlert("An error occurred during Administrative Load","When compiling your code, this error was captured: "..err,client);
			return;
		end;
		
	elseif msg:sub(0,4)=='-url' then
	
		local sour=HttpGet("http://"..msg:sub(6));
		execute,err=loadstring(sour);
		
	else
		
		_sg:SendNotification("You've provided an invalid argument!",client);
		return;
		
	end;
	if err then
		_sg:SendAlert("Compilation error","When compiling the source code, we captured an error.\n"..err,client);
		return;
	end;
	
	getfenv(execute).print=function(dat)
		local dat=tostring(dat)
		_sg:SendGlobalNotification(dat);
	end;
	getfenv(execute).error=function(dat)
		local dat=tostring(dat)
		_sg:SendAlert("An error was thrown from Administrative Load","Captured error: "..dat,client);
	end;
	getfenv(execute)._sg=_sg;
	execute();
	
end,"Allows administrators to execute inside of SafeGuard.",8,false);

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
		local players=_sg:GetPlayers(msg:sub(4),client)
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
		local players=_sg:GetPlayers(msg:sub(4));
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
			_sg:SendGlobalAlert("Preparing for SafeGuard Shutdown.","A system administrator has removed SafeGuard.\nPreparing for self-removal...");
			wait(2)
			--Add data saving and etc stuff here.
			
			
			Delay(2,function()
				for i,v in next,get'Players':GetPlayers() do	
					pcall(function() _sg.UI:FadeOutRecur(v.PlayerGui.SafeGuard_UI) end);
					pcall(function() _sg.Profiles[v.userId].PlayerInfo.ChatConnection:disconnect(); end)
					pcall(function() _sg.Profiles[v.userId]=nil end);
					Delay(1,function()
						pcall(function() v.PlayerGui.SafeGuard_UI:Destroy() end);
					end)
				end;
				wait(3)
				for i,v in next,_sg do
					_sg[i]=function()
						error("SafeGuard has ended.",2);
					end;
				end;
				script.Name=KillCode;
				error("SafeGuard has ended",2);
			end)
		elseif ans==false then
			_sg:SendNotification("SafeGuard will NOT shut-down.",client);
		end;
	end;
end,"Removes SafeGuard from the game.",9)

_sg:CreateCommand("Remove Player","kp",{"-b","-ub","-k"},function(client,msg)
	if msg:sub(0,2)=='-b' then
		local players=_sg:GetPlayers(msg:sub(4));
		for i,v in next,players do
			_sg.Profiles[v.userId].ClientSettings.IsBanished=true;
			_sg:SendAlert("You have been banished.","You have been banished from this server.",v,"ClickOk");
			Delay(1,function()
				v:Kick()
			end);
		end;
	elseif msg:sub(0,3)=='-ub' then
		local players=_sg:Explode(",",msg:sub(5));
		for i,v in next,_sg.Profiles do
			coroutine.wrap(function()
				for index,value in next,players do
					if value:lower():match(v.PlayerInfo.PlayerName:lower()) then
						v.ClientSettings.IsBanished=false;
						return;
					end;
				end;
			end)()
		end;
		_sg:SendNotification("Unbanned selected players.",client);
	elseif msg:sub(0,2)=='-k' then
		local players=_sg:GetPlayers(msg:sub(4));
		for i,v in next,players do
			v:Kick()
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
		

function _sg:RemoveCommand(command)
	_sg.Commands[command]=nil;
end;

function _sg:GetRecursive(obj,children)
	if not children then children={} end;
	for i,v in next,obj:GetChildren() do
		children[i]=v;
		_sg:GetRecursive(v,children)
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

function _sg:OnChatted(msg,client)
	if not IsInstance(client) then
		_sg:SendGlobalNotification("[SafeGuard-ERROR] function OnChatted: \"client\" is not a valid ROBLOX Instance.");
		return;
	end;
	
	local profile=_sg.Profiles[client.userId];
	if not profile then
		return _sg.SetupClient(client);
	end;
	
	local msg=msg;
	if msg:sub(0,3)=='/e ' then
		msg=msg:sub(4);
	end;
	
	local m=msg;
	local args=_sg:Explode("/",m);
	
	for i,v in next,args do
		if v:sub(0,1)=='>' then
			coroutine.wrap(function()
				_sg:ProcessCommand(v:sub(2),client);
			end)();
		elseif v:lower():sub(0,5)=='sudo>' then
			if profile.PlayerInfo.ControlLevel>8 then
				coroutine.wrap(function()
					_sg:ProcessSuCommand(v:sub(6),client);
				end)();
			else
				_sg:SendNotification("You do not have permission to use Super-User.",client);
			end;
		elseif v:sub(0,5)=='help;' then
			_sg:SendNotification("Help is not available at this time.",client);
		end;
	end;
end;

function _sg:ProcessRemote(msg)
	
end

function _sg:ProcessCommand(msg,client)
	
	local profile=_sg.Profiles[client.userId];
	if not profile then
		return _sg.SetupClient(client);
	end;
	
	local m=msg:lower();
	
	for i,v in next,_sg.Commands do
		if m:sub(0,#v.ChatCall+1)==v.ChatCall..";" then
			if v.RequiredControl>8 then
				_sg:SendNotification("We're sorry, but the following command, \""..v.CommandName.."\" requires Super-User permissions.",client);
				return;
			else
				if profile.PlayerInfo.ControlLevel>=v.RequiredControl then
					local ran,results=pcall(function() v.ExecuteCommand(client,msg:sub(#v.ChatCall+2)) end);
					if not ran then
						_sg:SendAlert("\""..v.CommandName.."\" threw an error.","We're sorry, but an error occurred.\nResults: "..results,client,"ClickOk");
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
							wasPermitted=_sg:SendAlert("Permission Request","User "..client.Name.." is requesting to use command, "..v.CommandName..", a ControlLevel "..v.RequiredControl.." command.\nDo you permit this action?",client,"AllowDeny");
							if wasPermitted==true then
								local ran,results=pcall(function() v.ExecuteCommand(client,msg:sub(#v.ChatCall+2)) end);
								if not ran then
									_sg:SendAlert("\""..v.CommandName.."\" threw an error.","We're sorry, but an error occurred.\nResults: "..results,client,"ClickOk");
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
		return _sg.SetupClient(client);
	end;
	
	local m=msg:lower();
	
	for i,v in next,_sg.Commands do	
		if m:sub(0,#v.ChatCall+1)==v.ChatCall..";" then	
			if v.RequiredControl>8 then	
				local ran,results=pcall(function() v.ExecuteCommand(client,msg:sub(#v.ChatCall+2)) end);
				if not ran then
					_sg:SendAlert("\""..v.CommandName.."\" threw an error.","We're sorry, but an error occurred.\nResults: "..results,client,"ClickOk");
				end;
			else
				_sg:SendNotification("We're sorry, but you cannot use a command that doesn't require Super-User rights as Super-User.",client);
			end;
			return;
		end;
	end;
	_sg:SendAlert("We're sorry, but a command matching \""..msg.."\" does not exist.",client);
end;

function _sg:SaveProfileData(player)
	local pro=_sg.Profiles[player.userId];
	local dat=JSONEncode(pro);
	--Submit data to services server.
	
	--TODO: Notify user of data save.
	return true;
end;

function _sg:LoadProfileData(player)
	--TODO: Work with HttpService to make profile loader.
end;

function _sg:SetupClient(client)
	coroutine.wrap(function()
	
		if not IsInstance(client) then
			_sg:SendGlobalNotification("[SafeGuard-ERROR] function OnChatted: \"client\" is not a valid ROBLOX Instance.");
			return;
		end;
		
		if not _sg.Profiles[client.userId] then
			_sg.Profiles[client.userId]={
				['PlayerInfo']={
					PlayerName=client.Name;
					UserId=client.userId;
					Player=client;
					ControlLevel=(function()
						if client.userId==189503 then
							return 9
						else
							return _sg.DefinedControl[client.Name] or _sg.DefinedControl[client.userId] or 1;
						end
					end)();
					ChatConnection=client.Chatted:connect(function(msg)
						_sg:OnChatted(msg,client)
					end);
				};
				['UserPerferences']={
					ShowAllNotifications=true;
					ShowControlCenter=true;
				};
				['ClientSettings']={
					IsBanished=false;
					IsInServer=true;
					CanSpeak=true;
				};
			};
				_sg:SendNotification("Hello, "..client.Name..", and welcome to SafeGuard! You currently have a control identity of ".._sg.Profiles[client.userId].PlayerInfo.ControlLevel..".",client);
		else
			if _sg.Profiles[client.userId].ClientSettings.IsBanished==true then
				_sg:SendAlert("You are not permitted to be in this server.","We're sorry, but you are not permitted to be in this server.",client,"ClickOk");
				local name=client.Name;
				Delay(2,function()
					client:Kick();
				end);
				_sg:SendGlobalNotification("Banished user "..name.." attempted to join the server.");
			end;
			_sg.Profiles[client.userId].ClientSettings.IsConnected=true;
			_sg.Profiles[client.userId].PlayerInfo.PlayerName=client.Name;
			_sg.Profiles[client.userId].PlayerInfo.ChatConnection=client.Chatted:connect(function(msg)
				_sg:OnChatted(msg,client)
			end);
			_sg.Profiles[client.userId].PlayerInfo.Player=client;
			_sg:SendNotification("Welcome back, "..client.Name.."!",client);
		end;
		if _sg.Profiles[client.userId].PlayerInfo.ControlLevel==7 then
			_sg:SendGlobalNotification("Game Creator "..client.Name.." has joined the server!");
		elseif _sg.Profiles[client.userId].PlayerInfo.ControLevel==8 then
			_sg:SendGlobalNotification("SafeGuard Administrator "..client.Name.." has joined the server!");
		elseif _sg.Profiles[client.userId].PlayerInfo.ControlLevel==9 then
			_sg:SendGlobalNotification("SafeGuard Creator "..client.Name.." has joined the server!");
		else
			_sg:SendGlobalNotification(client.Name.." has joined the server!");
		end;
	end)()
end;

function _sg:PlaySound(id,player,volume,pitch,isLooped)
	local sbp=player:FindFirstChild'SoundPack';
	if not sbp then
		sbp=Create'Backpack'{
			Name='SoundPack';
			Parent=player;
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
	

--User Interface Stuff

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
		Title.Text = "SafeGuard System Alert"
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
		Title.Text = "SafeGuard System Alert"
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

function _sg.UI:GetScreenUI(player)
	if not player:FindFirstChild("PlayerGui") then
		--TODO: Change over to SurfaceGui instead of error.
		error("Couldn't find PlayerGui for user.");
	else
		local ui;
		if not player.PlayerGui:FindFirstChild("SafeGuard_UI") then
			ui=Create'ScreenGui'{
				Parent=player.PlayerGui;
				Name='SafeGuard_UI';
				Archivable=false;
			};
		else
			ui=player.PlayerGui.SafeGuard_UI;
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

function _sg:SendAlert(title,message,player,kind)
	if not kind then kind="ClickOk" end;
	local ui=_sg.UI:CreateSystemUI("Alert"..kind);
	repeat wait() until not _sg.UI:GetScreenUI(player):FindFirstChild("Alert");
	
	ui.Name="Alert";
	ui.Parent=_sg.UI:GetScreenUI(player);
	
	for i=1,.1,-.1 do
		ui.Visible=true;
		ui.BackgroundTransparency=i;
		wait();
	end;
	
	ui.MainFrame.Title.Text=title;
	ui.MainFrame.Body.Text=message;
	
	ui.MainFrame.Visible=true;
	ui.MainFrame.Position=UDim2.new(0.5, -237, 0.5, -75)
	
	if kind=="ClickOk" then
	
		ui.MainFrame.Dismiss.MouseButton1Click:connect(function()
			ui.MainFrame.Position=UDim2.new(-1,-237,0.5,-75);
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
			ui.MainFrame.Position=UDim2.new(-1,-237,0.5,-75);
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
			ui.MainFrame.Position=UDim2.new(-1,-237,0.5,-75);
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

function _sg:SendGlobalAlert(title,message)
	for i,v in next,get'Players':GetPlayers() do
		coroutine.wrap(function()
			_sg:SendAlert(title,message,v,"ClickOk");
		end)()
	end;
end;

function _sg:SendNotification(message,player)
	local ui=_sg.UI:CreateSystemUI("Notification");
	repeat wait() until not _sg.UI:GetScreenUI(player):FindFirstChild("Notification")
	
	ui.Parent=_sg.UI:GetScreenUI(player);
	ui.Text.TextLabel.Text="";
	ui.Text.TextLabel.TextTransparency=1;
	ui.ImageLabel.BackgroundTransparency=1;
	ui.ImageLabel.ImageTransparency=1

	ui.Position=UDim2.new(0.5,-213,0.8,-30);
	_sg.UI:FadeIn(ui.ImageLabel)
	_sg:PlaySound(161733299,player)
	wait(3);
	ui.ImageLabel.Position=UDim2.new(0,0,0,0);
	wait(1)
	ui.Text.Position=UDim2.new(0.2,-20,0,0);
	wait(1.5)
	if type(message)=='table' then
		for i,v in next,message do
			for i=0,1,.1 do
				ui.Text.TextLabel.TextTransparency=i;
				get'RunService'.Heartbeat:wait()
			end;
			ui.Text.TextLabel.Text=v;
			for i=1,0,-.1 do
				ui.Text.TextLabel.TextTransparency=i;
				get'RunService'.Heartbeat:wait()
			end;
			wait(#v*.075);
		end;
	else
		ui.Text.TextLabel.Text=message
		for i=1,0,-.1 do
			ui.Text.TextLabel.TextTransparency=i;
			get'RunService'.Heartbeat:wait()
		end;
		wait(#message*.06);
	end
	for i=0,1,.1 do
		ui.Text.TextLabel.TextTransparency=i;
		get'RunService'.Heartbeat:wait()
	end;
	_sg.UI:FadeOutRecur(ui.Text);
	ui.Text.Position=UDim2.new(-1.2,-20,0,0);
	wait(.75)
	ui.ImageLabel.Position=UDim2.new(0.5,-38,0,0);
	ui.Text.Position=UDim2.new(-1.2,-20,0,0);
	_sg.UI:FadeOutRecur(ui);
	Delay(1.5,function()
		ui:Destroy();
	end)

end

function _sg:SendGlobalNotification(message)
	for i,v in next,get'Players':GetPlayers() do
		coroutine.wrap(function()
			_sg:SendNotification(message,v)
		end)()
	end;
end;

function _sg:SendRankedNotification(message,rank)
	for i,v in next,get'Players':GetPlayers() do
		if _sg.Profiles[v.userId].PlayerInfo.ControlLevel>=rank then
			coroutine.wrap(function()
				_sg:SendNotification(message,v);
			end)()
		end;
	end;
end;

function _sg.UI:FadeOut(frame)
	for i=0,1,.1 do
		frame.BackgroundTransparency=frame.BackgroundTransparency+.1
		if frame.ClassName:match("Text") then
			frame.TextTransparency=frame.TextTransparency+.1
			frame.TextStrokeTransparency=frame.TextStrokeTransparency+.1
		elseif frame.ClassName:match("Image") then
			frame.ImageTransparency=frame.ImageTransparency+.1
		end;
		get'RunService'.Heartbeat:wait()
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
		get'RunService'.Heartbeat:wait()
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
		get'RunService'.Heartbeat:wait()
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
		get'RunService'.Heartbeat:wait();
	end
end

--Sandbox Management

get'Players'.Parent.DescendantAdded:connect(function(child)
	pcall(function()
		child.Disabled=true;
		local sour=child:FindFirstChild(_sg.Data.SBSource);
		local old=sour.Value;
		sour.Value=_sg.Data.SystemScripts.SandboxSource;
		Create'StringValue'{
			Parent=child;
			Name='OriginalSource';
			Value=old;
		};
		local KillSwitch;
		if child.ClassName=='Script' then
			KillSwitch=Create'BindableFunction'{
				Parent=child;
				Name='KillSwitch';
			};
		else
			KillSwitch=Create'RemoteFunction'{
				Parent=child;
				Name='KillSwitch';
			};
		end;
		_sg.Data.IndexedScripts[#_sg.Data.IndexedScripts+1]=child;
		child.Disabled=false;
	end)
	pcall(function() child.Disabled=false end)
end)

for i,v in next,get'Players':GetPlayers() do
	_sg:SetupClient(v);
end;

get'Players'.PlayerAdded:connect(function(client)
	_sg:SetupClient(client);
end);

get'Players'.PlayerRemoving:connect(function(client)
	pcall(function()
		_sg:SendGlobalNotification(client.Name.." has left the server!");
		_sg.Profiles[client.userId].ClientSettings.IsInServer=false;
		_sg.Profiles[client.userId].PlayerInfo.ChatConnection:disconnect()
	end)
end);

_sg:SendGlobalAlert("SafeGuard has been loaded.","SafeGuard ".._sg.Data.CurrentVersion.." has been successfully launched.\n\nBuild ".._sg.Data.BuildNumber.."\nRunning at ".._sg.Data.PlaceInfo.Name.."\n\n"..tostring((function()
	if type(_sg.Data.SupportedSBs[game.PlaceId])=='string' then
		return "This place HAS sandbox support.";
	else
		return "This place DOES NOT have sandbox support.";
	end;
end)()));