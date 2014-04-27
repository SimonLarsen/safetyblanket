local shader = {}

shader.pixelcode = [[
extern vec2 offset;
extern Image disp;
extern vec2 screen;

vec4 effect(vec4 color, Image texture, vec2 tc, vec2 screen_coords) {
	vec4 norm = Texel(disp, screen_coords/screen);
	vec2 texture_coords = tc + vec2((norm.r-0.5)*0.32, (norm.g-0.5)*0.32);
	vec4 gcolor = Texel(texture, texture_coords);
	vec4 rcolor = Texel(texture, texture_coords+offset);
	vec4 bcolor = Texel(texture, texture_coords-offset);
	return vec4(rcolor.r, gcolor.g, bcolor.b, bcolor.a) * color;
}
]]

return shader
