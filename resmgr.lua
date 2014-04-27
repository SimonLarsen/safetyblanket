local ResMgr = {}

ResMgr.images = {}
ResMgr.fonts = {}
ResMgr.sounds = {}

function ResMgr.getImage(path)
	if ResMgr.images[path] == nil then
		ResMgr.images[path] = love.graphics.newImage("res/gfx/" .. path)
		print("Loaded image: " .. path)
	end

	return ResMgr.images[path]
end

function ResMgr.getFont(path, size)
	if ResMgr.fonts[path..size] == nil then
		ResMgr.fonts[path..size] = love.graphics.newFont("res/fonts/" .. path, size)
	end

	return ResMgr.fonts[path..size]
end

function ResMgr.getSound(path)
	if ResMgr.sounds[path] == nil then
		ResMgr.sounds[path] = love.audio.newSource("res/sfx/" .. path, "static")
		print("Loaded sound: " .. path)
	end
	
	return ResMgr.sounds[path]
end

function ResMgr.playSound(path)
	ResMgr.getSound(path):play()
end

return ResMgr
