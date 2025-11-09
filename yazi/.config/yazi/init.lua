---@diagnostic disable: undefined-global

Status:children_add(function(self)
  local h = self._current.hovered
  return h and h.link_to and (" -> " .. tostring(h.link_to)) or ""
end, 3300, Status.LEFT)

th.git = th.git or {}
th.git.added = ui.Style():fg("green")
th.git.added_sign = "A"
th.git.modified = ui.Style():fg("yellow")
th.git.modified_sign = "M"
th.git.updated = ui.Style():fg("magenta")
th.git.updated_sign = "U"
th.git.deleted = ui.Style():fg("red")
th.git.deleted_sign = "D"
th.git.untracked = ui.Style():fg("darkgray")
th.git.untracked_sign = "N"
th.git.ignored_sign = "⋅"
th.git.ignored = ui.Style():fg("darkgray")
require("git"):setup()

require("session"):setup({
  sync_yanked = true,
})

require("gvfs"):setup({
  -- (Optional) Allowed keys to select device.
  -- which_keys = "1234567890qwertyuiopasdfghjklzxcvbnm-=[]\\;',./!@#$%^&*()_+{}|:\"<>?",

  -- (Optional) Save file.
  -- Default: ~/.config/yazi/gvfs.private
  save_path = os.getenv("HOME") .. "/.cache/yazi/gvfs.private",

  -- (Optional) Save file for automount devices. Use with `automount-when-cd` action.
  -- Default: ~/.config/yazi/gvfs_automounts.private
  save_path_automounts = os.getenv("HOME")
    .. "/.cache/yazi/gvfs_automounts.private",

  -- (Optional) Input box position.
  -- Default: { "top-center", y = 3, w = 60 },
  -- Position, which is a table:
  -- 	`1`: Origin position, available values: "top-left", "top-center", "top-right",
  -- 	     "bottom-left", "bottom-center", "bottom-right", "center", and "hovered".
  --         "hovered" is the position of hovered file/folder
  -- 	`x`: X offset from the origin position.
  -- 	`y`: Y offset from the origin position.
  -- 	`w`: Width of the input.
  -- 	`h`: Height of the input.
  -- input_position = { "center", y = 0, w = 60 },

  -- (Optional) Select where to save passwords.
  -- Default: nil
  -- Available options: "keyring", "pass", or nil
  password_vault = "keyring",

  -- (Optional) Auto-save password after mount.
  -- Default: false
  save_password_autoconfirm = true,
  -- (Optional) mountpoint of gvfs. Default: /run/user/USER_ID/gvfs
  -- On some system it could be ~/.gvfs
  -- You can't decide this path, it will be created automatically. Only changed if you know where gvfs mountpoint is.
  -- Use command `ps aux | grep gvfs` to search for gvfs process and get the mountpoint path.
  -- root_mountpoint = (os.getenv("XDG_RUNTIME_DIR") or ("/run/user/" .. ya.uid())) .. "/gvfs"
})
