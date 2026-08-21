local alias = require("modules.alias")
local combo = function(keys)
  return table.concat(keys, " + ")
end

hl.bind(combo({ "SUPER", "Space" }), hl.dsp.exec_cmd("kbdswitch.sh"), {
  locked = true,
  submap_universal = true,
  description = "Keyboard : Switch layout",
})

hl.bind(
  combo({ "SUPER", "L" }),
  hl.dsp.exec_cmd("hyprlock"),
  { description = "System : Lock" }
)

hl.bind(combo({ "SUPER", "Q" }), hl.dsp.window.close(), {
  submap_universal = true,
  description = "Window : Close",
})

hl.bind(combo({ "SUPER", "SHIFT", "Q" }), hl.dsp.window.kill(), {
  release = true,
  submap_universal = true,
  description = "Window : Kill",
})

hl.bind(combo({ "SUPER", "Delete" }), hl.dsp.exec_cmd("safelogout.sh"), {
  locked = true,
  release = true,
  submap_universal = true,
  description = "System : Safe logout",
})

hl.bind(
  combo({ "SUPER", "SHIFT", "Delete" }),
  hl.dsp.exec_cmd("safepoweroff.sh"),
  {
    locked = true,
    release = true,
    submap_universal = true,
    description = "System : Safe poweroff",
  }
)

hl.bind(
  combo({ "SUPER", "CTRL", "Delete" }),
  hl.dsp.exec_cmd("safereboot.sh"),
  {
    locked = true,
    release = true,
    submap_universal = true,
    description = "System : Safe reboot",
  }
)

hl.bind(
  combo({ "SUPER", "ALT", "Delete" }),
  hl.dsp.exec_cmd('loginctl terminate-user ""'),
  {
    locked = true,
    release = true,
    submap_universal = true,
    description = "System : Logout",
  }
)

hl.bind(
  combo({ "SUPER", "ALT", "SHIFT", "Delete" }),
  hl.dsp.exec_cmd("systemctl poweroff"),
  {
    locked = true,
    release = true,
    submap_universal = true,
    description = "System : Poweroff",
  }
)

hl.bind(
  combo({ "SUPER", "ALT", "CTRL", "Delete" }),
  hl.dsp.exec_cmd("systemctl reboot"),
  {
    locked = true,
    release = true,
    submap_universal = true,
    description = "System : Reboot",
  }
)

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("audiomute.sh"), {
  locked = true,
  submap_universal = true,
  description = "Audio : Mute",
})

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("audiodown.sh"), {
  repeating = true,
  locked = true,
  submap_universal = true,
  description = "Audio : Down",
})

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("audioup.sh"), {
  repeating = true,
  locked = true,
  submap_universal = true,
  description = "Audio : Up",
})

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("micmute.sh"), {
  repeating = true,
  locked = true,
  submap_universal = true,
  description = "Mic : Mute",
})

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessup.sh"), {
  repeating = true,
  locked = true,
  submap_universal = true,
  description = "Screen : Up",
})

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessdown.sh"), {
  repeating = true,
  locked = true,
  submap_universal = true,
  description = "Screen : Down",
})

hl.bind(combo({ "SUPER", "K" }), hl.dsp.exec_cmd("playerctl play-pause"), {
  locked = true,
  description = "Player : Pause",
})

hl.bind(
  combo({ "SUPER", "CTRL", "K" }),
  hl.dsp.exec_cmd("playerctl position 10-"),
  {
    locked = true,
    repeating = true,
    description = "Player : -10s",
  }
)

hl.bind(
  combo({ "SUPER", "ALT", "K" }),
  hl.dsp.exec_cmd("playerctl position 10-"),
  {
    locked = true,
    repeating = true,
    description = "Player : +10s",
  }
)

-- TODO:
-- hl.bind(combo({ "ALT", "Tab" }), hl.dsp.focus({}), {
--   description = "Window : Last",
-- })
-- bind = SUPER, Tab, cyclenext, prev hist
-- hl.bind(combo({ "SUPER", "Tab" }), hl.dsp.window.cycle_next({}), {})
-- hl.dsp.layout("cyclenext")
-- bind = SUPER SHIFT, Tab, cyclenext, hist

hl.bind(
  combo({ "SUPER", "SHIFT", "H" }),
  hl.dsp.focus({ direction = "left" }),
  { description = "Window : Focus : Left" }
)

hl.bind(
  combo({ "SUPER", "SHIFT", "J" }),
  hl.dsp.focus({ direction = "down" }),
  { description = "Window : Focus : Down" }
)

hl.bind(
  combo({ "SUPER", "SHIFT", "K" }),
  hl.dsp.focus({ direction = "up" }),
  { description = "Window : Focus : Up" }
)

