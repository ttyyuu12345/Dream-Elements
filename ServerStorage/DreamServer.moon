
setmetatable            = setmetatable
newproxy                = newproxy
coroutine               = coroutine
error                   = error
typeof                  = typeof
game                    = game
setfenv                 = setfenv
Instance                = Instance
spawn                   = spawn
wait                    = wait
tostring                = tostring
assert                  = assert
string                  = string
debug                   = debug
print                   = print
_G                      = _G

setfenv 1, {}


-- dreamServer ver 0.0.1 indev
-- Core component responsible for handling Server tasks
dreamServer   = {
  publicAPI:       {}
  privateAPI:      {}
  data:            {}
}

-- Internal settings
forceTypeChecks       = true
debugOutputEnabled    = true
debugModeEnabled      = true


-- internal void debugOutput (string message, vararg ...)
-- Sends detailed information about system operations to output, if enabled.
debugOutput = (message, ...) ->
  if forceTypeChecks
    assert typeof message == "string", "bad argument #1 (string expected, got #{typeof message})"

  if debugOutputEnabled
    message = string.format message, ...
    print "[dreamServer DEBUG] ->\n#{message}\n#{debug.traceback!}\n"


-- internal vararg createAPIBlock (string name, boolean isInternalOnly = false)
-- Automates boilerplate code for API blocks.
createAPIBlock = (name, isInternalOnly = false) ->
  if forceTypeChecks
    assert typeof name == "string", "bad argument #1 (string expected, got #{typeof name})"
    assert typeof isInternalOnly == "boolean", "bad argument #2 (boolean expected, got #{typeof isInternalOnly})"


  dreamServer.data[name]           = {}
  dreamServer.privateAPI[name]     = {}

  if not isInternalOnly
    dreamServer.publicAPI[name]     = {}
    return dreamServer.data[name], dreamServer.privateAPI[name], dreamServer.publicAPI[name]

  dreamServer.data[name], dreamServer.privateAPI[name]



-- internal serverGuard 1.0
-- Critical security backbone of dreamServer. Responsible for registering System threads and
-- protecting sensitive API from outside access.
with data, private, public = createAPIBlock "ServerGuard"
  -- Forgot it's a bad idea to include this stuff in data ...
  authenicatedThreads                      = setmetatable {}, {__mode: "k"}
  rootThread                               = coroutine.running!
  authenicationStatusEnums                 = {
    granted:      newproxy!
    denied:       newproxy!
  }

  -- void boolean public\IsThreadAuthenicated (thread coroutine)
  -- Returns whether the thread is authenicated as System or not.
  public.IsThreadAuthenicated = (coroutine = coroutine.running!) =>
    if forceTypeChecks
      assert typeof coroutine == "thread", "bad argument #1 (thread expected, got #{typeof coroutine})"


    if authenicatedThreads[coroutine] == authenicationStatusEnums.granted
      true

    false


  -- void private\AuthenicateThread (thread thread)
  -- Registers the thread as System for using protected APIs
  private.AuthenicateThread = (thread) =>
    private\RequireAuthenication!

    if forceTypeChecks
      assert typeof thread == "thread", "bad argument #1 (thread expected, got #{typeof thread})"


    authenicatedThreads[thread] = authenicationStatusEnums.granted
    debugOutput "#{tostring thread} is now authenicated"


  -- ProtectedAPI void private.RequireAuthenication
  -- Requires that the calling thread is registered as System before continuing execution of code.
  private.RequireAuthenication = () =>
    assert authenicatedThreads[coroutine.running!], "Error occurred, no output from Lua."


  -- ProtectedAPI void public.RunAsSystem (function callback)
  -- Authenicates the provided callback as System
  public.RunAsSystem = (callback, ...) =>
    --private\RequireAuthenication!

    if forceTypeChecks
      assert typeof callback == "function", "bad argument #1 (function expected, got #{typeof callback})"

    authenicatedThread = coroutine.create callback
    private\AuthenicateThread authenicatedThread
    coroutine.resume authenicatedThread, ...


  -- manually authenicate master thread
  authenicatedThreads[rootThread] = authenicationStatusEnums.granted


