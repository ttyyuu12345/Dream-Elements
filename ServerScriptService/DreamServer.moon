setmetatable            = setmetatable
newproxy                = newproxy
coroutine               = coroutine
error                   = error
typeof                  = typeof
game                    = game
setfenv                 = setfenv
Instance                = Instance
spawn                   = spawn

setfenv 1, {}
setfenv 2, {}


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
  dreamServer.apiPrivate[name]     = {}

  if not isInternalOnly
    dreamServer.publicAPI[name]     = {}
    dreamServer.data[name], dreamServer.privateAPI[name], dreamServer.publicAPI[name]

  dreamServer.data[name], dreamServer.privateAPI[name]



-- internal serverGuard 1.0
-- Critical security backbone of dreamServer. Responsible for registering System threads and
-- protecting sensitive API from outside access.
with data, private, public = createAPIBlock "ServerGuard"
  data.threads                      = setmetatable {}, {__mode: "k"}
  data.rootThread                   = coroutine.running!
  data.authenicationStatusEnums     = {
    granted:      newproxy!
    denied:       newproxy!
  }

  -- void boolean private\IsThreadAuthenicated (thread coroutine)
  -- Returns whether the thread is authenicated as System or not.
  private.IsThreadAuthenicated = (coroutine = coroutine.running!) =>
    assert data.threads[coroutine.running!], "Error occurred, no output from Lua."

    if forceTypeChecks
      assert typeof coroutine == "thread", "bad argument #1 (thread expected, got #{typeof coroutine})"


    if data.threads[coroutine] == data.authenicationStatusEnums.granted
      true

    false


  -- void private\RegisterThreadAsSystem (thread coroutine)
  -- Registers the provided thread as a System thread, thus granting it access to critical
  -- internal API
  private.RegisterThreadAsSystem = (coroutine) =>
    assert data.threads[coroutine.running!], "Error occurred, no output from Lua."

    if forceTypeChecks
      assert typeof coroutine == "thread", "bad argument #1 (thread expected, got #{typeof coroutine})"


    data.threads[coroutine] = data.authenicationStatusEnums.granted
    debugOutput "Registered #{tostring coroutine} as System"


  -- ProtectedAPI void private.RequireAuthenicationToExecute
  -- Requires that the calling thread is reigstered as System before continuing execution of code.
  private.RequireAuthenicationToExecute = () =>
    assert data.threads[coroutine.running!], "Error occurred, no output from Lua."


-- LTStorageService 0.1
-- Responsible for handling long-term data storage requests.
with data, private, public = createAPIBlock "LTStorageService"
  data.requestQueue         = {}

  -- *TEMPORARY STORAGE SYSTEM*
  -- For now, we'll use DataStores until we've built enough to start working on our external
  -- web services.
  httpService = game\GetService "HttpService"
  dataStore   = game\GetService "DataStoreService"\GetDataStore "Dream Elements"

  requestAttemptLimit   = 10
  requestTypeEnum       = {
    retrieve:         newproxy! ,
    set:              newproxy! ,
    update:           newproxy!
  }


  -- ProtectedAPI vararg LSStorageService.RetrieveKeyAsync (string Key)
  -- Queues a Retrieve request for the LSStorageService
  private.RetrieveKeyAsync = (key) =>
    dreamServer.api.ServerGuard\RequireAuthenicationToExecute!
    assert typeof key == "string", "bad argument #1 (string expected, got #{typeof key})"

    request = {
      requestTypeEnum.retrieve,
      key,
      0,
      Instance.new "BindableEvent",
    }
    table.insert data.requestQueue, request
    unpack httpService\JsonDecode request[4].Event\wait!

  -- ProtectedAPI vararg LSStorageService.SetKeyAsync (string key, vararg value)
  -- Queues a set request for the LSStorageService
  private.SetKeyAsync = (key, value) =>
    dreamServer.api.ServerGuard\RequireAuthenicationToExecute!
    assert typeof key == "string", "bad argument #1 (string expected, got #{typeof key})"

    Request = {
      RequestTypeEnum.Set,
      Key,
      0,
      Instance.new "BindableEvent",
      Value
    }
    table.insert RequestQueue, Request
    unpack HttpService\JsonDecode Request[4].Event\wait!

  -- ProtectedAPI vararg LTStorageService.UpdateKeyAsync (string key, function callback)
  -- Queues a Update request for the LSStorageService
  privateAPI.UpdateKeyAsync = (key, callback) =>
    dreamServer.privateAPI
    assert typeof Key == "string", "bad argument #1 (string expected, got #{typeof Key})"
    assert typeof Callback == "function", "bad argument #2 (function expected, got #{typeof Callback})"

    Request = {
      RequestTypeEnum.Update,
      Key,
      0,
      Instance.new "BindableEvent",
      Callback,
    }
    table.insert RequestQueue, Request
    unpack HttpService\JsonDecode Request[4].Event\wait!


  -- Service Daemon
  spawn ->
    Request           = nil
    RequestType       = nil
    Key               = nil
    Attempts          = nil
    PassResults       = nil
    Success, Result   = nil, nil


    while true
      if #RequestQueue > 0
        Request = table.remove RequestQueue, 1
        RequestType = Request[1]
        Key         = Request[2]
        Attempts    = Request[3]
        PassResults = Request[4]

        if RequestType == RequestTypeEnum.Retrieve
          Success, Result = pcall ->
            DataStore\UpdateAsync Key, (oldData) ->
              Result = oldData

        elseif RequestType == RequestTypeEnum.Set
          Success, Result = pcall ->
            DataStore\SetAsync Key, Request[5]

        elseif RequestType == RequestTypeEnum.Update
          Success, Result = pcall ->
            DataStore\UpdateAsync Key, Result[5]

        else
          error "Invalid request type #{tostring RequestType}", 0, false


        if not Success
          if Attempts < RequestAttemptLimit
            Request.Attempts += 1
            table.insert RequestQueue, Request
            error "BackendDataService failure!\n#{Result}", 0, false

          else
            error "BackendDataService gave up on request!", 0, false

        else
          PassResults\Fire HttpService\JsonEncode {Result}

      wait 1


-- UserAccountsService
--