hl.bind(
  combo({ "SUPER", "SHIFT", "L" }),
  hl.dsp.focus({ direction = "right" }),
  { description = "Window : Focus : Right" }
)

hl.bind(
  combo({ "SUPER", "Up" }),
  hl.dsp.window.fullscreen_state({
    internal = 2,
    client = -1,
    action = "toggle",
  }),
  { description = "Window : Maximize" }
)

hl.bind(
  combo({ "SUPER", "Left" }),
  hl.dsp.exec_cmd('workspaceswitch.sh "r-1"'),
  { description = "Workspace : Left" }
)

hl.bind(
  combo({ "SUPER", "mouse_up" }),
  hl.dsp.exec_cmd('workspaceswitch.sh "r-1"'),
  { description = "Workspace : Left" }
)

hl.bind(
  combo({ "SUPER", "Right" }),
  hl.dsp.exec_cmd('workspaceswitch.sh "r+1"'),
  { description = "Workspace : Right" }
)

hl.bind(
  combo({ "SUPER", "mouse_down" }),
  hl.dsp.exec_cmd('workspaceswitch.sh "r+1"'),
  { description = "Workspace : Right" }
)

hl.bind(
  combo({ "SUPER", "Down" }),
  hl.dsp.exec_cmd('workspaceswitch.sh "empty"'),
  { description = "Workspace : Empty" }
)

hl.bind(
  combo({ "SUPER", "0" }),
  hl.dsp.exec_cmd('workspaceswitch.sh "empty"'),
  { description = "Workspace : Empty" }
)

hl.bind(
  combo({ "SUPER", "SHIFT", "Down" }),
  hl.dsp.exec_cmd('workspacemove.sh "empty"'),
  { description = "Window : Move : Workspace : Empty" }
)

hl.bind(
  combo({ "SUPER", "SHIFT", "0" }),
  hl.dsp.exec_cmd('workspacemove.sh "empty"'),
  { description = "Window : Move : Workspace : Empty" }
)

