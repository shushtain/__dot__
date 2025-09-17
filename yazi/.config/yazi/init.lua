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
