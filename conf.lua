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
    t.window.fullscreentype = "normal"
    t.window.vsync = true
    t.window.fsaa = 0
    t.window.display = 1
    t.window.highdpi = false
    t.window.srgb = false
    t.window.x = nil
    t.window.y = nil
 
    t.modules.joystick = true
end

function love.conf(t)
    t.identity = "safetyblanket"
    t.appendidentity = false
    t.version = "11.0"
    t.console = false
    t.accelerometerjoystick = true
    t.externalstorage = false
    t.gammacorrect = false
 
    t.audio.mixwithsystem = true
 
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
    t.window.vsync = 1
    t.window.msaa = 0
    t.window.display = 1
    t.window.highdpi = false
    t.window.x = nil
    t.window.y = nil
 
    t.modules.audio = true
    t.modules.data = true
    t.modules.event = true
    t.modules.font = true
    t.modules.graphics = true
    t.modules.image = true
    t.modules.joystick = true
    t.modules.keyboard = true
    t.modules.math = true
    t.modules.mouse = true
    t.modules.physics = true
    t.modules.sound = true
    t.modules.system = true
    t.modules.thread = true
    t.modules.timer = true
    t.modules.touch = true
    t.modules.window = true

    t.modules.video = false
end