hl.gesture({
  fingers = 3,
  direction = "up",
  action = "fullscreen",
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

hl.gesture({
  fingers = 3,
  direction = "down",
  action = function()
    hl.exec_cmd('workspaceswitch.sh "empty"')
  end,
})

for i = 1, 9 do
  hl.bind(
    combo({ "SUPER", i }),
    hl.dsp.exec_cmd("workspaceswitch.sh " .. i),
    { description = "Workspace : " .. i }
  )
end

for i = 1, 9 do
  hl.bind(
    combo({ "SUPER", "SHIFT", i }),
    hl.dsp.exec_cmd("workspacemove.sh " .. i),
    { description = "Window : Move : Workspace : " .. i }
  )
end

for i = 1, 9 do
  hl.bind(
    combo({ "SUPER", "CTRL", i }),
    hl.dsp.exec_cmd("workspacemovesilent.sh " .. i),
    { description = "Window : Throw : Workspace : " .. i }
  )
end

hl.bind(
  combo({ "SUPER", "Grave" }),
  hl.dsp.workspace.toggle_special(),
  { description = "Workspace : Special" }
)

hl.bind(
  combo({ "SUPER", "SHIFT", "Grave" }),
  hl.dsp.window.move({ workspace = "special", follow = true }),
  { description = "Window : Move : Workspace : Special" }
)

hl.bind(
  combo({ "SUPER", "CTRL", "Grave" }),
  hl.dsp.window.move({ workspace = "special", follow = false }),
  { description = "Window : Throw : Workspace : Special" }
)

hl.bind(
  combo({ "SUPER", "F" }),
  hl.dsp.window.fullscreen_state({
    internal = 2,
    client = -1,
    action = "toggle",
  }),
  { description = "Window : Maximize" }
)

hl.bind(
  combo({ "SUPER", "SHIFT", "F" }),
  hl.dsp.window.fullscreen_state({
    internal = 2,
    client = 2,
    action = "toggle",
  }),
  { description = "Window : Fullscreen" }
)

hl.bind(
  combo({ "SUPER", "CTRL", "F" }),
  hl.dsp.window.fullscreen_state({
    internal = -1,
    client = 2,
    action = "toggle",
  }),
  { description = "Window : Fullscreen Client" }
)

hl.bind(
  combo({ "SUPER", "D" }),
  hl.dsp.window.float({ action = "toggle" }),
  { description = "Window : Float" }
)

hl.bind(
  combo({ "SUPER", "SHIFT", "D" }),
  hl.dsp.window.pin({ action = "toggle" }),
  { description = "Window : Pin" }
)
-- bind = SUPER CTRL, D, pseudo, active
hl.bind(
  combo({ "SUPER", "CTRL", "D" }),
  hl.dsp.window.pseudo({ action = "toggle" }),
  { description = "Window : Pseudo" }
)

hl.bind(
  combo({ "SUPER", "Backslash" }),
  hl.dsp.layout("swapsplit"),
  { description = "Layout : Swap Split" }
)

hl.bind(
  combo({ "SUPER", "SHIFT", "Backslash" }),
  hl.dsp.layout("togglesplit"),
  { description = "Layout : Toggle Split" }
)

hl.bind(
  combo({ "SUPER", "mouse:272" }),
  hl.dsp.window.drag(),
  { description = "Window : Drag", mouse = true }
)

hl.bind(
  combo({ "SUPER", "mouse:273" }),
  hl.dsp.window.resize(),
  { description = "Window : Resize", mouse = true }
)

hl.bind(
  combo({ "SUPER", "Minus" }),
  hl.dsp.submap("resize"),
  { description = "Submap : Resize" }
)

hl.define_submap("resize", function()
  hl.bind(
    "H",
    hl.dsp.window.resize({ x = -16, y = 0, relative = true }),
    { repeating = true }
  )
  hl.bind(
    "J",
    hl.dsp.window.resize({ x = 0, y = -16, relative = true }),
    { repeating = true }
  )
  hl.bind(
    "K",
    hl.dsp.window.resize({ x = 0, y = 16, relative = true }),
    { repeating = true }
  )
  hl.bind(
    "L",
    hl.dsp.window.resize({ x = 16, y = 0, relative = true }),
    { repeating = true }
  )
  hl.bind(
    combo({ "SHIFT", "H" }),
    hl.dsp.window.resize({ x = -160, y = 0, relative = true })
  )
  hl.bind(
    combo({ "SHIFT", "J" }),
    hl.dsp.window.resize({ x = 0, y = -160, relative = true })
  )
  hl.bind(
    combo({ "SHIFT", "K" }),
    hl.dsp.window.resize({ x = 0, y = 160, relative = true })
  )
  hl.bind(
    combo({ "SHIFT", "L" }),
    hl.dsp.window.resize({ x = 160, y = 0, relative = true })
  )
  hl.bind("Escape", hl.dsp.submap("reset"), { description = "Submap : Reset" })
end)

hl.bind(
  combo({ "SUPER", "SHIFT", "R" }),
  hl.dsp.exec_cmd("hyprreload.sh"),
  { description = "System : Reload" }
)

hl.bind(
  combo({ "SUPER", "A" }),
  hl.dsp.exec_cmd("fuzzel"),
  { description = "System : Apps" }
)

hl.bind(
  combo({ "SUPER", "SHIFT", "A" }),
  hl.dsp.exec_cmd("fuzzel --show-actions"),
  { description = "System : Apps with Actions" }
)

hl.bind(
  combo({ "SUPER", "V" }),
  hl.dsp.exec_cmd("cliphist.sh"),
  { description = "System : Clipboard" }
)

hl.bind(
  combo({ "SUPER", "SHIFT", "V" }),
  hl.dsp.exec_cmd("cliphist.sh wipe"),
  { description = "System : Clipboard : Wipe" }
)

hl.bind(
  combo({ "Print" }),
  hl.dsp.exec_cmd("hyprshot --mode active --mode output -s -o ~/lot"),
  { description = "System : Print : Screen" }
)

hl.bind(
  combo({ "SUPER", "S" }),
  hl.dsp.exec_cmd("hyprshot --mode active --mode output -s -o ~/lot"),
  { description = "System : Print : Screen" }
)

hl.bind(
  combo({ "SUPER", "ALT", "S" }),
  hl.dsp.exec_cmd("hyprshot --mode active --mode window -s -o ~/lot"),
  { description = "System : Print : Window" }
)

hl.bind(
  combo({ "SUPER", "SHIFT", "S" }),
  hl.dsp.exec_cmd("hyprshot --mode region --freeze -s -o ~/lot"),
  { description = "System : Print : Region" }
)

hl.bind(
  combo({ "SUPER", "SHIFT", "C" }),
  hl.dsp.exec_cmd('screenrecorder.sh "start"'),
  { description = "System : Record : Screen" }
)

hl.bind(
  combo({ "SUPER", "CTRL", "C" }),
  hl.dsp.exec_cmd('screenrecorder.sh "start-area"'),
  { description = "System : Record : Area" }
)

hl.bind(
  combo({ "SUPER", "C" }),
  hl.dsp.exec_cmd('screenrecorder.sh "stop"'),
  { description = "System : Record : Stop" }
)

hl.bind(
  combo({ "SUPER", "Escape" }),
  hl.dsp.exec_cmd(alias.app.resources),
  { submap_universal = true, description = "System : Resources" }
)

hl.bind(
  combo({ "SUPER", "Return" }),
  hl.dsp.exec_cmd("kbdswitch.sh 0 silent && " .. alias.term),
  { submap_universal = true, description = "App : Terminal" }
)

hl.bind(
  combo({ "SUPER", "J" }),
  hl.dsp.exec_cmd("kbdswitch.sh 0 silent && " .. alias.term),
  { submap_universal = true, description = "App : Terminal" }
)

hl.bind(
  combo({ "SUPER", "ALT", "Return" }),
  hl.dsp.exec_cmd(
    "kbdswitch.sh 0 silent && " .. alias.term .. " msg create-window"
  ),
  { description = "App : Terminal : Window" }
)

hl.bind(
  combo({ "SUPER", "ALT", "J" }),
  hl.dsp.exec_cmd(
    "kbdswitch.sh 0 silent && " .. alias.term .. " msg create-window"
  ),
  { description = "App : Terminal : Window" }
)

hl.bind(
  combo({ "SUPER", "W" }),
  hl.dsp.exec_cmd(alias.app.browser),
  { description = "App : Browser" }
)

hl.bind(
  combo({ "SUPER", "SHIFT", "W" }),
  hl.dsp.exec_cmd(alias.app.browser .. " --private-window"),
  { description = "App : Browser : Private" }
)

hl.bind(
  combo({ "SUPER", "Semicolon" }),
  hl.dsp.exec_cmd(alias.app.editor),
  { submap_universal = true, description = "App : Editor" }
)

hl.bind(
  combo({ "SUPER", "E" }),
  hl.dsp.exec_cmd(alias.app.explorer .. " ~/lot"),
  { submap_universal = true, description = "App : Explorer" }
)

hl.bind(
  combo({ "SUPER", "U" }),
  hl.dsp.exec_cmd(alias.app.messenger),
  { submap_universal = true, description = "App : Messenger" }
)

hl.bind(
  combo({ "SUPER", "Super_L" }),
  hl.dsp.exec_cmd("time.sh"),
  { release = true, submap_universal = true, description = "System : Time" }
)

-- bindl = SUPER, T, exec, hyprctl -r -- keyword device["synaptics-tm3336-001"]:enabled true
-- bindl = SUPER SHIFT, T, exec, hyprctl -r -- keyword device["synaptics-tm3336-001"]:enabled false

-- bind = SUPER, Y, exec, hyprpicker -a
-- bind = SUPER SHIFT, Y, exec, hyprpicker -af hsl

-- bind = SUPER, O, exec, $term msg config -r
-- bind = SUPER SHIFT, O, exec, $term msg config -w -1 window.opacity=0

hl.bind(
  combo({ "SUPER", "Comma" }),
  hl.dsp.exec_cmd("dmentia.sh symbols"),
  { description = "System : Symbols" }
)

hl.bind(
  combo({ "SUPER", "Period" }),
  hl.dsp.exec_cmd("dmentia.sh emojis"),
  { description = "System : Emojis" }
)

-- bind = SUPER, G, exec, $app_browser gemini.google.com
-- bind = SUPER SHIFT, G, exec, $app_browser --new-window gemini.google.com
-- bind = SUPER, I, exec, $app_ai

hl.bind(
  combo({ "SUPER", "B" }),
  hl.dsp.exec_cmd("rfkill unblock bluetooth && $term -e bluetui"),
  { description = "App : Bluetui" }
)

hl.bind(
  combo({ "SUPER", "SHIFT", "B" }),
  hl.dsp.exec_cmd("bluetooth.sh"),
  { description = "System : Bluetooth" }
)

-- bind = SUPER, N, exec, $term -e wlctl
-- bind = SUPER SHIFT, N, exec, killall dunst

-- bind = SUPER, P, exec, hyprshade toggle sunset
-- bind = SUPER SHIFT, P, exec, hyprshade toggle grayscale
-- bind = SUPER ALT, P, exec, hyprshade toggle dreamy
-- bind = SUPER ALT SHIFT, P, exec, hyprshade toggle calm
-- bind = SUPER CTRL, P, exec, hyprshade toggle inverted
-- bind = SUPER CTRL SHIFT, P, exec, hyprshade toggle antihue
-- bind = SUPER ALT CTRL, P, exec, hyprshade toggle negative

hl.bind(
  combo({ "SUPER", "X" }),
  hl.dsp.exec_cmd("dropboxstatus.sh"),
  { description = "App : Dropbox" }
)

-- bind = SUPER, Z, exec, radio.sh
-- bind = SUPER SHIFT, Z, exec, radio.sh stop
-- bind = SUPER CTRL, Z, exec, radio.sh random
-- bind = SUPER ALT, Z, exec, radio.sh check
