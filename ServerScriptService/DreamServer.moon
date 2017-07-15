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
  public:       {}
  data:         {}
  api:          {}
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


  dreamServer.data[name]    = {}
  dreamServer.api[name]     = {}

  if not isInternalOnly
    dreamServer.public[name]     = {}
    dreamServer.api[name], dreamServer.data[name], dreamServer.public[name]

  dreamServer.api[name], dreamServer.data[name], dreamServer.public[name]



-- internal serverGuard 1.0
-- Critical security backbone of dreamServer. Responsible for registering System threads and
-- protecting sensitive API from outside access.
with private, data, public = createAPIBlock "serverGuard"
  data.threads                      = setmetatable {}, {__mode: "k"}
  data.rootThread                   = coroutine.running!
  data.authenicationStatusEnums     = {
    granted:      newproxy!
    denied:       newproxy!
  }

  -- void private\registerThreadAsSystem (thread coroutine)
  -- Registers the provided thread as a System thread, thus granting it access to critical
  -- internal API
  private.registerThreadAsSystem = (coroutine) =>
    assert data.threads[coroutine.running!], "Error occurred, no output from Lua."

    if forceTypeChecks
      assert typeof coroutine == "thread", "bad argument #1 (thread expected, got #{typeof coroutine})"


    data.threads[coroutine] = true
    debugOutput "Registered #{tostring coroutine} as System"


  -- ProtectedAPI void public.requireAuthenicationToExecute
  -- Requires that the calling thread is reigstered as System before continuing execution of code.
  public.requireAuthenicationToExecute = () =>
    assert data.threads[coroutine.running!], "Error occurred, no output from Lua."



  -- boolean public.isThreadSystem = (thread coroutine = coroutine.running!) =>
  -- Returns whether the thread is registered as System or not
  public.isThreadSystem = (coroutine = coroutine.running!) =>
    if forceTypeChecks
      assert typeof coroutine == "thread", "Error occured, no output from Lua."


    data.threads[coroutine] or false



-- BackendDataService 0.1
-- Internal service responsible for handling long-term storage.
BackendDataService = {}
do
  DreamServer.BackendDataService = BackendDataService

  -- *TEMPORARY STORAGE SYSTEM*
  HttpService = game\GetService "HttpService"
  DataStore   = game\GetService "DataStoreService"\GetDataStore "Dream Elements"

  RequestAttemptLimit   = 10
  RequestQueue          = {}
  RequestTypeEnum       = {
    Retrieve:         newproxy! ,
    Set:              newproxy! ,
    Update:           newproxy!
  }


  -- ProtectedAPI ... BackendDataService.RetrieveKeyAsync (string Key)
  -- Queues a Retrieve request for the BackendDataService
  BackendDataService.RetrieveKeyAsync = (Key) =>
    AuthenicationManager\RequireAuthenication!
    assert typeof Key == "string", "bad argument #1 (string expected, got #{typeof Key})"

    Request = {
      RequestTypeEnum.Retrieve,
      Key,
      0,
      Instance.new "BindableEvent",
    }
    table.insert RequestQueue, Request
    unpack HttpService\JsonDecode Request[4].Event\wait!

  -- ProtectedAPI ... BackendDataService.SetKeyAsync (string Key, ... Value)
  -- Queues a Set request for the BackendDataService
  BackendDataService.SetKeyAsync = (Key, Value) =>
    AuthenicationManager\RequireAuthenication!
    assert typeof Key == "string", "bad argument #1 (string expected, got #{typeof Key})"

    Request = {
      RequestTypeEnum.Set,
      Key,
      0,
      Instance.new "BindableEvent",
      Value
    }
    table.insert RequestQueue, Request
    unpack HttpService\JsonDecode Request[4].Event\wait!

  -- ProtectedAPI ... BackendDataService.UpdateKeyAsync (string Key, function Callback)
  -- Queues a Update request for the BackendDataService
  BackendDataService.UpdateKeyAsync = (Key, Callback) =>
    AuthenicationManager\RequireAuthenication!
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
