shader_type spatial;

render_mode unshaded, blend_mix, depth_test_disabled, cull_disabled;

uniform vec4 color : source_color = vec4(1,1,1,1);

float rect(vec2 uv, vec2 size) {
	float x = 1.0 - step((size.x * 5.0) / 10.0, distance(uv.x, 0.5));
	float y = 1.0 - step((size.y * 5.0) / 10.0, distance(uv.y, 0.5));
	return x * y;
}

vec2 rotate(vec2 uv, vec2 pivot, float angle)
{
	mat2 rotation = mat2(vec2(sin(angle), -cos(angle)), vec2(cos(angle), sin(angle)));
	
	uv -= pivot;
	uv = uv * rotation;
	uv += pivot;
	return uv;
}

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
	float outerRect = rect(UV, vec2(1.0));
	float innerRect = rect(UV, vec2(0.8));
	float horizontal = rect(UV, vec2(0.5, 1.0));
	float vertical = rect(UV, vec2(1.0, 0.5));
	
	float corners = outerRect - innerRect - horizontal - vertical;
	//float innerRect = rect(rotate(UV, vec2(0.5, 0.5), 45.0 * (PI / 180.0)), 1.0);
	
	ALBEDO.rgb = vec3(corners);
	ALPHA = clamp(corners, 0.0, 1.0);
}