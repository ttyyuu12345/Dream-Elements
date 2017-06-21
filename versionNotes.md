Dream Elements Admin Framework Version Planning
An modular administration system built with an extensive API for creating games and projects on top of.
===

1.0 rtp major features:

- [1] Modular "core" which is shared between Server and Clients
- [1] Enchanted system integrity thru internal thread tracking + sandboxing
- [1] User Account services for storing user settings, permissions, moderation data and be able to be stored into both datastore and remote server (base work for later)
- [1] Application "sandbox" for creating and managing various system features (commands, gui, etc)
- [2] Add basic commands (generic admin stuff, etc)



0.1 beta:
DreamCore security + module loading

- [1](CORE)     CoreGuard:
                Internal security policy enforcer which sandboxes system components and identifies them
                via their threads.

                - [1] API for storing data and referencing it to threads
                - [1] Permissions API following the SecurityRing concept
                - [1] Sandbox API which creates individual sandboxes for system components while
                      using the same functions for lightweight memory usage + increased performance

- [1](CORE)     ComponentLoader:
                Using CoreGuard to create a new Session + Sandbox, loads system components into DreamCore
                and ensures their using the CoreGuard Sandboxed Environment

                - [1] API for loading system components into DreamCore


    0.1.1 beta:
    DreamCore Libraries

    - [1] GeneralUtilities library (Modifying/Creating Instances)
    - [1] LuaSignals  (Create custom "RBXLuaSignals" in pure Lua)



0.2.0 beta:
