local ResMgr = {}

ResMgr.images = {}
ResMgr.fonts = {}

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

return ResMgr
