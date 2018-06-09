function love.conf(t)
    t.identity = "safetyblanket"
    t.version = "11.0"
    t.console = false
 
    t.window.title = "Safety Blanket"
    t.window.icon = nil
    t.window.width = 1024
    t.window.height = 768
    t.window.borderless = false
    t.window.resizable = false
    t.window.minwidth = 1
    t.window.minheight = 1
    t.window.fullscreen = false
    t.window.fullscreentype = "desktop"
    t.window.vsync = true
    t.window.fsaa = 0
    t.window.display = 1
    t.window.highdpi = false
    t.window.srgb = false
    t.window.x = nil
    t.window.y = nil
 
    t.modules.joystick = true
end
