local shader = {}

shader.pixelcode = [[
extern vec2 offset;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
	vec4 gcolor = Texel(texture, texture_coords);
	vec4 rcolor = Texel(texture, texture_coords+offset);
	vec4 bcolor = Texel(texture, texture_coords-offset);
	return vec4(rcolor.r, gcolor.g, bcolor.b, bcolor.a) * color;
}
]]

shader.vertexcode = [[
vec4 position(mat4 transform_projection, vec4 vertex_position) {
	return transform_projection * vertex_position;
}
]]

return shader
