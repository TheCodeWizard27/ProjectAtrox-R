shader_type spatial;

render_mode unshaded;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform vec4 color : source_color = vec4(0.38, 0.37, 0.33, 0.74);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 screen = texture(screen_texture, SCREEN_UV, 0.0);
	
	// Called for every pixel the material is visible on.
	//COLOR.rgb = 1.0 - test.rgb;
	ALBEDO.rgb = (1.0 - screen.rgb) * color.rgb;
	//ALBEDO.rgb = vec3(1.0,0,0);
}