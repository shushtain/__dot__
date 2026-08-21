hl.env(
  "PATH",
  "$HOME/.bin:$HOME/.nix-profile/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.npm-global/bin:$PATH"
)

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("LIBVA_DRIVER_NAME", "radeonsi")
hl.env("VDPAU_DRIVER", "radeonsi")
hl.env("RADV_PERFTEST", "video_decode")
hl.env("AMD_VULKAN_ICD", "RADV")
-- hl.env("HYPRLAND_NO_SD_EVENT", "0")

hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("GDK_SCALE", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("GTK_THEME", "Adwaita:dark")

hl.env("EDITOR", "nvim")
hl.env("GIT_EDITOR", "nvim")
hl.env("VISUAL", "nvim")
hl.env("BROWSER", "firefox")
hl.env("TERMINAL", "alacritty")

hl.env("XDG_DESKTOP_DIR", "$HOME/lot")
hl.env("XDG_DOCUMENTS_DIR", "$HOME/lot")
hl.env("XDG_DOWNLOAD_DIR", "$HOME/lot")
hl.env("XDG_MUSIC_DIR", "$HOME/lot")
hl.env("XDG_PICTURES_DIR", "$HOME/lot")
hl.env("XDG_PUBLICSHARE_DIR", "$HOME/pub")
hl.env("XDG_TEMPLATES_DIR", "$HOME/tpl")
hl.env("XDG_VIDEOS_DIR", "$HOME/lot")
hl.env("XDG_CLOUD_DIR", "$HOME/box")
