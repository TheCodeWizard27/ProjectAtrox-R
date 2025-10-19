shader_type spatial;

render_mode blend_mix, depth_draw_opaque, cull_disabled, diffuse_lambert, specular_schlick_ggx, unshaded, shadows_disabled, ambient_light_disabled;

uniform vec4 color : source_color = vec4(0.12, 0.114, 0.093, 0.6);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec3 baseColor = color.rgb;
	
	float scanColor = sin((UV.y + TIME * 0.8) * 54.0);
	
	ALBEDO = scanColor * 0.2 * baseColor;
	ALPHA = color.w;
}

void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
}
