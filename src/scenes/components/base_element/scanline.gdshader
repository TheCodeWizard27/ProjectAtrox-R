shader_type spatial;

render_mode blend_mix, depth_draw_opaque, cull_disabled, diffuse_lambert, specular_schlick_ggx, unshaded, shadows_disabled, ambient_light_disabled;

uniform float scanlineThreshold : hint_range(0, 1.0) = 0.0;
uniform vec4 color : source_color = vec4(0.38, 0.37, 0.33, 0.74);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec3 baseColor = color.rgb;
	
	float scanColor = sin((UV.y + TIME * 0.8) * 54.0);
	
	ALBEDO = max(scanColor * 0.4, scanlineThreshold) * baseColor;
	ALPHA = color.w;
}

void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
}
