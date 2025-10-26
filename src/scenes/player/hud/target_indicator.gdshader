shader_type spatial;

render_mode unshaded, blend_mix, depth_test_disabled, cull_disabled;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform vec4 color : source_color = vec4(0.38, 0.37, 0.33, 0.74);

void vertex() {
	if (PROJECTION_MATRIX[3][3] != 0.0) {
		// Orthogonal matrix; try to do about the same with viewport size.
		float h = abs(1.0 / (2.0 * PROJECTION_MATRIX[1][1]));
		// Consistent with vertical FOV (Keep Height).
		float sc = (h * 2.0);
		MODELVIEW_MATRIX[0] *= sc;
		MODELVIEW_MATRIX[1] *= sc;
		MODELVIEW_MATRIX[2] *= sc;
	} else {
		// Scale by depth.
		float sc = -(MODELVIEW_MATRIX)[3].z;
		MODELVIEW_MATRIX[0] *= sc;
		MODELVIEW_MATRIX[1] *= sc;
		MODELVIEW_MATRIX[2] *= sc;
	}
}

void fragment() {
	float distanceFactor = length(UV - vec2(0.5));
	distanceFactor = step(0.4, distanceFactor) - step(0.5, distanceFactor);
	vec4 background = texture(screen_texture, SCREEN_UV, 0.0);

	if (distanceFactor <= 0.0){
		discard;
	}

	ALBEDO.rgb = (1.0 - background.rgb) * color.rgb;
}