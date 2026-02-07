---@diagnostic disable: undefined-global

Status:children_add(function(self)
  local h = self._current.hovered
  return h and h.link_to and (" -> " .. tostring(h.link_to)) or ""
end, 3300, Status.LEFT)

require("session"):setup({ sync_yanked = true })

th.git = th.git or {}
th.git.added = ui.Style():fg("green")
th.git.added_sign = "+"
th.git.modified = ui.Style():fg("yellow")
th.git.modified_sign = "~"
th.git.updated = ui.Style():fg("magenta")
th.git.updated_sign = "≈"
th.git.deleted = ui.Style():fg("red")
th.git.deleted_sign = "−"
th.git.untracked = ui.Style():fg("darkgray")
th.git.untracked_sign = "?"
th.git.ignored = ui.Style():fg("darkgray")
th.git.ignored_sign = "⋅"
require("git"):setup()

require("gvfs"):setup({
  save_path = os.getenv("HOME") .. "/.cache/yazi/gvfs.private",
  save_path_automounts = os.getenv("HOME")
    .. "/.cache/yazi/gvfs_automounts.private",
  password_vault = "keyring",
  save_password_autoconfirm = true,
})
