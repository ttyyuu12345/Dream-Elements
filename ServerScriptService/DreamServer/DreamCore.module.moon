-- Dream Elements | DreamServer/DreamCore.moon
-- DreamCore ver 0.1 indev
--
-- Responsible for providing a universal structure on both Server and Clients.
--
-- Changelog:
-- [indev 8917]
--    # Implemented ComponentsManager


dreamCore = {}
internalResources = {}  -- used by modules to securely share/store internal API


do
  componentsManager = {}

  -- variables
  installedComponents = {}  -- contains all "installed" modules
  installedComponentsLookup = setmetatable {}, {__mode: "v"}  -- lookup reference for installed modules
  coreComponents = script\WaitForChild "Components"\GetChildren


    -- register all of our modules
  for _, component in next, coreComponents
    assert component.ClassName == "ModuleScript", "[DreamCore.ComponentsManager ERROR] Expected #{component\GetFullName!} to be of Class ModuleScript, got #{component.ClassName}"

    componentProxy = require component\Clone!
    componentProxy\setup dreamCore, internalResources
    table.insert installedComponents, componentProxy
    installedComponentsLookup[component] = {componentProxy, #installedComponents}
    print "[DreamCore.ComponentsManager] Installed CoreComponent #{component.Name}"


  -- ComponentsManager:installComponent(Instance component, boolean setupNow = false)
  -- Installs an Component to DreamCore
  componentsManager.installComponent = (component, setupNow = false) =>
    dreamCore.DebugTools\checkType component, "Instance"
    dreamCore.DebugTools\checkType setupNow, "boolean"
    dreamCore.DebugTools\assert component.ClassName == "ModuleScript", "Bad argument #1 (RBXClass ModuleScript expected, got #{component.ClassName})"

    componentProxy = require component\Clone!
    componentProxy\setup dreamCore, internalResources
    table.insert installedComponents, {componentProxy, #installedComponents}
    installedComponentsLookup[component] = componentProxy
    dreamCore.DebugTools\output "Installed Component #{componentProxy\GetInstance ().Name}"


  -- ComponentsManager:uninstallComponent(Instance component)
  -- Cleans up and removes an Component from DreamCore
  componentsManager.uninstallComponent = (component) =>
    dreamCore.DebugTools\checkType component, "Instance"
    dreamCore.DebugTools\assert component.ClassName == "ModuleScript", "Bad argument #1 (RBXClass ModuleScript expected, got #{component.ClassName})"

    componentProxy = installedComponentsLookup[components][1] assert componentProxy, "This Component was never installed."
    if typeof componentProxy.uninstall == "function"
      -- TODO: implement some type of security checkpoint, as this is a vurnability af.
      componentProxy\uninstall!

    table.remove installedComponents, installedComponentsLookup[2]
    dreamCore.DebugTools\output "Uninstalled Component #{componentProxy\GetInstance ().Name}"


    -- ComponentManager proxy thing
    proxy = newproxy true
    proxyMetatable = getmetatable proxy
    proxyMetatable.__index = componentsManager
    proxyMetatable.__tostring = -> "DreamCore.ComponentsManager"
    proxyMetatable.__metatable = "The metatable is locked"
    internalResources.componentsManager = proxy



-- DreamCore proxy
proxy = newproxy true
proxyMetatable = getmetatable proxy
proxyMetatable.__call = () =>
  if internalResources.CoreGuard\isEnabled!
    internalResources.CoreGuard\requireAuthenication!

  dreamCore
proxyMetatable.__tostring = -> "DreamCore.ComponentsManager"
proxyMetatable.__metatable = "The metatable is locked"
proxy
