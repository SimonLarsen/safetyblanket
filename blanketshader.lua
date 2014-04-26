local shader = {}

shader.pixelcode = [[
extern Image plaid;
extern vec2 screen;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
	/*
	vec4 texcolor = Texel(texture, texture_coords);
	return texcolor * color;
	*/
	return Texel(plaid, screen_coords/screen);
}
]]

shader.vertexcode = [[
vec4 position(mat4 transform_projection, vec4 vertex_position) {
	return transform_projection * vertex_position;
}
]]

return shader
