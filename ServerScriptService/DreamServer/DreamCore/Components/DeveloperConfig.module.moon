-- DreamCore.DeveloperConfig
-- This settings are intended for Developers, as it controls various debugging components
-- throughout the System.

developerConfig = {
  -- DeveloperConfig.Debug
  -- Controls how Dream Elements handles its code debugging features
  debug: {
    enabled:                    true      -- turn off in production to reduce vm calls
    specificModeEnabled:        false     -- Utilizing the "SpecificComponents" section, determines whether just specific or all Components
    -- will spit out their debug information.

    specificComponents:         {
      ["DreamCore"]:                      true
    }
  }
  -- DeveloperConfig.
}



-- variables
api = {}
local dreamCore
local internalResources

api.setup = (_dreamCore, _internalResources) =>
  dreamCore = _dreamCore
  internalResources = _internalResources

  internalResources.developerConfig = developerConfig
  api.setup = nil


api.uninstall = () =>
  internalResources.DebugTools\error "This Component cannot be uninstalled!", true  -- DEVELOPER NOTE: dreamCore.DebugTools.error (string message, boolean forceError = false)
  -- forceError should bypass the DeveloperConfig setting check;


-- DeveloperConfig:getSetting(string path)
-- Breaks down the path to locate the DeveloperConfig setting in a secure manner.
api.getSetting = (path) =>
  assert api.setup == nil, "Component has not been configured!"

  result = developerConfig
  for split in string.gmatch path, "%w+"
    result = result[split]

  result



-- Create proxy for handling API
proxy = newproxy true
proxyMetatable = getmetatable proxy
proxyMetatable.__index = api
proxyMetatable.__tostring = -> "DreamCore.DeveloperConfig"
proxyMetatable.__metatable = "The metatable is locked"
proxy
