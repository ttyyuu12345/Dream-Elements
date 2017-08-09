--SafeGuard ServerScript
--This script is designed specifically for SafeGuard, and shouldn't be used for anything else.

if not script.ClassName=="Script" then
	error("Failed to execute: Not a ServerScript.")
end
local source=script:FindFirstChild("SCode")
if source then
	local func,err=loadstring(source.Value)
	if not err then
		local ran,problem=ypcall(function() func() end)
		if not ran then
			error(problem)
		end
	else
		error(err)
	end
end