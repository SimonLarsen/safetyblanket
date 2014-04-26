local ResMgr = {}

ResMgr.images = {}

function ResMgr.getImage(path)
	if ResMgr.images[path] == nil then
		ResMgr.images[path] = love.graphics.newImage("res/gfx/" .. path)
		print("Loaded image: " .. path)
	end

	return ResMgr.images[path]
end

return ResMgr
