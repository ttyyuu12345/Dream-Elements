-- DreamCore.DebugTools
-- Tools utilized throughout Dream Elements for debugging its various components


api = {}
local dreamCore
local internalResources


api.setup = (_dreamCore, _internalResources) =>
  dreamCore           = _dreamCore
  internalResources   = _internalResources

  internalResources.DebugTools = api
  api.setup = nil


api.uninstall = () =>
  internalResources.DebugTools\error "This Component cannot be uninstalled!", true


-- DebugTools:error(string message, boolean forceError = false, boolean breakExecution = true)
-- Internal "error" function used for tracking issues and formatting error output.
api.error = (message, forceError = false, breakExecution = true) =>
  api\checkType message, "string"
  api\checkType forceError, "boolean"
  api\checkType breakExecution, "boolean"

  if (internalResources.developerConfig.debug.enabled or forceError)
    requestingScript = getfenv (2).script
    message = "[DreamCore.#{requestingScript.Name} ERROR] #{message}\n\n#{debug.traceback!}\n\n"

    if (breakExecution)
      error message, 2
    else
      spawn -> error message, 2


-- DebugTools:checkType(anytype variable, string typeToCompare)
-- Internal tool used to check variable types
api.checkType = (variable, typeToCompare, position) =>
  if (internalResources.developerConfig.debug.enabled)
    if (typeof variable == typeToCompare)
      api.error "Argument #{position} expected type #{typeToCompare}, got #{typeof variable}", true




-- proxy
proxy = newproxy true
proxyMetatable = getmetatable proxy
proxyMetatable.__index = api
proxyMetatable.__tostring = -> "DreamCore.DebugTools"
proxyMetatable.__metatable = "The metatable is locked"
proxy
