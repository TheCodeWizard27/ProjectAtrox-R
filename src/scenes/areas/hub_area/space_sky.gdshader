shader_type sky;
uniform sampler2D StarNoise : filter_nearest_mipmap;

void sky() {
	vec2 uv = EYEDIR.xz / EYEDIR.y;
	vec3 sky = texture(StarNoise, uv + TIME * 0.01).xyz;
	vec3 coloredSky = sky.xyz * step(0.05, sky) * EYEDIR;
	
	COLOR = sky.xyz;
}
