shader_type canvas_item;

uniform sampler2D noise : repeat_enable;

void fragment() {
	COLOR = texture(noise, UV * min(0.1, max(1.0, sin(TIME * 0.2))) + sin(UV) + 0.04 * TIME);
	COLOR.a = 0.05;
}
