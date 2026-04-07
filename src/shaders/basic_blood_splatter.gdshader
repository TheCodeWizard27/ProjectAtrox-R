shader_type spatial;
render_mode blend_mix, depth_draw_opaque, depth_test_default, cull_disabled, diffuse_lambert, specular_schlick_ggx, unshaded;

uniform float Fade = 1.0;
uniform vec4 Color : source_color = vec4(0.764706, 0.031373, 0.113725, 1.000000);
uniform sampler2D Noise : filter_nearest_mipmap;

void vertex() {
	// Billboard
	MODELVIEW_MATRIX = VIEW_MATRIX * mat4(
			MAIN_CAM_INV_VIEW_MATRIX[0],
			MAIN_CAM_INV_VIEW_MATRIX[1],
			MAIN_CAM_INV_VIEW_MATRIX[2],
			MODEL_MATRIX[3]);
	MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);
}

void fragment() {
	vec2 currentUV = UV + (TIME * 0.01);
	vec4 noise = texture(Noise, currentUV);
	vec4 coloredNoise = Color * noise;
	
	float r = distance(UV, vec2(0.5));
	vec2 circle = smoothstep(vec2(r), vec2(1.0), vec2(0.6));

	float splatter = clamp(circle.x * 5.0 * noise.x, 0, 1);
	ALBEDO = vec3(coloredNoise.xyz);
	ALPHA = splatter * Fade;
}
