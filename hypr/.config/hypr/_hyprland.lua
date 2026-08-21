require("modules.env")

require("modules.monitor")
require("modules.exec-once")
-- require("modules.binds")

local ok, err = pcall(require, "modules.binds")
if not ok then
  print("\n--- HYRPLAND LUA ERROR IN BINDS ---")
  print(err)
  print("-----------------------------------\n")
end

require("modules.general")
require("modules.layouts")
require("modules.group")
require("modules.input")

require("modules.rules")
require("modules.permissions")
require("modules.misc")
