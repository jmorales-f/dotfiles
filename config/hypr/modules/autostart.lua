-- Autostart: start the systemd graphical session (which pulls in user
-- services such as waybar.service) and the wallpaper daemon.
hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprland-session.target")
    hl.exec_cmd("hyprpaper")
end)

-- Stop the session on shutdown so bound services (waybar) don't linger.
hl.on("hyprland.shutdown", function()
    os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
end)
