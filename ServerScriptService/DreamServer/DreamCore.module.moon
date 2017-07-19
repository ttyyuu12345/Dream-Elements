-- DreamCore indev 0.1
-- Foundation of the Dream Elements system
dreamCore = {
  public:       {}
  internal:     {}
}


-- dreamConfig
-- Internal developer settings responsible for activating developer stuff. Does nothing useful unless
-- you're modding the system.
with dreamConfig = {}
  dreamCore.internal.dreamConfig = dreamConfig

  -- dreamConfig.debug
  -- Control various features of the internal debugger
  dreamConfig.debug = {
    printEnabled:         true
    debugModeEnabled:     true
  }


  -- dreamConfig.versioning
  -- Responsible for telling our Update server what version we're running. It's advised
  -- you don't mess with these settings unless you are modding Dream Elements.
  dreamConfig.versioning = {
    updateBranch:         "indev"
    major:                "0"
    minor:                "1.0"
    operatingType:        game\GetService("RunService")\IsServer! == true and "Server" or game\GetService("RunService")\IsStudio! and "Studio" or "Client"
  }


-- Enums and EnumsManager
-- Responsible for providing Dream Elements with clean code through Enumeration
with enums, enumsManager = {}, {}
  dreamCore.internal.enums = enums
  dreamCore.internal.enumsManager = enumsManager


  -- Enum createEnum (string name, table values)
  -- Creates a new Enum datatype and returns it
  enumsManager.createEnum = (name, values) ->
    if dreamCore.internal.dreamConfig.debug.debugModeEnabled
      assert typeof name == "string", "bad argument 1 (string expected, got #{typeof name})"
      assert typeof values == "table", "bad argument 2 (table expected, got #{typeof values})"


    enumType = {}
    enumTypeProxy = newproxy true
    enumTypeProxyMetatable = getmetatable enumTypeProxy

    for key, value in next, values
      enumObjectProxy = newproxy true
      enumObjectProxyMetatable = getmetatable enumObjectProxyMetatable

      enumObjectProxyMetatable.__index = {
        Value: key
        Parent: enumTypeProxy
      }
      enumObjectProxyMetatable.__tostring = () =>
        "#{name}.#{key}"
      enumObjectProxyMetatable.__metatable = "This metatable is locked"
      enumType[key] = enumObjectProxy

    enumTypeProxyMetatable.__index = enumType
    enumTypeProxyMetatable.__metatable = "This metatable is locked"
    enums[name] = enumTypeProxy

    enumTypeProxy


-- debugTools
-- Internal tools designed to assist with debugging issues within Dream Elements
with debugTools = {}
  dreamCore.internal.debugTools = debugTools


  -- debugTools.checkType (vararg value, number position, string expectedType)
  -- If debugMode is enabled, will check to see if the type of value matches expectedType
  debugTools.checkType = (value, position, expectedType) =>
    if dreamCore.internal.dreamConfig.debug.debugModeEnabled
      assert typeof position == "number", "bad argument 2 (number expected, got #{typeof position})"
      assert typeof expectedType == "string", "bad argument 3 (string expected, got #{typeof expectedType})"

      if not typeof value == expectedType
        error "bad argument #{position} (#{expectedType} expected, got #{typeof value})", 2


  -- debugTools.output (string message, boolean includeTraceback)
  -- If debugMode is enabled, will send message to the output and an optional traceback
  debugTools.output = (message, includeTraceback = false) =>
    if dreamCore.internal.dreamConfig.debug.debugModeEnabled
      debugTools\checkType message, "string"
      debugTools\checkType includeTraceback, "boolean"


      print "Dream#{dreamCore.internal.dreamConfig.versioning.operatingType} DEBUG:\n#{message}\n#{includeTraceback and .. debug.traceback! .."\n\n".. or .."\n"}"


  -- debugTools.nonblockingError (string message, number level)
  -- Throws an error without stopping execution
  debugTools.nonblockingError = (message, level = 2) =>
    debugTools\checkType message, "string"
    debugTools\checkType level, "number"


    spawn ->
      error message, level + 1



----------------------------------------------
----- !!! WARNING !!! ------------------------
----- Old source beyond this point -----------
----- Will soon be rewritten -----------------
----- That is all ----------------------------
----------------------------------------------


-- componentsManager
-- Responsible for managing + organizing code, enforcing sandboxing, authenication requirements, and in-game updates.
with dreamCore.internal.componentsManager = {}
  installedComponents       = {}
  localStorage              = {}
  activeThreads             = {}


  -- authenicationManager
  -- Responsible for enforcing authenication requirement for protected API
  authenicationManager = {}
  do
    authenicatedThreads         = setmetatable {}, {__mode: "k"}
    authenicationGrantedEnum    = newproxy!
    rootThread                  = coroutine.running!


    -- void authenicotionManager.RequireAuthenication ()
    -- Enforces that the calling thread is authorized with the System before continuing execution.
    authenicationManager.RequireAuthenication = () =>
      if not authenicatedThreads[coroutine.running!]
        error "Error occurred, no output from Lua.", 0


    -- void authenicationManager.AuthenicateThread (thread thread)
    -- Authenicates the provided thread with the System
    authenicationManager.AuthenicateThread = (thread) =>
      if dreamConfig.debug.debugModeEnabled
        assert typeof thread == "thread", "bad argument #1 (thread expected, got #{typeof thread})"


      authenicatedThreads[thread] = authenicationGrantedEnum


    -- boolean authenicationManager.IsThreadAuthenicated ()
    -- Returns whether the thread is authenicated or not
    authenicationManager.IsThreadAuthenicated = () =>
      authenicatedThreads[coroutine.running!] == authenicationGrantedEnum and true or false


    -- manually authenicate the root thread
    authenicatedThreads[rootThread] = authenicationGrantedEnum
    dreamCore.internal.debug.output "authenicated root thread!"


  -- sandboxManager
  -- Responsible for sandboxing the various components of dreamCore
  sandboxManager = {}
  do
    sandboxCache          = {}

    -- sandboxConfig
    -- Global settings which effect all sandbox containers
    sandboxConfig     = {}
    do
      -- sandboxConfig.blockedObjects
      -- Objects which are blocked across all sandboxes
      sandboxConfig.blockedObjects          = {

      }


      -- sandboxConfig.lockedInstances
      -- Instances which can be interacted with, but not destroyed
      sandboxConfig.lockedInstances         = {

      }


      -- sandboxConfig.classModifier
      -- Allows you to directly modify a ROBLOX class, performing various checks