-- LTStorageService 0.1
-- Responsible for handling long-term data storage requests.
with data, private, public = createAPIBlock "LTStorageService"
  data.requestQueue         = {}

  -- *TEMPORARY STORAGE SYSTEM*
  -- For now, we'll use DataStores until we've built enough to start working on our external
  -- web services.
  data.httpService = game\GetService "HttpService"
  with data.dataStore   = game\GetService "DataStoreService"
    data.dataStore\GetDataStore "Dream Elements", "TestBuild"

  data.requestAttemptLimit   = 10
  data.requestTypeEnum       = {
    retrieve:         newproxy! ,
    set:              newproxy! ,
    update:           newproxy!
  }


  -- ProtectedAPI vararg LTStorageService.RetrieveKeyAsync (string Key)
  -- Queues a Retrieve request for the LSStorageService
  private.RetrieveKeyAsync = (key) =>
    dreamServer.privateAPI.ServerGuard\RequireAuthenicationToExecute!
    assert typeof key == "string", "bad argument #1 (string expected, got #{typeof key})"

    request = {
      data.requestTypeEnum.retrieve,
      key,
      0,
      Instance.new "BindableEvent",
    }
    table.insert data.requestQueue, request
    unpack data.httpService\JsonDecode request[4].Event\wait!

  -- ProtectedAPI vararg LTStorageService.SetKeyAsync (string key, vararg value)
  -- Queues a set request for the LSStorageService
  private.SetKeyAsync = (key, value) =>
    dreamServer.privateAPI.ServerGuard\RequireAuthenicationToExecute!
    assert typeof key == "string", "bad argument #1 (string expected, got #{typeof key})"

    request = {
      data.requestTypeEnum.set,
      key,
      0,
      Instance.new "BindableEvent",
      value
    }
    table.insert data.requestQueue, request
    unpack data.httpService\JsonDecode request[4].Event\wait!

  -- ProtectedAPI vararg LTStorageService.UpdateKeyAsync (string key, function callback)
  -- Queues a Update request for the LSStorageService
  private.UpdateKeyAsync = (key, callback) =>
    dreamServer.privateAPI.ServerGuard\RequireAuthenicationToExecute!
    assert typeof key == "string", "bad argument #1 (string expected, got #{typeof key})"
    assert typeof callback == "function", "bad argument #2 (function expected, got #{typeof callback})"

    request = {
      data.requestTypeEnum.Update,
      key,
      0,
      Instance.new "BindableEvent",
      callback,
    }
    table.insert data.requestQueue, request
    unpack data.httpService\JsonDecode request[4].Event\wait!


  -- Service Daemon
  spawn ->
    request           = nil
    requestType       = nil
    key               = nil
    attempts          = nil
    passResults       = nil
    success, result   = nil, nil


    while true
      if #data.requestQueue > 0
        request     = table.remove data.requestQueue, 1
        requestType = request[1]
        key         = request[2]
        attempts    = request[3]
        passResults = request[4]

        if requestType == data.requestTypeEnum.retrieve
          success, result = pcall ->
            data.dataStore\UpdateAsync key, (oldData) ->
              result = oldData

        elseif requestType == data.requestTypeEnum.set
          success, result = pcall ->
            data.dataStore\SetAsync key, request[5]

        elseif requestType == data.requestTypeEnum.update
          success, result = pcall ->
            data.dataStore\UpdateAsync key, result[5]

        else
          error "Invalid request type #{tostring requestType}", 0, false


        if not success
          if attempts < data.requestAttemptLimit
            request.attempts += 1
            table.insert data.requestQueue, request
            error "LTStorageService failure!\n#{result}", 0, false

          else
            error "LTStorageService gave up on request!", 0, false

        else
          data.passResults\Fire data.httpService\JsonEncode {result}

      wait 1


-- UserAccountsService
--


if debugModeEnabled
  debugOutputEnabled = true -- override output setting, as debug mode is enabled.
  debugOutput "Dream Elements is running in Debug Mode!"

  _G.dreamServer = dreamServer
